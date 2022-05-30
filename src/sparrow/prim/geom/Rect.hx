package sparrow.prim.geom;

import sparrow.prim.geom.F32Point;

typedef Rect = {
    var x:Int;
    var y:Int;
    var w:Int;
    var h:Int;
}

typedef F32Rect = {
    // Bottom Right
    var BR : F32Point;
    // Bottom Left
    var BL : F32Point;
    // Top Right
    var TR : F32Point;
    // Top Left
    var TL : F32Point;
}

class RectUtils {
    public static function getRect(x:Int, y:Int, w:Int, h:Int) : Rect {
        var rect : Rect = {
            x: x,
            y: y,
            w: w,
            h: h
        };
        return rect;
    }

    public static function getRectNormalized(rect:Rect, stageWidth:Int, stageHeight:Int) : F32Rect {
        var x = (2*rect.x-stageWidth)/stageWidth;
        var y = (2*rect.y-stageHeight)/stageHeight;
        var w = 2*(rect.w/stageWidth);
        var h = 2*(rect.h/stageHeight);
        var frect : F32Rect = {
            BL: {x: x, y: y},
            BR: {x: x+w, y: y},
            TL: {x: x, y: y+h},
            TR: {x: x+w, y: y+h},
        }
        return frect;
    }

    public static function toTrianglesVertexArray(rect:F32Rect, color:Color, z:Float) : Array<Float> {
        // TL | BL | TR
        // BL | TR | BR
        return [
            rect.TL.x(), rect.TL.y(), z, color.rNorm, color.gNorm, color.bNorm, color.aNorm,
            rect.BL.x(), rect.BL.y(), z, color.rNorm, color.gNorm, color.bNorm, color.aNorm,
            rect.TR.x(), rect.TR.y(), z, color.rNorm, color.gNorm, color.bNorm, color.aNorm,
            rect.BR.x(), rect.BR.y(), z, color.rNorm, color.gNorm, color.bNorm, color.aNorm,
            rect.TR.x(), rect.TR.y(), z, color.rNorm, color.gNorm, color.bNorm, color.aNorm,
            rect.BL.x(), rect.BL.y(), z, color.rNorm, color.gNorm, color.bNorm, color.aNorm,
        ];
    }

    public static function toTriangleStripVertexArray(rect:F32Rect, color:Color) : Array<Float> {
        return [
            rect.TL.x(), rect.TL.y(), 0.0, color.rNorm, color.gNorm, color.bNorm, color.aNorm,
            rect.BL.x(), rect.BL.y(), 0.0, color.rNorm, color.gNorm, color.bNorm, color.aNorm,
            rect.TR.x(), rect.TR.y(), 0.0, color.rNorm, color.gNorm, color.bNorm, color.aNorm,
            rect.BR.x(), rect.BR.y(), 0.0, color.rNorm, color.gNorm, color.bNorm, color.aNorm,
        ];
    }
}