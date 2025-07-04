

function str_surface () constructor {
	surface = -1;
	update = false;
	
// @function f_check_and_set(surface_struct, width, height)
/// @param {Real} width
/// @param {Real} height
/// @return {Bool} Whether the surface should be updated.
	static f_check_and_set = function (_w, _h) {
		if ( surface_exists(surface) && !update ) { return false; }
	
		if ( !surface_exists(surface) ) { surface = surface_create(_w, _h); }
		else if ( surface_get_width(surface) != _w && surface_get_height(surface) ) { surface_resize(surface, _w, _h); }
		
		surface_set_target(surface);
		draw_clear_alpha(c_black, 0);
		update = false;
		return true;
	}
};