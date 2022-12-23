dp = [[dataPosition = Vector3.new(0,0,0)]]
runcode = [[


part = function(className, name, 
shape, 
reflectance, transparency, material, canCollide, size, brickColor, cframe, parent, 
	decalFace, decalTexture, 
	cylinderMeshScale, cylinderMeshOffset, 
	blockMeshScale, blockMeshOffset, 
	specialMeshScale, specialMeshType, specialMeshId)
	local p = Instance.new(className)
	p.Anchored = true
	p.Locked = true
	p.Size = size
	p.Material = material
	if (shape ~= nil) then
		p.Shape = shape
	end
	p.CanCollide = canCollide
	p.Transparency = transparency
	p.Reflectance = reflectance
	p.BrickColor = brickColor
	p.Name = name
	p.CFrame = cframe
	p.TopSurface = 0
	p.BottomSurface = 0
	p.Parent = parent
	
	if (decalTexture ~= "") then
		local d = Instance.new("Decal",p)
		d.Face = decalFace
		d.Texture = decalTexture
	end
	
	if (cylinderMeshScale ~= Vector3.new(0,0,0)) then
		local cm = Instance.new("CylinderMesh",p)
		cm.Scale = cylinderMeshScale
		cm.Offset = cylinderMeshOffset
	end
	
	if (blockMeshScale ~= Vector3.new(0,0,0)) then
		local bm = Instance.new("BlockMesh",p)
		bm.Scale = blockMeshScale
		bm.Offset = blockMeshOffset
	end
	
	if (specialMeshScale ~= Vector3.new(0,0,0)) then
		local sm = Instance.new("SpecialMesh",p)
		sm.Scale = specialMeshScale
		sm.MeshType = specialMeshType
		sm.MeshId = specialMeshId
	end
	
	
	--if (p.Name == "DiscoFloor") then
	local l = Instance.new("PointLight",p)
	l.Brightness = 0.2/27
	l.Range = 666
	--end
	
	
	return p
end

main = function()
	local model = Instance.new("Model",workspace)
	for i,v in pairs(partData) do
		part(v.className, v.name, 
		v.shape, 
		v.reflectance, v.transparency, v.material, v.canCollide, v.size, v.brickColor, v.cframe, model, v.decalFace, v.decalTexture, v.cylinderMeshScale, v.cylinderMeshOffset, v.blockMeshScale, v.blockMeshOffset, v.specialMeshScale, v.specialMeshType, v.specialMeshId)
	end
end

main()
]]


generateSources = function(source)
	--Credit to Gooncreeper @ Roblox for this part of the code
	print("Creating source file, source length " .. #source)

	if #source < 200000 then
		local sourcefile = Instance.new("Script", script)
		sourcefile.Source = source
		sourcefile.Name = "Source"

		print("Source file created :", sourcefile)
	else
		print("Source is >= 200000 characters, resault will have to be split")
		local sources = {}

		local p = 1
		local c = 1
		repeat
			local sourcefile = Instance.new("Script", workspace)
			sourcefile.Source = source:sub(p,p+199998)
			sourcefile.Name = "Source" .. c

			table.insert(sources, sourcefile)
			p += 199999
			c += 1
		until p > #source

		print("Source files created :", table.unpack(sources))
	end
end

main = function()
	local outputz = ""
	local printz = function(stuff)
		outputz = outputz.."\n"..tostring(stuff)
	end
	printz( dp)
	printz( 'partData = {')
	for i,v in pairs(workspace.Model:GetDescendants()) do wait()
		if (v:IsA("Part") or v:IsA("TrussPart")) then
			printz( 
				'{' 
					..'className = "'..v.ClassName..'",'
					..'name = "'..v.Name..'",'
					..'material = '..tostring(v.Material)..','
					..'reflectance = '..tostring(v.Reflectance)..','
					..'transparency = '..tostring(v.Transparency)..','
					..'canCollide = '..tostring(v.CanCollide)..','
					..'size = Vector3.new('..tostring(v.Size)..'),'
					..'brickColor = BrickColor.new("'..tostring(v.BrickColor)..'"),'
					..'cframe = CFrame.fromMatrix('
					..'Vector3.new('
					..'dataPosition.X + '..tostring(v.Position.X)..','
					..'dataPosition.Y + '..tostring(v.Position.Y)..','
					..'dataPosition.Z + '..tostring(v.Position.Z)..''
					..'),'
					..'Vector3.new('
					..tostring(v.CFrame.XVector)
					..'),'
					..'Vector3.new('
					..tostring(v.CFrame.YVector)
					..'),'
					..'Vector3.new('
					..tostring(v.CFrame.ZVector)
					..')'
					..')'
			)
			local checkForShape, _ = pcall(function() return v.Shape end)
			if (checkForShape) then
				printz(',shape = '..tostring(v.Shape)..'')
			else
				printz(',shape = nil')
			end
			if (v:FindFirstChild("Decal")) then
				printz( ', decalTexture = "'..tostring(v:FindFirstChild("Decal").Texture)..'", decalFace = '..tostring(v:FindFirstChild("Decal").Face)..'')
			else
				printz( ', decalFace = "Top", decalTexture = ""')
			end
			if (v:FindFirstChildWhichIsA("CylinderMesh")) then
				printz( ',cylinderMeshScale = Vector3.new('..tostring(v:FindFirstChildWhichIsA("CylinderMesh").Scale)..'),cylinderMeshOffset = Vector3.new('..tostring(v:FindFirstChildWhichIsA("CylinderMesh").Offset)..')')
			else
				printz( ',cylinderMeshScale = Vector3.new(0,0,0),cylinderMeshOffset = Vector3.new(0,0,0)')
			end
			if (v:FindFirstChildWhichIsA("BlockMesh")) then
				printz( ',blockMeshScale = Vector3.new('..tostring(v:FindFirstChildWhichIsA("BlockMesh").Scale)..'),blockMeshOffset = Vector3.new('..tostring(v:FindFirstChildWhichIsA("BlockMesh").Offset)..')')
			else
				printz( ',blockMeshScale = Vector3.new(0,0,0),blockMeshOffset = Vector3.new(0,0,0)')
			end
			if (v:FindFirstChildWhichIsA("SpecialMesh")) then
				printz( ',specialMeshScale = Vector3.new('..tostring(v:FindFirstChildWhichIsA("SpecialMesh").Scale)..'), specialMeshType = '..tostring(v:FindFirstChildWhichIsA("SpecialMesh").MeshType)..', specialMeshId = "'..tostring(v:FindFirstChildWhichIsA("SpecialMesh").MeshId)..'"')

			else
				printz( ',specialMeshScale = Vector3.new(0,0,0), specialMeshType = "Head", specialMeshId = ""')
			end
			printz( '},')
		end
	end
	printz( '}')
	printz( runcode)
	generateSources(outputz)
end

main()
