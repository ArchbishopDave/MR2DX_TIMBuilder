function str_storage_network(_owner, _active = false, _source = false, _maximum = 50, _uniqueStorage = 2, _removeWhenEmpty = false, _flexibleStorage = false, ) constructor {
	owner = _owner;
	active = _active;
	source = _source;
	
	inputNetworks = [];
	outputNetworks = [];
	
	maximumStorage = _maximum == -1 ? 4294967295 : _maximum;
	
	uniqueStorageTypes = _uniqueStorage == -1 ? 4294967295 : _uniqueStorage;
	removeStorageWhenEmpty = _removeWhenEmpty;
	flexibleStorage = _flexibleStorage;
	
	storages = [];
	inputStorages = [];
	outputStorages = [];
	
	static fi_trigger_storage_network_input = function(_callingObject) {
			f_transfer_pending_into_storage();
			obj_ui_floating_tooltip.f_trigger_update(_callingObject);
	};

	static fi_trigger_storage_network_output = function(_callingObject, _quantity) {
			var transferred = f_transfer_storages_into_output_networks(_quantity);
			obj_ui_floating_tooltip.f_trigger_update(_callingObject);
	};
	
	static fi_trigger_storage_network_connection_change = function(_callingObject) {};
	
	f_trigger_input = fi_trigger_storage_network_input;
	f_trigger_output = fi_trigger_storage_network_output;
	f_trigger_network_change = fi_trigger_storage_network_connection_change;
	
	#region TP Connection Functions
	static f_set_tp_connection = function(_oTP, _sToO, _oToS) {
		if ( _sToO ) {
			array_push_unique(outputNetworks, _oTP);
			array_push_unique(_oTP.inputNetworks, self);
		}
		
		else {
			array_remove(outputNetworks, _oTP);
			array_remove(_oTP.inputNetworks, self);
		}
		
		if ( _oToS ) {
			array_push_unique(_oTP.outputNetworks, self);
			array_push_unique(inputNetworks, _oTP);
		}
		
		else {
			array_remove(_oTP.outputNetworks, self);
			array_remove(inputNetworks, _oTP);
		}
		
		f_trigger_network_change(owner);
		_oTP.f_trigger_network_change(_oTP.owner);
	}
	
	static f_get_tp_connection = function(_oTP) {
		var ret = { sourceToOther : false, otherToSource : false };
		if ( array_contains(outputNetworks, _oTP) ) { ret.sourceToOther = true; }
		if ( array_contains(_oTP.outputNetworks, self) ) { ret.otherToSource = true; }
		return ret;
	}
	
	static f_reset_network_connections = function() {
		for ( var i = array_length(inputNetworks); i > 0; i-- ) { 
			f_set_tp_connection(inputNetworks[i-1], false, false);
		}
		
		for ( var i = array_length(outputNetworks); i > 0; i-- ) { 
			f_set_tp_connection(outputNetworks[i-1], false, false);
		}
	}
	#endregion
	
	/// @function f_add_storage(item, input, output, [maximumItems], [forceCreate])
	/// @return {Struct.str_item_storage}
	static f_add_storage = function(_item, _input, _output, _maximum = maximumStorage, _forced = false) {
		var storage = f_get_storage(_item);
		
		if ( !_forced && ( ( storage == undefined && array_length(storages) >= uniqueStorageTypes ) || storage != undefined ) ) { return storage; }
		
		storage ??= new str_item_storage(_item, _maximum, 0);
		array_push(storages, storage); 
		if ( _input ) { array_push_unique(inputStorages, storage); }
		if ( _output ) { array_push_unique(outputStorages, storage); }
		
		uniqueStorageTypes = max(uniqueStorageTypes, array_length(storages));
		return storage;
	}
	
	/// @return {Struct.str_item_storage}
	static f_get_storage = function(_item) { 
		for ( var i = 0; i < array_length(storages); i++ ) { if ( storages[i].item == _item ) { return storages[i]; } }
		return undefined;
	}
	
	static f_transfer_pending_into_storage = function() {
		for ( var i = 0; i < array_length(storages); i++ ) {
			storages[i].f_transfer_pending_items();
		}
	}
	
	static fi_remove_empty_storages = function(_output = true, _input = true) {
		if ( !removeStorageWhenEmpty ) { return; }
		for ( var i = array_length(storages) - 1; i >= 0; i-- ) {
			storage = storages[i];
			
			if ( storage.count + storage.pending <= 0 ) {
				if ( _output ) { array_remove(outputStorages, storage); }
				if ( _input ) { array_remove(inputStorages, storage); }
				
				if ( !array_contains(outputStorages, storage) && !array_contains(inputStorages, storage) ) {
					array_remove(storages, storage);
				}
			}
		}	
	}
	
	static f_transfer_storages_into_output_networks = function(_count = 9999999 ) {
		// This is now count per network connection, rather than count per transfer attempt in full.
		var outputCount = array_length(outputNetworks); if ( outputCount <= 0 ) { return 0; }
		array_shuffle_ext(outputNetworks);
		var transferred = 0;
		
		for ( var i = 0; i < array_length(outputStorages); i++ ) {
			var storage = outputStorages[i];
			if ( storage.count <= 0 ) { continue; }
		
			for ( var j = 0; j < outputCount; j++ ) {
				var stransfer = fi_transfer_storage_into_output_network(storage, outputNetworks[j], _count); 
				if ( stransfer != -1 ) { transferred += stransfer; }
			}
		}
		
		fi_remove_empty_storages();
		
		return transferred;
	}
		
	/// @param {Struct.str_item_storage} _sourceStorage
	/// @param {Struct.str_storage_network} _tpNetwork
	/// @param {Real} count
	/// @return {Real} Items Transferred (-1 if invalid storage location)
	static fi_transfer_storage_into_output_network = function( _sourceStorage, _tpNetwork, _count = 9999999 ) {
		var transferred = -1;
		for ( var i = 0; i < array_length(_tpNetwork.inputStorages); i++ ) { // We already have an input storage.
			if ( _tpNetwork.inputStorages[i].item == _sourceStorage.item ) {
				transferred = _sourceStorage.f_transfer_items(_tpNetwork.inputStorages[i], _count);
			}
		}
		
		if ( transferred == -1 && _tpNetwork.flexibleStorage ) {
			var storage = _tpNetwork.f_add_storage(_sourceStorage.item, true, true);
			if ( storage ?? false ) {
				transferred = _sourceStorage.f_transfer_items(storage, _count);
			}
		}
		
		return transferred;
	}
	
	/// @param {Struct.str_storage_network} target network
	static f_transfer_storage_manual = function(_tnetwork, _emptyOutputs = false, _emptyInputs = true, _count = 99999999) {
		var storageList = inputStorages;
		if ( _emptyOutputs && _emptyInputs ) { storageList = storages; }
		else if ( _emptyOutputs ) { storageList = outputStorages; }
		
		for ( var i = 0; i < array_length(storageList); i++ ) {
			var lStorage = storageList[i];
			var tStorage = _tnetwork.f_add_storage(lStorage.item, true, true);
			lStorage.f_transfer_items(tStorage, _count);
		}
		
		fi_remove_empty_storages(_emptyOutputs, _emptyInputs);
	}
	
	/// @description Compares a storage network against the requirements of a cost. Ignores credits, only checks items.
	/// @param {Struct.str_g_costs} costs
	static f_costs_check_availability = function(_costs) {
		for ( var i = 0; i < array_length(_costs.items); i++ ) {
			var iStorage = f_get_storage(_costs.items[i]);
			if ( iStorage == undefined ) { return false; }
			
			if ( iStorage.count < _costs.values[i] ) { return false; }
		}
		return true;
	}
	
	static f_costs_destroy_items = function(_costs) {
		var destroyAll = true;
		for ( var i = 0; i < array_length(_costs.items); i++ ) {
			var iStorage = f_get_storage(_costs.items[i]);
			if ( iStorage == undefined ) { destroyAll = false; }
			
			destroyAll = iStorage.f_remove_items(_costs.values[i]) == _costs.values[i] ? destroyAll : false;
		}
		
		return destroyAll;
	}
}