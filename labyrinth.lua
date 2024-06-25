local labyrinth = {
	[0] = function()
	end,
	[1] = {
	['RoomTitle'] = 'Entrance',
	-- a description of the room itself
	['RoomDescript']='Massive stone pillars flank the entrance, their surfaces weathered by time and adorned with creeping ivy, adding an aura of ancient wisdom to the scene.The entrance itself is a grand archway, its intricately carved designs depicting scenes of myth and legend. As you step closer, you notice the faint glow emanating from within, hinting at the secrets that lie beyond. The air carries a faint scent of moss and damp earth, adding to the mystique of the place.',
	-- linked rooms: doors that lead to other rooms
	['linkedRooms'] = {
			['NORTH']= 2
		},
	-- items in room that can be taken
		-- items will be ased on a number whose data will be contianed in another data_table that will hold all item data
	['roomItems'] = '',
	-- room entities
		--  entities will be based on a number that is contained in another data_table that will hold all entity data
	['entities'] = '',
	},
	[2] = {	
	['RoomTitle'] = 'Crossroads',
	-- a description of the room itself
	['RoomDescript']='he main corridor stretches out straight ahead, flanked by tall, arched doorways leading to various rooms of the mansion. Richly upholstered chairs and occasional tables line the walls, inviting guests to pause and admire the ornate artwork and tapestries adorning the space.At the end of the hallway, the corridor branches off into two distinct paths, forming the characteristic T-shape. To the left, a narrower passage leads to a cozy library or perhaps a private study, with shelves upon shelves of leather-bound books and plush armchairs arranged around a crackling fireplace.',
	-- linked rooms: doors that lead to other rooms
	['linkedRooms'] = {

			['SOUTH']= 1,
			['EAST'] = 3,
			['WEST'] = 4
		},
	-- items in room that can be taken
	-- room entities
	-- 
	['entities'] = '',
	},
		[3] = {	
	['RoomTitle'] = 'Study',
	-- a description of the room itself
	['RoomDescript']='The study room in the mansion is a sanctuary of intellectual pursuits and refined tastes. As you step inside, rich mahogany bookcases line the walls, filled to the brim with leather-bound tomes and antique volumes, their spines gleaming under the warm glow of the brass desk lamps. ',
	-- linked rooms: doors that lead to other rooms
	['linkedRooms'] = {
			['WEST'] = 2,
		},
	-- items in room that can be taken
	-- room entities
	-- 
	['entities'] = '',
	},
	[4] = {	
	['RoomTitle'] = 'Kitchen',
	-- a description of the room itself
	['RoomDescript']='The kitchen in the mansion is a culinary haven, marrying functionality with exquisite design. Upon entering, one is greeted by the inviting aroma of freshly baked bread and simmering spices. Gleaming marble countertops stretch along the walls, punctuated by professional-grade stainless steel appliances that glisten under the warm glow of recessed lighting. A large island takes center stage, its polished surface perfect for meal preparation or casual dining, surrounded by high-backed stools upholstered in luxurious fabrics. Oversized windows flood the space with natural light, offering views of manicured gardens or sweeping vistas beyond. From the gleaming copper cookware hanging above the stove to the meticulously organized pantry stocked with gourmet ingredients, every detail speaks to a commitment to culinary excellence and tasteful luxury.',
	-- linked rooms: doors that lead to other rooms
	['linkedRooms'] = {
			['EAST'] = 2
		},
	-- items in room that can be taken
	-- room entities
	-- 
	['entities'] = '',
	},
}







return labyrinth
