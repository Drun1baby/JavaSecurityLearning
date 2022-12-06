This is the domain library directory and is usually located at $DOMAIN_DIR/lib.

The jars located in this directory will be picked up and added dynamically to the end of the server classpath at server startup. The jars will be ordered lexically in the classpath. The domain library directory is one mechanism that can be used for adding application libraries to the server classpath.

It is possible to override the $DOMAIN_DIR/lib directory using the -Dweblogic.ext.dirs system property during startup. This property specifies a list of directories to pick up jars from and dynamically append to the end of the server classpath using java.io.File.pathSeparator as the delimiter between path entries.

