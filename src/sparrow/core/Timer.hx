package sparrow.core;

/**
    The MIT License (MIT)

    Copyright (c) 2013 Nicolas Cannasse

    Permission is hereby granted, free of charge, to any person obtaining a copy of
    this software and associated documentation files (the "Software"), to deal in
    the Software without restriction, including without limitation the rights to
    use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
    the Software, and to permit persons to whom the Software is furnished to do so,
    subject to the following conditions:

    The above copyright notice and this permission notice shall be included in all
    copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
    FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
    COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
    IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
    CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
**/

/**
	The Timer class acts as a global time measurement that can be accessed from various parts of the engine.
	These three values are representation of the same underlying calculus: tmod, dt, fps
**/
class Timer {

	/**
		The FPS on which "tmod" have values are based on.
		Can be freely configured if your gameplay runs at a different speed.
		Default : 60
	**/
	public static var wantedFPS = 60.;

	/**
		The maximum amount of time between two frames (in seconds).
		If the time exceed this amount, Timer will consider these lags are to be ignored.
		Default : 0.5
	**/
	public static var maxDeltaTime = 0.5;

	/**
		The smoothing done between frames. A smoothing of 0 gives "real time" values, higher values will smooth
		the results for tmod/dt/fps over frames using the formula   dt = lerp(dt, elapsedTime, smoothFactor)
		Default : 0 on HashLink, 0.95 on other platforms
	**/
	public static var smoothFactor = #if hl 0. #else 0.95 #end;

	/**
		The last timestamp in which update() function was called.
	**/
	public static var lastTimeStamp(default,null) = haxe.Timer.stamp();

	/**
		The amount of time (unsmoothed) that was spent since the last frame.
	**/
	public static var elapsedTime(default,null) = 0.;

	/**
		A frame counter, increases on each call to update()
	**/
	public static var frameCount = 0;

	/**
		The smoothed elapsed time (in seconds).

	**/
	public static var dt : Float = 1 / wantedFPS;

	/**
		The smoothed frame modifier, based on wantedFPS. Its value is the same as dt/wantedFPS
		Allows to express movements in terms of pixels-per-frame-at-wantedFPS instead of per second.
	**/
	public static var tmod(get,set) : Float;

	static var currentDT : Float = 1 / wantedFPS;

	/**
		Update the timer calculus on each frame. This is automatically called by hxd.App
	**/
	public static function update() {
		frameCount++;
		var newTime = haxe.Timer.stamp();
		elapsedTime = newTime - lastTimeStamp;
		lastTimeStamp = newTime;
		if( elapsedTime < maxDeltaTime )
			currentDT = elapsedTime + smoothFactor * (currentDT - elapsedTime);
		else
			elapsedTime = 1 / wantedFPS;
		dt = currentDT;
	}

	inline static function get_tmod() {
		return dt * wantedFPS;
	}

	inline static function set_tmod(v:Float) {
		dt = v / wantedFPS;
		return v;
	}

	/**
		The current smoothed FPS.
	**/
	public static function fps() : Float {
		// use currentDT to prevent gameplay change of dt to affect the displayed fps
		return 1. / currentDT;
	}

	/**
		After some loading / long processing, call skip() in order to prevent
		it from impacting your smoothed values.
	**/
	public static function skip() {
		lastTimeStamp = haxe.Timer.stamp();
	}

	/**
		Similar as skip() but also reset dt to default value.
		Can be used when starting a new game if you want to discard any previous measurement.
	**/
	public static function reset() {
		lastTimeStamp = haxe.Timer.stamp();
		dt = currentDT = 1. / wantedFPS;
	}
}