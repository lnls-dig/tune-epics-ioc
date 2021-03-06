< envPaths
epicsEnvSet("TOP", "../..")
< tune.config
< tuneSI.config

####################################################

## Register all support components
dbLoadDatabase("$(TOP)/dbd/tune.dbd",0,0)
tune_registerRecordDeviceDriver pdbbase

## Load record instances
dbLoadRecords("${TOP}/db/tune.db", "P=$(P), R=$(R), SPEC_ANA=$(SPEC_ANA), AMP=$(AMP)")
dbLoadRecords("${TOP}/db/tuneSI.db", "P=$(P), R=$(R), SPEC_ANA=$(SPEC_ANA), AMP=$(AMP)")

< save_restore.cmd

iocInit

< initTuneCommands

## Start any sequence programs
# No sequencer program

# Create periodic trigger for Autosave
create_monitor_set("auto_settings_tuneSI.req", 5, "P=${P}, R=${R}")
create_triggered_set("auto_settings_tuneSI.req", "${P}${R}Save-Cmd", "P=${P}, R=${R}")
set_savefile_name("auto_settings_tuneSI.req", "auto_settings_${P}${R}.sav")
