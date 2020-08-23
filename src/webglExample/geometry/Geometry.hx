package webglExample.geometry;
import webglExample.geometry.*;
@:structInit
class Geometry_ {
    public var face: Face;
    public function new( face: Face ){
        this.face = face;
    }
}
abstract Geometry( Geometry_ ) from Geometry_ to Geometry_ {
    public inline function new( face: Face ){
        this = new Geometry_( face );
    }
    public inline
    function vertexCount(){
        return this.faces.length * 3;
    }
    public inline
    function positions(){
        var answer = new Array<Float>();
        var len = this.faces.length;
        var vlen: Int;
        var face: Face;
        var vertex: Vertex;
        var v: Vector3;
        for( i in 0...len ){
            face = this.faces[ i ];
            vlen = face.vertices.length;
            for( j in 0...vlen ){
                vertex = face.vertices[ j ];
                v = vertex.position;
                answer.push( v.x );
                answer.push( v.y );
                answer.push( v.z );
            }
        }
        return answer;
    }
    public inline
    function normals(){
        var answer = new Array<Float>();
        var len = this.faces.length;
        var vlen: Int;
        var face: Face;
        var v: Vector3;
        for( i in 0...len ){
            face = this.faces[ i ];
            vlen = face.vectices.length;
            for( j in 0...vlen ){
                vertex = faces.vertices[ j ];
                v = vertex.normal;
                answer.push( v.x );
                answer.push( v.y );
                answer.push( v.z );
            }
        }
    }
    public inline
    function uvs(){
        var answer = new Array<Float>();
        var len = this.faces.length;
        var vlen: Int;
        var face: Face;
        var v: Vector2;
        for( i in 0...len ){
            face = this.faces[ i ];
            vlen = face.vectices.length;
            for( j in 0...vlen ){
                vertex = faces.vertices[ j ];
                v = vectex.uv;
                answer.push( v.x );
                answer.push( v.y );
            }
        }
    }
}