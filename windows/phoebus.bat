@echo OFF
echo Start running phoebus.bat

set "MYPATH=%CD%"
cd  C:\"Program Files (x86)"\Phoebus

set "OPTIONS=-settings phoebus\settings.ini -logging phoebus\phoebus_logging.properties -DCA_DISABLE_REPEATER=true -Dnashorn.args=--no-deprecation-warning -Djdk.gtk.verbose=false -Djdk.gtk.version=2 -Dprism.forceGPU=true -Dorg.csstudio.javafx.rtplot.update_counter=false"

if not "%1" == "" (
jdk-14.0.2\bin\java "-Dphoebus.user=C:\Program Files (x86)\Phoebus" -jar "phoebus\phoebus.jar" %OPTIONS% -resource %1
) else (
jdk-14.0.2\bin\java -jar "phoebus\phoebus.jar" %OPTIONS%
)

cd %MYPATH%

rem Following line keeps the cmd window open for testing

echo Finished running.
echo You can close this window when you're done.
