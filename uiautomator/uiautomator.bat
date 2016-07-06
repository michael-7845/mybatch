@echo off

:: Author by Michael Yu
:: Company CKT Chengdu

:: set the default value of variable
set MODE=0
set PROJ=TestDemo
set CaseClass=uia.example.my.LaunchSettings
:: set the value of variable by the batch file's parameter
if NOT "%1"=="" set MODE=%1
if NOT "%2"=="" set PROJ=%2
if NOT "%3"=="" set CaseClass=%3
:: set the vaule of variable workspace
set WORKSPACE=E:\adt-bundle-windows-x86_64-20130729\eclipse\project\%PROJ%

:: save the current path
set base_dir=%~dp0
%base_dir:~0,2%

if "%MODE%"=="1" goto Build
if "%MODE%"=="2" goto Run
if "%MODE%"=="-1" goto Build
if "%MODE%"=="-2" goto Run
echo Usage:
echo runtest.bat [mode] [project] [case class]
echo var1. mode
echo  1 - build, then upload, then run
echo  2 - only run the case
echo  -1 - build, then upload, then run; not prompt before running
echo  -2 - only run the case; not prompt before running
echo  other - help
echo var2. project - project name
echo var3. case class - which case will be run
goto End

:Build
:: create the ant's build.xml
::call android.bat create uitest-project -n %PROJ% -t 1 -p %WORKSPACE%
:: if not set SDK then remark
set SDK=E:\adt-bundle-windows-x86_64-20130729\sdk
if "%MODE%"=="1" call %SDK%\tools\android.bat create uitest-project -n %PROJ% -t 1 -p %WORKSPACE%
:: goto project
cd /d %WORKSPACE%
:: build project
call ant build

:Run
cd /d %WORKSPACE%
:: put to mobile
adb push bin\%PROJ%.jar /data/local/tmp/
:: start to run
if "%MODE%"=="-1" goto Running
if "%MODE%"=="-2" goto Running
echo start running test, ready... & pause
:Running
adb shell uiautomator runtest %PROJ%.jar -c %CaseClass%

:End
:: restore the path before running the batch file
cd %base_dir%

::UIAutomator工具是google从Android4.0开始推出的用户界面自动化工具，是一个非常好用也很强大的手机测试人员助手。
::但是这个工具对测试用例的编写后的编译和运行操作有些繁琐，因为必须使用ant编译出jar包后，放到测试手机上，在执行特殊的命令才能运行测试。
::
::使用方法： 在运行测试用例之前，需要在脚本中按需设置变量：
::MODE - 模式的缺省值
::PROJ - 测试工程的名字的缺省值
::CaseClass - 测试类的缺省值
::WORKSPACE - 测试工程所在的目录
::SDK - Android SDK所在的目录
::
::runtest.bat [模式] [项目] [测试类]
::模式（如不提供使用脚本中的缺省值）：、
::  1 - 编译，上传jar包到手机，执行（前需要确认）
::  -1 - 同1的过程，执行前不需要确认
::  2 - 上传jar包到手机，执行（前需要确认）
::  -2 - 同2的过程，执行前不需要确认
::  其他 - 打印帮助   
::项目（如不提供使用脚本中的缺省值）：
::  测试工程的名字
::测试类（如不提供使用脚本中的缺省值）：
::  测试类的全名字
