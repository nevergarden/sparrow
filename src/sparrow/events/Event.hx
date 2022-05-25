package sparrow.events;

import haxe.ds.Vector;

class Event {
    public static final ACTIVATE:String = "activate";
    public static final DEACTIVATE:String = "deactivate";

    public static final RENDER:String = "render";

    public static final CONTEXT_CREATE:String = "contextCreate";
    public static final QUIT:String = "quit";

    private static var sEventPool:Vector<Event> = new Vector<Event>(0);
    private static var sEventPoolTop:Int = 0;

    private var _target:EventDispatcher;
    private var _currentTarget:EventDispatcher;
    private var _type:String;
    private var _bubbles:Bool;
    private var _stopsPropagation:Bool;
    private var _stopsImmediatePropagation:Bool;
    private var _data:Dynamic;

    public function new(type:String, bubbles:Bool=false, data:Null<Dynamic>) {
        this._type = type;
        this._bubbles = bubbles;
        this._data = data;
    }

    public function stopPropagation() {
        this._stopsPropagation = true;
    }

    public function stopsImmediatePropagation() {
        this._stopsPropagation = this._stopsImmediatePropagation = true;
    }

    public function toString() : String {
        return "[Event type=" + _type + " bubbles=" + _bubbles + "]";
    }

    public var bubbles(get, null):Bool;
    function get_bubbles():Bool {
        return this._bubbles;
    }

    public var target(get, null):EventDispatcher;
    function get_target():EventDispatcher {
        return this._target;
    }
    private function setTarget(value:EventDispatcher) : Void {
        this._target = value; 
    }

    public var currentTarget(get, null):EventDispatcher;
    function get_currentTarget():EventDispatcher {
        return this._currentTarget;    
    }
    private function setCurrentTarget(value:EventDispatcher): Void {
        this._currentTarget = value;
    }

    public var type(get, null):String;
    function get_type():String {
        return this._type;
    }

    public var data(get, null):Null<Dynamic>;
    function get_data():Null<Dynamic> {
        return this._data;
    }
    private function setData(value:Null<Dynamic>) : Void {
        this._data = value;
    }

    static function fromPool(type:String, ?bubbles:Bool=false, data:Null<Dynamic>=null) : Event {
        if(sEventPoolTop>0){
            sEventPoolTop--;
            return sEventPool[sEventPoolTop].reset(type, bubbles, data);
        }
        return new Event(type, bubbles, data);
    }

    static function toPool(event:Event):Void {
        event._data = event._target = event._currentTarget = null;
        sEventPool[sEventPoolTop] = event;
        sEventPoolTop++;
    }

    function reset(type:String, bubbles:Bool=false, data:Null<Dynamic>=null):Event {
        _type = type;
        _bubbles = bubbles;
        _data = data;
        _target = _currentTarget = null;
        _stopsPropagation = _stopsImmediatePropagation = false;
        return this;
    }
}