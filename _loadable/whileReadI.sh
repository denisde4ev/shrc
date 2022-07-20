
whileReadI() {
	unset-unseted-i
	eval "while IFS= read -r i; do $@${NEW_LINE:-;} done"
	unset-seted-i # note: if eval uses return; wont unset 'i' var here
}
