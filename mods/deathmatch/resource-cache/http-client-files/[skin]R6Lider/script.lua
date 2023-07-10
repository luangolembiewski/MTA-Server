txd = engineLoadTXD( 'MaleRamdonSGL.txd' )
engineImportTXD( txd, 100 )
dff = engineLoadDFF('MaleRamdonSGL.dff', 100)
engineReplaceModel( dff, 100 )