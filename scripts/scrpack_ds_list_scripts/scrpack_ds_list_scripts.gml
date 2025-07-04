/// @function			dla(ds_list, values...)
/// @description		Shortened ds_list_add(...)
function dla() {
	for ( var i = 1; i < argument_count; i++ ) {
		ds_list_add(argument[0], argument[i]);
	}
}


/// @function			dlau(ds_list, values...)
/// @description		Shortened ds_list_add(...), only adds unique values
function dlau() {
	var newElements = 0;
	for ( var i = 1; i < argument_count; i++ ) {
		if ( !ds_list_contains(argument[0], argument[i] ) ) {
			ds_list_add(argument[0], argument[i]);
			newElements++;
		}
	}
	return newElements;
}


/// @function			dls(ds_list)
/// @description		Shortened ds_list_size()
function dls(argument0) {
	return ds_list_size(argument0);
}


/// @function			ds_list_clear_objects(ds_list)
/// @description		Destroys all objects contained in the ds_list.
function ds_list_clear_objects(argument0) {
	var l = argument0;

	for ( var i = ds_list_size(l) - 1; i >= 0; i-- ) {  
	    with (l[|i]) { instance_destroy(); }
	}
}


/// @function			ds_list_contains(ds_list, element)
/// @description		Returns whether an element is contained in a list or not.
function ds_list_contains(argument0, argument1) {
	return (ds_list_find_index(argument0, argument1) != -1);
}



/// @function			ds_list_create_with(...)
/// @description		Creates a new ds_list and prepopulates it with all function parameters.
function ds_list_create_with() {
	var dsl = ds_list_create();
	for ( var i = 0; i < argument_count; i++ ) {
		ds_list_add(dsl, argument[i]);
	}
	return dsl;
}


/// @function			ds_list_destroy_all(ds_list)
/// @description		Both deletes a ds_list and all objects contained in that list.
function ds_list_destroy_all(argument0) {
	var l = argument0;
	ds_list_clear_objects(l);
	ds_list_destroy(l);
}


/// @function			ds_list_remove(ds_list, element)
/// @description		Removes the first instance of an element from a ds_list.
function ds_list_remove(argument0, argument1) {
	var i = ds_list_find_index(argument0, argument1);
	if ( i != -1 ) { ds_list_delete(argument0, i); }
}


/// @function			ds_list_trim(ds_list, size)
/// @description		Removes elements from the end of a list until it's no longer than size.
function ds_list_trim(argument0, argument1) {
	var l = argument0;
	var m_size = argument1;
	while ( ds_list_size(l) > m_size && m_size >= 0 ) {
	    ds_list_delete(l, ds_list_size(l)-1);
	}
}

/// @function		ds_list_foreach(ds_list, function)
/// @description	Calls the provided function on each element of the list
function ds_list_foreach(dslist, func) {
	for ( var i = 0; i < dls(dslist); i++ ) { func( dslist[|i] ); } 
}