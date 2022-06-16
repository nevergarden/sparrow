package sparrow.rendering;

import sdl.GL.Buffer;

enum VertexArrayDrawMode {
    Triangles;
    TriangleStrip;
}

interface IVertexArrayBuffer {
    public final byteSize : UInt;
    public var glBuf:Buffer;
    public var count(get, null) : UInt;
    public function toGLBuffer() : Void;
    
    public function bind() : Void;
    public function unbind() : Void;
    public function draw(type:VertexArrayDrawMode) : Void;
}