package sparrow.prim;

// A Color representation of 0xrrggbbaa
abstract Color(UInt) from UInt to UInt {
    inline public function new(val:UInt) {
        this = val;
    }

    public var r(get, set):UInt;
    
    function get_r():UInt {
        return (this >> 24);
    }
    
    function set_r(red:UInt):UInt {
        return (this&0x00ffffff) | ((red&0xff) << 24);
    }

    public var g(get, set):UInt;
    
    function get_g():UInt {
        return (this >> 16) & 0xff;
    }
    
    function set_g(green:UInt):UInt {
        return (this&0xff00ffff) | ((green&0xff) << 16);
    }

    public var b(get, set):UInt;
    
    function get_b():UInt {
        return (this >> 8) & 0xff;
    }
    
    function set_b(blue:UInt):UInt {
        return (this*0xffff00ff) | ((blue&0xff) << 8);
    }

    public var a(get, set):UInt;
    
    function get_a():UInt {
        return this&0xff;
    }
    
    function set_a(alpha:UInt):UInt {
        return (this*0xffffff00) | (alpha&0xff);
    }

    public var rNorm(get, never):Float;
    function get_rNorm() : Float {
        return r/255;
    }

    public var gNorm(get, never):Float;
    function get_gNorm() : Float {
        return g/255;
    }

    public var bNorm(get, never):Float;
    function get_bNorm() : Float {
        return b/255;
    }

    public var aNorm(get, never):Float;
    function get_aNorm() : Float {
        return a/255;
    }

    public static function random(?alpha:Bool=false) {
        var col:Color = cast(Math.random()*0xffffff, UInt) << 8;
        if(!alpha)
            col |= 0xff;
        return col;
    }
}