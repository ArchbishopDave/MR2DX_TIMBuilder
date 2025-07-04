function str_color(_cdata) constructor {
    raw = _cdata;
    r = (_cdata & 31); // b1 - 4,5,6,7,8
    g = (((_cdata & 768) >> 5) + // b2 - 7, 8 
        ((_cdata & 224) >> 5 )); // b1 - 1, 2, 3
    b = (_cdata & 31744) >> 10; // b2 - 2,3,4,5,6
    stp = (_cdata & 32768) >> 15;
    
    gmcolor = make_color_rgb(r * 8, g * 8, b * 8);
    palette_id = -1;
    
    h = color_get_hue(gmcolor);
    s = color_get_saturation(gmcolor); 
    v = color_get_value(gmcolor);
 }

function str_color_copy(_ocolor) constructor {
    raw = _ocolor.raw;
    r = _ocolor.r;
    g = _ocolor.g;
    b = _ocolor.b;
    stp = _ocolor.stp;
    gmcolor = _ocolor.gmcolor;
    palette_id = _ocolor.palette_id;
    
    h = _ocolor.h;
    s = _ocolor.s;
    v = _ocolor.v;
}

function str_color_rgba(_r, _g, _b, _a) constructor {
    r = ( _r ) >> 3;
    g = ( _g ) >> 3;
    b = ( _b ) >> 3;
    stp = ( _a > 254 ) ? 0 : 1;
    stp = ( r + g + b == 0 ) ? 1 - stp : stp;
    
    gmcolor = make_color_rgb(r * 8, g * 8, b * 8);
    palette_id = -1;
    
    h = color_get_hue(gmcolor);
    s = color_get_saturation(gmcolor); 
    v = color_get_value(gmcolor);
    
    raw = 
        r +
        ( g << 5 )+
        ( b << 10 )+
        ( stp << 15 );
        
}