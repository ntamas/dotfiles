# Set up pyenv
if [[ -d ~/.pyenv/shims ]]; then
	export PATH="${HOME}/.pyenv/shims:$PATH"
	eval "$(pyenv init -)"
fi
