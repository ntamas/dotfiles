# Set up virtualenvwrapper
VENV=`which virtualenv`
if [ "x${VENV}" != x ]; then
	export WORKON_HOME="${HOME}/virtualenvs"
	source /usr/local/bin/virtualenvwrapper.sh
	workon default
fi