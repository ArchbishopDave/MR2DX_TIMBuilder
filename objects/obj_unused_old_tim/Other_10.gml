f_merge_closest_color = function(_cid, _palette, _minuses) {
    var closest_dist = 999999999;
    var closest_c = _palette[_cid];
    var closest_id = _cid;
    
    var color = _palette[_cid].color;
    
    for ( var i = 0; i < array_length(_palette); i++ ) {
        if ( i == _cid ) { continue; } 
        if ( _minuses > _palette[i].uses ) { continue; }
            
        var alt_color = _palette[i].color;
        
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
        _palette[closest_id].uses = _palette[closest_id].uses + _palette[_cid].uses;
        _palette[_cid] = _palette[closest_id];
        m_palette_length--; 
    }
}