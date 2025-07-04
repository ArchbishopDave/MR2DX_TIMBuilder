function dt_per_second(perSeconds) { return 1000000 / perSeconds; }
function dt_per_minute(perMinutes) { return dt_per_second(perMinutes) * 60; }

function dt_seconds_per(secondsPer) { return 1000000 * secondsPer; }
function dt_minutes_per(minutesPer) { return dt_seconds_per(60) / minutesPer; }

function str_numeric(_cur, _min, _max, _numNutation = true, _boundMin = true, _boundMax = true) constructor {
	value = _cur;
	vMin = _min;
	vMax = _max;
	
	numberNotation = _numNutation;
	static notation = ["k", "m", "b", "t", "q"];
	
	boundMin = _boundMin;
	boundMax = _boundMax;

	static f_add = function(v) {
		if ( v == 0 ) { return; }
		
		if ( v < 0 ) { f_sub(v); }
		else if ( boundMax ) { value = min(value + v, vMax); }
		else { value += v; }
	}
	
	static f_sub = function(v) { 
		if ( v <= 0 ) { f_add(v); }
		else if ( boundMin ) { value = max(value - v, vMin); }
		else { value -= v; }
	}
	
	static f_print = function() {
		if ( numberNotation ) {
			if ( value >= 1000 ) {
				var v = value; var l = -1; var s = 0;
				while ( v >= 1000 ) { s = (v % 1000) div 100; v = v div 1000; l++ ; }
				return string(v) + "." + string(s) + notation[l];
			}
		}
		return string(value);
	}
}

function str_incremental(_parent, _timer = 1000000,  _function = function(_a=0) {}, _usetimefactor = true, _maxfunctioncalls = -1, _active = true ) 
constructor {
	parent = _parent;
	startDate = date_current_datetime();
	startTime = get_timer();
	
	active = _active;
	triggerFunction = _function;
	maxCalls = _maxfunctioncalls;
	
	c_timer = 0;	m_timer = _timer;	p_timer = 0;
	
	time_factor = 1;
	time_factor_global = _usetimefactor;
	
	static f_increment = function() {
		if ( !active ) { return 0; }
		var tf = time_factor_global ? global.g_time_factor * time_factor : time_factor;
		
		c_timer += (delta_time * tf);
		
		var runs = 0;
		while ( ( c_timer >= m_timer ) && ( maxCalls == -1 || runs < maxCalls ) ) {
			runs++;
			c_timer -= m_timer;
			triggerFunction();
		}
		
		p_timer = c_timer / m_timer;
		return runs;
	}
	
	static f_change_timer = function(_timer, _time_factor = 1.0, _reset = true) {
		time_factor = _time_factor;
		
		if ( _timer < m_timer && !_reset ) { c_timer = lerp(0, _timer, (c_timer / m_timer)); } 
		else { c_timer = 0; }
		m_timer = _timer;
	}
	
	static f_set_active = function(_activate, _reset = true) {
		active = _activate;
		if ( _reset ) { c_timer = 0; p_timer = 0; }
	}
	
	/// @function f_reset_timer(timer) Sets the timer status to true and resets the timer to the new value.
	static f_reset_timer = function(_timer) {
		c_timer = 0; m_timer = _timer; active = true;
	}
}

function number_printable(_number, _notation = true) {
	static numberNotation = ["k", "m", "b", "t", "q"];
	if ( _number ) {
		if ( _number >= 1000 ) {
			var v = _number; var l = -1; var s = 0;
			while ( v >= 1000 ) { s = (v % 1000) div 100; v = v div 1000; l++ ; }
			return string(v) + "." + string(s) + numberNotation[l];
		}
	}
	return string(_number);
}	