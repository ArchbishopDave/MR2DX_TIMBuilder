f_merge_closest_color = function(_cid, _palette, _minuses) {
    var closest_dist = 999999999;
    var closest_c = _palette.palette_slots[_cid];
    var closest_id = _cid;
    
    var color = _palette.palette_slots[_cid].color;
    
    for ( var i = 0; i < array_length(_palette.palette_slots); i++ ) {
        if ( i == _cid ) { continue; } 
        if ( _minuses >= _palette.palette_slots[i].uses ) { continue; }
            
        var alt_color = _palette.palette_slots[i].color;
        
        var hdistance =  min(abs(color.h - alt_color.h), abs((color.h - 255) - alt_color.h), abs((color.h + 255) - alt_color.h)) * m_color_weights.h;
        var sdistance = abs(color.s - alt_color.s) * m_color_weights.s;
        var vdistance = abs(color.v - alt_color.v) * m_color_weights.v;
        var stp = color.stp == alt_color.stp ? 0 : 9999999;
        
        if ( (hdistance + sdistance + vdistance + stp) < closest_dist ) {
            closest_dist = (hdistance + sdistance + vdistance + stp);
            closest_c = alt_color;
            closest_id = i;
        }
    }
    
    if ( closest_id != _cid ) {
        _palette.palette_slots[closest_id].uses = _palette.palette_slots[closest_id].uses + _palette.palette_slots[_cid].uses;
        _palette.palette_slots[_cid] = _palette.palette_slots[closest_id];
        show_debug_message("Palette " + string(_palette.clut_id) + " has merged " + string(_cid) + " into " + string(closest_id) + " which has " + string(_palette.palette_slots[closest_id].uses) + "uses");
    }
}

f_convert_to_tim = function(_tim_list, _filename) {
    
    var buffer = buffer_create(24, buffer_grow, 1);
    buffer_seek(buffer, buffer_seek_start, 0);
    
    for ( var i = 0; i < array_length(_tim_list); i++ ) {
        var tim = _tim_list[i];
        
        buffer_write(buffer, buffer_u32, tim.header.tagver);
        buffer_write(buffer, buffer_u32, tim.header.bppclp);
        
        buffer_write(buffer, buffer_u32, tim.clut.length);
        buffer_write(buffer, buffer_u16, tim.clut.cx);
        buffer_write(buffer, buffer_u16, tim.clut.cy);
        buffer_write(buffer, buffer_u16, tim.clut.cw);
        buffer_write(buffer, buffer_u16, tim.clut.ch);
        
        for ( var j = 0; j < tim.clut.cw * tim.clut.ch; j++ ) {
            buffer_write(buffer, buffer_u16, tim.clut.colors[j].raw);
        }
            
        buffer_write(buffer, buffer_u32, tim.image.length);
        buffer_write(buffer, buffer_u16, tim.image.ix);
        buffer_write(buffer, buffer_u16, tim.image.iy);
        buffer_write(buffer, buffer_u16, tim.image.iw);
        buffer_write(buffer, buffer_u16, tim.image.ih);
        
        if ( tim.header.bppclp == 8 ) {
            for ( var j = 0; j < array_length(tim.image.data); j+=2 ) {
                buffer_write(buffer, buffer_u8, 
                    (tim.image.data[j+1] << 4) + 
                    tim.image.data[j]);
                var z = (tim.image.data[j+1] << 4) + 
                    tim.image.data[j];
            }
        }
        
        else if ( tim.header.bppclp == 9 ) { //8Bit
            for ( var j = 0; j < array_length(tim.image.data); j++ ) {
                buffer_write(buffer, buffer_u8, tim.image.data[j]);
            } 
        }
  }
        buffer_save(buffer, _filename );
}