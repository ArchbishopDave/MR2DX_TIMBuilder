// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

function str_physics_properties(_owner, _bindx = 0, _bindy = 0, _collision = -100, _density = 0, _kinematic = false, _sensor = false) constructor {
	owner = _owner;
	bindx = _bindx;
	bindy = _bindy;
	collision = _collision;
	density = _density;
	kinematic = _kinematic;
	sensor = _sensor;
	
	fixtures = [];
	
	static f_polygon_fixtures = function(_object, _array) {
		var fixtures = [];
		for ( var i = 0; i < array_length(_array); i++ ) {
			var fix = physics_fixture_create();
			physics_fixture_set_polygon_shape(fix);
			
			for ( var j = 0; j < array_length(_array[i]); j++ ) {
				physics_fixture_add_point(fix, _array[i][j][0], _array[i][j][1]);
			}
			
			physics_fixture_set_collision_group(fix, collision);
			physics_fixture_set_density(fix, density);
			
			if ( kinematic ) { physics_fixture_set_kinematic(fix); }
			physics_fixture_set_sensor(fix, sensor);
			
			array_push(fixtures, physics_fixture_bind_ext(fix, _object, bindx, bindy));
			physics_fixture_delete(fix);
		}
		return fixtures;
	}
	
	static f_reset = function(_bindx = 0, _bindy = 0, _collision = -100, _density = 0, _kinematic = false, _sensor = false) {
			for ( var i = 0; i < array_length(fixtures); i++ ) { 
				physics_remove_fixture(owner, fixtures[i]);
				physics_fixture_delete(fixtures[i]);  
			}
			
			bindx = _bindx;
			bindy = _bindy;
			collision = _collision;
			density = _density;
			kinematic = _kinematic;
			sensor = _sensor;
			
			fixtures = [];
		}
		
	static f_delete_fixtures = function() { 
		for ( var i = 0; i < array_length(fixtures); i++ ) { 
			physics_remove_fixture(owner, fixtures[i]);
			physics_fixture_delete(fixtures[i]); 
		}
		
		fixtures = [];
	}
	
	
	
	
}