package sparrow.rendering.drivers;

import sparrow.effects.MeshEffect;
import sparrow.prim.Color;
#if hlsdl
import sdl.GL;

class GLDriver extends Driver {
    var program :sparrow.rendering.Program;
    public static var buf: FloatVertexArrayBuffer;
    public function new() {
        var meshEffect = new MeshEffect();
        program = meshEffect.createProgram();
        
        buf = new FloatVertexArrayBuffer(7);

        GL.enable(GL.CULL_FACE);
        GL.cullFace(GL.BACK);
        GL.enable(GL.BLEND);
        GL.blendFunc(GL.SRC_ALPHA, GL.ONE_MINUS_SRC_ALPHA);

        GL.enable(GL.DEPTH_TEST);
        GL.depthMask(false); 
    }

    override function setClearColor(rgba:Color) {
        super.setClearColor(rgba);

        GL.clearColor(rgba.rNorm, rgba.gNorm, rgba.bNorm, rgba.aNorm);
    }

    override function clear() {
        super.clear();
        GL.colorMask(true, true, true, true);
        GL.clear(GL.COLOR_BUFFER_BIT | GL.DEPTH_BUFFER_BIT);
    }

    override function present() {
        super.present();
        
        program.activate();
        // TODO: add a function called uploadVertexBuffers and add this to that
        buf.bind();
        // Position
        GL.vertexAttribPointer(0, 3, GL.FLOAT, false, 7*4, 0);
        GL.enableVertexAttribArray(0);
        // Color
        GL.vertexAttribPointer(1, 4, GL.FLOAT, false, 7*4, 3*4);
        GL.enableVertexAttribArray(1);
        // triangle_count * 6 (position_count * vertex_count) * 4 (float_size)
        buf.drawTriangles();
        GL.disableVertexAttribArray(0);
        GL.disableVertexAttribArray(1);
        buf.unbind();
        program.deactivate();

    }

    override function resize(width:Int, height:Int) {
        super.resize(width, height);
        GL.viewport(0,0,width,height);
    }

    // public function uploadFloatVertexBuffer()
}

#else

class GLDriver extends Driver {
    public function new() {
        throw new NotImplementedException("WELP: I haven't yet implemented hldx nor webgl");
    } 
}
#end