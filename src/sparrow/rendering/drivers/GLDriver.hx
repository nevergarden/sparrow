package sparrow.rendering.drivers;

import sparrow.effects.MeshEffect;
import sparrow.prim.Color;
#if hlsdl
import sdl.GL;

class GLDriver extends Driver {
    var program :sparrow.rendering.Program;
    var buf: Buffer;
    public function new() {
        var meshEffect = new MeshEffect();
        program = meshEffect.createProgram();
        var f : Array<Float> = [
            -0.5, 0.5,
            -0.5, -0.5,
            0.5, 0.5,
            -0.5, -0.5,
            0.5, 0.5,
            0.5, -0.5
        ];
        var b = FloatBuffer.create();
        b.pushFloatArray(f);
        buf = b.toGLBuffer(Array);
    }

    override function setClearColor(rgba:Color) {
        super.setClearColor(rgba);

        GL.clearColor(rgba.rNorm, rgba.gNorm, rgba.bNorm, rgba.aNorm);
    }

    override function clear() {
        super.clear();
        GL.colorMask(true, true, true, true);
        GL.clear(GL.COLOR_BUFFER_BIT);
    }

    override function present() {
        super.present();
        
        program.activate();
        // TODO: add a function called uploadVertexBuffers and add this to that
        GL.bindBuffer(GL.ARRAY_BUFFER, buf);
        GL.vertexAttribPointer(0, 2, GL.FLOAT, false, 2*4, 0);
        GL.enableVertexAttribArray(0);
        // triangle_count * 6 (position_count * vertex_count) * 4 (float_size)
        GL.drawArrays(GL.TRIANGLES, 0, 2*6*4);
        GL.disableVertexAttribArray(0);
        program.deactivate();

    }

    override function resize(width:Int, height:Int) {
        super.resize(width, height);
        GL.viewport(0,0,width,height);
    }
}

#else

class GLDriver extends Driver {
    public function new() {
        throw new NotImplementedException("WELP: I haven't yet implemented hldx nor webgl");
    } 
}
#end