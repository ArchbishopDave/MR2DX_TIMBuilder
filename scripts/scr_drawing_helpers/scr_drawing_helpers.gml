/// @function scr_draw_storage_gauge(storage)
/// @param {Struct.str_storage_network} _storage
function scr_draw_storage_gauge(_x, _y, _storage) {
	if ( !surface_exists(global.surface_gauges) ) {
		var gwidth = 16; var gheight = 64 - 8; gspace = 4;
		var gsprite = spr_quality_gauge_vertical;
		global.surface_gauges = surface_create((gwidth + gspace) * 10, gheight);
		surface_set_target(global.surface_gauges);
	    draw_clear_alpha(c_black, 0);
	
		for ( var i = 0; i < 10; i++ ) {
			draw_sprite_ext(gsprite, 0, ( i * (gwidth + gspace) ), 0, 
			sprite_get_width(gsprite) / gwidth, sprite_get_height(gsprite) / gheight, 0, c_white, 1.0);
		}	 
	    surface_reset_target();
	}

}

function draw_sprite_size_ext(_sprite, _subimg, _x, _y, _w, _h, 
	_rot = image_angle, _color = image_blend, _alpha = image_alpha) {
		draw_sprite_ext(_sprite, _subimg, _x, _y, 
			_w / sprite_get_width(_sprite),
			_h / sprite_get_height(_sprite),
			_rot, _color, _alpha);
}



function draw_debug_struct(_struct, _color, _alpha) {
	draw_sprite_ext(spr_1x1, 0, x + _struct.x, y + _struct.y, _struct.w, _struct.h, 0, _color, _alpha);
}