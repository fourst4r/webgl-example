package webglExample;
import webglExample.Vector3;

class Light {
    public var lightDirection: Vector3; 
    public var ambienLight = 0.3;
    public function new(){
        lightDirection = new Vector3( -1., -1., -1. );
    }
    public function useLight( shaderProgram ){
        var dir = lightDirection;
        var gl = shaderProgram.gl;
        gl.unifrom3f( shaderProgram.lightDirection, dir.x, dir.y, dir.z );
        gl.uniform1f( shaderProgram.ambientLight, ambiantLight );
    }
}