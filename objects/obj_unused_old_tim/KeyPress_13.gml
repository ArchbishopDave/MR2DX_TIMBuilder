m_tim_list = [];

m_filename = get_open_filename_ext("MRDX TIM Files|*.tim;*.tex", "", "","Open MRDX TIM File");
if ( m_filename != "" ) {
    
    m_timbuffer = buffer_load(m_filename);
    buffer_seek(m_timbuffer, buffer_seek_start, 0);
    
 }

m_current_tim = -1;
var bufferpos = 0;
while ( buffer_tell(m_timbuffer) + 16 < buffer_get_size(m_timbuffer) ) {
    m_current_tim++;
    
    m_tim = {
        id : m_current_tim,
        
        header : {
            tagver : 0x10,
            version : 0,
            bppclp : 9,
        },
        
        clut : {
            length : 12,
            cx : 0,
            cy : 0,
            cw : 0,
            ch : 0,
            colors : []
        },
        
        image : {
            length : 12,
            ix : 0,
            iy : 0,
            iw : 0,
            ih : 0,
            wmult : 2,
            data : []
        }
    }
    
    m_tim.header.tagver = buffer_read(m_timbuffer, buffer_u32);
    m_tim.header.bppclp = buffer_read(m_timbuffer, buffer_u32);
    
    m_tim.clut.length = buffer_read(m_timbuffer, buffer_u32);
    m_tim.clut.cx = buffer_read(m_timbuffer, buffer_u16);
    m_tim.clut.cy = buffer_read(m_timbuffer, buffer_u16);
    m_tim.clut.cw = buffer_read(m_timbuffer, buffer_u16);
    m_tim.clut.ch = buffer_read(m_timbuffer, buffer_u16);
    
    m_tim.clut.colors = [];
    
    for ( var i = 0; i < m_tim.clut.cw * m_tim.clut.ch; i++ ) {
        var cdat = buffer_read(m_timbuffer, buffer_u16);
        var color = new str_color(cdat);
        
        //color.gmcolor = make_color_rgb(color.r * 8, color.g * 8, color.b * 8);
        
        array_push(m_tim.clut.colors,color);
    }
        
    m_tim.image.length = buffer_read(m_timbuffer, buffer_u32);
    m_tim.image.ix = buffer_read(m_timbuffer, buffer_u16);
    m_tim.image.iy = buffer_read(m_timbuffer, buffer_u16);
    m_tim.image.iw = buffer_read(m_timbuffer, buffer_u16);
    m_tim.image.ih = buffer_read(m_timbuffer, buffer_u16);
    
    m_tim.image.data = [];
    
    if ( m_tim.header.bppclp == 8 ) { 
        m_tim.image.wmult = 4; 
    
        for ( var i = 0; i < ( m_tim.image.iw ) * m_tim.image.ih; i++ ) {
        var cvals = buffer_read(m_timbuffer, buffer_u16);
            array_push(m_tim.image.data, (cvals >> 12) & 7);
            array_push(m_tim.image.data, (cvals >> 8) & 7); 
            array_push(m_tim.image.data, (cvals >> 4) & 7); 
            array_push(m_tim.image.data, cvals & 7);
            //TODO This doesn't work properly.
        }
    }
    
    else if ( m_tim.header.bppclp == 9 ) { //8Bit
        for ( var i = 0; i < ( m_tim.image.iw * 2 ) * m_tim.image.ih; i++ ) {
            array_push(m_tim.image.data, buffer_read(m_timbuffer, buffer_u8));
        } 
    }
    
    array_push(m_tim_list, m_tim);
    
}