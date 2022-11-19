
_git__() {
	local GIT_FIX_PWD="$PWD" || :
	export GIT_FIX_PWD

	case $PAGER in most) PAGER=less; esac # most is full screen pager...

	##for git_command; do case $git_command in [!-]*) break; esac; done
	# find first non arg. (but cant shift it later, so this is useless)
	# TODO: implement __sourcable/sift_at_i.sh and __sourcable/find_index_nonarg_to_i.sh

	case ${1-} in
	#status) shift; \git stat "$@";;
	_g)
		shift
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
	commit)
		if [ -t 0 -a $# -eq 0 ]; then
			[ ! -d .git ] || \
			_git_dir=$(\git rev-parse --show-toplevel) \
			|| return

			if [ -f "${_git_dir-.}/.git/.git-next-commit.md" ]; then
				cat "${_git_dir-.}/.git/.git-next-commit.md" | \
				\git commit -e
				return
			fi
		fi
		;;
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
	init)
		. "${B?}/_/git/gitconfig" || return
		;;
	esac


	\git "$@"
}

# GIT_SSH_COMMAND=ssh -i ~...
