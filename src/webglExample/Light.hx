package webglExample;
import webglExample.geometry.Vector3;

class Light {
    public var lightDirection: Vector3; 
    public var ambientLight = 0.3;
    public function new(){
        lightDirection = new Vector3( -1., -1., -1. );
    }
    public function useLight( shaderProgram: ShaderProgram ){
        var dir = lightDirection;
        var gl = shaderProgram.gl;
        gl.uniform3f( shaderProgram.lightDirection, dir.x, dir.y, dir.z );
        gl.uniform1f( shaderProgram.ambientLight, ambientLight );
    }
}