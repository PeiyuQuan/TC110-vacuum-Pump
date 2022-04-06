#!../../bin/linux-x86_64/TC110

#- You may have to change TC110 to something else
#- everywhere it appears in this file

< envPaths

cd "${TOP}"

## Register all support components
dbLoadDatabase "dbd/TC110.dbd"
TC110_registerRecordDeviceDriver pdbbase

epicsEnvSet ("STREAM_PROTOCOL_PATH", "${TOP}/DG645App/Db")
epicsEnvSet("PREFIX", "SLAC:TC110:")
epicsEnvSet("PORT", "serial1")

drvAsynSerialPortConfigure("serial1", "/dev/ttyUSB1", 0, 0, 0)
asynOctetSetInputEos("serial1",0,"\r\n")
asynOctetSetOutputEos("serial1",0,"\r\n")
asynSetOption("serial1",0,"baud","19200")
asynSetOption("serial1",0,"bits","8")
asynSetOption("serial1",0,"stop","1")
asynSetOption("serial1",0,"parity","none")
asynSetOption("serial1",0,"clocal","Y")
asynSetOption("serial1",0,"crtscts","Y")

dbLoadRecords ("${TOP}/DG645App/Db/DG6451.db","P=$(PREFIX),PORT=serial1")
dbLoadRecords ("$(ASYN)/db/asynRecord.db", "P=$(PREFIX), R=asyn1, PORT=serial1, ADDR=0, IMAX=80, OMAX=80")
dbLoadRecords ("$(AUTOSAVE)/db/save_restoreStatus.db", "P=$(PREFIX)")

cd "${TOP}/iocBoot/${IOC}"
iocInit

