function scr_hoverable_master() {
	ms_hoverable_list = [];
}

function scr_hoverable_obtain_instance(_master) {
	var ho = -1;
	for ( var i = 0; i < array_length(obj_master_game.ms_hoverable_list); i++ ) {
		ho = obj_master_game.ms_hoverable_list[i];
		if ( ho.ms_tether_master != undefined ) { ho = -1; }
		else { instance_activate_object(ho); break; }
	}
	
	if ( ho == -1 ) { 
		ho = instance_create_depth(OOB, OOB, 0, obj_ui_item_hoverable);
		array_push(obj_master_game.ms_hoverable_list, ho);
	}
	
	if ( !variable_instance_exists(_master, "ms_hoverable_list") ) { _master.ms_hoverable_list = []; }
	array_push(_master.ms_hoverable_list, ho);
	return ho;
}

/// @function scr_hoverable_relinquish_instance(master, [instance])
/// @param {Id.Instance} master
/// @param {Id.Instance} instance [All]
function scr_hoverable_relinquish_instance(_master, _instance = -1 ) {
	if ( _instance == -1 ) {
		for ( var i = 0; i < array_length(_master.ms_hoverable_list); i++ ) {
			scr_tether_break(_master, _master.ms_hoverable_list[i]);
			instance_deactivate_object(_master.ms_hoverable_list[i]);
		}
		_master.ms_hoverable_list = [];
	}
	
	else {
		array_remove(_master.ms_hoverable_list, _instance);
		scr_tether_break(_master, _instance);
		instance_deactivate_object(_instance);
	}
}


function scr_hoverable_setup_costs_row (_costs, _master, _x, _y, _size, _spacing ) {
	var count = 0;
	var cx = 0;
	
	if ( _costs.effort != 0 ) { 
		var hoverable = scr_hoverable_obtain_instance(_master);
		hoverable.f_setup_cost_effort_hoverable(_master, _x + cx, _y, _size, _size, _costs.effort );
		cx += (_spacing + _size); count++;
	}
	
	if ( _costs.credits != 0 ) { 
		var hoverable = scr_hoverable_obtain_instance(_master);
		hoverable.f_setup_cost_credits_hoverable(_master, _x + cx, _y, _size, _size, _costs.credits );
		cx += (_spacing + _size); count++;
	}
	
	for ( var i = 0; i < array_length(_costs.items); i++ ) {
		var hoverable = scr_hoverable_obtain_instance(_master);
		hoverable.f_setup_cost_item_hoverable(_master, _x + cx, _y, _size, _size, _costs.items[i], _costs.values[i] );
		cx += (_spacing + _size); count++;
	}
	
	return count;
}

/// @function scr_hoverable_setup_storage_outputs_row(storage_network, master, x, y, size, spacing)
/// @param {Struct.str_storage_network} storage_network
/// @param {Bool} output_networks
/// @param {Bool} input_networks
/// @param {Id.Instance} master
/// @param {Real} x
/// @param {Real} y
/// @param {Real} hoverable_wh
/// @param {Real} spacing
function scr_hoverable_setup_storage_row( _storage_network, _out, _in, _master, _x, _y, _size, _spacing ) {
	var cx = 0; 
	var slist = []; 
	if ( _out ) { for ( var i = 0; i < array_length(_storage_network.outputStorages); i++ ) { array_push(slist, _storage_network.outputStorages[i]); } }
	if ( _in ) { for ( var i = 0; i < array_length(_storage_network.inputStorages); i++ ) { array_push(slist, _storage_network.inputStorages[i]); } }
	
	for ( var i = 0; i < array_length(slist); i++ ) {
		var cur_storage = slist[i];
		var tt_text = cur_storage.maximum ? "{0}\nStorage: {1}/{2}" : "{0}\nStorage: {1}";
		var hoverable = scr_hoverable_obtain_instance(_master); 
			hoverable.f_setup_hoverable_manual(_master, _x + cx, _y, _size, _size, 
				cur_storage.item.sprite, number_printable(cur_storage.count), 
				string(tt_text, cur_storage.item.name, number_printable(cur_storage.count), number_printable(cur_storage.maximum)));
		cx += (_spacing + _size);
	}
	
	return array_length(slist);
}

/// @function scr_hoverable_setup_storagecost_row(storage_network, item, master, x, y, size, spacing)
/// @param {Struct.str_storage_network} storage_network
/// @param {Struct.str_g_item} item
/// @param {Id.Instance} master
/// @param {Real} x
/// @param {Real} y
/// @param {Real} hoverable_wh
/// @param {Real} spacing
function scr_hoverable_setup_storage_cost_row( _storage_network, _item, _master, _x, _y, _size, _spacing ) {
	var cx = 0; 
	var count = 0;
	
	for ( var i = 0; i < array_length(_storage_network.inputStorages); i++ ) {
		var cur_storage = _storage_network.inputStorages[i];
		var tt_text = "{0}\nStorage: {1}/{2}\nRequires: {3}";
		
		var it_index = array_get_index(_item.costs.items, cur_storage.item);
		if ( it_index != -1 ) {
			var it_req = _item.costs.values[it_index];
			var hoverable = scr_hoverable_obtain_instance(_master); 
				hoverable.f_setup_hoverable_manual(_master, _x + cx, _y, _size, _size, 
					cur_storage.item.sprite, string("{0}/{1}", number_printable(cur_storage.count), number_printable(it_req)),
					string(tt_text, cur_storage.item.name, number_printable(cur_storage.count), number_printable(cur_storage.maximum), number_printable(it_req)));
			cx += (_spacing + _size);
			count++;
		}
	}
	
	return count;
}
	