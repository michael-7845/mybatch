adb devices 

@echo "retrieving mtklog" 
adb pull /mnt/sdcard/mtklog mtklog 

@echo "retrieving trace" 
adb pull /data/anr mtklog/anr 

@echo "retrieving data aee db" 
adb pull /data/aee_exp mtklog/data_aee_exp 

@echo "retrieving data mobilelog" 
adb pull /data/mobilelog mtklog/data_mobilelog 

@echo "retrieving NE core" 
adb pull /data/core mtklog/data_core 

@echo "retrieving tombstones" 
adb pull /data/tombstones mtklog/tombstones 

@echo "retrieving cat.log" 
adb pull /sdcard/cat.log mtklog/cat.log

@echo "Finished." 

pause 