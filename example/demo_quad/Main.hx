package demo_quad;

import sparrow.prim.Color;
import sparrow.rendering.drivers.GLDriver;
import sparrow.prim.geom.Rect;
import sparrow.events.Event;
import sparrow.core.Sparrow;

class Main {
    static var sparrow : Sparrow;
    static function main() {
        sparrow = new Sparrow("Draw Quad", 300,300);
        // resize is not handled in this
        // Also this is so low level shouldn't be here.
        var rect1 : Rect = RectUtils.getRect(0,0, 50, 50);
        var rect2 : Rect = RectUtils.getRect(0,100, 50, 50);
        var rect3 : Rect = RectUtils.getRect(0,200, 50, 50);
        GLDriver.buf.pushFloatArray(RectUtils.toTrianglesVertexArray(RectUtils.getRectNormalized(rect1, window.width, window.height), 0xff0000ff, 0));
        GLDriver.buf.pushFloatArray(RectUtils.toTrianglesVertexArray(RectUtils.getRectNormalized(rect2, window.width, window.height), 0x00ff00ff, 0));
        GLDriver.buf.pushFloatArray(RectUtils.toTrianglesVertexArray(RectUtils.getRectNormalized(rect3, window.width, window.height), 0x0000ffff, 0));
        GLDriver.buf.toGLBuffer();
        // Update them with:
        // GLDriver.buf.updateGPUMemory(0, RectUtils.toTrianglesVertexArray(RectUtils.getRectNormalized(rect3, window.width, window.height), 0xff0000aa, -0.6));
        // GLDriver.buf.updateGPUMemory(0, RectUtils.toTrianglesVertexArray(RectUtils.getRectNormalized(rect3, window.width, window.height), 0xff0000aa, -0.6));
        // GLDriver.buf.updateGPUMemory(0, RectUtils.toTrianglesVertexArray(RectUtils.getRectNormalized(rect3, window.width, window.height), 0xff0000aa, -0.6));
        sparrow.start();
    }

    static function onActivate(e:Event) {
        trace("Activate");
    }

    static function onQuit(e:Event) {
        trace("Closing App");
    }

    static function onRender(e:Event) {
        trace("render frame: " + e.data);
    }
}