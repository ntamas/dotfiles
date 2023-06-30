export PIPENV_VENV_IN_PROJECT=true

if [[ $(arch) != arm64* ]]; then
    export PYENV_ROOT="$HOME/.pyenv-x86"
fi

