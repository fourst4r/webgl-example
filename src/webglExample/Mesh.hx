// Under development

package webglExample;
import webglExample.geometry.Geometry;

class Mesh{
    public var postions: VBO;
    public var normals: VBO;
    var texture: Texture;
    public function new( gl, geometry: Geometry, texture: Texture ){
        var vertexCount = geometry.vertexCount();
        positions = new VBO( gl, geometry.positions(), vertexCount );
        normals = new VBO( gl, geometry.normals(), vertexCount );
        uvs = new VBO( gl, geometry.uvs(), vertexCount );
        this.texture = texture;
        this.vertexCount = vertexCount;
        this.position = new Transformation();
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
      normals.bindToAttribute( shaderProgram.normal );
      uvs.bindToAttribute( shaderProgram.uv );
      position.sendToGpu(this.gl, shaderProgram.model );
      texture.useTexture(shaderProgram.diffuse, 0 );
      gl.drawArrays( gl.TRIANGLES, 0, vertexCount );
    }

    public inline
    function load( gl: RenderingTexture, modelUrl: String , textureUrl: String ){
      var geometry = Geometry.loadOBJ( modelUrl );
      var texture = Texture.load( gl, textureUrl );
      return Promise.all( [ geometry, texture ] ).then( function ( params ) {
        return new Mesh( gl, params[0], params[1] );
      });
    }
}