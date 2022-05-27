package sparrow.rendering;

import sparrow.core.Sparrow;
import sparrow.events.Event;
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

    public function new(sparrowInstance:Sparrow) {
        sparrowInstance.addEventListener(Event.RESIZE, resize_handler);
        #if hlsdl
        driver = new GLDriver();
        #end
    }

    public function clear() {
        this.driver.clear();
    }

    public function present() {
        this.driver.present();
    }

    private function resize_handler(e:Event) : Void {
        this.driver.resize(e.data.width, e.data.height);
    }
}