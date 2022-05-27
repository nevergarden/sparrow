package sparrow.rendering;

class Program {
    #if hlsdl
    private var _vertexShader:sdl.GL.Shader;
    private var _fragmentShader:sdl.GL.Shader;
    private var _program : sdl.GL.Program;
    #end

    public function new() {
        _vertexShader = sdl.GL.createShader(sdl.GL.VERTEX_SHADER);
        _fragmentShader = sdl.GL.createShader(sdl.GL.FRAGMENT_SHADER);
        _program = sdl.GL.createProgram();
    }

    private function compileVertexShader(vertexShaderSource:String):Void {
        sdl.GL.shaderSource(_vertexShader, vertexShaderSource);
        sdl.GL.compileShader(_vertexShader);
        // trace( sdl.GL.getShaderInfoLog(_vertexShader) );
    }
    
    private function compileFragmentShader(fragmentShaderSource:String):Void {
        sdl.GL.shaderSource(_fragmentShader, fragmentShaderSource);
        sdl.GL.compileShader(_fragmentShader);
        // trace( sdl.GL.getShaderInfoLog(_fragmentShader) );
    }

    private function attachShaders() {
        sdl.GL.attachShader(_program, _vertexShader);
        sdl.GL.attachShader(_program, _fragmentShader);
    }

    private function link() {
        sdl.GL.linkProgram(_program);
        // trace( sdl.GL.getProgramInfoLog(_program) );
        // FIX: hashlink opengl implementation lacks glDetachShader function.
        // sdl.GL.detatchShader()
    }

    public function activate() {
        sdl.GL.useProgram(_program);
    }

    public function deactivate() {
        sdl.GL.useProgram(cast(0, sdl.GL.Program));
    }

    public function dispose() {
        if(_program != null) {
            sdl.GL.deleteShader(_vertexShader);
            sdl.GL.deleteShader(_fragmentShader);
            // FIX: hashlink opengl implementation lacks glDeleteProgram function.
            this._program = null;
        }
    }

    public static function fromSource(vertexShader:String, fragmentShader:String) : Program {
        var p = new Program();
        p.compileVertexShader(vertexShader);
        p.compileFragmentShader(fragmentShader);
        p.attachShaders();
        p.link();
        return p;
    }
}