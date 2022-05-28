package sparrow.rendering;

import haxe.ds.Vector;

class FloatBuffer {
    private static var sFloatBufferPool:Vector<FloatBuffer> = new Vector<FloatBuffer>(0);
    private static var sFloatBufferPoolTop:Int = 0;

    // Increment GUID on each buffer creation
    static var GUID : UInt = 1;
    public var id : UInt;
    public var size(get, null) : UInt;

    public function get_size() : UInt {
        return _internal.length;
    }

    private var _internal:Array<hl.F32>;

    function new(id:UInt) {
        this.id = id;
        this._internal = new Array();
    }

    public static function create() : FloatBuffer {
        return fromPool();
    }

    public function pushFloat(f:Float) {
        this._internal.push(f);
    }

    public function pushFloatArray(f:Array<Float>) {
        for(d in f)
            pushFloat(d);
    }

    public function dispose() : Void {
        toPool(this);
    }

    function reset(id:UInt) : FloatBuffer {
        this.id = id;
        return this;
    }

    static function fromPool() : FloatBuffer {
        if(sFloatBufferPoolTop > 0) {
            sFloatBufferPoolTop--;
            return sFloatBufferPool[sFloatBufferPoolTop].reset(GUID++);
        }
        return new FloatBuffer(GUID++);
    }

    static function toPool(value : FloatBuffer) {
        value._internal.resize(0);
        sFloatBufferPool[sFloatBufferPoolTop] = value;
        sFloatBufferPoolTop++;
    }
}