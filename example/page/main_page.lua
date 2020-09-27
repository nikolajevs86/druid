local lang = require("example.lang")

local M = {}


local function empty_callback(self, param)
	print("Empty callback. Param", param)
end


local function random_progress(progress, text)
	local rnd = math.random()

	gui.set_text(text, math.ceil(rnd * 100) .. "%")
	progress:to(rnd)
end


local function setup_button(self)
	local b = self.druid:new_button("button_simple", lang.toggle_locale, "button_param")
	self.druid:new_button("button_template/button", function()
		msg.post("@system:", "toggle_profile")
		print(b:is_enabled())
		b:set_enabled(not b:is_enabled())
	end, "button_param")
end


local function setup_texts(self)
	self.druid:new_lang_text("text_button", "ui_section_button")
	self.druid:new_lang_text("text_text", "ui_section_text")
	self.druid:new_lang_text("text_timer", "ui_section_timer")
	self.druid:new_lang_text("text_progress", "ui_section_progress")
	self.druid:new_lang_text("text_slider", "ui_section_slider")
	self.druid:new_lang_text("text_radio", "ui_section_radio")
	self.druid:new_lang_text("text_checkbox", "ui_section_checkbox")

	self.druid:new_lang_text("text_translated", "ui_text_example")
	self.druid:new_lang_text("text_button_lang", "ui_text_change_lang")
	self.druid:new_text("text_simple", "Simple")
end


local function setup_progress(self)
	self.progress = self.druid:new_progress("progress_fill", "x", 0.4)
	random_progress(self.progress, gui.get_node("text_progress_amount"))
	timer.delay(2, true, function()
		random_progress(self.progress, gui.get_node("text_progress_amount"))
	end)
end


local function setup_slider(self)
	local slider = self.druid:new_slider("slider_pin", vmath.vector3(95, 0, 0), function(_, value)
		gui.set_text(gui.get_node("text_progress_slider"), math.ceil(value * 100) .. "%")
	end)

	slider:set(0.2)
end


local function setup_checkbox(self)
	local radio_group = self.druid:new_radio_group(
		{"radio1/check", "radio2/check", "radio3/check"},
		nil,
		{"radio1/back", "radio2/back", "radio3/back"})

	local checkbox_group = self.druid:new_checkbox_group(
		{"checkbox1/check", "checkbox2/check", "checkbox3/check"},
		nil,
		{"checkbox1/back", "checkbox2/back", "checkbox3/back"})

	radio_group:set_state(2)
	checkbox_group:set_state({true, false, true})
end


local function setup_timer(self)
	self.timer = self.druid:new_timer("timer", 300, 0, empty_callback)
end


local function setup_back_handler(self)
	self.druid:new_back_handler(empty_callback, "back button")
end


local function setup_input(self)
	local input = self.druid:new_input("input_box", "input_text")
	input:set_text("hello!")
end


function M.setup_page(self)
	setup_texts(self)

	setup_button(self)
	setup_progress(self)
	setup_timer(self)
	setup_checkbox(self)
	setup_slider(self)
	setup_back_handler(self)
	setup_input(self)
end


return M
