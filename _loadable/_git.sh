
_git() {
	echo >&2 _git fn: NOT DONE
	return 123


	# todo: is `most` pager fixed for git or what
	# wast time I checked it was unusable or something..?
	## case ${PAGER-} in most)
	## 	command. local && case $1 in log|commit) ;; *)
	## 	 \local PAGER=less
	## 	esac
	## esac

	#clone 

	for git_command; do case $git_command in [!-]*) break; esac; done
	case ${i:git_command} in
	status) shift; \git stat "$@";;
	#pull) shift; \git pull -v "$@";;
	-*) puts >&2 "_git note: cant parse in arguments: got \$1='$1'"; \git "$@";;
	commit)
		if [ -t 0 -a $# -eq 0 ]; then
			[ ! -d .git ] || _git_dir=$(git rev-parse --show-toplevel) || return
			if [ -f "${_git_dir-.}/.git/.git-next-commit.md" ]; then
				cat "${_git_dir-.}/.git/.git-next-commit.md" | git commit -e
				return
			fi
		fi

		git commit "$@"
	;;
	*) \git "$@";;
	esac
	set -- ${git_conf_user_name:+"-c$git_conf_user_name"} ${git_conf_user_email:+"-c$git_conf_user_email"} # set in ~/B/_main
}

# GIT_SSH_COMMAND=ssh -i ~...
