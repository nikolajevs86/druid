-- luacheck: ignore


---@class druid
local druid = {}

--- Create Druid instance.
---@param context table Druid context. Usually it is self of script
---@param style table Druid style module
---@return druid_instance Druid instance
function druid.new(context, style) end

--- Druid on language change.
function druid.on_language_change() end

--- Callback on global language change event.
function druid.on_language_change() end

--- Callback on global layout change event.
function druid.on_layout_change() end

--- Callback on global window event.
---@param event string Event param from window listener
function druid.on_window_callback(event) end

--- Register external druid component.
---@param name string module name
---@param module table lua table with component
function druid.register(name, module) end

--- Set new default style.
---@param style table Druid style module
function druid.set_default_style(style) end

--- Set sound function.
---@param callback function Sound play callback
function druid.set_sound_function(callback) end

--- Set text function  Druid locale component will call this function  to get translated text.
---@param callback function Get localized text function
function druid.set_text_function(callback) end


---@class druid.back_handler : druid.base_component
---@field on_back druid_event On back handler callback(self, params)
local druid__back_handler = {}

--- Component init function
---@param self druid.back_handler
---@param callback callback On back button
---@param params any Callback argument
function druid__back_handler.init(self, callback, params) end

--- Input handler for component
---@param self druid.back_handler
---@param action_id string on_input action id
---@param action table on_input action
function druid__back_handler.on_input(self, action_id, action) end


---@class druid.base_component
local druid__base_component = {}

--- Get current component context
---@param self druid.base_component
---@return table BaseComponent context
function druid__base_component.get_context(self) end

--- Return druid with context of calling component.
---@param self druid.base_component
---@return Druid Druid instance with component context
function druid__base_component.get_druid(self) end

--- Return component name
---@param self druid.base_component
---@return string The component name
function druid__base_component.get_name(self) end

--- Get node for component by name.
---@param self druid.base_component
---@param node_or_name string|node Node name or node itself
---@return node Gui node
function druid__base_component.get_node(self, node_or_name) end

--- Return the parent for current component
---@param self druid.base_component
---@return druid.base_component|nil The druid component instance or nil
function druid__base_component.get_parent_component(self) end

--- Increase input priority in current input stack
---@param self druid.base_component
function druid__base_component.increase_input_priority(self) end

--- Reset input priority in current input stack
---@param self druid.base_component
function druid__base_component.reset_input_priority(self) end

--- Set component input state.
---@param self druid.base_component
---@param state bool The component input state
---@return druid.base_component BaseComponent itself
function druid__base_component.set_input_enabled(self, state) end

--- Set current component nodes
---@param self druid.base_component
---@param nodes table BaseComponent nodes table
function druid__base_component.set_nodes(self, nodes) end

--- Set current component style table.
---@param self druid.base_component
---@param druid_style table Druid style module
function druid__base_component.set_style(self, druid_style) end

--- Set current component template name
---@param self druid.base_component
---@param template string BaseComponent template name
function druid__base_component.set_template(self, template) end

--- Setup component context and his style table
---@param self druid.base_component
---@param druid_instance table The parent druid instance
---@param context table Druid context. Usually it is self of script
---@param style table Druid style module
---@return component BaseComponent itself
function druid__base_component.setup_component(self, druid_instance, context, style) end


---@class druid.blocker : druid.base_component
local druid__blocker = {}

--- Component init function
---@param self druid.blocker
---@param node node Gui node
function druid__blocker.init(self, node) end

--- Return blocked enabled state
---@param self druid.blocker
---@return bool True, if blocker is enabled
function druid__blocker.is_enabled(self) end

--- Set enabled blocker component state
---@param self druid.blocker
---@param state bool Enabled state
function druid__blocker.set_enabled(self, state) end


---@class druid.button : druid.base_component
---@field anim_node node Animation node
---@field hover druid.hover Druid hover logic component
---@field node node Trigger node
---@field on_click druid_event On release button callback(self, params, button_instance)
---@field on_click_outside druid_event On click outside of button(self, params, button_instance)
---@field on_double_click druid_event On double tap button callback(self, params, button_instance, click_amount)
---@field on_hold_callback druid_event On button hold before long_click callback(self, params, button_instance, time)
---@field on_long_click druid_event On long tap button callback(self, params, button_instance, time)
---@field on_repeated_click druid_event On repeated action button callback(self, params, button_instance, click_amount)
---@field params any Params to click callbacks
---@field pos vector3 Initial pos of anim_node
---@field start_pos vector3 Initial pos of anim_node
---@field start_scale vector3 Initial scale of anim_node
---@field style druid.button.style Component style params.
local druid__button = {}

--- Get key-code to trigger this button
---@param self druid.button
---@return hash The action_id of the key
function druid__button.get_key_trigger(self) end

--- Component init function
---@param self druid.button
---@param node node Gui node
---@param callback function Button callback
---@param params table Button callback params
---@param anim_node node Button anim node (node, if not provided)
function druid__button.init(self, node, callback, params, anim_node) end

--- Return button enabled state
---@param self druid.button
---@return bool True, if button is enabled
function druid__button.is_enabled(self) end

--- Strict button click area.
---@param self druid.button
---@param zone node Gui node
---@return druid.button Current button instance
function druid__button.set_click_zone(self, zone) end

--- Set enabled button component state
---@param self druid.button
---@param state bool Enabled state
---@return druid.button Current button instance
function druid__button.set_enabled(self, state) end

--- Set key-code to trigger this button
---@param self druid.button
---@param key hash The action_id of the key
---@return druid.button Current button instance
function druid__button.set_key_trigger(self, key) end


---@class druid.button.style
---@field AUTOHOLD_TRIGGER field  Maximum hold time to trigger button release while holding
---@field DOUBLETAP_TIME field  Time between double taps
---@field LONGTAP_TIME field  Minimum time to trigger on_hold_callback
---@field on_click field  (self, node)
---@field on_click_disabled field  (self, node)
---@field on_hover field  (self, node, hover_state)
---@field on_mouse_hover field  (self, node, hover_state)
---@field on_set_enabled field  (self, node, enabled_state)
local druid__button__style = {}


---@class druid.checkbox : druid.base_component
---@field click_node node Button trigger node
---@field node node Visual node
---@field on_change_state druid_event On change state callback(self, state)
---@field style druid.checkbox.style Component style params.
local druid__checkbox = {}

--- Return checkbox state
---@param self druid.checkbox
---@return bool Checkbox state
function druid__checkbox.get_state(self) end

--- Component init function
---@param self druid.checkbox
---@param node node Gui node
---@param callback function Checkbox callback
---@param click_node node Trigger node, by default equals to node
function druid__checkbox.init(self, node, callback, click_node) end

--- Set checkbox state
---@param self druid.checkbox
---@param state bool Checkbox state
---@param is_silent bool Don't trigger on_change_state if true
function druid__checkbox.set_state(self, state, is_silent) end


---@class druid.checkbox.style
---@field on_change_state field  (self, node, state)
local druid__checkbox__style = {}


---@class druid.checkbox_group : druid.base_component
---@field on_checkbox_click druid_event On any checkbox click callback(self, index)
local druid__checkbox_group = {}

--- Return checkbox group state
---@param self druid.checkbox_group
---@return bool[] Array if checkboxes state
function druid__checkbox_group.get_state(self) end

--- Component init function
---@param self druid.checkbox_group
---@param nodes node[] Array of gui node
---@param callback function Checkbox callback
---@param click_nodes node[] Array of trigger nodes, by default equals to nodes
function druid__checkbox_group.init(self, nodes, callback, click_nodes) end

--- Set checkbox group state
---@param self druid.checkbox_group
---@param indexes bool[] Array of checkbox state
function druid__checkbox_group.set_state(self, indexes) end


---@class druid.drag : druid.base_component
---@field can_x bool Is drag component process vertical dragging.
---@field can_y bool Is drag component process horizontal.
---@field is_drag bool Is component now dragging
---@field is_touch bool Is component now touching
---@field on_drag druid_event on drag progress callback(self, dx, dy)
---@field on_drag_end druid_event Event on drag end callback(self)
---@field on_drag_start druid_event Event on drag start callback(self)
---@field on_touch_end druid_event Event on touch end callback(self)
---@field on_touch_start druid_event Event on touch start callback(self)
---@field style druid.drag.style Component style params.
---@field x number Current touch x position
---@field y number Current touch y position
local druid__drag = {}

--- Drag component constructor
---@param self druid.drag
---@param node node GUI node to detect dragging
---@param on_drag_callback function Callback for on_drag_event(self, dx, dy)
function druid__drag.init(self, node, on_drag_callback) end

--- Strict drag click area.
---@param self druid.drag
---@param zone node Gui node
function druid__drag.set_click_zone(self, zone) end


---@class druid.drag.style
---@field DRAG_DEADZONE field  Distance in pixels to start dragging
local druid__drag__style = {}


---@class druid.dynamic_grid : druid.base_component
---@field first_index number The first index of node in grid
---@field last_index number The last index of node in grid
---@field node_size vector3 Item size
---@field nodes node[] List of all grid nodes
---@field on_add_item druid_event On item add callback(self, node, index)
---@field on_change_items druid_event On item add or remove callback(self, index)
---@field on_clear druid_event On grid clear callback(self)
---@field on_remove_item druid_event On item remove callback(self, index)
---@field on_update_positions druid_event On update item positions callback(self)
---@field parent node Parent gui node
local druid__dynamic_grid = {}

--- Return side vector to correct node shifting
---@param self unknown
---@param side unknown
---@param is_forward unknown
function druid__dynamic_grid._get_side_vector(self, side, is_forward) end

--- Add new node to the grid
---@param self druid.dynamic_grid
---@param node node Gui node
---@param index number The node position. By default add as last node
---@param is_shift_left bool If true, shift all nodes to the left, otherwise shift nodes to the right
function druid__dynamic_grid.add(self, node, index, is_shift_left) end

--- Clear grid nodes array.
---@param self druid.dynamic_grid
---@return druid.dynamic_grid Current grid instance
function druid__dynamic_grid.clear(self) end

--- Return array of all node positions
---@param self druid.dynamic_grid
---@return vector3[] All grid node positions
function druid__dynamic_grid.get_all_pos(self) end

--- Return grid index by node
---@param self druid.dynamic_grid
---@param node node The gui node in the grid
---@return number The node index
function druid__dynamic_grid.get_index_by_node(self, node) end

--- Return pos for grid node index
---@param self druid.dynamic_grid
---@param index number The grid element index
---@param node node The node to be placed
---@param origin_index number Index of nearby node
---@return vector3 Node position
function druid__dynamic_grid.get_pos(self, index, node, origin_index) end

--- Return grid content size
---@param self druid.dynamic_grid
---@param border vector3
---@return vector3 The grid content size
function druid__dynamic_grid.get_size(self, border) end

--- Component init function
---@param self druid.dynamic_grid
---@param parent node The gui node parent, where items will be placed
function druid__dynamic_grid.init(self, parent) end

--- Remove the item from the grid.
---@param self druid.dynamic_grid
---@param index number The grid node index to remove
---@param is_shift_left bool If true, shift all nodes to the left, otherwise shift nodes to the right
function druid__dynamic_grid.remove(self, index, is_shift_left) end

--- Change set position function for grid nodes.
---@param self druid.dynamic_grid
---@param callback function Function on node set position
---@return druid.dynamic_grid Current grid instance
function druid__dynamic_grid.set_position_function(self, callback) end


---@class druid.hover : druid.base_component
---@field on_hover druid_event On hover callback(self, state)
local druid__hover = {}

--- Component init function
---@param self druid.hover
---@param node node Gui node
---@param on_hover_callback function Hover callback
function druid__hover.init(self, node, on_hover_callback) end

--- Return current hover enabled state
---@param self druid.hover
---@return bool The hover enabled state
function druid__hover.is_enabled(self) end

--- Strict hover click area.
---@param self druid.hover
---@param zone node Gui node
function druid__hover.set_click_zone(self, zone) end

--- Set enable state of hover component.
---@param self druid.hover
---@param state bool The hover enabled state
function druid__hover.set_enabled(self, state) end

--- Set hover state
---@param self druid.hover
---@param state bool The hover state
function druid__hover.set_hover(self, state) end

--- Set mouse hover state
---@param self druid.hover
---@param state bool The mouse hover state
function druid__hover.set_mouse_hover(self, state) end


---@class druid.input : druid.base_component
---@field allowerd_characters string Pattern matching for user input
---@field button druid.button Button component
---@field is_empty bool Is current input is empty now
---@field is_selected bool Is current input selected now
---@field max_length number Max length for input text
---@field on_input_empty druid_event On input field text change to empty string callback(self, input_text)
---@field on_input_full druid_event On input field text change to max length string callback(self, input_text)
---@field on_input_select druid_event On input field select callback(self, button_node)
---@field on_input_text druid_event On input field text change callback(self, input_text)
---@field on_input_unselect druid_event On input field unselect callback(self, button_node)
---@field on_input_wrong druid_event On trying user input with not allowed character callback(self, params, button_instance)
---@field style druid.input.style Component style params.
---@field text druid.text Text component
local druid__input = {}

--- Return current input field text
---@param self druid.input
---@return string The current input field text
function druid__input.get_text(self) end

--- Reset current input selection and return previous value
---@param self druid.input
function druid__input.reset_changes(self) end

--- Set allowed charaters for input field.
---@param self druid.input
---@param characters string Regulax exp. for validate user input
---@return druid.input Current input instance
function druid__input.set_allowed_characters(self, characters) end

--- Set maximum length for input field.
---@param self druid.input
---@param max_length number Maximum length for input text field
---@return druid.input Current input instance
function druid__input.set_max_length(self, max_length) end

--- Set text for input field
---@param self druid.input
---@param input_text string The string to apply for input field
function druid__input.set_text(self, input_text) end


---@class druid.input.style
---@field IS_LONGTAP_ERASE field  Is long tap will erase current input data
---@field MASK_DEFAULT_CHAR field  Default character mask for password input
---@field button_style field  Custom button style for input node
---@field on_input_wrong field  (self, button_node) Callback on wrong user input
---@field on_select field  (self, button_node) Callback on input field selecting
---@field on_unselect field  (self, button_node) Callback on input field unselecting
local druid__input__style = {}


---@class druid.lang_text : druid.base_component
---@field on_change druid_event On change text callback
local druid__lang_text = {}

--- Component init function
---@param self druid.lang_text
---@param node node The text node
---@param locale_id string Default locale id
---@param no_adjust bool If true, will not correct text size
function druid__lang_text.init(self, node, locale_id, no_adjust) end

--- Setup raw text to lang_text component
---@param self druid.lang_text
---@param text string Text for text node
function druid__lang_text.set_to(self, text) end

--- Translate the text by locale_id
---@param self druid.lang_text
---@param locale_id string Locale id
function druid__lang_text.translate(self, locale_id) end


---@class druid.progress : druid.base_component
---@field key string The progress bar direction
---@field max_size number Maximum size of progress bar
---@field node node Progress bar fill node
---@field on_change druid_event On progress bar change callback(self, new_value)
---@field scale vector3 Current progress bar scale
---@field size vector3 Current progress bar size
---@field style druid.progress.style Component style params.
local druid__progress = {}

--- Empty a progress bar
---@param self druid.progress
function druid__progress.empty(self) end

--- Fill a progress bar and stop progress animation
---@param self druid.progress
function druid__progress.fill(self) end

--- Return current progress bar value
---@param self druid.progress
function druid__progress.get(self) end

--- Component init function
---@param self druid.progress
---@param node string|node Progress bar fill node or node name
---@param key string Progress bar direction: const.SIDE.X or const.SIDE.Y
---@param init_value number Initial value of progress bar
function druid__progress.init(self, node, key, init_value) end

--- Set points on progress bar to fire the callback
---@param self druid.progress
---@param steps number[] Array of progress bar values
---@param callback function Callback on intersect step value
function druid__progress.set_steps(self, steps, callback) end

--- Instant fill progress bar to value
---@param self druid.progress
---@param to number Progress bar value, from 0 to 1
function druid__progress.set_to(self, to) end

--- Start animation of a progress bar
---@param self druid.progress
---@param to number value between 0..1
---@param callback function Callback on animation ends
function druid__progress.to(self, to, callback) end


---@class druid.progress.style
---@field MIN_DELTA field  Minimum step to fill progress bar
---@field SPEED field  Progress bas fill rate. More -> faster
local druid__progress__style = {}


---@class druid.radio_group : druid.base_component
---@field on_radio_click druid_event On any checkbox click
local druid__radio_group = {}

--- Return radio group state
---@param self druid.radio_group
---@return number Index in radio group
function druid__radio_group.get_state(self) end

--- Component init function
---@param self druid.radio_group
---@param nodes node[] Array of gui node
---@param callback function Radio callback
---@param click_nodes node[] Array of trigger nodes, by default equals to nodes
function druid__radio_group.init(self, nodes, callback, click_nodes) end

--- Set radio group state
---@param self druid.radio_group
---@param index number Index in radio group
function druid__radio_group.set_state(self, index) end


---@class druid.scroll : druid.base_component
---@field available_pos vector4 Available position for content node: (min_x, max_y, max_x, min_y)
---@field available_size vector3 Size of available positions: (width, height, 0)
---@field content_node node Scroll content node
---@field drag Drag Drag Druid component
---@field inertion vector3 Current inert speed
---@field is_inert bool Flag, if scroll now moving by inertion
---@field on_point_scroll druid_event On scroll_to_index function callback(self, index, point)
---@field on_scroll druid_event On scroll move callback(self, position)
---@field on_scroll_to druid_event On scroll_to function callback(self, target, is_instant)
---@field position vector3 Current scroll posisition
---@field selected number Current index of points of interests
---@field style druid.scroll.style Component style params.
---@field target_position vector3 Current scroll target position
---@field view_node node Scroll view node
local druid__scroll = {}

--- Cancel animation on other animation or input touch
---@param self unknown
function druid__scroll._cancel_animate(self) end

--- Bind the grid component (Static or Dynamic) to recalculate  scroll size on grid changes
---@param self druid.scroll
---@param grid StaticGrid|DynamicGrid Druid grid component
---@return druid.scroll Current scroll instance
function druid__scroll.bind_grid(self, grid) end

--- Return current scroll progress status.
---@param self druid.scroll
---@return vector3 New vector with scroll progress values
function druid__scroll.get_percent(self) end

--- Return vector of scroll size with width and height.
---@param self druid.scroll
---@return vector3 Available scroll size
function druid__scroll.get_scroll_size(self) end

--- Scroll constructor
---@param self druid.scroll
---@param view_node node GUI view scroll node
---@param content_node node GUI content scroll node
function druid__scroll.init(self, view_node, content_node) end

--- Return if scroll have inertion.
---@param self druid.scroll
---@return bool If scroll have inertion
function druid__scroll.is_inert(self) end

--- Start scroll to target point.
---@param self druid.scroll
---@param point vector3 Target point
---@param is_instant bool Instant scroll flag
function druid__scroll.scroll_to(self, point, is_instant) end

--- Scroll to item in scroll by point index.
---@param self druid.scroll
---@param index number Point index
---@param skip_cb bool If true, skip the point callback
function druid__scroll.scroll_to_index(self, index, skip_cb) end

--- Start scroll to target scroll percent
---@param self druid.scroll
---@param percent vector3 target percent
---@param is_instant bool instant scroll flag
function druid__scroll.scroll_to_percent(self, percent, is_instant) end

--- Set extra size for scroll stretching.
---@param self druid.scroll
---@param stretch_size number Size in pixels of additional scroll area
---@return druid.scroll Current scroll instance
function druid__scroll.set_extra_stretch_size(self, stretch_size) end

--- Lock or unlock horizontal scroll
---@param self druid.scroll
---@param state bool True, if horizontal scroll is enabled
---@return druid.scroll Current scroll instance
function druid__scroll.set_horizontal_scroll(self, state) end

--- Enable or disable scroll inert.
---@param self druid.scroll
---@param state bool Inert scroll state
---@return druid.scroll Current scroll instance
function druid__scroll.set_inert(self, state) end

--- Set points of interest.
---@param self druid.scroll
---@param points table Array of vector3 points
---@return druid.scroll Current scroll instance
function druid__scroll.set_points(self, points) end

--- Set scroll content size.
---@param self druid.scroll
---@param size vector3 The new size for content node
---@return druid.scroll Current scroll instance
function druid__scroll.set_size(self, size) end

--- Lock or unlock vertical scroll
---@param self druid.scroll
---@param state bool True, if vertical scroll is enabled
---@return druid.scroll Current scroll instance
function druid__scroll.set_vertical_scroll(self, state) end


---@class druid.scroll.style
---@field ANIM_SPEED field  Scroll gui.animation speed for scroll_to function
---@field BACK_SPEED field  Scroll back returning lerp speed
---@field EXTRA_STRETCH_SIZE field  extra size in pixels outside of scroll (stretch effect)
---@field FRICT field  Multiplier for free inertion
---@field FRICT_HOLD field  Multiplier for inertion, while touching
---@field INERT_SPEED field  Multiplier for inertion speed
---@field INERT_THRESHOLD field  Scroll speed to stop inertion
---@field POINTS_DEADZONE field  Speed to check points of interests in no_inertion mode
---@field SMALL_CONTENT_SCROLL field  If true, content node with size less than view node size can be scrolled
local druid__scroll__style = {}


---@class druid.slider : druid.base_component
---@field dist number Length between start and end position
---@field end_pos vector3 End pin node position
---@field is_drag bool Current drag state
---@field node node Slider pin node
---@field on_change_value druid_event On change value callback(self, value)
---@field pos vector3 Current pin node position
---@field start_pos vector3 Start pin node position
---@field target_pos vector3 Targer pin node position
local druid__slider = {}

--- Component init function
---@param self druid.slider
---@param node node Gui pin node
---@param end_pos vector3 The end position of slider
---@param callback function On slider change callback
function druid__slider.init(self, node, end_pos, callback) end

--- Set value for slider
---@param self druid.slider
---@param value number Value from 0 to 1
---@param is_silent bool Don't trigger event if true
function druid__slider.set(self, value, is_silent) end

--- Set slider steps.
---@param self druid.slider
---@param steps number[] Array of steps
function druid__slider.set_steps(self, steps) end


---@class druid.static_grid : druid.base_component
---@field anchor vector3 Item anchor
---@field first_index number The first index of node in grid
---@field last_index number The last index of node in grid
---@field node_size vector3 Item size
---@field nodes node[] List of all grid nodes
---@field on_add_item druid_event On item add callback(self, node, index)
---@field on_change_items druid_event On item add or remove callback(self, index)
---@field on_clear druid_event On grid clear callback(self)
---@field on_remove_item druid_event On item remove callback(self, index)
---@field on_update_positions druid_event On update item positions callback(self)
---@field parent node Parent gui node
local druid__static_grid = {}

--- Add new item to the grid
---@param self druid.static_grid
---@param item node Gui node
---@param index number The item position. By default add as last item
function druid__static_grid.add(self, item, index) end

--- Clear grid nodes array.
---@param self druid.static_grid
---@return druid.static_grid Current grid instance
function druid__static_grid.clear(self) end

--- Return array of all node positions
---@param self druid.static_grid
---@return vector3[] All grid node positions
function druid__static_grid.get_all_pos(self) end

--- Return index for grid pos
---@param self druid.static_grid
---@param pos vector3 The node position in the grid
---@return number The node index
function druid__static_grid.get_index(self, pos) end

--- Return grid index by node
---@param self druid.static_grid
---@param node node The gui node in the grid
---@return number The node index
function druid__static_grid.get_index_by_node(self, node) end

--- Return pos for grid node index
---@param self druid.static_grid
---@param index number The grid element index
---@return vector3 Node position
function druid__static_grid.get_pos(self, index) end

--- Return grid content size
---@param self druid.static_grid
---@return vector3 The grid content size
function druid__static_grid.get_size(self) end

--- Component init function
---@param self druid.static_grid
---@param parent node The gui node parent, where items will be placed
---@param element node Element prefab. Need to get it size
---@param in_row number How many nodes in row can be placed
function druid__static_grid.init(self, parent, element, in_row) end

--- Remove the item from the grid.
---@param self druid.static_grid
---@param index number The grid node index to remove
---@param is_shift_nodes bool If true, will shift nodes left after index
function druid__static_grid.remove(self, index, is_shift_nodes) end

--- Set grid anchor.
---@param self druid.static_grid
---@param anchor vector3 Anchor
function druid__static_grid.set_anchor(self, anchor) end

--- Change set position function for grid nodes.
---@param self druid.static_grid
---@param callback function Function on node set position
---@return druid.static_grid Current grid instance
function druid__static_grid.set_position_function(self, callback) end


---@class druid.swipe : druid.base_component
---@field click_zone node Restriction zone
---@field node node Swipe node
---@field style druid.swipe.style Component style params.
local druid__swipe = {}

--- Component init function
---@param self druid.swipe
---@param node node Gui node
---@param on_swipe_callback function Swipe callback for on_swipe_end event
function druid__swipe.init(self, node, on_swipe_callback) end

--- Strict swipe click area.
---@param self druid.swipe
---@param zone node Gui node
function druid__swipe.set_click_zone(self, zone) end


---@class druid.swipe.style
---@field SWIPE_THRESHOLD field  Minimum distance for swipe trigger
---@field SWIPE_TIME field  Maximum time for swipe trigger
---@field SWIPE_TRIGGER_ON_MOVE field  If true, trigger on swipe moving, not only release action
local druid__swipe__style = {}


---@class druid.text : druid.base_component
---@field is_no_adjust bool Current text size adjust settings
---@field node node Text node
---@field on_set_pivot druid_event On change pivot callback(self, pivot)
---@field on_set_text druid_event On set text callback(self, text)
---@field on_update_text_scale druid_event On adjust text size callback(self, new_scale)
---@field pos vector3 Current text position
---@field scale vector3 Current text node scale
---@field start_scale vector3 Initial text node scale
---@field start_size vector3 Initial text node size
---@field text_area vector3 Current text node available are
local druid__text = {}

--- Calculate text width with font with respect to trailing space
---@param self druid.text
---@param text string
function druid__text.get_text_width(self, text) end

--- Component init function
---@param self druid.text
---@param node node Gui text node
---@param value string Initial text. Default value is node text from GUI scene.
---@param no_adjust bool If true, text will be not auto-adjust size
function druid__text.init(self, node, value, no_adjust) end

--- Return true, if text with line break
---@param self druid.text
---@return bool Is text node with line break
function druid__text.is_multiline(self) end

--- Set alpha
---@param self druid.text
---@param alpha number Alpha for node
function druid__text.set_alpha(self, alpha) end

--- Set color
---@param self druid.text
---@param color vector4 Color for node
function druid__text.set_color(self, color) end

--- Set text pivot.
---@param self druid.text
---@param pivot gui.pivot Gui pivot constant
function druid__text.set_pivot(self, pivot) end

--- Set scale
---@param self druid.text
---@param scale vector3 Scale for node
function druid__text.set_scale(self, scale) end

--- Set text to text field
---@param self druid.text
---@param set_to string Text for node
function druid__text.set_to(self, set_to) end


---@class druid.timer : druid.base_component
---@field from number Initial timer value
---@field node node Trigger node
---@field on_set_enabled druid_event On timer change enabled state callback(self, is_enabled)
---@field on_tick druid_event On timer tick.
---@field on_timer_end druid_event On timer end callback
---@field target number Target timer value
local druid__timer = {}

--- Component init function
---@param self druid.timer
---@param node node Gui text node
---@param seconds_from number Start timer value in seconds
---@param seconds_to number End timer value in seconds
---@param callback function Function on timer end
function druid__timer.init(self, node, seconds_from, seconds_to, callback) end

--- Set time interval
---@param self druid.timer
---@param from number Start time in seconds
---@param to number Target time in seconds
function druid__timer.set_interval(self, from, to) end

--- Called when update
---@param self druid.timer
---@param is_on bool Timer enable state
function druid__timer.set_state(self, is_on) end

--- Set text to text field
---@param self druid.timer
---@param set_to number Value in seconds
function druid__timer.set_to(self, set_to) end


---@class druid_event
local druid_event = {}

--- Clear the all event handlers
---@param self druid_event
function druid_event.clear(self) end

--- Event constructur
---@param self druid_event
---@param initial_callback function Subscribe the callback on new event, if callback exist
function druid_event.initialize(self, initial_callback) end

--- Return true, if event have at lease one handler
---@param self druid_event
---@return bool True if event have handlers
function druid_event.is_exist(self) end

--- Subscribe callback on event
---@param self druid_event
---@param callback function Callback itself
function druid_event.subscribe(self, callback) end

--- Trigger the event and call all subscribed callbacks
---@param self druid_event
---@param ... any All event params
function druid_event.trigger(self, ...) end

--- Unsubscribe callback on event
---@param self druid_event
---@param callback function Callback itself
function druid_event.unsubscribe(self, callback) end


---@class druid_instance
local druid_instance = {}

--- Create new druid component
---@param self druid_instance
---@param component Component Component module
---@param ... args Other component params to pass it to component:init function
function druid_instance.create(self, component, ...) end

--- Call on final function on gui_script.
---@param self druid_instance
function druid_instance.final(self) end

--- Druid class constructor
---@param self druid_instance
---@param context table Druid context. Usually it is self of script
---@param style table Druid style module
function druid_instance.initialize(self, context, style) end

--- Create back_handler basic component
---@param self druid_instance
---@param ... args back_handler init args
---@return druid.back_handler back_handler component
function druid_instance.new_back_handler(self, ...) end

--- Create blocker basic component
---@param self druid_instance
---@param ... args blocker init args
---@return druid.blocker blocker component
function druid_instance.new_blocker(self, ...) end

--- Create button basic component
---@param self druid_instance
---@param ... args button init args
---@return druid.button button component
function druid_instance.new_button(self, ...) end

--- Create checkbox component
---@param self druid_instance
---@param ... args checkbox init args
---@return druid.checkbox checkbox component
function druid_instance.new_checkbox(self, ...) end

--- Create checkbox_group component
---@param self druid_instance
---@param ... args checkbox_group init args
---@return druid.checkbox_group checkbox_group component
function druid_instance.new_checkbox_group(self, ...) end

--- Create drag basic component
---@param self druid_instance
---@param ... args drag init args
---@return druid.drag drag component
function druid_instance.new_drag(self, ...) end

--- Create dynamic grid component
---@param self druid_instance
---@param ... args grid init args
---@return druid.dynamic_grid grid component
function druid_instance.new_dynamic_grid(self, ...) end

--- Create grid basic component  Deprecated
---@param self druid_instance
---@param ... args grid init args
---@return druid.static_grid grid component
function druid_instance.new_grid(self, ...) end

--- Create hover basic component
---@param self druid_instance
---@param ... args hover init args
---@return druid.hover hover component
function druid_instance.new_hover(self, ...) end

--- Create input component
---@param self druid_instance
---@param ... args input init args
---@return druid.input input component
function druid_instance.new_input(self, ...) end

--- Create lang_text component
---@param self druid_instance
---@param ... args lang_text init args
---@return druid.lang_text lang_text component
function druid_instance.new_lang_text(self, ...) end

--- Create progress component
---@param self druid_instance
---@param ... args progress init args
---@return druid.progress progress component
function druid_instance.new_progress(self, ...) end

--- Create radio_group component
---@param self druid_instance
---@param ... args radio_group init args
---@return druid.radio_group radio_group component
function druid_instance.new_radio_group(self, ...) end

--- Create scroll basic component
---@param self druid_instance
---@param ... args scroll init args
---@return druid.scroll scroll component
function druid_instance.new_scroll(self, ...) end

--- Create slider component
---@param self druid_instance
---@param ... args slider init args
---@return druid.slider slider component
function druid_instance.new_slider(self, ...) end

--- Create static grid basic component
---@param self druid_instance
---@param ... args grid init args
---@return druid.static_grid grid component
function druid_instance.new_static_grid(self, ...) end

--- Create swipe basic component
---@param self druid_instance
---@param ... args swipe init args
---@return druid.swipe swipe component
function druid_instance.new_swipe(self, ...) end

--- Create text basic component
---@param self druid_instance
---@param ... args text init args
---@return Tet text component
function druid_instance.new_text(self, ...) end

--- Create timer component
---@param self druid_instance
---@param ... args timer init args
---@return druid.timer timer component
function druid_instance.new_timer(self, ...) end

--- Druid on focus gained interest function.
---@param self druid_instance
function druid_instance.on_focus_gained(self) end

--- Druid on focus lost interest function.
---@param self druid_instance
function druid_instance.on_focus_lost(self) end

--- Druid on_input function
---@param self druid_instance
---@param action_id hash Action_id from on_input
---@param action table Action from on_input
function druid_instance.on_input(self, action_id, action) end

--- Druid on layout change function.
---@param self druid_instance
function druid_instance.on_layout_change(self) end

--- Druid on_message function
---@param self druid_instance
---@param message_id hash Message_id from on_message
---@param message table Message from on_message
---@param sender hash Sender from on_message
function druid_instance.on_message(self, message_id, message, sender) end

--- Remove component from druid instance.
---@param self druid_instance
---@param component Component Component instance
function druid_instance.remove(self, component) end

--- Druid update function
---@param self druid_instance
---@param dt number Delta time
function druid_instance.update(self, dt) end


---@class helper
local helper = {}

--- Center two nodes.
---@param icon_node box Gui box node
---@param text_node text Gui text node
---@param margin number Offset between nodes
function helper.centrate_icon_with_text(icon_node, text_node, margin) end

--- Center two nodes.
---@param text_node text Gui text node
---@param icon_node box Gui box node
---@param margin number Offset between nodes
function helper.centrate_text_with_icon(text_node, icon_node, margin) end

--- Show deprecated message.
---@param message string The deprecated message
function helper.deprecated(message) end

--- Distance from node to size border
---@return  vector4 (left, top, right, down)
function helper.get_border() end

--- Get node offset for given gui pivot
---@param pivot gui.pivot The node pivot
---@return vector3 Vector offset with [-1..1] values
function helper.get_pivot_offset(pivot) end

--- Check if node is enabled in gui hierarchy.
---@param node node Gui node
---@return bool Is enabled in hierarchy
function helper.is_enabled(node) end

--- Check if device is mobile (Android or iOS)
function helper.is_mobile() end

--- Check if device is HTML5
function helper.is_web() end


