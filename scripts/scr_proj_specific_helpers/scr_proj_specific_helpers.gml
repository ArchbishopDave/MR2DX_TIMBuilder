// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function instance_f_activate_array(_array) {
	for ( var i = 0; i < array_length(_array); i++ ) {
		_array[i].f_instance_activate();
	}
}

function instance_f_deactivate_array(_array) {
	for ( var i = 0; i < array_length(_array); i++ ) {
		_array[i].f_instance_deactivate();
	}
}

function instance_create_mm( _object, _pass_struct = {}, _depth = 1 ) {
	_pass_struct.m_mode_master = other.id;
	return instance_create_depth(OOB, OOB, other.depth - _depth, _object, _pass_struct);
}