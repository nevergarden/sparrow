package sparrow.effects;

import sparrow.rendering.FloatVertexArrayBuffer;
#if hlsdl
import sdl.GL;
#else
#error "Not implemented platform"
#end

import sparrow.rendering.Program;
import sparrow.rendering.Effect;

class MeshEffect extends Effect {

    override public function new() {
        super();
        this._buffer = new FloatVertexArrayBuffer(7);
    }

    override function createProgram():Program {
        return Program.fromSource(
"
#version 330 core
layout(location=0) in vec3 position;
layout(location=1) in vec4 color;

out vec4 vColor;
void main() {
    gl_Position = vec4(position.x, position.y, position.z, 1);
    vColor = color;
}
",
"
#version 330 core
in vec4 vColor;
out vec4 gl_Color;
void main() {
    gl_Color = vColor;
}
");
    }

    override function pre_render() {
        super.pre_render();

        this.getProgram().activate();
        _buffer.bind();
        // Position
        GL.vertexAttribPointer(0, 3, GL.FLOAT, false, 7*4, 0);
        // Color
        GL.vertexAttribPointer(1, 4, GL.FLOAT, false, 7*4, 3*4);
        GL.enableVertexAttribArray(0);
        GL.enableVertexAttribArray(1);
    }

    override function render() {
        super.render();
        _buffer.draw(TriangleStrip);
    }

    override function post_render() {
        super.post_render();
        GL.disableVertexAttribArray(0);
        GL.disableVertexAttribArray(1);
        _buffer.unbind();
        this.getProgram().deactivate();
    }
}