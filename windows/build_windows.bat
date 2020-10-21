@echo OFF

REM set the top directory
SET TOP=%cd%

REM set the java and maven env variables

SET JAVA_HOME=%TOP%\lib\jdk-14.0.2
SET PATH=%JAVA_HOME%\bin;%PATH%

SET MVN_HOME=%TOP%\lib\apache-maven-3.6.0
SET PATH=%MVN_HOME%\bin;%PATH%

REM build phoebus
cd %TOP%\phoebus-src
mvn clean install -DskipTests=true
