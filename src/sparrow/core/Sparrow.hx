package sparrow.core;

#if hlsdl
import sdl.Sdl;
import sdl.Window;
#elseif hldx
import dx.Window;
#end
var window:Window;

class Sparrow {
    private var _frameID : UInt = 1;
    private var _started : Bool = false;
    private var _rendering : Bool = false;

    public var isRunning : Bool = true;
    public var frameID(get, null) : UInt;
    public function new(title:String, width:Int, height:Int) {
        #if hlsdl
        window = new Window(title, width, height);
        initialize();
        #end
    }

    function onEvent( e : #if hldx dx.Event #else sdl.Event #end ) : Bool {
		switch (e.type) {
            case Quit:
                isRunning = false;
                return false;
            default:
        }
        return false;
	}

    private function initialize() {
        #if hlsdl
        Sdl.init();
        #end
    }

    public function start() {
        _started = _rendering = true;
        while(this.isRunning) {
            Sdl.processEvents(onEvent);
        }
    }

    public function stop(?suspendRendering:Bool=true) {
        _started = false;
        _rendering = !suspendRendering;
    }

	function get_frameID():UInt {
		return _frameID;
	}
}