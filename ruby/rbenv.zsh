# Set up rbenv
if [[ -d ~/.rbenv/shims ]]; then
	export PATH="${HOME}/.rbenv/shims:$PATH"
	eval "$(rbenv init -)"
fi