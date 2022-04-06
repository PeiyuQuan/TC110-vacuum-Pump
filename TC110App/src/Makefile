TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS BELOW HERE

# Use typed rset structure (see 3.16.1 release notes)
USR_CPPFLAGS += -DUSE_TYPED_RSET

# xxxRecord.h will be created from xxxRecord.dbd
DBDINC += xxxRecord

# Install xxxSupport.dbd into <top>/dbd
DBD += xxxSupport.dbd

# Build an IOC support library
LIBRARY_IOC += TC110Support

# Compile and add code to the support library
TC110Support_SRCS += xxxRecord.c
TC110Support_SRCS += devXxxSoft.c

# Link locally-provided code into the support library,
# rather than directly into the IOC application, that
# causes problems on Windows DLL builds
TC110Support_SRCS += dbSubExample.c
TC110Support_SRCS += devTC110Version.c
TC110Support_SRCS += TC110Hello.c
TC110Support_SRCS += initTrace.c

TC110Support_LIBS += $(EPICS_BASE_IOC_LIBS)

# Auto-generate a header file containing a version string.
# Version comes from the VCS if available, else date+time.
GENVERSION = TC110Version.h
# Macro name
GENVERSIONMACRO = TC110VERSION

# Build the IOC application
PROD_IOC = TC110

# TC110.dbd will be created and installed
DBD += TC110.dbd

# TC110.dbd will include these files:
TC110_DBD += base.dbd
TC110_DBD += xxxSupport.dbd
TC110_DBD += dbSubExample.dbd
TC110_DBD += devTC110Version.dbd
TC110_DBD += TC110Hello.dbd
TC110_DBD += initTrace.dbd
TC110_DBD += asyn.dbd
TC110_DBD += drvAsynIPPort.dbd
TC110_DBD += drvAsynSerialPort.dbd
TC110_DBD += calc.dbd
TC110_DBD += stream-scalcout.dbd
TC110_DBD += stream.dbd
TC110_DBD += as.dbd
TC110_DBD += asSupport.dbd
# TC110_registerRecordDeviceDriver.cpp derives from TC110.dbd
TC110_SRCS += TC110_registerRecordDeviceDriver.cpp

# Build the main IOC entry point where needed
TC110_SRCS_DEFAULT += TC110Main.cpp
TC110_SRCS_vxWorks += -nil-

# Link in the code from our support library
TC110_LIBS += TC110Support
TC110_LIBS += asyn
TC110_LIBS += calc
TC110_LIBS += autosave
TC110_LIBS += stream
# To build SNL programs, SNCSEQ must be defined
# in the <top>/configure/RELEASE file
ifneq ($(SNCSEQ),)
    # Build sncExample into TC110Support
    sncExample_SNCFLAGS += +r
    TC110_DBD += sncExample.dbd
    # A .stt sequence program is *not* pre-processed:
    TC110Support_SRCS += sncExample.stt
    TC110Support_LIBS += seq pv
    TC110_LIBS += seq pv

    # Build sncProgram as a standalone program
    PROD_HOST += sncProgram
    sncProgram_SNCFLAGS += +m
    # A .st sequence program *is* pre-processed:
    sncProgram_SRCS += sncProgram.st
    sncProgram_LIBS += seq pv
    sncProgram_LIBS += $(EPICS_BASE_HOST_LIBS)
endif

# Link QSRV (pvAccess Server) if available
ifdef EPICS_QSRV_MAJOR_VERSION
    TC110_LIBS += qsrv
    TC110_LIBS += $(EPICS_BASE_PVA_CORE_LIBS)
    TC110_DBD += PVAServerRegister.dbd
    TC110_DBD += qsrv.dbd
endif

# Finally link IOC to the EPICS Base libraries
TC110_LIBS += $(EPICS_BASE_IOC_LIBS)

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD EXTRA GNUMAKE RULES BELOW HERE

# Explicit dependency needed for generated header file
devTC110Version$(DEP): $(COMMON_DIR)/$(GENVERSION)
