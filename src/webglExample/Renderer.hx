package webglExample;

import js.html.CanvasElement;
import js.html.webgl.RenderingContext;
import js.html.webgl.Shader;
class Renderer {
    var gl: RenderingContext;
    var shaderProgram: ShaderProgram;
    public function new( canvas: CanvasElement ){
        gl = canvas.getContextWebGL();
        gl.enable( RenderingContext.DEPTH_TEST );
        shaderProgram = null;
    }
    public inline
    function setClearColor( red: Float, green: Float, blue: Float ){
        gl.clearColor( red / 255., green / 255., blue / 255., 1. );
    }
    public inline
    function getContext() {
      return gl;
    }
    public inline 
    function setShader( shaderProgram: ShaderProgram ){
        trace('shader set');
        this.shaderProgram = shaderProgram;
    }
    public inline
    function render( camera: Camera, light: Light, objects: Array<Mesh> ){
        gl.clear( RenderingContext.COLOR_BUFFER_BIT | RenderingContext.DEPTH_BUFFER_BIT );
        if( shaderProgram == null ) return;
        shaderProgram.useShader();
        light.useLight( shaderProgram );
        camera.useCamera( shaderProgram );
        var mesh: Mesh;
        for( i in 0...objects.length ){
            mesh = objects[ i ];
            mesh.draw( shaderProgram );
        }
    }
}
