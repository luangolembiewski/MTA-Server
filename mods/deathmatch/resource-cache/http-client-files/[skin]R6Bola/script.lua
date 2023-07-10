txd = engineLoadTXD( 'MaleRamdonSGG1.txd' )
engineImportTXD( txd, 103 )
dff = engineLoadDFF('MaleRamdonSGG1.dff', 103)
engineReplaceModel( dff, 103 )