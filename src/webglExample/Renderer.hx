package webglExample;

import js.html.CanvasElement;
import js.html.webgl.RenderingContext;
import webglExmaple;

class Renderer {
    var gl: RenderingContext;
    var shader: 
    public function new( canvas: CanvasElement ){
        var gl = canvas.getContextWebGL();
        gl.enable( RenderingContext.DEPTH_TEST );
        this.gl = gl;
        this.shader = null;
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
    function setShader( shader ){
        this.shader = shader;
    }
    public inline
    function render( camera: Camera, light: Light, objects: Array<Mesh> ){
        gl.clear( RenderingContext.COLOR_BUFFER_BIT | RenderingContext.DEPTH_BUFFER_BIT );
        if( shader == null ) return;
        shader.useShader();
        light.useLight();
        camera.useCamera();
        var mesh: Mesh;
        for( i in 0...objects.length ){
            mesh = objects[ i ];
            mesh.draw( shader );
        }
    }
}
