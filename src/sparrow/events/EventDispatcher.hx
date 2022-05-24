package sparrow.events;

import haxe.ds.GenericStack;
import haxe.exceptions.NotImplementedException;

class EventDispatcher {
    private var _eventListeners:Map<String, Array<Event->Void>>;
    private var _eventStack:GenericStack<String> = new GenericStack<String>();

    public function new() {}

    public function addEventListener(type:String, listener:Event->Void) {
        if(_eventListeners == null)
            _eventListeners = new Map<String, Array<Event->Void>>();
        var listeners:Array<Event->Void> = _eventListeners.get(type);
        if(listeners == null) {
            listeners = _eventListeners[type] = new Array<Event->Void>();
        }
        if(listeners.indexOf(listener) == -1)
            listeners.push(listener);
    }

    public function removeEventListener(type:String, listener:Event->Void) {
        if(_eventListeners != null) {
            var listeners:Array<Event->Void> = _eventListeners.get(type);
            if(listeners!=null && listeners.length > 0) {
                listeners.remove(listener);
            }
        }
    }

    public function removeEventListeners(?type:String=null) {
        if(type != null && _eventListeners != null) {
            _eventListeners.set(type, null);
        } else {
            _eventListeners.clear();
        }
    }

    public function dispatchEvent(event:Event) {
        var previousTarget:EventDispatcher = event.target;
        @:privateAccess event.setTarget(this);
        //if(bubbles && Std.isOfType(DisplayObject)) bubbleEvent(event);
        //else
        invokeEvent(event);
        if(previousTarget!=null) @:privateAccess event.setTarget(previousTarget);
    }

    public function dispatchEventWith(type:String, ?bubbles:Bool=false, ?data:Null<Dynamic>=null) {
        if(hasEventListener(type)) {
            var event:Event = @:privateAccess Event.fromPool(type, bubbles, data);
            dispatchEvent(event);
            @:privateAccess Event.toPool(event);
        }
    }

    public function hasEventListener(type:String, ?listener:Null<Event->Void>=null) {
        if(_eventListeners == null)
            return false;
        var listeners:Array<Event->Void> = _eventListeners.get(type);
        if(listeners == null)
            return false;
        
        if(listener!=null) return listeners.indexOf(listener) != -1;

        return listeners.length != 0;
    }

    function invokeEvent(event:Event) : Bool {
        if(_eventListeners==null)
            return false;
        
        var listeners:Array<Event->Void> = _eventListeners.get(event.type);
        if(listeners.length!=0) {
            @:privateAccess event.setCurrentTarget(this);
            _eventStack.add(event.type);

            for(listener in listeners) {
                listener(event);
                if(@:privateAccess event._stopsImmediatePropagation) {
                    _eventStack.pop();
                    return true;
                }
            }
            return @:privateAccess event._stopsPropagation;
        }

        return false;
    }

    function bubbleEvent(event:Event) : Void {
        throw new NotImplementedException("bubbleEvent not implemented.");
    }
}