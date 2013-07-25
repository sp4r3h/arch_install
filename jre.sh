if [ -z $J2SKDKDIR ] ; then
export J2REDIR=/opt/java/jre
export PATH=$PATH:$JREDIR/bin
export CLASSPATH=$CLASSPATH:$J2REDIR/lib
else
export J2REDIR=$J2SDKDIR
fi
export JAVA_HOME=$J2REDIR
