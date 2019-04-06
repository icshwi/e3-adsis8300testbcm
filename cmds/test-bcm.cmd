require busy,1.7.0
require ADCore,3.3.2
require adsis8300test,develop
require adsis8300testbcm,develop

errlogInit(20000)

epicsEnvSet("EPICS_CA_MAX_ARRAY_BYTES",     "10000000")

epicsEnvSet("SISDEV",        "/dev/sis8300-5")
epicsEnvSet("PREFIX",        "SIS8300BCM:")
epicsEnvSet("PORT",          "SIS8300BCM")
epicsEnvSet("ACQ_SAMPLES",   "100000")
epicsEnvSet("HOLD_SAMPLES",  "200")

epicsEnvSet("XSIZE",         "$(ACQ_SAMPLES)")
epicsEnvSet("YSIZE",         "1")
epicsEnvSet("TSPOINTS",      "$(HOLD_SAMPLES)")
epicsEnvSet("QSIZE",         "20")
epicsEnvSet("NCHANS",        "100")
epicsEnvSet("CBUFFS",        "500")
epicsEnvSet("MAX_THREADS",   "4")

# Create a SIS8300 driver
# sis8300Configure(const char *portName, const char *devicePath,
#                  int numSamples, int maxBuffers, size_t maxMemory, int priority, int stackSize)
sis8300bcmConfigure("$(PORT)", "$(SISDEV)", $(ACQ_SAMPLES), 0, 0)

dbLoadRecords("sis8300bcm.template","P=$(PREFIX),R=,PORT=$(PORT),ADDR=0,TIMEOUT=1,MAX_SAMPLES=$(ACQ_SAMPLES)")

#asynSetTraceIOMask("$(PORT)",0,2)
#asynSetTraceMask("$(PORT)",0,255)

iocInit()
