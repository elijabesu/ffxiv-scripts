channel = "/p" --change to /y for Bozja

diff = math.floor(math.abs(GetTargetHPP() - GetFocusTargetHPP()))
if (t > f and diff > 3) then
   toSend = "Focus "..GetTargetName()..", current difference is "..diff.."%!"
elseif (f > t and diff > 3) then
   toSend = "Focus "..GetFocusTargetName()..", current difference is "..diff.."%!"
else
   toSend = "Targets are even!"
end
yield(channel.." "..toSend)