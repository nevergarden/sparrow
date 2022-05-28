package sparrow.rendering;

import sdl.GL.Buffer;

interface IVertexArrayBuffer {
    public final byteSize : UInt;
    public var glBuf:Buffer;
    public var count(get, null) : UInt;
    public function toGLBuffer() : Void;
    
    public function bind() : Void;
}