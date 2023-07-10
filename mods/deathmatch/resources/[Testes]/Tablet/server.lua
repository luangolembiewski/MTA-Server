
local acl= "Staff"

function painel(source)
    if isObjectInACLGroup ( "user." ..getAccountName(getPlayerAccount(source)), aclGetGroup ( acl )) then
        triggerClientEvent (source, "tablet", root)
    end
end


addCommandHandler("tablet",painel)



