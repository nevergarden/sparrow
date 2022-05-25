package sparrow.rendering;

import sparrow.rendering.drivers.GLDriver;
import sparrow.prim.Color;

class Painter {

    #if hlsdl
    var driver : GLDriver;
    #end

    private var _clearColor : Color = 0x00;
    public var clearColor(get, set):Color;
    function get_clearColor():Color {
        return _clearColor;
    }
    function set_clearColor(value:Color):Color {
        this.driver.setClearColor(value);
        return this._clearColor = value;
    }

    public function new() {
        #if hlsdl
        driver = new GLDriver();
        #end
    }

    public function clear() {
        this.driver.clear();
    }
}