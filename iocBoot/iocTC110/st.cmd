#!../../bin/linux-x86_64/TC110

#- You may have to change TC110 to something else
#- everywhere it appears in this file

< envPaths

cd "${TOP}"

## Register all support components
dbLoadDatabase "dbd/TC110.dbd"
TC110_registerRecordDeviceDriver pdbbase

epicsEnvSet ("STREAM_PROTOCOL_PATH", "${TOP}/TC110App/Db")
epicsEnvSet("PREFIX", "SLAC:TC110:")
epicsEnvSet("PORT", "serial4")
epicsEnvSet("M","m1:")

drvAsynIPPortConfigure("serial4", "192.168.0.35:4004<192.168.0.35:4004/> COM", 0, 0, 0)
asynOctetSetInputEos("serial4",0,"\r")
asynOctetSetOutputEos("serial4",0,"\r")
asynSetOption("serial4",0,"baud","9600")
asynSetOption("serial4",0,"bits","8")
asynSetOption("serial4",0,"stop","1")
asynSetOption("serial4",0,"parity","none")
#asynSetOption("serial4",0,"clocal","Y")
asynSetOption("serial4",0,"crtscts","N")
asynSetTraceIOMask("serial4",0,ESCAPE)
asynSetTraceMask("serial4",0,DRIVER|ERROR|FLOW)

dbLoadRecords ("${TOP}/TC110App/Db/TC110.db","P=$(PREFIX),M=$(M),PORT=serial4")
dbLoadRecords ("$(ASYN)/db/asynRecord.db", "P=$(PREFIX), R=asyn4, PORT=serial4, ADDR=0, IMAX=80, OMAX=80")
dbLoadRecords ("$(AUTOSAVE)/db/save_restoreStatus.db", "P=$(PREFIX)")

cd "${TOP}/iocBoot/${IOC}"
iocInit

