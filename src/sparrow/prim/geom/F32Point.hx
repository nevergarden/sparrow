package sparrow.prim.geom;

#if hl
typedef F32 = hl.F32;
#else
typedef F32 = hl.F32;
#end

typedef F32PointType = {
    var x : F32;
    var y : F32;
}

abstract F32Point(F32PointType) from F32PointType {
    public function x() {
        return this.x;
    }

    public function y() {
        return this.y;
    }
    
    public function new(val:F32PointType) {
        this = val;
    }

    @to
    public function pointType() : F32PointType {
        return {x:this.x, y:this.y};
      }
}