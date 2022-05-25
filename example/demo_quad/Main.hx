package demo_quad;

import sparrow.events.Event;
import sparrow.core.Sparrow;

class Main {
    static var sparrow : Sparrow;
    static function main() {
        sparrow = new Sparrow("Draw Quad", 200,600);
        sparrow.addEventListener(Event.QUIT, onQuit);
        sparrow.addEventListener(Event.ACTIVATE, onActivate);
        sparrow.addEventListener(Event.RENDER, onRender);
        // TODO: Adding listeners should work after main loop too
        // handle events on another thread
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