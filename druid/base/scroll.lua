--- 
-- @module druid.scroll

--- Components fields
-- @table Fields

--- Component events
-- @table Events

--- Component style params
-- @table Style

local Event = require("druid.event")
local const = require("druid.const")
local helper = require("druid.helper")
local component = require("druid.component")

local M = component.create("scroll", { const.ON_UPDATE })


local function inverse_lerp(min, max, current)
	return helper.clamp((current - min) / (max - min), 0, 1)
end


local function on_scroll_drag(self, dx, dy)
	local t = self.target_pos
	local b = self.available_pos
	local eb = self.available_pos_extra
	local extra_size = self.style.EXTRA_STRECH_SIZE

	-- Handle soft zones
	-- Percent - multiplier for delta. Less if outside of scroll zone
	local x_perc = 1
	local y_perc = 1

	-- Right border (minimum x)
	if t.x < b.x and dx < 0 then
		x_perc = inverse_lerp(eb.x, b.x, t.x)
	end
	-- Left border (maximum x)
	if t.x > b.z and dx > 0 then
		x_perc = inverse_lerp(eb.z, b.z, t.x)
	end
	-- Disable x scroll
	if not self.can_x then
		x_perc = 0
	end

	-- Top border (minimum y)
	if t.y < b.y and dy < 0 then
		y_perc = inverse_lerp(eb.y, b.y, t.y)
	end
	-- Bot border (maximum y)
	if t.y > b.w and dy > 0 and extra_size > 0 then
		y_perc = inverse_lerp(eb.w, b.w, t.y)
	end
	if not self.can_y then
		y_perc = 0
	end

	t.x = t.x + dx * x_perc
	t.y = t.y + dy * y_perc
end


local function set_pos(self, position)
	position.x = helper.clamp(position.x, self.available_pos_extra.x, self.available_pos_extra.z)
	position.y = helper.clamp(position.y, self.available_pos_extra.w, self.available_pos_extra.y)

	if self.current_pos.x ~= position.x or self.current_pos.y ~= position.y then
		self.current_pos.x = position.x
		self.current_pos.y = position.y
		gui.set_position(self.content_node, position)

		self.on_scroll:trigger(self:get_context(), self.current_pos)
	end
end


local function update_hand_scroll(self, dt)
	local dx = self.target_pos.x - self.current_pos.x
	local dy = self.target_pos.y - self.current_pos.y

	self.inertion.x = (self.inertion.x + dx) * self.style.FRICT_HOLD
	self.inertion.y = (self.inertion.y + dy) * self.style.FRICT_HOLD

	set_pos(self, self.target_pos)
end


local function check_soft_zone(self)
	local t = self.target_pos
	local b = self.available_pos

	-- Right border (minimum x)
	if t.x < b.x then
		t.x = helper.step(t.x, b.x, math.abs(t.x - b.x) * self.style.BACK_SPEED)
	end
	-- Left border (maximum x)
	if t.x > b.z then
		t.x = helper.step(t.x, b.z, math.abs(t.x - b.z) * self.style.BACK_SPEED)
	end
	-- Top border (maximum y)
	if t.y < b.y then
		t.y = helper.step(t.y, b.y, math.abs(t.y - b.y) * self.style.BACK_SPEED)
	end
	-- Bot border (minimum y)
	if t.y > b.w then
		t.y = helper.step(t.y, b.w, math.abs(t.y - b.w) * self.style.BACK_SPEED)
	end
end


--- Find closer point of interest
-- if no inert, scroll to next point by scroll direction
-- if inert, find next point by scroll director
-- @local
local function check_points(self)
	if not self.points then
		return
	end

	local inert = self.inertion
	if not self.is_inert then
		if math.abs(inert.x) > self.style.DEADZONE then
			self:scroll_to_index(self.selected - helper.sign(inert.x))
			return
		end
		if math.abs(inert.y) > self.style.DEADZONE then
			self:scroll_to_index(self.selected + helper.sign(inert.y))
			return
		end
	end

	-- Find closest point and point by scroll direction
	-- Scroll to one of them (by scroll direction in priority)

	local temp_dist = math.huge
	local temp_dist_on_inert = math.huge
	local index = false
	local index_on_inert = false
	local pos = self.current_pos
	for i = 1, #self.points do
		local p = self.points[i]
		local dist = helper.distance(pos.x, pos.y, p.x, p.y)
		local on_inert = true
		-- If inert ~= 0, scroll only by move direction
		if inert.x ~= 0 and helper.sign(inert.x) ~= helper.sign(p.x - pos.x) then
			on_inert = false
		end
		if inert.y ~= 0 and helper.sign(inert.y) ~= helper.sign(p.y - pos.y) then
			on_inert = false
		end

		if dist < temp_dist then
			index = i
			temp_dist = dist
		end
		if on_inert and dist < temp_dist_on_inert then
			index_on_inert = i
			temp_dist_on_inert = dist
		end
	end

	self:scroll_to_index(index_on_inert or index)
end


local function check_threshold(self)
	local is_stopped = false

	if self.inertion.x ~= 0 and math.abs(self.inertion.x) < self.style.INERT_THRESHOLD then
		is_stopped = true
		self.inertion.x = 0
	end
	if self.inertion.y ~= 0 and math.abs(self.inertion.y) < self.style.INERT_THRESHOLD then
		is_stopped = true
		self.inertion.y = 0
	end

	if is_stopped or not self.inert then
		if self.points then
			print("check points free inert?")
		end
		check_points(self)
	end
end


local function update_free_scroll(self, dt)
	local target = self.target_pos

	if self.is_inert and (self.inertion.x ~= 0 or self.inertion.y ~= 0) then
		-- Inertion apply
		target.x = self.current_pos.x + self.inertion.x * self.style.INERT_SPEED * dt
		target.y = self.current_pos.y + self.inertion.y * self.style.INERT_SPEED * dt

		check_threshold(self)
	end

	-- Inertion friction
	self.inertion = self.inertion * self.style.FRICT

	check_soft_zone(self)
	set_pos(self, target)
end


local function on_touch_start(self)
	self.inertion.x = 0
	self.inertion.y = 0
	self.target_pos.x = self.current_pos.x
	self.target_pos.y = self.current_pos.y
end


local function on_touch_end(self)
	check_threshold(self)
end


local function update_size(self)
	self.view_border = helper.get_border(self.view_node)
	self.view_size = vmath.mul_per_elem(gui.get_size(self.view_node),
		gui.get_scale(self.view_node))

	self.content_border = helper.get_border(self.content_node)
	self.content_size = vmath.mul_per_elem(gui.get_size(self.content_node),
		gui.get_scale(self.content_node))

	--== AVAILABLE POSITION
	-- (min_x, min_y, max_x, max_y)
	self.available_pos = vmath.vector4(
		self.view_border.x - self.content_border.x,
		self.view_border.y - self.content_border.y,
		self.view_border.z - self.content_border.z,
		self.view_border.w - self.content_border.w
	)

	if self.available_pos.x > self.available_pos.z then
		self.available_pos.x, self.available_pos.z = self.available_pos.z, self.available_pos.x
	end
	if self.available_pos.y > self.available_pos.w then
		self.available_pos.y, self.available_pos.w = self.available_pos.w, self.available_pos.y
	end

	self.available_size = vmath.vector3(
		self.available_pos.z - self.available_pos.x,
		self.available_pos.w - self.available_pos.y,
	0)

	self.can_x = math.abs(self.available_pos.x - self.available_pos.z) > 0
	self.can_y = math.abs(self.available_pos.y - self.available_pos.w) > 0

	self.drag.can_x = self.can_x
	self.drag.can_y = self.can_y


	--== EXTRA CONTENT SIZE
	self.content_size_extra = helper.get_border(self.content_node)
	if self.can_x then
		local sign = self.content_size.x > self.view_size.x and 1 or -1
		self.content_size_extra.x = self.content_size_extra.x - self.style.EXTRA_STRECH_SIZE * sign
		self.content_size_extra.z = self.content_size_extra.z + self.style.EXTRA_STRECH_SIZE * sign
	end

	if self.can_y then
		local sign = self.content_size.y > self.view_size.y and 1 or -1
		self.content_size_extra.y = self.content_size_extra.y + self.style.EXTRA_STRECH_SIZE * sign
		self.content_size_extra.w = self.content_size_extra.w - self.style.EXTRA_STRECH_SIZE * sign
	end

	self.available_pos_extra = vmath.vector4(
		self.view_border.x - self.content_size_extra.x,
		self.view_border.y - self.content_size_extra.y,
		self.view_border.z - self.content_size_extra.z,
		self.view_border.w - self.content_size_extra.w
	)
	if self.available_pos_extra.x > self.available_pos_extra.z then
		self.available_pos_extra.x, self.available_pos_extra.z = self.available_pos_extra.z, self.available_pos_extra.x
	end
	if self.available_pos_extra.y > self.available_pos_extra.w then
		self.available_pos_extra.y, self.available_pos_extra.w = self.available_pos_extra.w, self.available_pos_extra.y
	end

	self.available_size_extra = vmath.vector3(
		self.available_pos_extra.z - self.available_pos_extra.x,
		self.available_pos_extra.w - self.available_pos_extra.y,
	0)
	--== END CONTENT EXTRA

	-- print("VIEW BORDER", self.view_border)
	-- print("CONTENT BORDER", self.content_border)
	-- print("AVAILABLE POS", self.available_pos)
	-- print("CURRENT POS", self.current_pos)
	-- print("VIEW_SIZE", self.view_size)
	-- print("CONTENT_SIZE", self.content_size)
	-- print("AVAILABLE_SIZE", self.available_size)

	-- print("CONTENT SIZE EXTRA", self.content_size_extra)
	-- print("AVAILABLE POS EXTRA", self.available_pos_extra)
	-- print("")
end


--- Cancel animation on other animation or input touch
local function cancel_animate(self)
	if self.animate then
		self.target_pos = gui.get_position(self.content_node)
		self.current_pos.x = self.target_pos.x
		self.current_pos.y = self.target_pos.y
		gui.cancel_animation(self.content_node, gui.PROP_POSITION)
		self.animate = false
	end
end


--- Component init function
-- @function swipe:init
-- @tparam node node Gui node
-- @tparam function on_swipe_callback Swipe callback for on_swipe_end event
function M.init(self, view_zone, content_zone)
	self.druid = self:get_druid()
	self.style = self:get_style()

	self.view_node = self:get_node(view_zone)
	self.content_node = self:get_node(content_zone)

	self.current_pos = gui.get_position(self.content_node)
	self.target_pos = vmath.vector3(self.current_pos)
	self.inertion = vmath.vector3(0)

	self.drag = self.druid:new_drag(view_zone, on_scroll_drag)
	self.drag.on_touch_start:subscribe(on_touch_start)
	self.drag.on_touch_end:subscribe(on_touch_end)

	self.on_scroll = Event()
	self.on_scroll_to = Event()
	self.on_point_scroll = Event()

	self.is_inert = true

	update_size(self)
end


function M.set_size(self, size)
	gui.set_size(self.content_node, size)
	update_size(self)
end


function M.update(self, dt)
	if self.drag.is_drag then
		update_hand_scroll(self, dt)
	else
		update_free_scroll(self, dt)
	end
end


--- Start scroll to target point
-- @function scroll:scroll_to
-- @tparam point vector3 target point
-- @tparam[opt] bool is_instant instant scroll flag
-- @usage scroll:scroll_to(vmath.vector3(0, 50, 0))
-- @usage scroll:scroll_to(vmath.vector3(0), true)
function M.scroll_to(self, point, is_instant)
	local b = self.available_pos
	local target = vmath.vector3(point)
	target.x = helper.clamp(point.x, b.x, b.z)
	target.y = helper.clamp(point.y, b.y, b.w)

	cancel_animate(self)

	self.animate = not is_instant

	if is_instant then
		self.target_pos = target
		set_pos(self, target)
	else
		gui.animate(self.content_node, gui.PROP_POSITION, target, gui.EASING_OUTSINE, self.style.ANIM_SPEED, 0, function()
			self.animate = false
			self.target_pos = target
			set_pos(self, target)
		end)
	end

	self.on_scroll_to:trigger(self:get_context(), target, is_instant)
end


--- Scroll to item in scroll by point index
-- @function scroll:scroll_to_index
-- @tparam number index Point index
-- @tparam[opt] bool skip_cb If true, skip the point callback
function M.scroll_to_index(self, index, skip_cb)
	index = helper.clamp(index, 1, #self.points)

	if self.selected ~= index then
		self.selected = index

		if not skip_cb then
			self.on_point_scroll:trigger(self:get_context(), index, self.points[index])
		end
	end

	self:scroll_to(self.points[index])
end



function M.scroll_to_percent(self, percent, is_instant)
	local border = self.available_pos

	local size_x = math.abs(border.z - border.x)
	if size_x == 0 then
		size_x = 1
	end
	local size_y = math.abs(border.w - border.y)
	if size_y == 0 then
		size_y = 1
	end

	local pos = vmath.vector3(
		-size_x * percent.x + border.x,
		-size_y * percent.y + border.y,
		0)
	M.scroll_to(self, pos, is_instant)
end


function M.get_percent(self)
	local y_dist = self.available_size.y
	local y_perc = y_dist ~= 0 and (self.current_pos.y - self.available_pos.w) / y_dist or 1

	local x_dist = self.available_size.x
	local x_perc = x_dist ~= 0 and (self.current_pos.x - self.available_pos.z) / x_dist or 1

	return vmath.vector3(x_perc, y_perc, 0)
end


--- Enable or disable scroll inert.
-- If disabled, scroll through points (if exist)
-- If no points, just simple drag without inertion
-- @function scroll:set_inert
-- @tparam bool state Inert scroll state
function M.set_inert(self, state)
	self.is_inert = state

	return self
end


--- Set points of interest.
-- Scroll will always centered on closer points
-- @function scroll:set_points
-- @tparam table points Array of vector3 points
function M.set_points(self, points)
	self.points = points
	-- cause of parent move in other side by y
	for i = 1, #self.points do
		self.points[i].x = -self.points[i].x
		self.points[i].y = -self.points[i].y
	end

	table.sort(self.points, function(a, b)
		return a.x > b.x or a.y < b.y
	end)

	check_threshold(self)

	pprint(self.points)

	return self
end


return M
