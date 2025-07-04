function str_item_storage(_item, _maximum, _count = 0) constructor {
	item = _item;
	maximum = _maximum;
	count = _count;
	free = _maximum ? _maximum - _count : 9999999;
	pending = 0;
	
	/// @function f_add_items(count,  pending, override)
	/// @param {Real} _count - How many items to add.
	/// @param {Bool} _pending - Add this to the pending queue or straight into storage
	/// @param {Bool} _override - Adds the item regardless of maximums
	/// @return {Real} - How many items remain for entry (it was full).
	static f_add_items = function(_count, _pending = true, _override = false) {
		if ( maximum ) {
			if ( maximum && free >= _count || _override ) { 
				if ( _pending ) { pending += _count; }
				else { count += _count; }
				free -= _count;
			
				return 0;
			}
		
			else {
				if ( _pending ) { pending += free; }
				else { count += free; }
			
				var oldfree = free;
				free = 0;
			
				return oldfree;
			}
		}
		
		else { 
			if ( _pending ) { pending += _count; }
			else { count += _count; }
			return 9999999;
		}
	}
	
	static f_transfer_pending_items = function(_common) {
		count += pending; pending = 0;
	}
			
	/// @function f_remove_items(count, allowMissing)
	/// @param {Real} count
	/// @param {Bool} allowMissing - False will fail if there are not the required number of items in storage.
	/// @return {Real} The number of items removed.
	static f_remove_items = function( _count, _allowMissing = false ) {
		if ( _count == 0 ) { return 0; }
		if ( _allowMissing == false ) {
			if ( count < _count ) { return 0; }
		}
		
		var removed = min(_count, count);
		
		count -= removed;
		free += removed;
		
		return removed;
	}
	
	/// @param {Struct.str_item_storage} _storageTarget
	/// @param {Real} _count
	static f_transfer_items = function(_storageTarget, _count ) {
		var removed = min(_count, count, _storageTarget.free);
		f_remove_items(removed, true);
		_storageTarget.f_add_items(removed);
		return removed;
	}
	
	static f_draw_storage = function(_x, _y, _w, _h, _image_index = 0) {
		var spr_scale = 8;
		var spr_border = 4;
		var b_border = 2;
		
		var min_width = max(string_width(item.name), string_width("Count: " + number_printable(count, true)));
		min_width = max(_w, min_width + 32 + (4 * 7));
		
		draw_sprite_ext(spr_ui_border_tiny, 0, _x + b_border, _y + b_border, 
			(min_width - ( 2 * b_border ) ) / spr_scale, (_h - ( 2 * b_border ) ) / spr_scale, 0, c_white, 1.0);
			
		draw_sprite_ext(item.sprite, 0, _x + ( spr_border * 2 ), _y + ( _h div 2 ) - 16, 1, 1, 0, c_white, 1.0);
		
		draw_set_font(global.g_font_m);
		draw_set_align(-1, 0);
		var inner = (_h - (2 * spr_border)) / 4;
		draw_text_color_e(_x + 32 + (spr_border * 4) , _y + spr_border + inner, item.name, c_white);

		draw_text_color_e(_x + 32 + (spr_border * 4) , _y + spr_border + (inner * 3), "Count: ", c_white);
		
		return { x : ( 32 + (spr_border * 4) + string_width("Count:|") ), y : 4 + (inner * 3) };
	}
	
	static f_draw_storage_compact = function(_x, _y, _w, _h, _image_index = 0 ) {
		static t_font = draw_get_font();
		static text_number_width = string_width("999.9 m");
		static border_scale = sprite_get_width(spr_ui_border_tiny);
		static sprite_border = 4;
		
		if ( t_font != draw_get_font() ) { t_font = draw_get_font(); text_number_width = string_width("999.9 m"); }
		
		var text_width = 0;
	}
}
 