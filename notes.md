# Lua Labyrinth
### A small text adventure about an unlikely hero
* How can movement be tracked
    * multiples methods
    * two demensional arrays
### current tasks
 - Create test rooms
    * create test items
    * create test entities
- import labyrinth from other file and test to see if present --done
- Create function to read table data from labyrinth(then items and entity tables) --done
- create walk comand --done
   - will ask for cardinal direction
      - *NOTE*if direction doesnt exist, it should return nil right?
- Checking location to return "Path doesnt exist" 
   - Current solution requires the removal of character.location to a global variable so i can make a new variable PrevCharLocation to check and see if the character has moved
      - Check to see if location is more than location or less than location fir
- Command function redo(done)
   + Finish updating commands in commandController
   + command type guard tripping with new cmd results. returning nil
   + Update the help command to include description on commands
- Inventory system
   + Inventory system will be keyword based as the table entry isnt copied unless its equipped(mabye? needed for stat changes)
   + Player and chest have only 10 loot slots
   + Player can perform the following commands with there inventory
      - Equip Armor, potions, and weapons from their inventory
      - Drop items from their inventory(deletes item)
   + players can perform the following commands on chests and corpses
      - Aquire items
      - exit container
- Items
   + Items, unless armor or weapons are single use and are removed from the player inventory
