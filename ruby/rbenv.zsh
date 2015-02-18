# Set up rbenv
if [[ -d ~/.rbenv/shims ]]; then
	export PATH="${HOME}/.rbenv/shims:$PATH"
	eval "$(pyenv init -)"
fi