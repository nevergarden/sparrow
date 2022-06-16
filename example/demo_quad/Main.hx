package demo_quad;

import sparrow.display.Mesh;
import sparrow.prim.Color;
import sparrow.rendering.drivers.GLDriver;
import sparrow.prim.geom.Rect;
import sparrow.events.Event;
import sparrow.core.Sparrow;

class Main {
    static var sparrow : Sparrow;
    static function main() {
        sparrow = new Sparrow("Draw Quad", 300,300);
        sparrow.addEventListener(Event.ACTIVATE, onActivate);
        sparrow.addEventListener(Event.RENDER, onRender);
        sparrow.start();
    }

    public static var m1 : Mesh;

    static function onActivate(e:Event) {
        trace("Activate");
        var rect1 : Rect = RectUtils.getRect(30,0, 50, 50);
        var rect2 : Rect = RectUtils.getRect(0,100, 50, 50);
        var rect3 : Rect = RectUtils.getRect(0,200, 50, 50);
        var mesh : Mesh = new Mesh(rect2, 0xff00ffff, 300, 300);
        mesh = new Mesh(rect3, 0xffff00ff, 300, 300);

        m1 = new Mesh(rect1, 0xffff00ff, 300, 300);
    }

    static function onQuit(e:Event) {
        trace("Closing App");
    }

    static function onRender(e:Event) {
        trace("render frame: " + e.data);
        m1.x += 1;
        trace(m1.x);
    }
}