#!/ /hint/bash


	#$(alias | sed -nEe 's/^alias ([^=]*which[^=]*).+/\1/p') \
for i in \
cd.which \
cmd-which \
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
cmd-which \
ew \
\$ \
x \
'?' \
'??'
do
	# command arg expand:
	complete -F _command "$i"
done




{
	# tldr special, maybe use command instead?
	complete -F _tldr tldr
	_tldr() { complete -W "$(tldr 2>/dev/null --list)" tldr; }
}


# pwd is mine (echo $PWD/$1) (from ~/B/fn)
complete -F _minimal pwd

return


# NOT USED:
# # virable expand
# complete -v Earg # function Earg() { echo "${!@@Q}"; } ## extreme bashisum version 5+
