package webglExample.geometry;

@:structInit
class Vertex {
    public var position: Vector3;
    public var normal:   Vector3;
    public var uv:       Vector2;
    public function new( position: Vector3, normal: Vector3, uv: Vector2 ){
        this.position = position;
        this.normal   = normal;
        this.uv       = uv;
    }
}