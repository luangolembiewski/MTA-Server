
----------------------------------------------------------------------------------------------------
-------------------------------------------- By -Thiagu* -------------------------------------------
--                                Por favor, não retire os creditos!                              --

addEvent("controlWheels", true)
addEventHandler("controlWheels", getRootElement(),
function( player, veh, wheel, sW)
triggerClientEvent(getRootElement(), "changeWheels", player, veh, wheel, sW)
end
)