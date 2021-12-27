# Specify JAVA_HOME
export JAVA_HOME="$(brew --prefix)/opt/openjdk"

# Give more heap space to Ant
export ANT_OPTS="-Xmx1024M"