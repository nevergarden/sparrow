package sparrow.core;

import sparrow.prim.Color;
import sparrow.rendering.Painter;
import sparrow.events.Event;
import sparrow.events.EventDispatcher;
#if hlsdl
import sdl.Sdl;
import sdl.Window;
#elseif hldx
import dx.Window;
#end
var window:Window;

class Sparrow extends EventDispatcher {
    private var _frameID : UInt = 1;
    private var _started : Bool = false;
    private var _rendering : Bool = false;
    private var _painter : Painter;

    public var isRunning : Bool = true;
    public var frameID(get, null) : UInt;
    public function new(title:String, width:Int, height:Int) {
        super();
        #if hlsdl
        window = new Window(title, width, height);
        initialize();
        #end
    }

    function onEvent( e : #if hldx dx.Event #else sdl.Event #end ) : Bool {
		switch (e.type) {
            case WindowState:
                switch(e.state) {
                    case Resize:
                        this.dispatchEventWith(Event.RESIZE, false, {width: window.width, height: window.height});
                    case Focus:
                        this.dispatchEventWith(Event.ACTIVATE);
                    case Blur:
                        this.dispatchEventWith(Event.DEACTIVATE);
                    default:
                }
            case Quit:
                this.dispatchEventWith(Event.QUIT);
                isRunning = false;
                return false;
            default:
        }
        return false;
	}

    private function initialize() {
        #if hlsdl
        Sdl.init();
        this._painter = new Painter(this);
        #end

        this.dispatchEventWith(Event.CONTEXT_CREATE);
    }

    public function start() {
        _started = _rendering = true;
        while(this.isRunning) {
            Timer.update();
            Sdl.processEvents(onEvent);
            update(Timer.dt);
            if(_rendering)
                render();
        }
    }

    function render() {
        _frameID++;
        this.dispatchEventWith(Event.RENDER, false, frameID);
        this._painter.clear();
        this._painter.present();
        window.present();
    }

    public dynamic function update(dt:Float) {}

    public function stop(?suspendRendering:Bool=true) {
        _started = false;
        _rendering = !suspendRendering;
    }

	function get_frameID():UInt {
		return _frameID;
	}

    public function set_renderer_clear_color(rgba:Color) {
        this._painter.clearColor = rgba;
    }
}