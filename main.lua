-- pls set tabs to width of 4 spaces
class	= require "lib/middleclass"
wind	= require "lib/windfield"
stalker	= require "lib/STALKER-X"

downwall = 1; rightwall = 2; leftwall = 3
mainmenu = 0; game = 1; gameover = 2; pause = 3

world = wind.newWorld(0, 400, true)

-- GAME STATES
--------------------------------------------------------------------------------
-- LOVE
----------------------------------------
function love.load ()
	math.randomseed(os.time())

	dieParticle = nil
	love.graphics.setDefaultFilter("nearest", "nearest")
--	a_ttf = love.graphics.newFont("art/font/alagard.ttf", nil, "none")

--	mainmenu_load()
	game_load()
end


function love.update(dt)
	if(mode == mainmenu) then		mainmenu_update(dt)
	elseif(mode == game) then		game_update(dt)
	elseif(mode == gameover) then	gameover_update(dt)
	elseif(mode == pause) then		pause_update(dt)
	end
end


function love.draw ()
	if(mode == mainmenu)		then mainmenu_draw()
	elseif(mode == game)		then game_draw()
	elseif(mode == gameover)	then gameover_draw()
	elseif(mode == pause)		then pause_draw()
	end
end


function love.keypressed(key)
	if(mode == mainmenu) then		mainmenu_keypressed(key)
	elseif(mode == game) then		game_keypressed(key)
	elseif(mode == gameover) then	gameover_keypressed(key)
	elseif(mode == pause) then		pause_keypressed(key)
	end
end


function love.keyreleased (key)
	if(mode == mainmenu) then		mainmenu_keyreleased(key)
	elseif(mode == game) then		game_keyreleased(key)
	elseif(mode == gameover) then	gameover_keyreleased(key)
	elseif(mode == pause) then		pause_keyreleased(key)
	end
end


-- MENU STATE
----------------------------------------
function mainmenu_load ()
	mode = mainmenu
	selection = 1
--	if(bgm) then
--		bgm:stop()
--	end
--	bgm = love.audio.newSource("art/music/menu.ogg", "static")
--	bgm:play()
--	bgm:setLooping(true)
--	bgm:setVolume(1.5)
--
--	frontMenu = Menu:new(100, 100, 30, 50, 2, 
--			      { { love.graphics.newText(a_ttf, "get bannana!"),
--				  function () game_load() end },
--				{ love.graphics.newText(a_ttf, "get help!"),
--				  function () helpScreen = true end },
--				{ love.graphics.newText(a_ttf, "get outta dodge!"),
--				  function () love.event.quit(0) end } })
end


function mainmenu_update(dt)
end


function mainmenu_draw ()
end


function mainmenu_keypressed(key)
end


function mainmenu_keyreleased(key)
end



-- PAUSE STATE
----------------------------------------
function pause_load ()
end


function pause_update(dt)
end


function pause_draw ()
end


function pause_keypressed(key)
end


function pause_keyreleased(key)
end


-- GAMEOVER STATE
----------------------------------------
function gameover_load ()
end


function gameover_update(dt)
end


function gameover_draw ()
	game_draw()
end


function gameover_keypressed(key)
	if(key == "return"  or  key == "escape") then
		mainmenu_load()
	end
end


function gameover_keyreleased(key)
end



-- GAME STATE
----------------------------------------
function game_load ()
	mode = game
	map = Map:new("maps/tutorial/1.lua")
	camera = stalker()
	camera:setFollowStyle('PLATFORMER')
	camera:setFollowLerp(0.1)

--	bgm:stop()
--	bgm = love.audio.newSource("art/music/game.ogg", "static")
--	bgm:play()
end


function game_update(dt)
	world:update(dt)
	player:update(dt)
	map:update(dt)

	local x, y = player.monks[player.current].body:getPosition()
	camera:update(dt)
	camera:follow(x, y)
end


function game_draw ()
	camera:attach()

	map:draw()
	player:draw()
	bananna:draw()

	camera:detach()
	camera:draw()
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
		camera.scale = camera.scale + 1
	elseif (key == "-" and camera.scale > 1) then
		camera.scale = camera.scale - 1
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
world:addCollisionClass('Monk')

function Monk:initialize(x, y, count)
	self.monks = {}
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
		self.monks[i]:setCollisionClass('Monk')
		self.monks[i]:setObject(self)
		self.monkSprites[i] = 'default'

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
		else self.monkSprites[i] = 'jump'
		end
	end

	-- cleanup
	for i=0,(self.last) do
		self.onGround[i] = 0
	end
	if (dir['left'] == 2 and dir['right'] == 0) then dir['left'] = 1; end
	if (dir['right'] == 2 and dir['left'] == 0) then dir['right'] = 1; end
end


function Monk:draw ()
	-- live monkeys
	for i=self.current,self.last do
		local monk = self.monks[i]
		local x,y = monk.body:getWorldPoints(monk.shape:getPoints())

		love.graphics.draw(self.sprites[self.monkSprites[i]], x, y,
			monk.body:getAngle(), 1, 1)
	end
	-- frozen monkeys
	for i=0,self.current-1 do
		local monk = self.monks[i]
		local x,y = monk.body:getWorldPoints(monk.shape:getPoints())

		love.graphics.draw(self.sprites['frozen'], x, y, monk.body:getAngle(),
			1, 1)
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

		if (mx < (x + 30)) then
			thisMonk:setLinearVelocity(newVel, dy)
		elseif ((x - 30) < mx) then
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
function Monk:freeze ()
	if not (self.current > self.last) then
		local monk = self.monks[self.current]
		monk:setType('static')
		monk:setCollisionClass('Platform')
		self:switch(self.current + 1)
	end
end


-- switch from current monkey to next
function Monk:switch (index)
	self.current = index
	if (index > self.last) then
		gameover_load()
	end
end


-- each monkey in party needs a unique callback
function Monk:makeCollisionCallback (i)
	local function collision(collision1, collision2, contact)
		local nx, ny = contact:getNormal( )

		if collision1.collision_class == "Monk"
		and collision2.collision_class == "Platform"
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
		end
	end
	return collision
end



-- BANNANA		owo (win condition obj)
----------------------------------------
Bananna = class('Bananna')
world:addCollisionClass('Bananna')

function Bananna:initialize(x, y)
	self.sprite = love.graphics.newImage("art/sprites/bananna.png")
	self.collider = world:newRectangleCollider(x, y, 16, 16);
end


function Bananna:draw()
	local col = self.collider
	local x,y = col.body:getWorldPoints(col.shape:getPoints())
	love.graphics.draw(self.sprite, x, y, col.body:getAngle(), 1, 1)
end



-- MAP	used to store map data (ofc)
----------------------------------------
Map = class('Map')
world:addCollisionClass('Platform')

function Map:initialize(filepath)
	self.ground = {}
	self.platforms = {}
	self.objects = {}
	self.object_c = 0
	local maptable = dofile(filepath)

	love.graphics.setBackgroundColor(146/255, 187/255, 203/255)
	local monkCount = 3
	local monkX,monkY = 100,100
	local banannaX,banannaY =  200,200

	for n,layer in pairs(maptable.layers) do
		if not (layer.type == "objectgroup") then break; end
		for nn,object in pairs(layer.objects) do

			if (object.shape == "rectangle") then
				self.object_c = self.object_c + 1
				local o_c = self.object_c
				self.objects[o_c] =
					world:newRectangleCollider(object.x, object.y,
						object.width, object.height)
				self.objects[o_c]:setType('static')
				self.objects[o_c]:setCollisionClass('Platform')

			elseif (object.shape == "point" and object.type == "spawn") then
				if not (object.properties == nil
					and object.properties["count"] == nil) then
					monkCount = object.properties["count"]
				end
				monkX,monkY = object.x,object.y

			elseif (object.shape == "point" and object.type == "bananna") then
				banannaX,banannaY = object.x,object.y
			end
		end
	end
	player = Monk:new(monkX, monkY, monkCount)
	bananna = Bananna:new(banannaX, banannaY)
end


function Map:update(dt)
end


function Map:draw()
	for k,object in pairs(self.objects) do
		love.graphics.polygon('fill',
			object.body:getWorldPoints(object.shape:getPoints()))
	end	
end



-- MENU	used for creating menus (lol)
----------------------------------------
Menu = class("Menu")

function Menu:initialize(x, y, offset_x, offset_y, scale, menuItems)
	self.x = x; self.y = y
	self.offset_x = offset_x; self.offset_y = offset_y
	self.scale = scale
	self.options = menuItems
	self.selected = 1
	self.enter = false
	self.up = false
	self.down = false
end

function Menu:draw ()
--			love.graphics.draw(love.graphics.newText(a_ttf, ">>"),
--					    self.x - self.offset_x, this_y, 0,
--					    self.scale, self.scale)
end

function Menu:keypressed(key)
	maxn = table.maxn(self.options)

	if(key == "return"  and  self.enter == false) then
		self.enter = true
		if(self.options[self.selected][2]) then
			self.options[self.selected][2]()
		end
	elseif(key == "up"  and  self.selected > 1  and  self.up == false) then
		self.up = true
		self.selected = self.selected - 1
	elseif(key == "up"  and  self.up == false) then
		self.up = true
		self.selected = maxn
	elseif(key == "down" and self.selected < maxn  and  self.down == false) then
		self.down = true
		self.selected = self.selected + 1
	elseif(key == "down" and  self.down == false) then
		self.down = true
		self.selected = 1
	end
end


function Menu:keyreleased(key)
	if(key == "return") then
		self.enter = false
	elseif(key == "up") then
		self.up = false
	elseif(key == "down") then
		self.down = false
	end
end


