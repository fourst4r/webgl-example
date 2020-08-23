package webglExample.geometry;

@:structInit
class Vertex {
    var position: Vector3;
    var normal:   Vector3;
    var uv:       Vector2;
    public function new( position: Vector3, normal: Vector3, uv: Vector2 ){
        this.position = position;
        this.normal   = normal;
        this.uv       = uv;
    }
}