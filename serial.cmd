################################################################################
# AJA power supply setup

#drvAsynSerialPortConfigure("portName","ttyName",priority,noAutoConnect,noProcessEosIn)
#asynSetOption("portName",addr,"Key","value")

drvAsynSerialPortConfigure("serial1", "COM13", 0, 0, 0)
asynSetOption("serial1",0,"baud","9600")
asynSetOption("serial1",0,"bits","8")
asynSetOption("serial1",0,"stop","1")
asynSetOption("serial1",0,"parity","none")
#asynSetOption("serial1",0,"clocal","Y")
#asynSetOption("serial1",0,"crtscts","N")


# Load asyn records on all serial ports
dbLoadTemplate("asynRecord.template")
dbLoadRecords("$(IP)/db/AJA-powersupply.db","P=$(PREFIX),PORT=serial1")
