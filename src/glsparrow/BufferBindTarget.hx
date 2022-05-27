package glsparrow;

enum abstract BufferBindTarget(Int) {
    #if (gl_ver_maj > 1 || (gl_ver_maj == 1 && gl_ver_min >= 5 )) // 1.5
    var Array = 0x8892;// GL_ARRAY_BUFFER
    var ElementArray = 0x8893; //GL_ELEMENT_ARRAY_BUFFER
    #if (gl_ver_maj > 2 || (gl_ver_maj == 2 && gl_ver_min >= 1 )) // 2.1
    var PixelPack = 0x88EB; //GL_PIXEL_PACK_BUFFER
    var PixelUnpack = 0x88EC; //GL_PIXEL_UNPACK_BUFFER
    #end
    #if (gl_ver_maj > 3 || (gl_ver_maj == 3 && gl_ver_min >= 0 )) // 3.0
    var TransformFeedback = 0x8C8E; //GL_TRANSFORM_FEEDBACK_BUFFER
    #if (gl_ver_maj > 3 || (gl_ver_maj == 3 && gl_ver_min >= 1 )) // 3.1
    var CopyRead = 0x8F36; //GL_COPY_READ_BUFFER
    var CopyWrite = 0x8F37; //GL_COPY_WRITE_BUFFER
    var Texture = 0x8C2A; //GL_TEXTURE_BUFFER
    var Uniform = 0x8A11; //GL_UNIFORM_BUFFER
    #end
    #end
    #if (gl_ver_maj > 4 || (gl_ver_maj == 4 && gl_ver_min >= 0 )) // 4.0
    var DrawIndirect = 0x8F3F; //GL_DRAW_INDIRECT_BUFFER
    #if (gl_ver_maj > 4 || (gl_ver_maj == 4 && gl_ver_min >= 2 )) // 4.2
    var AtomicCounter = 0x92C0; //GL_ATOMIC_COUNTER_BUFFER
    #end
    #if (gl_ver_maj > 4 || (gl_ver_maj == 4 && gl_ver_min >= 3 )) // 4.3
    var DispatchIndirect = 0x90EE; //GL_DISPATCH_INDIRECT_BUFFER
    var ShaderStorage = 0x90D2; //GL_SHADER_STORAGE_BUFFER
    #end
    #if (gl_ver_maj > 4 || (gl_ver_maj == 4 && gl_ver_min >= 4 )) // 4.4
    var Query = 0x9192; //GL_QUERY_BUFFER
    #end
    #end
    #end
}