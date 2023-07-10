addEvent(":verifCoords",true)
addEventHandler(":verifCoords",root,function()
    if isObjectInACLGroup ( "user." ..getAccountName(getPlayerAccount(source)), aclGetGroup ("Staff")) then
        triggerClientEvent(source,":openCoords",source)
    end
end)