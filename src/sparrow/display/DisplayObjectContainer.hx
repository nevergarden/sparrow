package sparrow.display;

import haxe.exceptions.NotImplementedException;
import haxe.Exception;
import haxe.macro.Expr.Error;

class DisplayObjectContainer extends DisplayObject {
    private var _children:Array<DisplayObject>;
    
    public function new() {
        super();
        this._children = new Array<DisplayObject>();
    }

    override function dispose() {
        for (child in _children)
            child.dispose();

        super.dispose();
    }

    public function addChildAt(child:DisplayObject, index:Int) : Void {

    }

    public function addChild(child:DisplayObject) : Void {

    }

    public function removeChild(child:DisplayObject, ?dispose:Bool=false) : Void {

    }

    public function removeChildrenAt(index:Int, ?dispose:Bool=false) : Void {

    }

    public function removeChildren(?beginIndex:Int=0, ?endIndex:Int=-1, ?dispose:Bool=false) : Void {

    }

    public function getChildAt(index:Int):DisplayObject {
        return _children[index];
    }

    public function getChildByName(name:String):DisplayObject {
        for(child in _children)
            if(child.name == name) return child;
        return null;
    }

    public function getChildIndex(child:DisplayObject) : Int {
        return _children.indexOf(child);
    }

    public function setChildIndex(child:DisplayObject, index:Int) {
        var oldindex = getChildIndex(child);
        if(oldindex == index) return;
        if(oldindex == -1) throw new Exception("WELP: not even in children");

        _children.remove(child);
        _children.insert(index, child);
        setRequiresRedraw();
    }

    public function swapChildrenAt(index1:Int, index2:Int) {
        var c1 = getChildAt(index1);
        var c2 = getChildAt(index2);
        _children[index1] = c2;
        _children[index2] = c1;
        setRequiresRedraw();
    }

    public function swapChildren(child1:DisplayObject, child2:DisplayObject) {
        var i1 = getChildIndex(child1);
        var i2 = getChildIndex(child2);
        if(i1 == -1 || i2 == -1) throw new Exception("WELP: at least on of children is not in list");
        swapChildrenAt(i1, i2);
    }

    public function sortChildren(compareFunction:(DisplayObject,DisplayObject)->Int) : Void {
        throw new NotImplementedException("WELP: I haven't implement this yet");
    }

    public function contains(child:DisplayObject) : Bool {
        throw new NotImplementedException("WELP: I haven't implement this yet");
    }

    
}