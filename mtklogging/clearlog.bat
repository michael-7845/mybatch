adb devices 

@echo "delete /sdcard/mtklog" 
adb shell rm -rf /sdcard/mtklog

@echo "delete /sdcard/cat.log" 
adb shell rm -rf /sdcard/cat.log

@echo "Finished." 

pause 