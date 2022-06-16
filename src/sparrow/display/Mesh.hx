package sparrow.display;

import sparrow.core.Sparrow;
import sparrow.core.Sparrow.window;
import sparrow.rendering.drivers.GLDriver;
import sparrow.prim.Color;
import sparrow.rendering.FloatVertexArrayBuffer;
import sparrow.effects.MeshEffect;
import sparrow.prim.geom.Rect;

class Mesh {
    var rect : Rect;
    var color : Color;
    var sw : Int = 0;
    var sh : Int = 0;
    public var effect : MeshEffect;
    var buff : FloatVertexArrayBuffer;

    public var x(get, set):Int;
    
    function get_x():Int {
        return rect.x;
    }
    
    function set_x(x:Int):Int {
        rect.x = x;
        resize(this.sw, this.sh);
        return x;
    }

    public function new(rect:Rect, color:Color, stageWidth:Int, stageHeight:Int) {
        this.effect = new MeshEffect();
        this.rect = rect;
        this.color = color;
        this.sw = stageWidth;
        this.sh = stageHeight;
        this.buff = @:privateAccess cast(this.effect._buffer);
        var d = RectUtils.toTriangleStripVertexArray(RectUtils.getRectNormalized(rect, this.sw, this.sh), color);
        this.buff.pushFloatArray(d);
        this.buff.toGLBuffer();
        this.upload();
    }

    public function resize(stageWidth:Int, stageHeight:Int) {
        this.sw = stageWidth;
        this.sh = stageHeight;
        this.buff.updateGPUMemory(0, RectUtils.toTriangleStripVertexArray(RectUtils.getRectNormalized(rect, this.sw, this.sh), color));
    }

    private function upload() {
        sparrow._painter.driver.uploadEffect(this.effect);
    }
}