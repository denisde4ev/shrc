#! /hint/bash
${shell_is_interactive-return}

	#$(alias | sed -nEe 's/^alias ([^=]*which[^=]*).+/\1/p') \
i{
for i in \
cd.which \
com-which \
e.which \
ll.which \
shellcheck.which \
\
set-x \
debugger \
bash-debugger \
\
HELP \
- \
ew \
\$ \
x \
'?' \
'??' \
e.loadable \

do
	# command arg expand:
	complete -F _command "$i"
done
}i


complete -F _tldr tldr
_tldr() { complete -W "$(tldr 2>/dev/null --list)" tldr; }


if command. _minimal; then
	complete -F _minimal pwd
else
	complete -d pwd
fi

return



# {
 # ((( umount-fzf -> DONT, it also accepts block device path, but umount does not autocomplete them.. )))
 # _umount_module(){ __load_completion umount; }
 # complete -o nospace -F _umount_module -F _minimal umount-fzf
# }

# pwd is mine (echo $PWD/$1) (from ~/B/fn)


# NOT USED:
# # virable expand
# complete -v Earg # function Earg() { echo "${!@@Q}"; } ## extreme bashisum version 5+
