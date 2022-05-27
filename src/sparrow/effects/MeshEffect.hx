package sparrow.effects;

import sparrow.rendering.Program;
import sparrow.rendering.Effect;

class MeshEffect extends Effect {
    
    override function createProgram():Program {
        return Program.fromSource(
"
#version 330 core
layout(location=0) in vec2 position;
void main() {
    gl_Position = vec4(position.x, position.y, 0, 1);
}
",
"
#version 330 core
out vec4 gl_Color;
void main() {
    gl_Color = vec4(1,1,1,1);
}
");
    }
}