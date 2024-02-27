t = GetTargetHPP()
f = GetFocusTargetHPP()
diff = math.floor(math.abs(t-f))
substr = "%!"
str = "Focus %s, current difference is %d%s"
if (t > f and diff > 3) then
   toSend = string.format(str, GetTargetName(), diff, substr)
elseif (f > t and diff > 3) then
   toSend = string.format(str, GetFocusTargetName(), diff, substr)
else
   toSend = "Targets are even!"
end
yield("/echo "..toSend)