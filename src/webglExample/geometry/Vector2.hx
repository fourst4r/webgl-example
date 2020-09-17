package webglExample.geometry;

@:structInit
class Vector2 {
    public var x: Float;
    public var y: Float;
    public function new( x: Float, y: Float ){
        this.x = x;
        this.y = y;
    }
    public static inline
    function fromStrings( xs: String, ys: String ): Vector2 {
        return new Vector2( Std.parseFloat( xs ), Std.parseFloat( ys ) );
    }
}