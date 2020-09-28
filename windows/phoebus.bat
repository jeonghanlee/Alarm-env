@echo OFF

SET TOP=%cd%

SET JAVA_HOME=%TOP%\jdk-14.0.2
SET PATH=%JAVA_HOME%\bin;%PATH%

echo %TOP%

set "OPTIONS=-DCA_DISABLE_REPEATER=true -Dnashorn .args=--no-deprecation-warning -Djdk.gtk.verbose=false -Djdk.gtk.version=2 -Dprism.forceGPU=true -Dorg.csstudio.javafx.rtplot.update_counter=false"

%JAVA_HOME%\bin\java -jar "phoebus\phoebus.jar" %OPTIONS%

echo %JDK_JAVA_OPTIONS%

java -jar %PHOEBUS_JAR% -settings %TOP%\phoebus\settings.ini -logging %TOP%\phoebus\phoebus_logging.properties %OPTIONS% -resource %l &
