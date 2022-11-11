local uis = game:GetService("UserInputService")

local ram = {}
local vram = {}
local c = {"print","alloc","dealloc","read"}

function vraminsert(add)
	table.insert(vram,add)
end

function vramremove(add)
	vram[add] = nil
end

function dealloc(val)
	for i,v in ram do
		if v == val then
			ram[i] = nil
		end
	end
end

function flushmem()
	for i,v in ram do
		table.remove(ram,1)
	end
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
		local command = string.split(script.Parent.Text,"#")
		
		local action = command[1]
		local arg = command[2]
		
		
		if action == c[1] then
			table.insert(ram,arg)
			
			for i,v in ram do
				
				if v == arg then
					display(v)
					flushmem()
				end
			end
		end
	end
end)
