
_git__() {
	local GIT_FIX_PWD="$PWD" || :
	export GIT_FIX_PWD

	case ${GIT_DIR+x} in '')
		case $PWD in
			/mnt/c/usr|/mnt/c/Windows|/mnt/c/Windows/) eval 'dotfiles-pc57-win-env _git__ "$@"; return';;
		esac
	esac

	case $PAGER in most) PAGER=less; esac # most is full screen pager...

	##for git_command; do case $git_command in [!-]*) break; esac; done
	# find first non arg. (but cant shift it later, so this is useless)
	# TODO: implement __sourcable/sift_at_i.sh and __sourcable/find_index_nonarg_to_i.sh


	case ${1-} in
	#status) shift; \git stat "$@";;
	_g)
		shift

		case $PWD in
		/mnt/c/usr|/mnt/c/Windows/System32/drivers/etc)
			case $#:${1-} in
				1:stat) set -- "$1" --untracked-files=normal .;;
			esac
			;;
		esac

		case ${1-} in
			stat|stat-all|diff)
				case $# in
					1) set -- "$1" .;;
					2) case $1 in -*) set -- "$1" "$2" .; esac;;

					#3)
					# ..., I wont even check for more then 3,
					# for now I'm not using `alias ...='_git__ _q ...'` with 3 aliased options
				esac
			;;
			*)
				printf %s\\n >&2 "_git__: note: ${1+"not recognized: '"}${1-no args}${1+"'"}"
			;;
		esac
		;;
	pull) shift; \git pull -v "$@";;
	-*)
		puts >&2 "_git__ note: cant parse in arguments: got \$1='$1'";
		\git "$@"
		;;
##	commit)
##		if [ -t 0 -a $# -eq 0 ]; then
##
##			# TODO THIS WONT WORK WHEN `GIT_DIR` IS SET
##			[ ! -d .git ] || \
##			_git_dir=$(\git rev-parse --show-toplevel) \
##			|| return
##
##			if [ -f "${_git_dir-.}/.git/.git-next-commit.md" ]; then
##				cat "${_git_dir-.}/.git/.git-next-commit.md" | \
##				\git commit -e
##				return
##			fi
##		fi
##		;;
	worktree)
		# fns _git_worktree* are fro, $B/_loadable/_git_wotktree*.sh
		case $2 in
			--help)
				printf %s\\n \
					"_git__ overwritten: git worktree <add|del>" \
					"" \
					"overwritten add:" \
					"$(eval '_git_worktree_add --help')" \
					"" \
					"overwritten del:" \
					"$(eval '_git_worktreeAndBranch_remove --help')" \
					"" \
					"" \
				;
			;;
			# eval needed to satisfy __load_loadable from alias to fn.
			add) shift 2; eval '_git_worktree_add "$@"';             return;;
			del) shift 2; eval '_git_worktreeAndBranch_remove "$@"'; return;;
		esac
		;;
	##init)
	##	"${B?}/_/git/gitconfig" || return
	##	;;


	INDEX:ls-full|:ls-full|ls-full) shift
		## \git ls-files --full-name "$@" # dont use, it will not list files that are outside pwd
		(
		GIT_WORKTREE=$(git rev-parse --show-toplevel)
		cd "$GIT_WORKTREE" || exit # never change pwd for main shell, use subshell
		\git ls-files --full-name "$@"
		# if not using subshell then unsetting var `GIT_WORKTREE` will be bad for shells that do not support `local`
		)
		return;;
	HEAD:ls-full) shift
		# inconsistency: will list files that are outside pwd
		\git ls-tree --name-only HEAD -r --full-tree "$@"
		return;;

	INDEX:ls-find|:ls-find|ls-find) shift
		# 'ls-files' makes no sense, I think it shoould be ls-recursive/ls-r/ls-find if it will only list recursively
		\git ls-files --cached "$@"
		return;;
	HEAD:ls-find) shift
		\git ls-tree --name-only HEAD -r "$@"
		return;;


	# never used: INDEX:diff-ls|:diff-ls|diff-ls) shift; \git diff --cached --name-only "$@"; return;;
	INDEX:ls|:ls|ls) shift
		# sadly, I cannot find alternative to `git ls-files` that does not list recursively -> needs to filter by piping
		unset-unseted-i
		for i; do case $i in */*) unset i; break; esac; done
		case ${i+x} in
		x) unset i;
			\git ls-files --cached "$@" | grep -oE '^(\./)?[^/]*/?' | uniq
			;;
		*)
			unset-unseted-i
			for i; do
				# [ -d "$i" ] # no, we cannot check if path is dir based on exiting nonindexed files
				case $i in
				*/*)
					( # note: won't work if filename has NL at the end
					cd "${i%/*}"
					\git ls-files --cached "${i##*/}" | grep -oE '^(\./)?[^/]*/?' | while IFS='' read f; do
						f=${f#./} # seems to not be needed?
						printf %s\\n "${i%/*}/$f"
					done
					)
					;;
				*)
					\git ls-files --cached "$@" | grep -oE '^(\./)?[^/]*/?' | uniq
				esac
			done
			unset-seted-i
			;;
		esac
		return;;
	HEAD:ls) shift
		\git ls-tree --name-only HEAD "$@"
		return;;

	INDEX:rm) shift
		\git rm --cached "$@"
		return;;

	*:cat)
		local ref; ref=${1%":cat"}; shift
		case $ref in INDEX) ref='';; esac
		# most of the time: `INDEX:cat|HEAD:cat` -> ref="" or ref=HEAD

		case $# in 0) printf %s\\n "specify file" >&2; return 2; esac

		case $1 in /*|./*) ;; *) set -- "$ref:./$1"; esac
		\git git-fix-pwd-git show "$@"

		unset ref; return
		;;


	esac


	\git "$@"
}

# GIT_SSH_COMMAND=ssh -i ~...
