txd = engineLoadTXD( 'MaleRamdonSGG2.txd' )
engineImportTXD( txd, 102 )
dff = engineLoadDFF('MaleRamdonSGG2.dff', 102)
engineReplaceModel( dff, 102 )