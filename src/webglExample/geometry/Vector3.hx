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
        return new Vector3( Std.parseInt( xs ), Std.parseInt( ys ), Std.parseInt( zs ) );
    }
    public static inline
    function fromResults( results: Array<String> ): Vector3 {
        return fromStrings( results[ 1 ], results[ 2 ], results[ 3 ] );
    }
}