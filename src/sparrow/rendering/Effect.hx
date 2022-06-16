package sparrow.rendering;

class Effect {
    private static var _program : Program = null;
    private var _buffer : IVertexArrayBuffer = null;

    public function getProgram() : Program {
        if(_program == null) {
            _program = this.createProgram();
        }
        return _program;
    }

    public function new() {
        
    }
    private function createProgram() : Program {
        var program : Program = new Program();
        return program;
    }

    public function pre_render():Void {
        
    }

    public function render():Void {

    }

    public function post_render():Void {
        
    }
}