
cls
@echo off
chcp 936
title APK �������ͼ���ȡ���� by. ForthXu.com
COLOR 3f

GOTO MENU
:MENU
cls
ECHO.
if exist apks (echo .) else (mkdir apks)
ECHO.========================================================================
ECHO.             ��          APK �������ͼ���ȡ���� 
ECHO.
ECHO.                                          -- POWER BY forthxu.com    
ECHO.                                                                            
ECHO.˵����������Ҫ��װJava����;
ECHO.      Ҫ�����apk�����apksĿ¼��
ECHO.
ECHO.                                                                 
ECHO.      1. ��ȡָ��apk��Ϣ��       
ECHO.      2. ������ָ��apk��  
ECHO.      3. ��ȡapksĿ¼��Ӧ�ö�Ӧ��ͼ�ꣻ        
ECHO.      0. �˳���
ECHO.                                                    
ECHO.========================================================================
if exist tmp (echo .) else (mkdir tmp)
ECHO.����������ѡ��1��2��3��0�����س�����
set /p ID=
if "%id%"=="1" goto cmd1
if "%id%"=="2" goto cmd2
if "%id%"=="3" goto cmd3
if "%id%"=="0" goto cmd0
pause
goto menu

:cmd1
@echo off
ECHO.    ������apksĿ¼��apk�����磺a.apk����
set /p APK=
ECHO.��  "���ڲ鿴%APK% apk����Ϣ..."
if exist "apks\%APK%" (
    aapt.exe d badging "apks\%APK%"
) else (
    echo "%APK% ������"
)
ECHO. 
ECHO. 
ECHO. ����������ز˵�
pause>nul
@echo off
goto menu

:cmd2
@echo off
ECHO.    ������apksĿ¼��apk�����磺a.apk����
set /p APK=
ECHO.��  "���ڷ��������� %APK% apk��..."
echo %APK:~0,-4%
if exist "apks\%APK%" (
    if exist "tmp\%APK:~0,-4%" (
        echo .
    ) else (
        mkdir "tmp\%APK:~0,-4%"
    )
    java -jar apktool.jar d -f "apks\%APK%" "tmp\%APK:~0,-4%"
    echo "��������ɣ��ļ��� tmp\%APK:~0,-4% Ŀ¼"
) else (
    echo "%APK% ������"
)
ECHO. 
ECHO. 
ECHO. ����������ز˵�
pause>nul
@echo off
goto menu


:cmd3
ECHO.�������ڿ���ͼ����...
@echo off

for /f "delims=" %%a in ('dir /b /s /a:-d apks\*.apk') do (
    set "APK_PATH=%%a"
    set "APK_NAME=%%~nxa"
    REM set "str=%%~nxa"
    
    setlocal enabledelayedexpansion
        REM echo "!str:~3!"
        echo !APK_PATH!
        for /f "tokens=1,2,3,4 delims=\'" %%b in ('aapt.exe d badging "!APK_PATH!" ^| findstr "png"') do (
            set "tmp_D=%%d"
            set "tmp_E=%%e"
            
            REM echo !tmp_D!
            if {!tmp_D:~1!}=={icon=} (
                set "PNG=!tmp_E!"
            ) else (
                set "PNG=!tmp_D!"
            )
            REM echo !PNG!
        )
    REM endlocal
    echo  !PNG!
    for /f "tokens=1,2,3 delims=\/" %%f in ('echo !PNG!') do ( set "ICON=%%h" )

    echo !ICON!
    
    if exist "tmp\!APK_NAME:~0,-4!" (echo "Ӧ��ͼ����ʱĿ¼���ڣ�����...") else (mkdir "tmp\!APK_NAME:~0,-4!")
    "C:\Program Files\WinRAR\WinRAR.exe" x "!APK_PATH!" *\!ICON! "tmp\!APK_NAME:~0,-4!"
    
    if exist "tmp\!APK_NAME:~0,-4!\res\drawable-xxhdpi\!ICON!" (
        COPY "tmp\!APK_NAME:~0,-4!\res\drawable-xxhdpi\!ICON!"  "apks\!APK_NAME:~0,-4!_144.png"
    ) else if exist "tmp\!APK_NAME:~0,-4!\res\drawable-xxhdpi-v4\!ICON!" (
        COPY "tmp\!APK_NAME:~0,-4!\res\drawable-xxhdpi-v4\!ICON!"  "apks\!APK_NAME:~0,-4!_144.png"
    ) else if exist "tmp\!APK_NAME:~0,-4!\res\drawable-xhdpi\!ICON!" (
        COPY "tmp\!APK_NAME:~0,-4!\res\drawable-xhdpi\!ICON!"  "apks\!APK_NAME:~0,-4!_96.png"
    ) else if exist "tmp\!APK_NAME:~0,-4!\res\drawable-xhdpi-v4\!ICON!" (
        COPY "tmp\!APK_NAME:~0,-4!\res\drawable-xhdpi-v4\!ICON!"  "apks\!APK_NAME:~0,-4!_96.png"
    ) else if exist "tmp\!APK_NAME:~0,-4!\res\drawable-hdpi\!ICON!" (
        COPY "tmp\!APK_NAME:~0,-4!\res\drawable-hdpi\!ICON!"  "apks\!APK_NAME:~0,-4!_72.png"
    ) else if exist "tmp\!APK_NAME:~0,-4!\res\drawable-hdpi-v4\!ICON!" (
        COPY "tmp\!APK_NAME:~0,-4!\res\drawable-hdpi-v4\!ICON!"  "apks\!APK_NAME:~0,-4!_72.png"
    ) else if exist "tmp\!APK_NAME:~0,-4!\res\drawable\!ICON!" (
        COPY "tmp\!APK_NAME:~0,-4!\res\drawable\!ICON!"  "apks\!APK_NAME:~0,-4!_72.png"
    ) else (
        echo "ͼ�겻����"
    )
    endlocal
)
ECHO. 
ECHO. 
ECHO. ����������ز˵�
pause>nul
@echo off
goto menu

:cmd0
exit