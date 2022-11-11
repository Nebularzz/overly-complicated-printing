local uis = game:GetService("UserInputService")

local ram = {}
local vram = {}
local c = {"print","add"}

function vraminsert(add)
	table.insert(vram,add)
end

function vramremove(add)
	table.remove(vram,add)
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
		local command = string.split(script.Parent.Text,"+")
		
		local action = command[1]
		local arg = command[2]
		
		local calc = command[1]
		local n1 = command[2]
		local n2 = command[3]
		
		if action == c[1] then
			table.insert(ram,arg)
			
			for i,v in ram do
				if v == arg then
					display(v)
					table.remove(ram,i)
				end
			end
		end
		
		
		if calc == c[3] then
			table.insert(ram, n1)
			table.insert(ram,n2)
			
			for i,v in ram do
				if v == n1 then
					for i,v2 in ram do
						if v2 == n2 then
							local a = tonumber(v)
							table.insert(ram,a)
							local a2 = tonumber(v2)
							table.insert(ram,v2)
							
							for i,n in ram do
								if n == a2 then
									for i,b in ram do
										if b == a then
											table.insert(ram,n+b)
											for i,aa in ram do
												if aa == n+b then
													display(aa)
													flushmem()
													for k,vr in vram do
														print("a")
														vramremove(k)
													end
												end
											end
										end
									end
									
									print("calculating")
									
								end
							end
						end
					end
				end
			end
		end
	end
end)
