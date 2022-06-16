package sparrow.rendering.drivers;

import sparrow.effects.MeshEffect;
import sparrow.prim.Color;
#if hlsdl
import sdl.GL;

class GLDriver extends Driver {
    var uploadedEffects : Array<Effect> = new Array<Effect>();
    public function new() {
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
        for(effect in this.uploadedEffects) {
            effect.pre_render();
            effect.render();
            effect.post_render();
        }
    }

    override function resize(width:Int, height:Int) {
        super.resize(width, height);
        GL.viewport(0,0,width,height);
    }

    override function uploadEffect(effect:Effect) {
        super.uploadEffect(effect);
        this.uploadedEffects.push(effect);
    }
}

#else

class GLDriver extends Driver {
    public function new() {
        throw new NotImplementedException("WELP: I haven't yet implemented hldx nor webgl");
    } 
}
#end