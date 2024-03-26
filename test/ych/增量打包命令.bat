	@echo off
		
	setlocal enabledelayedexpansion
	set file="file_list.txt"
	set file=%file:"=%
	for %%i in ("%file%") do set file=%%~fi
	rem 替换的文本 
	set replaced1=/release/reinsure/
	set replaced2=src/
	set replaced3=src/
	set replaced4=WebRoot/
	set replaced5=.java
	
	rem 替换后的文本
	set all1=
	set all2=WEB-INF/classes/
	set all3=WEB-INF/classes/
	set all4=
	set all5=.class
	
	rem 开始替换
	for /f "delims=" %%i in ('type "%file%"') do (
		set str=%%i
		set "str=!str:%replaced1%=%all1%!"
		set "str=!str:%replaced2%=%all2%!"
		set "str=!str:%replaced3%=%all3%!"
		set "str=!str:%replaced4%=%all4%!"
		set "str=!str:%replaced5%=%all5%!"
		echo !str!>>"%file%"_tmp.txt
		)
	rem copy "%file%" "%file%"_bak.txt >nul 2>nul
	move "%file%"_tmp.txt "%file%"
	
	rem 打开文本
	rem start "" "%file%"
	
	rem 开始打增量包
		
	echo =========打包成jar===============
	
	cd ./WebRoot
	
	
	rem 设置日期变量d和时间变量t
	set d=%date:~0,4%%date:~5,2%%date:~8,2%
	set t=%time:~0,2%%time:~3,2%%time:~6,2%
	
	jar cvf reinsure_%d%_%t%.jar @%file%
	
	pause
	
	ping -n 3 127.0.0.1 >nul
	md ..\jar
	move reinsure_%d%_%t%.jar ../jar/reinsure_%d%_%t%.jar
	
	echo =========打包成jar 完成==========