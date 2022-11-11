local uis = game:GetService("UserInputService")

local ram = {}
local vram = {}
local c = {"print"}

function vraminsert(add)
	table.insert(vram,add)
end

function vramremove(add)
	table.remove(vram,add)
end

function display(str)
	for i,v in ram do
		if v == str then
			vraminsert(str)
			
			for ind,vr in vram do
				if vr == str then
					script.Parent.Text = vr
					vramremove(ind)
				end
			end
		end
	end
end

uis.InputBegan:Connect(function(input)
	if input.KeyCode == Enum.KeyCode.Return then
		local command = string.split(script.Parent.Text,"+")
		
		local action = command[1]
		local arg = command[2]
		
		if action == c[1] then
			table.insert(ram,arg)
			
			for i,v in ram do
				if v == arg then
					display(v)
					table.remove(ram,i)
				end
			end
		end
	end
end)
