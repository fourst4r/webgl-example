package webglExample;
import webglExample.geometry.Geometry;
import webglExample.geometry.GeometryParser;
import js.html.webgl.RenderingContext;
import js.lib.Promise;
class Mesh{
    public var positions:   Vbo;
    public var normals:     Vbo;
    public var uvs:         Vbo;
    public var vertexCount: Int;
    public var position:    Transformation;
    public var gl:          RenderingContext;
    public var texture: Texture;
    public function new( gl, geometry: Geometry, texture: Texture ){
        var vertexCount = geometry.vertexCount();
        positions = new Vbo( gl, geometry.positions(), vertexCount );
        normals   = new Vbo( gl, geometry.normals(), vertexCount );
        uvs       = new Vbo( gl, geometry.uvs(), vertexCount );
        this.texture     = texture;
        this.vertexCount = vertexCount;
        this.position    = new Transformation();
        this.gl = gl;
    }
    public inline
    function destroy() {
        positions.destroy();
        normals.destroy();
        uvs.destroy();
    }
    public inline 
    function draw( shaderProgram ){
        positions.bindToAttribute( shaderProgram.position );
        normals.bindToAttribute(   shaderProgram.normal   );
        uvs.bindToAttribute(       shaderProgram.uv       );
        position.sendToGpu( gl,    shaderProgram.model    );
        texture.useTexture( shaderProgram.diffuse, 0 );
        gl.drawArrays( RenderingContext.TRIANGLES, 0, vertexCount );
    }

    public static inline
    function load( gl: RenderingContext, modelUrl: String , textureUrl: String ){
        var geometry = loadOBJ( modelUrl );
        var texture = Texture.load( gl, textureUrl );
        return Promise.all( [ geometry, texture ] ).then( function ( params ) {
            return new Mesh( gl, params[ 0 ], params[ 1 ] );
        });
    }
}