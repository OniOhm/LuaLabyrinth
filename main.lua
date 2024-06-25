local version = "dev"
local items = require("items")
local maze = require("labyrinth")
local extra = require("extra")
local container = require("container")
local currentLocation = 1
local prevCharLocation = 0
local cmdList = { "WALK", "STAT", "LOOK", "INVENTORY", "HELP" }
-- The character table(object) will act as a read only with the command function doing the majority of the work
local Character = {
	["name"] = "The Hero",
	["SKILLS"] = {
		["STR"] = 2,
		["DEX"] = 0,
		["WIL"] = 1,
	},
	["Level"] = 1,
	["EQUIPPED"] = {
		["Armor"] = {},
		["LHand"] = {},
		["RHand"] = {},
		["belt1"] = {},
		["belt2"] = {},
	},
	-- container has been converted to a table need to perform a deeper copy of the table to use correctly
	["INVENTORY"] = extra.tableClone(container["basicContainer"]),
	-- getter methods
	["getstats"] = function(self)
		for k, v in pairs(self.SKILLS) do
			print(k .. " --> " .. tostring(v))
		end
	end,
}
-- to delete
local entityFuncs = {
	["getStats"] = function(entity)
		for k, v in pairs(entity.SKILLS) do
			print(k .. " --> " .. tostring(v))
		end
	end,
}
-- need to add a modifier paremeter for stats intergration
function UniversalRoller(diceNum, dieLimit)
	local resultTable = {}
	local dieRoll
	for i = 1, diceNum do
		dieRoll = math.floor(math.random(1, dieLimit))
		table.insert(resultTable, dieRoll)
	end
	return resultTable
end
local function playTitle()
	print(extra.title)
	print(
		"In the heart of an ancient realm, where myths intertwine with reality, there exists a labyrinthine maze shrouded in mystery and peril – the domain of the dreaded Minotaur. Legends whispered of its twisting corridors, where the echoes of past heroes' footsteps mingled with the roars of the monstrous beast that lurked within."
	)
	print("press enter to continue")

	local pahs = io.read("*l")

	print(
		"Yet, amidst the daunting tales, a lone warrior emerged, fueled not by fear, but by an unwavering resolve and love that knew no bounds. Clad in armor forged from the finest steel, his sword gleamed with determination as he embarked on a quest that would test both his strength and his spirit."
	)

	print("press enter to continue")
	io.read("*l")
	os.execute("clear")
end
-- update to include a action parem
local function commandController(command)
	-- multi word commands now consist of a keyword and a command result table. change commands that use data to acommidate this new structure
	-- commit made 6/19/24
	local Commands = {
		["WALK"] = function(direction)
			local walkTo = string.upper(direction[2])
			local openDoors = extra.getRooms(maze[currentLocation])
			-- needs to return both key and value pair the key is needed for comparision and the value is needed to change character location
			if walkTo ~= "NORTH" and walkTo ~= "SOUTH" and walkTo ~= "EAST" and walkTo ~= "WEST" then
				print("invalid direction")
			else
				for locDirection, locValue in pairs(maze[currentLocation].linkedRooms) do
					if walkTo == locDirection then
						prevCharacterLoc = currentLocation
						currentLocation = locValue
						break
					end
				end
				if currentLocation == prevCharacterLoc then
					print("There is no path in that direction")
				else
					print("You walk to the " .. tostring(maze[currentLocation].RoomTitle))
				end
			end
		end,
		["STAT"] = function()
			entityFuncs.getStats(Character)
		end,
		["INVENTORY"] = function()
			local inventCmdList = { "EQUIP", "DROP" }
			local inventMark = 1

			local inventoryReducer = function(input)
				local inventoryCommands = {
					["DROP"] = function(toDelete)
						local itemToDelete
						-- just make into a number that runs through the table and replaces it with blank
						-- may need to ask for prompt here instead of straight to delete
						for slotNum, item in ipairs(Character["INVENTORY"]) do
							if slotNum == tonumber(toDelete) then
								Character["INVENTORY"][tonumber(toDelete)] = "blank"
								itemToDelete = item
							end
						end
						print(itemToDelete .. " dropped")
					end,
					["EQUIP"] = function(toEquip)
						print("equip function called")
					end,
				}
				print(inventoryCommands[input[1]](input[2]))
			end
			local function cmds(input)
				local command = extra.cmdResolver(inventCmdList, input)
				inventoryReducer(command)
			end
			while inventMark == 1 do
				os.execute("clear")
				print(type(Character.INVENTORY[1]))
				print(utf8.char(9659) .. "inventory")

				print("Commands: DROP [item] | EQUIP [item]")
				for inventSlot, inventItem in ipairs(Character["INVENTORY"]) do
					print(tostring(inventSlot) .. ")  " .. inventItem)
				end
				local inventRes = string.upper(io.read("*l"))
				if inventRes == "EXIT" then
					inventMark = 2
				else
					print(cmds(inventRes))
				end

				io.read("*l")
			end
		end,
		["LOOK"] = function()
			print(maze[currentLocation]["RoomDescript"])
			print(extra.listDirections(maze[currentLocation]))
		end,
		["ROLL DICE"] = function()
			print("number of dice?\n")
			local numDice = io.read("*l")
			print("limit of die?\n")
			local dieLimit = io.read("*l")
			local results = UniversalRoller(numDice, dieLimit)
			for i, item in ipairs(results) do
				print(item)
			end
		end,
		["HELP"] = function(keyword)
			local HelpReducer = {
				["STAT"] = "Displays Stats",
				["LOOK"] = "usage: look\nLook around the current local",
				["INVENTORY"] = "usage: inventory displays character inventory",
				["WALK"] = "usage: walk [DIRECTION] \n Walks in given direction if that direction is available",
				["LIST"] = "usage: help [KEYWORD]\n type Help followed by the following keyword for more information\n walk, stat, look, inventory",
			}
			if type(keyword) == "function" then
				print(HelpReducer["LIST"])
			else
				print(HelpReducer[string.upper(keyword)])
			end
		end,
	}
	local prompt = ""
	if type(command[2]) == "nil" then
		prompt = Commands[command[1]]
	else
		prompt = Commands[command[1]](command)
	end
	if type(prompt) == "string" then
		print(prompt)
	elseif type(prompt) == "function" then
		prompt(prompt)
	end
	-- this if statment needs to be changed to actually handle results that could include other things
	print("\n\npress any key to continue")
	io.read("*l")
	os.execute("clear")
end

function main()
	cmdInput = function(cmdList, cmd)
		local results = extra.cmdResolver(cmdList, cmd)

		return results
	end
	playTitle()
	local state = 1
	while state == 1 do
		print("Mouth of the Minotaur - version" .. version)
		print(
			"What do you want to do?"
				.. "\nCurrent location: "
				.. tostring(maze[currentLocation].RoomTitle)
				.. "\nType 'help list' for a list of commands."
				.. "\n----------------------------"
		)
		local command = string.upper(io.read("*l"))

		inputConsumer = function(cmd)
			commandController(cmdInput(cmdList, cmd))
		end
		if command == "EXIT" then
			state = 0
		else
			print("\n")
			inputConsumer(command)
		end
	end
end
main()
