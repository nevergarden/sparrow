package sparrow.effects;

import sparrow.rendering.Program;
import sparrow.rendering.Effect;

class MeshEffect extends Effect {
    
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
}