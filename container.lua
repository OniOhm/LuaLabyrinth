-- A basic container is a table consisting of 10 records. the records contain itemsh
local extras = require("extra")
local container = {
	["basicContainer"] = {
		["1"] = "Sword of something",
		["2"] = "blank",
		["3"] = "blank",
		["4"] = "blank",
		["5"] = "blank",
		["6"] = "blank",
		["7"] = "blank",
		["8"] = "blank",
		["9"] = "blank",
		["10"] = "blank",
	},
	["openContainer"] = function(table, tableName, table2)
		local newTable = extras.tableDeepClone(table)
		local inventCmdList = { "EQUIP", "DROP" }
		local inventMark = 1

		local inventoryReducer = function(input)
			local inventoryCommands = {
				["DROP"] = function(toDelete)
					local itemToDelete
					-- just make into a number that runs through the table and replaces it with blank
					-- may need to ask for prompt here instead of straight to delete
					for slotNum, item in pairs(newTable) do
						-- remove tonumber
						if slotNum == toDelete then
							newTable[toDelete] = "blank"
							itemToDelete = item
						end
					end
					print(itemToDelete .. " dropped")
				end,
				["EQUIP"] = function(toAdd)
					print("equip function called")
				end,
			}
			-- add error guard
			print(inventoryCommands[input[1]](input[2]))
		end
		local function cmds(input)
			local command = extras.cmdResolver(inventCmdList, input)
			inventoryReducer(command)
		end
		while inventMark == 1 do
			os.execute("clear")
			print(utf8.char(9659) .. tableName)

			print("Commands: DROP [item] | EQUIP [item]")
			for inventSlot, inventItem in pairs(newTable) do
				print(tostring(inventSlot) .. ")  " .. inventItem)
			end
			local inventRes = string.upper(io.read("*l"))
			if inventRes == "EXIT" then
				inventMark = 2
				return newTable
			elseif type(inventRes) == " " then
				print("command not recognized")
			else
				print(cmds(inventRes))
			end

			io.read("*l")
		end
	end,
}
return container
