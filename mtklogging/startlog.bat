adb devices 

@echo "delete /sdcard/mtklog" 
adb shell "logcat -v time -s 'TEST' > /sdcard/cat.log &"

@echo "Finished." 

pause 