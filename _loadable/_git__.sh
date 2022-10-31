
_git__() {
	local GIT_FIX_PWD="$PWD" || :
	#echo >&2 _git fn: NOT DONE
	#return 123

	### set in "$B"/_main
	##set -- \
	##	${git_conf_user_name:+"-c$git_conf_user_name"} \
	##	${git_conf_user_email:+"-c$git_conf_user_email"} \
	##;

	# todo: is `most` pager fixed for git or what
	# wast time I checked it was unusable or something..?
	## case ${PAGER-} in most)
	## 	command. local && case $1 in log|commit) ;; *)
	## 	 \local PAGER=less
	## 	esac
	## esac

	#clone 

	for git_command; do case $git_command in [!-]*) break; esac; done
	case ${1-} in
	#status) shift; \git stat "$@";;
	pull) shift; \git pull -v "$@";;
	-*)
		puts >&2 "_git note: cant parse in arguments: got \$1='$1'";
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
					"overwritten: git worktree <add|del>" \
					"" \
					"overwritten add:" \
					"$(eval '_git_worktree_add --help')" \
					"" \
					"overwritten del:" \
					"$(eval '_git_worktreeAndBranch_remove --help')" \
					"" \
				;
			;;
			# eval needed to satisfy __load_loadable from alias to fn.
			add) shift 2; eval '_git_worktree_add "$@"';             return;;
			del) shift 2; eval '_git_worktreeAndBranch_remove "$@"'; return;;
		esac
		;;
	esac


	\git "$@"
}

# GIT_SSH_COMMAND=ssh -i ~...
