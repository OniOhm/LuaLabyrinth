extras = {
	["gameversion"] = "alpha",
	["title"] = " __   __  _______  __   __  _______  __   __    _______  _______    _______  __   __  _______    __   __  ___   __    _  _______  _______  _______  __   __  ______\n"
		.. "|  |_|  ||       ||  | |  ||       ||  | |  |  |       ||       |  |       ||  | |  ||       |  |  |_|  ||   | |  |  | ||       ||       ||   _   ||  | |  ||    _ |    \n"
		.. "|       ||   _   ||  | |  ||_     _||  |_|  |  |   _   ||    ___|  |_     _||  |_|  ||    ___|  |       ||   | |   |_| ||   _   ||_     _||  |_|  ||  | |  ||   | ||    \n"
		.. "|       ||  | |  ||  |_|  |  |   |  |       |  |  | |  ||   |___     |   |  |       ||   |___   |       ||   | |       ||  | |  |  |   |  |       ||  |_|  ||   |_||_   \n"
		.. "|       ||  |_|  ||       |  |   |  |       |  |  |_|  ||    ___|    |   |  |       ||    ___|  |       ||   | |  _    ||  |_|  |  |   |  |       ||       ||    __  |  \n"
		.. "| ||_|| ||       ||       |  |   |  |   _   |  |       ||   |        |   |  |   _   ||   |___   | ||_|| ||   | | | |   ||       |  |   |  |   _   ||       ||   |  | |  \n"
		.. "|_|   |_||_______||_______|  |___|  |__| |__|  |_______||___|        |___|  |__| |__||_______|  |_|   |_||___| |_|  |__||_______|  |___|  |__| |__||_______||___|  |_|  \n",
	["listDirections"] = function(labyrinth)
		-- should it print all know locations. just make a combined string
		local directions = labyrinth["linkedRooms"]
		local directionList = "Available directions: "
		for k, roomId in pairs(directions) do
			directionList = directionList .. " " .. k
		end
		return directionList
	end,
	["getRooms"] = function(labyrinth)
		local doors = labyrinth.linkedRooms
		-- need a table to add just the key name of linked rooms
		local openDoors = {}
		for k, roomId in pairs(doors) do
			table.insert(openDoors, k)
		end
		return openDoors
	end,
	["cmdResolver"] = function(cmdList, command)
		--needs to return a table to be used by the command reducer
		local chosenCmd = {}
		local sortedCmd = {}
		local tableSize = 0
		-- runs through given cmdList
		for w in string.gmatch(command, "%w+") do
			table.insert(sortedCmd, w)
		end
		for w, cmdTerm in ipairs(cmdList) do
			if cmdTerm == sortedCmd[1] then
				table.insert(chosenCmd, sortedCmd[1])
				break
			end
		end
		for item in pairs(sortedCmd) do
			tableSize = tableSize + 1
		end
		for i = 2, tableSize, 1 do
			chosenCmd[i] = sortedCmd[i]
		end
		-- table within a table situation
		--table.insert(chosenCmd, sortedCmd[2])
		return chosenCmd
	end,
	["tableClone"] = function(org)
		return { table.unpack(org) }
	end,
	["tableDeepClone"] = function(org_table)
		local copy = {}
		for value, item in pairs(org_table) do
			copy[value] = item
		end
		return copy
	end,
}

-- Testing
--local test_table = {
--	["itemName"] = "Rock",
--	["itemDescription"] = "Just a plain ordinary rock nothing special",
--	["itemSlot"] = "CONSUM",
--	["itemValue"] = 1,
--}
--
--print("testing deepClonetable")
--local newtab = extras["tableDeepClone"](test_table)
--print(newtab["itemName"])

return extras
