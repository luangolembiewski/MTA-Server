addEvent(":verifDina",true)
addEventHandler(":verifDina",root,function()
    if isObjectInACLGroup ( "user." ..getAccountName(getPlayerAccount(source)), aclGetGroup ("Staff")) then
        triggerClientEvent(source,":openDina",source)
    end
end)
