package sparrow.rendering.drivers;

import sparrow.prim.Color;

class Driver {
    public function setClearColor(rgba:Color) {}
    public function clear() {}
    public function present() {}
    public function resize(width:Int, height:Int) {}
    public function uploadEffect(effect:Effect) {}
}