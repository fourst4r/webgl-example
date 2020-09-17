package webglExample.geometry;

@:structInit
class Vector3 {
    public var x: Float;
    public var y: Float;
    public var z: Float;
    public function new( x: Float, y: Float, z: Float ){
        this.x = x;
        this.y = y;
        this.z = z;
    }
    public static inline
    function fromStrings( xs: String, ys: String, zs: String ): Vector3 {
        return new Vector3( Std.parseFloat( xs )
                          , Std.parseFloat( ys )
                          , Std.parseFloat( zs ) );
    }
}