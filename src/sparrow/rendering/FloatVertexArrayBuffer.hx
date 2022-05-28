package sparrow.rendering;

import sdl.GL;

class FloatVertexArrayBuffer implements IVertexArrayBuffer {
    public final byteSize:UInt = 4; // F32 size
    public var glBuf:Buffer;
    public var data:FloatBuffer;
    public var isFinal : Bool = false;

	public function get_count():UInt {
		return this.count;
	}

	public var count(get, null):UInt;

    public function new() {
        glBuf = GL.createBuffer();
        data = FloatBuffer.create();
    }

    public function pushFloat(f:Float) {
        if(isFinal)
            return;
        data.pushFloat(f);
        this.count++;
    }

    public function pushFloatArray(f:Array<Float>) {
        if(isFinal)
            return;
        data.pushFloatArray(f);
        this.count+=f.length;
    }

	public function bind() {
        GL.bindBuffer(GL.ARRAY_BUFFER, glBuf);
    }

    public function unbind() {
        GL.bindBuffer(GL.ARRAY_BUFFER, null);        
    }

    public function drawTriangles() {
        GL.drawArrays(GL.TRIANGLES, 0, this.count*byteSize);
    }

	public function toGLBuffer() {
        if(isFinal)
            return;
        this.bind();
        GL.bufferData(GL.ARRAY_BUFFER, data.size*byteSize, hl.Bytes.getArray(@:privateAccess data._internal), GL.DYNAMIC_DRAW);
        this.unbind();
        isFinal = true;
    }
}