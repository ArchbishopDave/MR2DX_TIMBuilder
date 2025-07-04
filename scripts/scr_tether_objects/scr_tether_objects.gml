function scr_tether_setup_master() {
	ms_tether_lx = x;
	ms_tether_ly = y;
	ms_tether_children = [];
	//ms_tether_children_settings = [];
	array_push_unique(obj_master_game.ms_tether_list, self.id);
}

function scr_tether_game_update(_master) {
	if ( _master.x != _master.ms_tether_lx || _master.y != _master.ms_tether_ly ) {
		for ( var j = 0; j < array_length(_master.ms_tether_children); j++ ) {
			var child = _master.ms_tether_children[j];
			child.x = _master.x + child.ms_tether_master_setting.x;
			child.y = _master.y + child.ms_tether_master_setting.y;
		}
		_master.ms_tether_lx = _master.x; _master.ms_tether_ly = _master.y;
	}
}


function scr_tether_setup(_master, _child, _xoff, _yoff, _absolute = false) {
	_child.ms_tether_master = _master;
	
	array_push_unique(_master.ms_tether_children, _child);
	var ns = { x : _xoff, y : _yoff };
	if ( _absolute ) { ns.x = _xoff - _master.x; ns.y = _yoff - _master.y; }
	_child.ms_tether_master_setting = ns;

	scr_tether_refresh(_child);

}

function scr_tether_update(_master, _child, _xoff, _yoff, _absolute = false ) {
	if ( array_contains(_master.ms_tether_children, _child) ) {
		var ns = { x : _xoff, y : _yoff };
		if ( _absolute ) { ns.x = _xoff - _master.x; ns.y = _yoff - _master.y; }
		
		_child.ms_tether_master_setting = ns;
		scr_tether_refresh(_child);
	}
}

function scr_tether_refresh(_child = self.id) {
	_child.x = _child.ms_tether_master.x + _child.ms_tether_master_setting.x;
	_child.y = _child.ms_tether_master.y + _child.ms_tether_master_setting.y;
}



function scr_tether_break(_master, _child) {
	if ( array_remove(_master.ms_tether_children, _child) ) {
		_child.ms_tether_master = undefined;
		_child.ms_tether_master_setting = { x : 0, y : 0 };
	}
}
	