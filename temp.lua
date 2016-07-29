-- [ O B J E C T ] --

obj={x=0, y=0, flip={x=false, y=false}, spd={x=0, y=0}, spr=0, hitbox={x=0, y=0, w=8, h=8}}
obj.__index=obj

function obj.new(x, y, spdx, spdy)
	local self = setmetatable({}, obj)
	self.x=x
	self.y=y
	self.spd.x=spdx
	self.spd.y=spdy
	return self
end

function obj.update(self)
end

function obj.draw(self)
	spr(self.spr, self.x, self.y, 1, 1, self.flip.x, self.flip.y)
end

-- end of object --

-- [ s h o t ] --

-- meta class
shot= {time=0, maxtime=30}
shot.__index=shot
setmetatable(shot, {__index = obj})

--- derived class
function shot.new(x, y, spdx, spdy)
	local self = setmetatable({}, shot)
	self.x=x
	self.y=y
	self.spd.x=spdx
	self.spd.y=spdy
	self.spr=18
	self.time=0
	self.maxtime=30
	return self
end

function shot.init()
end

function shot.update(self)
	--self.x+=self.dirx*self.speed
	if move_x(self, self.spd.x) or move_y(self, self.spd.y) then
		add(objects, s_explode.new(self.x, self.y))
		del(objects, self)
		
	end
	--self.y+=self.diry*self.speed
	
	self.time+=1
	if self.time > self.maxtime then add(objects, s_explode.new(self.x, self.y)) del(objects, self) end
end

-- function shot.draw(self)
-- 	spr(self.spr, self.x, self.y, 1, 1, self.flip.x, self.flip.y)
-- end

-- shot explosion
s_explode=obj.new(0, 0, 0, 0)
s_explode.__index=s_explode

function s_explode.new(x, y, spdx, spdy)
	local self = setmetatable({}, obj)
	self.x=x
	self.y=y
	self.spd.x=spdx
	self.spd.y=spdy
	self.spr=19
	return self
end

function s_explode.init()
end

function s_explode.update(self)
	self.spr=19+self.anim_t%3
	self.anim_t+=0.50
	if self.spr>20 then del(objects, self) end
end

-- function s_explode.draw(self)
-- 	spr(self.spr, self.x, self.y, 1, 1, self.flip.x, self.flip.y)
-- end

------ end of shot ------


-- [ S M O K E ] --

smoke={x=0, y=0, spr=21, anim_t=0, flipx=false, flipy=false}
smoke.__index=smoke

function smoke.new(x, y)
	local self = setmetatable({}, smoke)
	self.x=x-1+rnd(2)
	self.y=y-1+rnd(2)
	self.flipy=flr(rnd(2))==1
	self.flipx=flr(rnd(2))==1
	return self
end

function smoke.init()
end

function smoke.update(self)
	self.spr=21+self.anim_t%3
	self.anim_t+=0.50
	if self.spr>=23 then del(objects, self) end
end

function smoke.draw(self)
	spr(self.spr, self.x, self.y, 1, 1, self.flipx, self.flipy)
end


-- end of smoke --