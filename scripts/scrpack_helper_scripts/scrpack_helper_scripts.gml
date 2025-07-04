/// @function			date_timestamp()
/// @description		Returns the current timestamp.
function date_timestamp() {
	return ceil(date_second_span(25569, date_current_datetime()));
}


/// @function			destroy_instance(instance_id) 
/// @description		Destroys a given instance.
function destroy_instance(argument0) {
	with ( argument0 ) { instance_destroy(); }
}


/// @function			draw_text_color_e(x, y, string, color)
/// @desccription		One Color draw_text_color
function draw_text_color_e(_x, _y, _string, _color) {
	draw_text_color(_x, _y, _string, _color, _color, _color,_color, 1.0);
}


/// @function			id_exists(instance_id)
/// @description		Checks to see if a given object id exists. 
function id_exists(argument0) {
	var i = argument0;

	if ( i < 100000 ) { return false; }
	//with ( i ) { return true; } 
	return false;
}

function f_empty() {};

/// @function			instance_create(type, x, y)
/// @description		Creates a new instance without the depth requirements
function instance_create(argument0, argument1, argument2) {
	return instance_create_depth(argument1, argument2, 0, argument0);
}


/// @function			string_split(string, delimeter_char)
/// @description		Splits a string into a ds_list by the delimeter character.
function string_split(argument0, argument1) {
	var s = argument0;
	var del = argument1;
	var list = ds_list_create();

	var word = "";
	for ( var i = 0; i < string_length(s)-1; i++ ) {
	    var c = string_char_at(s, i+1);
    
	    if ( c == del ) { ds_list_add(list, word); word = ""; }
	    else { word += c; }
	}

	ds_list_add(list, word);

	return list;
}


/// @function			user_event(instance_id, event_id)
/// @description		Calls the user_event function of a given number for a given object.
function user_event(argument0, argument1) {
	with ( argument0 ) { event_user(argument1); }
}

function between(num, _min, _max) {
	return (num >= _min && num <= _max);
}

function lengthdir_xy(len, dir) {
	return { x : lengthdir_x(len, dir), y : lengthdir_y(len, dir) };
}

function str_ctimer(maxTimer, drainAll = true, increment = 1, currentTimer = 0) constructor {
	active = false;
	maxValue = maxTimer;
	currentValue = currentTimer;
	incrementValue = increment;
	drainType = drainAll;
	
	increment = function() { 
		currentValue = min(maxValue, currentValue + incrementValue);
		if ( currentValue == maxValue ) { active = true; }
	};
	
	decrement = function() {
		if (drainAll) { currentValue = 0; active = false; } 
	
		else {
			currentValue = max(0, currentValue - maxValue);
			if ( currentValue < maxValue ) { 
				active = false;
			}
		}
	};
}

function ctimer_increment(ctimer) {
	ctimer.cur = min(ctimer.max, ctimer.cur + ctimer.inc);
	if ( ctimer.cur == ctimer.max ) { ctimer.active = true; }
}

function ctimer_decrement(ctimer, drainAll = true) {
	if (drainAll) {
		ctimer.cur = 0;
		ctimer.active = false;
	} 
	
	else {
		ctimer.cur = max(0, ctimer.cur - ctimer.max);
		if ( ctimer.cur < ctimer.max ) { 
			ctimer.active = false;
		}
	}
}

/// @function			array_remove(_array, _value)
/// @description		Removes the first instance of an element from a array.
/// @return {Bool}		Was the object in the array and removed?
function array_remove(_array, _value) {
	var i = array_get_index(_array, _value);
	if ( i != -1 ) { array_delete(_array, i, 1); return true; }
	return false;
}

/// @function			array_push_unique(_array, _value)
/// @description		Adds the element to the array if it is not already in the array.
/// @return				Was the value added?
function array_push_unique(_array, _value) {
	if ( array_get_index(_array, _value) != -1 ) { return false; }
	array_push(_array, _value); 
	return true;
}

/// @function			array_count(_array, _value)
/// @description		Counts the number of times a specific value is in the array.
/// @return				The number of the specific value is in the array.
function array_count(_array, _value) {
	var c = 0;
	for ( var i = 0; i < array_length(_array); i++ ) { 
		if ( _array[i] == _value ) { c++; } }
	return c;
}

function instance_activate_array(_array) {
	for ( var i = 0; i < array_length(_array); i++ ) {
		instance_activate_object(_array[i]);
	}
}

function instance_deactivate_array(_array) {
	for ( var i = 0; i < array_length(_array); i++ ) {
		instance_deactivate_object(_array[i]);
	}
}

function instance_destroy_array(_array, _clear = true) {
	for ( var i = array_length(_array)-1; i >= 0; i-- ) {
		instance_destroy(_array[i]);
	}
	if ( _clear ) { _array = []; }
}

function set_image_xyscale(_object, _width, _height) {
	if ( _width != false ) { _object.image_xscale = _width / sprite_get_width(_object.sprite_index); }
	if ( _height != false ) { _object.image_yscale = _height / sprite_get_height(_object.sprite_index); }
}

function draw_set_align(_h, _v) {
	if ( _h < 0 ) { draw_set_halign(fa_left); }
	else if ( _h == 0 ) { draw_set_halign(fa_center); }
	else { draw_set_halign(fa_right); }
	
	if ( _v < 0 ) { draw_set_valign(fa_top); }
	else if ( _v == 0 ) { draw_set_valign(fa_middle); }
	else { draw_set_valign(fa_bottom); }
}

function set_draw_font(_font, _h, _v, _color = undefined ) {
	draw_set_font(_font);
	
	if ( _h < 0 ) { draw_set_halign(fa_left); }
	else if ( _h == 0 ) { draw_set_halign(fa_center); }
	else { draw_set_halign(fa_right); }
	
	if ( _v < 0 ) { draw_set_valign(fa_top); }
	else if ( _v == 0 ) { draw_set_valign(fa_middle); }
	else { draw_set_valign(fa_bottom); }
	
	if ( _color != undefined ) { draw_set_color(_color); }
}

/// @function string_width_fext (_text, _font, [_sep], [_width])
function string_width_fext(_text, _font, _sep = -1, _width = -1 ) {
	draw_set_font(_font);
	return string_width_ext(_text, _sep, _width);
}

/// @function string_height_fext (_text, _font, [_sep], [_width])
function string_height_fext(_text, _font, _sep = -1, _width = -1 ) {
	draw_set_font(_font);
	return string_height_ext(_text, _sep, _width);
}


function debug_timer(_print = true, _reset = false, _name = "") {
	static times = [];
	static last_time = 0;
	static name = "";
	
	if ( _reset ) { times = []; last_time = get_timer(); }
	if ( _name != "" ) { name = _name; }
	
	array_push(times, get_timer()-last_time);
	
	if ( _print ) {
		show_debug_message(string("{0} Debug Timer : {1}", name, times)); }
}

