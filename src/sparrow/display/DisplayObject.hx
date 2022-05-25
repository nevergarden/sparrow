package sparrow.display;

import sparrow.rendering.Painter;
import sparrow.events.EventDispatcher;

class DisplayObject extends EventDispatcher {
    private var _x:Float;
    private var _y:Float;
    private var _pivotX:Float;
    private var _pivotY:Float;
    private var _scaleX:Float;
    private var _scaleY:Float;
    private var _rotation:Float;
    private var _visible:Bool;

    public var name:String;

    public function new() {
        super();
        _x = _y = _pivotX = _pivotY = _rotation = 0;
        _scaleX = _scaleY = 1;
        _visible = true;
    }

    public function dispose() {
        
    }

    public function setRequiresRedraw() {

    }

    public function render(painter:Painter) {

    }
}