package sparrow.rendering.drivers;

import sparrow.prim.Color;
import haxe.exceptions.NotImplementedException;
#if hlsdl
import sdl.GL;

class GLDriver extends Driver {
    public function new() {}

    override function setClearColor(rgba:Color) {
        super.setClearColor(rgba);

        GL.clearColor(rgba.rNorm, rgba.gNorm, rgba.bNorm, rgba.aNorm);
    }

    override function clear() {
        super.clear();
        GL.colorMask(true, true, true, true);
        GL.clear(GL.COLOR_BUFFER_BIT);
    }
}

#else

class GLDriver extends Driver {
    public function new() {
        throw new NotImplementedException("WELP: I haven't yet implemented hldx nor webgl");
    } 
}
#end