
/// @param {Real} id
/// @param {String} name
/// @param {String} description
/// @param {Asset.GMObject} object
/// @param {Real} width
/// @param {Real} height
/// @param {Real} tier
/// @param {Struct.str_g_costs} costs
function str_g_building(_id, _name, _description, _object, _construction_object, _w, _h, _tier, _costs, _upgrades = []) constructor {
	str_id = _id;
	name = _name; description = _description;
	object = _object;
	construction_object = _construction_object;
	sprite = object_get_sprite(_object);
	w = _w; h = _h;
	tier = _tier;
	costs = _costs;
	upgrades_applicable = _upgrades;
	
	static f_get_drawing_struct = function(_xo, _yo, _w) {
		draw_set_font(global.g_font_m);
		var d_struct = { x : 12, y : _yo + 8, w : _w - 24, h : 0, desc_x : 0, desc_w : 0 };
		d_struct.desc_x = d_struct.x + sprite_get_width(sprite) + 12;
		d_struct.desc_w = d_struct.w - d_struct.desc_x;
		d_struct.h = max(string_height_ext(description, -1, d_struct.desc_w), sprite_get_height(sprite));
		return d_struct;
	}
	
	static f_draw_struct = function(d_struct) { 
		draw_set_font(global.g_font_m); draw_set_align(-1, -1);
		draw_sprite_ext(sprite, 0, d_struct.x, d_struct.y + sprite_get_bbox_top(sprite), 1, 1, 0, c_white, 1.0);
		draw_text_ext(d_struct.desc_x, d_struct.y, description, -1, d_struct.desc_w);
	}
}

/// @param {String} type
/// @param {String} name
/// @param {String} description
/// @param {Asset.GMSprite} sprite
/// @param {Real} tier
/// @param {Struct.str_g_costs} costs
function str_g_item(_id, _type, _name, _description, _sprite, _tier, _costs ) constructor {
	str_id = _id;
	type = _type;
	name = _name;
	description = _description;
	sprite = _sprite;
	tier = _tier;
	costs = _costs;
	
	struct_hash = undefined;
}
	
/// @param {Real} effort - Time in Seconds
/// @param {Real} credits
function str_g_costs(_effort, _credits) constructor {
	effort = dt_seconds_per(_effort);
	credits = _credits
	items = [];
	values = [];
	
	/// @function f_addItem(item, value)
	/// @param {Struct.str_g_item} items
	/// @param {Real} values
	/// @return {Struct.str_g_costs} 
	static f_AddItem = function (_item, _value) {
		if ( array_contains(items, _item) ) { values[array_get_index(items, _item)] = _value; }
		else { array_push(items, _item); array_push(values, _value); }
		return self;
	}	
}

/// @param {Real} type
/// @param {String} name
/// @param {String} description
/// @param {Asset.GMSprite} sprite
/// @param {Real} tier
/// @param {Array.Struct.str_g_runlock} unlocks
/// @param {Struct.str_g_costs} costs
function str_g_research (_id, _type, _name, _description, _sprite, _tier, _unlocks = [], _costs = global.g_cost_empty ) constructor {
	str_id = _id;
	type = _type;
	name = _name;
	description = _description;
	sprite = _sprite;
	tier = _tier;
	costs = _costs;
	
	unlocks = _unlocks
	
	prerequisites = [];
	dependencies = [];
	
	hidden_outside_tree = false;
	hidden = false;
	hidden_prerequisites = undefined;	
	
	/// @function f_addPrereq(research)
	/// @param {Struct.str_g_research} research
	/// @return {Struct.str_g_research} 
	static f_addPrereq = function(_research) {
		array_push_unique(prerequisites, _research);
		array_push_unique(_research.dependencies, self);
		return self;
	}
	
	/// @function f_addUnlock(research)
	/// @param {Struct.str_g_research} research
	/// @return {Struct.str_g_research} 
	static f_addUnlock = function(_research) {
		array_push_unique(dependencies, _research);
		array_push_unique(_research.prerequisites, self);
		return self;
	}
	
	static f_setupHidden = function(_outside_tree, _hidden, _prerequisites = []) {
		hidden_outside_tree = _outside_tree;
		hidden = _hidden;
		hidden_prerequisites = _prerequisites;
		
		for ( var i = 0; i < array_length(_prerequisites); i++ ) {
			array_push_unique(hidden_prerequisites, _prerequisites[i]);
			array_push_unique(_prerequisites[i].dependencies, self);
		}
		return self;
	}
}

/// @param {Real} type
/// @param {Struct} unlock
/// @param {String} description
/// @param {Asset.GMSprite} sprite
function str_g_runlock ( _type, _unlock, _description, _sprite ) constructor {
	type = _type;
	unlock = _unlock;
	description = _description;
	sprite = _sprite;
}


/// @param {Real} group
/// @param {Real} type
/// @param {Array} values
/// @param {String} [description = ""]
function str_g_upgrade ( _group, _type, _values, _description = "" ) constructor {
	category = -1;
	group = _group;
	type = _type;
	description = _description;
	
	values = _values;
	
	static groups = { z_situational : -1, 
		mines_all : 0, mines_basic : 1, 
		assemblers_all : 10, 
		smelters_all : 20,
		eng_miners : 1000, eng_assemblers : 1010, eng_smelters : 1020};
		
	static categories = { building_upgrade : 999, engineering_upgrade : 1999 };
		
	static types = { speed_mult : 0, effort_mult: 5, output_item_count : 10, output_extra_chance : 20,
		eng_point_preadd : 1010, eng_point_mult : 1020, eng_point_add : 1030, eng_board_launch_rate : 1050, eng_board_launch_cost : 1060,
		eng_board_modification : 1090 };
	
	static applicable = function(_group, _type) {
		return { group : _group, type : _type };
	}
	
	static f_applicable_upgrade = function ( _applicable_list ) {
		for ( var i = 0; i < array_length(_applicable_list); i++ ) {
			if ( group == _applicable_list[i].group && type == _applicable_list[i].type ) { return true; } }
		return false;
	}
	
	static f_duplicate = function() {
		var n = new str_g_upgrade( group, type, [], description );
		for ( var i = 0; i < array_length(values); i++ ) { array_push(n.values, values[i]); }
		return n;
	}
	
	if ( type < categories.building_upgrade ) { category = categories.building_upgrade; }
	else if ( type < categories.engineering_upgrade ) { category = categories.engineering_upgrade; }
}