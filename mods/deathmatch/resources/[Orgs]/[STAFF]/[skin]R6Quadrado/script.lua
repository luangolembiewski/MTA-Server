txd = engineLoadTXD( 'MaleRamdonSGG3.txd' )
engineImportTXD( txd, 101 )
dff = engineLoadDFF('MaleRamdonSGG3.dff', 101)
engineReplaceModel( dff, 101 )