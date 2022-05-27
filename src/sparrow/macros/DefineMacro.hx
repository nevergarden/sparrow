package sparrow.macros;

#if macro
import haxe.macro.Context;
import haxe.macro.Compiler;

class DefineMacro {
    public static function run() : Void {
        if(!Context.defined("gl_ver_min")) {
            Compiler.define("gl_ver_min", $v{"2"});
        }
        if(!Context.defined("gl_ver_maj")) {
            Compiler.define("gl_ver_maj", $v{"3"});
        }
    }
}

#end