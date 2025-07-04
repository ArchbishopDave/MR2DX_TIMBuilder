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
            for ( var j = 0; j < (array_length(tim.image.data) / 4); j++ ) {
                buffer_write(buffer, buffer_u16, 4);
                //TODO This doesn't work properly.
            }
        }
        
        else if ( m_tim.header.bppclp == 9 ) { //8Bit
            for ( var j = 0; j < array_length(tim.image.data); j++ ) {
                buffer_write(buffer, buffer_u8, tim.image.data[j]);
            } 
        }
  }
        buffer_save(buffer, _filename );
}