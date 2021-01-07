-- pls set tabs to width of 4 spaces
class	= require "lib/middleclass"
wind	= require "lib/windfield"
stalker	= require "lib/STALKER-X"

downwall = 1; rightwall = 2; leftwall = 3
mainmenu = 0; game = 1; gameover = 2; pause = 3; youwin = 4

world = wind.newWorld(0, 40, true)

-- GAME STATES
--------------------------------------------------------------------------------
-- LOVE
----------------------------------------
function love.load ()
	math.randomseed(os.time())

	dieParticle = nil
	love.graphics.setDefaultFilter("nearest", "nearest")
	a_ttf = love.graphics.newFont("art/font/alagard.ttf", nil, "none")
	r_ttf = love.graphics.newFont("art/font/romulus.ttf", nil, "none")

	camera = stalker()

	mainmenu_load()
end


function love.update(dt)
	if(mode == mainmenu) then		mainmenu_update(dt)
	elseif(mode == game) then		game_update(dt)
	elseif(mode == gameover) then	gameover_update(dt)
	elseif(mode == youwin) then		youwin_update(dt)
	elseif(mode == pause) then		pause_update(dt)
	end
	camera:update(dt)
end


function love.draw()
	camera:attach()
	if(mode == mainmenu)		then mainmenu_draw()
	elseif(mode == game)		then game_draw()
	elseif(mode == gameover)	then gameover_draw()
	elseif(mode == youwin)		then youwin_draw()
	elseif(mode == pause)		then pause_draw()
	end
	camera:detach()
	camera:draw()
end


function love.resize()
	camera = stalker()
end


function love.keypressed(key)
	if(mode == mainmenu) then		mainmenu_keypressed(key)
	elseif(mode == game) then		game_keypressed(key)
	elseif(mode == gameover) then	gameover_keypressed(key)
	elseif(mode == youwin) then		youwin_keypressed(key)
	elseif(mode == pause) then		pause_keypressed(key)
	end
end


function love.keyreleased (key)
	if(mode == mainmenu) then		mainmenu_keyreleased(key)
	elseif(mode == game) then		game_keyreleased(key)
	elseif(mode == gameover) then	gameover_keyreleased(key)
	elseif(mode == youwin) then		youwin_keyreleased(key)
	elseif(mode == pause) then		pause_keyreleased(key)
	end
end


-- MENU STATE
----------------------------------------
function mainmenu_load ()
	mode = mainmenu
	selection = 1
	if(bgm) then
		bgm:stop()
	end
	bgm = love.audio.newSource("art/music/default.mp3", "static")
	bgm:play()
	bgm:setLooping(true)
--	bgm:setVolume(1.5)
	frontMenu = nil
	mapMenu = nil

	frontMenu_init()

	camera = stalker()
	map = Map:new("maps/sys/menu.lua")
	player.following = true
end


function mainmenu_update(dt)
	if not (mapMenu == nil) then return; end

	world:update(dt)
	player:update(dt)
	map:update(dt)

	-- make player monkey move randomly
	local num = math.random(100)
	local dirs = player.directionals
	if (num == 1) then
		dirs['left'] = 1
		dirs['right'] = 0
	elseif (num == 2) then
		dirs['right'] = 1
		dirs['left'] = 0
	elseif (num == 3) then
		dirs['up'] = 1
	end
end


function mainmenu_draw ()
	if (mapMenu == nil) then
		map:draw()
		player:draw()
		frontMenu:draw()
	else
		mapMenu:draw()
	end
end


function mainmenu_keypressed(key)
	if (mapMenu == nil) then
		frontMenu:keypressed(key)
	else
		mapMenu:keypressed(key)
	end
end


function mainmenu_keyreleased(key)
	if (mapMenu == nil) then
		frontMenu:keyreleased(key)
	else
		mapMenu:keyreleased(key)
	end
end


function frontMenu_init()
	frontMenu = Menu:new(100, 100, 30, 50, 3, {
		{love.graphics.newText(a_ttf, "get banana"),
			function () mapMenu_init() end},
--				camera:fade(.2, {0,0,0,1}, function() mapMenu_init() end)
--				2, {0,0,0,1}, function() mapMenu_init() end)
--			end},
		{love.graphics.newText(a_ttf, "get outta dodge"),
			function () love.event.quit(0) end }})
	mapMenu = nil
end


function mapMenu_init(directory)
	directory = directory or "maps"
	local menuEntries = {[1] = {love.graphics.newText(a_ttf, "../"),
		function () mainmenu_load() end}}
--			if (directory == "maps") then mainmenu_load()

	local indice = 2
	local files = love.filesystem.getDirectoryItems(directory)

	for k,file in pairs(files) do
		file = directory .. "/" .. file
		local filetype = love.filesystem.getInfo(file).type
		local fileSplit = split(file, ".")
		local fileExt = fileSplit[2] or ""
		
		if (filetype == "directory") then
			menuEntries[indice] = {love.graphics.newText(a_ttf, file .. "/"),
					function() mapMenu_init(file) end}
			indice = indice + 1
		elseif (filetype == "file" and fileExt == "lua") then
			menuEntries[indice] = {love.graphics.newText(a_ttf, fileSplit[1]),
					function() game_load(file) end}
			indice = indice + 1
		end
	end

	mapMenu = Menu:new(100, 100, 30, 50, 3, menuEntries)
	frontMenu = nil
end


-- PAUSE STATE
----------------------------------------
function pause_load()
	if(bgm) then
		bgm:stop()
	end
	mode = pause
end


function pause_update(dt)
end


function pause_draw ()
	game_draw()
	camera:detach()
	love.graphics.draw(love.graphics.newText(r_ttf,
		"paused\n[enter to continue]\n[escape to exit]"), 200, 200, 0, 3, 3)
	camera:attach()
end


function pause_keypressed(key)
	if (key == "return") then
		if(bgm) then
			bgm:play()
		end
		mode = game
	elseif (key == "escape") then
		mainmenu_load()
	end
end


function pause_keyreleased(key)
end


-- GAMEOVER STATE
----------------------------------------
function gameover_load ()
	mode = gameover
end


function gameover_update(dt)
end


function gameover_draw ()
	game_draw()
	camera:detach()
	love.graphics.draw(love.graphics.newText(r_ttf,
		"nice try!\n[enter to restart]\n[escape to exit]"), 200, 200, 0, 3, 3)
	camera:attach()
end


function gameover_keypressed(key)
	if (key == "return" or key == "space") then
		camera:fade(.2, {0,0,0,1}, function() game_load() end)
	elseif (key == "escape") then
		mainmenu_load()
	end
end


function gameover_keyreleased(key)
end



-- YOUWIN STATE
----------------------------------------
function youwin_load ()
	mode = youwin

	if(bgm) then
		bgm:stop()
	end
	bgm = love.audio.newSource("art/music/win.mp3", "static")
	bgm:play()
	bgm:setLooping(true)

	camera = stalker()
	map = Map:new("maps/sys/win.lua")
end


function youwin_update(dt)
	world:update(dt)
	player:update(dt)
end


function youwin_draw ()
	map:draw()
	player:draw()

	camera:detach()
	love.graphics.draw(love.graphics.newText(r_ttf,
		"monkey happy!\nhit enter!"), 200, 200, 0, 3, 3)
	camera:attach()
end


function youwin_keypressed(key)
	if (key == "return" or key == "space" or key == "escape") then
		mainmenu_load()
	end
end


function youwin_keyreleased(key)
end



-- GAME STATE
----------------------------------------
function game_load(mapfile)
	mode = game

	mapfile = mapfile or map.filepath
	map = Map:new(mapfile)

	camera:fade(.2, {0,0,0,0})
	camera:setFollowLerp(0.1)
	camera:setFollowStyle('PLATFORMER')

--	bgm:stop()
--	bgm = love.audio.newSource("art/music/game.ogg", "static")
--	bgm:play()
end


function game_update(dt)
	world:update(dt)
	player:update(dt)
	map:update(dt)

	local x, y = player.monks[player.current].body:getPosition()
	camera:follow(x, y)
end


function game_draw ()
	map:draw()
	player:draw()
end


function game_keypressed(key)
	local dir = player.directionals

	-- if a player presses the left key, then holds the right key, they should
	-- go right until they let go, then they should go left.
	if (key == "right" or key == "d") then
		dir['right'] = 1
		if (dir['left'] == 1) then dir['left'] = 2; end
	elseif (key == "left" or key == "a") then
		dir['left'] = 1
		if (dir['right'] == 1) then dir['right'] = 2; end
	elseif (key == "up" or key == "w") then
		dir['up'] = 1
		if (dir['down'] == 1) then dir['down'] = 2; end

	elseif (key == "space") then
		player:freeze()

	elseif (key == "f" and player.following == false) then
		player.following = true
	elseif (key == "f" and player.following == true) then
		player.following = false

	elseif (key == "=" and camera.scale < 10) then
		camera.scale = camera.scale + .5
	elseif (key == "-" and camera.scale > .5) then
		camera.scale = camera.scale - .5

	elseif (key == "escape") then
		pause_load()
	end
end


function game_keyreleased (key)
	local dir = player.directionals
	local monk = player.monks[player.current]
	local dx, dy = monk:getLinearVelocity()

	if (key == "right" or key == "d") then
		dir['right'] = 0
		monk:setLinearVelocity(dx - 150, dy)
	elseif (key == "left" or key == "a") then
		dir['left'] = 0
		monk:setLinearVelocity(dx + 150, dy)
	elseif (key == "up" or key == "w") then
		dir['up'] = 0
	elseif (key == "down") then
		dir['down'] = 0
	end
end



-- CLASSES
--------------------------------------------------------------------------------
-- MONK		player class
----------------------------------------
Monk = class('Monk')

function Monk:initialize(x, y, count)
	self.monks = {}
	self.frozen = {}
	self.onGround = {}
	self.current = 0
	self.last = count - 1
	self.following = false
	self.directionals = {}

	self.monkSprites = {}
	self.sprites ={
		['default'] = love.graphics.newImage("art/sprites/monk.png"),
		['jump'] = love.graphics.newImage("art/sprites/monk-jump.png"),
		['frozen'] = love.graphics.newImage("art/sprites/monk-frozen.png") }
		
	for i=0,(count-1) do
		self.monks[i] = world:newRectangleCollider(x - (i * 20), y, 16, 16);
		self.monks[i]:setCollisionClass('monk')
		self.monks[i]:setObject(self)
		self.monkSprites[i] = 'default'
		self.frozen[i] = false

		local collision = self:makeCollisionCallback(i)
		self.monks[i]:setPreSolve(collision)
		self.onGround[i] = 0
	end
end


function Monk:update(dt)
	local dir = self.directionals

	if (self.following == true) then self:follow()
	else self:idle()
	end

	self:movement()

	for i=0,(self.last) do
		if (self.onGround[i] > 0) then self.monkSprites[i] = 'default'
		elseif (self.frozen[i] == true) then self.monkSprites[i] = 'frozen'
		else self.monkSprites[i] = 'jump'
		end
	end

	local allFrozen = true
	for k,frozen in pairs(self.frozen) do
		if (frozen == true) then
			self.monks[k]:setType('static')
			self.monks[k]:setCollisionClass('platform')
		elseif (frozen == false) then
			allFrozen = false
		end
	end
	if (allFrozen == true) then gameover_load(); end

	-- cleanup
	for i=0,(self.last) do
		self.onGround[i] = 0
	end
	if (dir['left'] == 2 and dir['right'] == 0) then dir['left'] = 1; end
	if (dir['right'] == 2 and dir['left'] == 0) then dir['right'] = 1; end
end


function Monk:draw ()
	for i=0,self.last do
		local monk = self.monks[i]
		local x,y = monk.body:getWorldPoints(monk.shape:getPoints())

		love.graphics.draw(self.sprites[self.monkSprites[i]], x, y,
			monk.body:getAngle(), 1, 1)
	end
end


function Monk:movement ()
	local monk = self.monks[self.current]
	local dx, dy = monk:getLinearVelocity()
	local dir = self.directionals
	local newVel = 250
	local onGround = self.onGround[self.current]

	if not (onGround == downwall) then
		newVel = newVel - 50
	end

	if (dir['left'] == 1) then
		monk:setLinearVelocity(-newVel, dy);
	elseif (dir['right'] == 1) then
		monk:setLinearVelocity(newVel, dy);
	end

	if (dir['up'] == 1 and onGround == downwall) then
		monk:setLinearVelocity(dx, -newVel);
	elseif (dir['up'] == 1 and onGround == leftwall) then
		monk:setLinearVelocity(newVel, -newVel - 30);
	elseif (dir['up'] == 1 and onGround == rightwall) then
		monk:setLinearVelocity(-newVel, -newVel - 30);
	end
end


-- try to get non-player monkeys in party to rougly follow player
function Monk:follow ()
	if (self.current == self.last) then return 0; end

	local monk = self.monks[self.current]
	local x, y = monk.body:getPosition()
	local newVel = 300
	if (self.onGround[self.current] == 0) then
		newVel = newVel - 50
	end

	for i=self.current+1,self.last do
		local thisMonk = self.monks[i]
		local mx, my = thisMonk.body:getPosition()
		local dx, dy = thisMonk:getLinearVelocity()

		if (mx < (x + 30) and math.random(20) == 1) then
			thisMonk:setLinearVelocity(newVel, dy)
		elseif ((x - 30) < mx and math.random(10) == 1) then
			thisMonk:setLinearVelocity(-newVel, dy)
		end

		if (y < my and self.onGround[i] == downwall) then
			thisMonk:setLinearVelocity(dx, -newVel)
		end
	end
end


-- non-player monkeys hop every second-ish idly
function Monk:idle ()
	if (self.current == self.last) then return; end

	for i=self.current+1,self.last do
		if (self.onGround[i] == downwall and math.random(20) == 5) then
			local thisMonk = self.monks[i]
			local dx, dy = thisMonk:getLinearVelocity()
			self.monks[i]:setLinearVelocity(dx, -100)
		end
	end
end


-- freeze the player monkey in place, making it a platform
function Monk:freeze (indice)
	indice = indice or self.current
	local monk = self.monks[indice]
	self.frozen[indice] = true

	if (indice == self.current) then
		for i=0,self.last do
			if (self.frozen[self.last - i] == false) then
				self:switch(self.last - i)
				i = self.last
			end
		end
	end
end


-- switch from current monkey to next
function Monk:switch (index)
	self.current = index
end


-- each monkey in party needs a unique callback
function Monk:makeCollisionCallback (i)
	local function collision(collision1, collision2, contact)
		local nx, ny = contact:getNormal( )

		if (collision1.collision_class == "monk"
		and collision2.collision_class == "platform")
		then
			if (math.abs(ny) == 1) then
				self.onGround[i] = downwall
			elseif (nx < 0) then
				if not (self.onGround[i] == 0) then return; end
				self.onGround[i] = leftwall
			elseif (nx > 0) then
				if not (self.onGround[i] == 0) then return; end
				self.onGround[i] = rightwall
			end

		elseif (collision1.collision_class == "monk"
		and collision2.collision_class == "banana")
		then
			youwin_load()

		elseif (collision1.collision_class == "monk"
		and collision2.collision_class == "button")
		then
			map.buttonHit = true

		elseif (collision1.collision_class == "monk"
		and collision2.collision_class == "frozenButton"
		and self.frozen[i] == true)
		then
			map.frozenHit = true
		end
	end
	return collision
end



-- BANNANA		owo (win condition obj)
----------------------------------------
Banana = class('Banana')

function Banana:initialize(x, y)
	self.sprite = love.graphics.newImage("art/sprites/banana.png")
	self.collider = world:newRectangleCollider(x, y, 16, 16);
	self.collider:setCollisionClass('banana')
end


function Banana:draw()
	local col = self.collider
	local x,y = col.body:getWorldPoints(col.shape:getPoints())
	love.graphics.draw(self.sprite, x, y, col.body:getAngle(), 1, 1)
end



-- MAP	used to store map data (ofc)
----------------------------------------
Map = class('Map')

function Map:initialize(filepath)
	self.filepath = filepath
	self.ground = {}
	self.platforms = {}
	self.tables = {}
	self.objects = {}
	self.outOfBounds = "die"
	self.spawn = {['x'] = 100, ['y'] = 100}
	self.respawn = {['x'] = 100, ['y'] = 100}
	self.buttonHit = false
	self.frozenHit = false

	local maptable = dofile(filepath)

	self.width,self.height = maptable.width,maptable.height
	self.tileWidth,self.tileHeight = maptable.tilewidth,maptable.tileheight

	love.graphics.setBackgroundColor(146/255, 187/255, 203/255)
	local monkCount = 3
	local monkX,monkY = 100,100
	world:destroy()
	world = wind.newWorld(0, 400, true)
	world:addCollisionClass('monk')
	world:addCollisionClass('banana')
	world:addCollisionClass('platform')
	world:addCollisionClass('button')
	world:addCollisionClass('frozenButton')
	world:addCollisionClass('toyButton')
	world:addCollisionClass('door')
	world:addCollisionClass('frozenDoor')
	world:addCollisionClass('toyDoor')
	world:addCollisionClass('toy')

	for n,layer in pairs(maptable.layers) do
		if not (layer.type == "objectgroup") then break; end
		for nn,object in pairs(layer.objects) do

			if (object.shape == "rectangle") then
				self.tables[object.id] =
					world:newRectangleCollider(object.x, object.y,
						object.width, object.height)
				self.tables[object.id]:setType('static')
				self.tables[object.id]:setCollisionClass('platform')

			elseif (object.shape == "polygon") then
				local ox,oy = object.x,object.y
				local vertices = {}
				local vi = 1
				for kk,verticePair in pairs(object.polygon) do
					vertices[vi] = verticePair['x'] + ox
					vertices[vi+1] = verticePair['y'] + oy
					vi = vi + 2
				end
				self.tables[object.id] =
					world:newPolygonCollider(vertices)
				self.tables[object.id]:setType('static')
				self.tables[object.id]:setCollisionClass('platform')

			elseif (object.shape == "text") then
				self.tables[object.id] = object

			elseif (object.shape == "point" and object.type == "spawn") then
				if not (object.properties == nil
					or object.properties["count"] == nil) then
					monkCount = object.properties["count"]
				end
				self.spawn['x'],self.spawn['y'] = object.x,object.y

			elseif (object.shape == "point" and object.type == "respawn") then
				self.respawn['x'],self.respawn['y'] = object.x,object.y
				self.outOfBounds = "teleport"

			elseif (object.shape == "point" and object.type == "banana") then
				self.objects[object.id] = Banana:new(object.x, object.y)
			end


			local thisTable = self.tables[object.id]

			if (object.type == "toy") then
				thisTable:setCollisionClass('toy')
				thisTable:setType('kinematic')
			end


			if (object.type == "door" or object.type == "frozenDoor"
			or object.type == "toyDoor")
			then
				thisTable.normPos = {}
				thisTable.normPos['x'],thisTable.normPos['y'] =
					thisTable.body:getPosition()
			end

			if (object.type == "door") then
				thisTable:setCollisionClass('door')
			elseif (object.type == "frozenDoor") then
				thisTable:setCollisionClass('frozenDoor')
			elseif (object.type == "toyDoor") then
				thisTable:setCollisionClass('toyDoor')
			elseif (object.type == "button") then
				thisTable:setCollisionClass('button')
			elseif (object.type == "frozenButton") then
				thisTable:setCollisionClass('frozenButton')
			elseif (object.type == "toyButton") then
				thisTable:setCollisionClass('toyButton')
			end
		end
	end

	player = Monk:new(self.spawn['x'], self.spawn['y'], monkCount)
end


function Map:update(dt)
	local heightMax = self.height * self.tileHeight + 100
	local widthMax = self.width * self.tileWidth + 200

	-- enforce borders
	for i=0,player.last do
		local x,y = player.monks[i].body:getPosition()

		if ((math.abs(x) > widthMax or y > heightMax)
			and self.outOfBounds == "die") then
			player:freeze(i)
		elseif ((math.abs(x) > widthMax or y > heightMax)
				and self.outOfBounds == "teleport") then
			player.monks[i].body:setPosition(
				self.respawn['x'], self.respawn['y'])
		end
	end

	-- unlock or reset doors
	for k,table in pairs(self.tables) do
		if (table.collision_class == "door" and self.buttonHit == true) then
			table.body:setPosition(-1000, -1000)
		elseif (table.collision_class == "door") then
			table.body:setPosition(table.normPos['x'], table.normPos['y'])

		elseif (table.collision_class == "frozenDoor"
		and self.frozenHit == true)
		then
			table.body:setPosition(-1000, -1000)
		elseif (table.collision_clas == "frozenDoor") then
			table.body:setPosition(table.normPos['x'], table.normPos['y'])

		elseif (table.collision_class == "toyDoor"
		and self.toyHit == true)
		then
			table.body:setPosition(-1000, -1000)
		elseif (table.collision_class == "toyDoor") then
			table.body:setPosition(table.normPos['x'], table.normPos['y'])
		end
	end

	self.toyHit = false
end


function Map:draw()
	for k,table in pairs(self.tables) do
		if (table.type == "Rectangle" or table.type == "Polygon") then
			love.graphics.polygon('fill',
				table.body:getWorldPoints(table.shape:getPoints()))

		elseif (table.shape == "text") then
			love.graphics.draw(love.graphics.newText(a_ttf, table.text),
				table.x, table.y, 0, 2, 2)
		end
	end	
	for k,object in pairs(self.objects) do
		object:draw()
	end
end



-- MENU	used for creating menus (lol)
----------------------------------------
Menu = class("Menu")

function Menu:initialize(x, y, offset_x, offset_y, scale, menuItems)
	self.x,self.y = x,y
	self.offset_x,self.offset_y = offset_x,offset_y
	self.options = menuItems
	self.selected = 1
	self.scale = scale

	self.keys = {}
	self.keys['up'] = false
	self.keys['down'] = false
	self.keys['enter'] = false

	self.ttf = r_ttf
end


function Menu:draw ()
	for i=1,table.maxn(self.options) do
		local this_y = self.y + (self.offset_y * i)

		love.graphics.draw(self.options[i][1],
				    self.x, this_y, 0, self.scale, self.scale)
		if (i == self.selected) then
			love.graphics.draw(love.graphics.newText(self.ttf, ">>"),
				self.x - self.offset_x, this_y, 0, self.scale, self.scale)
		end
	end
end


function Menu:keypressed(key)
	maxn = table.maxn(self.options)

	if (key == "return" or key == "space") then
		self.keys['enter'] = true
		if(self.options[self.selected][2]) then
			self.options[self.selected][2]()
		end

	elseif (key == "up"  and  self.selected > 1
			and  self.keys['up'] == false) then
		self.keys['up'] = true
		self.selected = self.selected - 1
	elseif (key == "up"  and  self.keys['up'] == false) then
		self.keys['up'] = true
		self.selected = maxn

	elseif (key == "down" and self.selected < maxn
			and  self.keys['down'] == false) then
		self.keys['down'] = true
		self.selected = self.selected + 1
	elseif (key == "down" and  self.keys['down'] == false) then
		self.keys['down'] = true
		self.selected = 1
	end
end


function Menu:keyreleased(key)
	if (key == "return" or key == "space") then
		self.keys['enter'] = false
	elseif (key == "up") then
		self.keys['up'] = false
	elseif (key == "down") then
		self.keys['down'] = false
	end
end



function split(inputString, seperator)
        local newString = {}
        for stringBit in string.gmatch(inputString, "([^"..seperator.."]+)") do
                table.insert(newString, stringBit)
        end
        return newString
end
