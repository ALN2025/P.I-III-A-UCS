@echo off
echo Verificando JDK...

REM Tentar encontrar JDK 17 ou mais recente
set JAVA_HOME=
for %%j in (17 18 19 20 21) do (
    if exist "C:\Program Files\Java\jdk-%%j" set JAVA_HOME=C:\Program Files\Java\jdk-%%j
    if exist "C:\Program Files\Java\jdk%%j" set JAVA_HOME=C:\Program Files\Java\jdk%%j
)

if "%JAVA_HOME%"=="" (
    echo JDK 17 ou superior não encontrado.
    echo Tentando JDK instalado...
)

echo Compilando o projeto...
if not "%JAVA_HOME%"=="" (
    echo Usando JDK em %JAVA_HOME%
    "%JAVA_HOME%\bin\javac" -encoding UTF-8 -d bin src/*.java
    
    echo Criando o arquivo JAR executavel...
    "%JAVA_HOME%\bin\jar" cfm SGA.jar manifest.txt -C bin .
) else (
    echo Usando JDK padrão do sistema
    javac -encoding UTF-8 -d bin src/*.java
    
    echo Criando o arquivo JAR executavel...
    jar cfm SGA.jar manifest.txt -C bin .
)

REM Tornar o arquivo JAR executável (ajustar permissões no Windows)
echo Ajustando permissões do arquivo JAR...
attrib +x SGA.jar

echo Processo concluido!
echo O arquivo JAR executavel SGA.jar foi criado com sucesso!
echo.
echo Para executar o sistema, você pode:
echo 1. Dar duplo clique no arquivo SGA.jar
echo 2. Ou usar o comando: java -jar SGA.jar
echo 3. Ou executar o script run.bat
echo.
echo IMPORTANTE: Se o sistema não abrir com duplo clique, use o script run.bat

pause 