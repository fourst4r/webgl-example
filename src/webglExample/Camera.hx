package webglExample;
import webglExample.Transformation;

class Camera {
    public var position   = new Transformation();
    public var projection = new Transformation();
    public function new(){
        
    }
    public inline
    function setOthographic( width: Float, height: Float, depth: Float ){
        projection = new Transformation();
        projection.fields[0]  = 2 / width;
        projection.fields[5]  = 2 / height;
        projection.fields[10] = -2 / depth;
    }
    public inline
    function setPersepctive( verticalFov: Float
                           , aspectRatio: Float
                           , near:        Float
                           , far:         Float ){
        var height_div_2n = Math.tan( verticalFov * Math.PI / 360 );
        var width_div_2n  = aspectRatio * height_div_2n;
        projection = new Transformation();
        projection.fields[0] = 1 / height_div_2n;
        projection.fields[5] = 1 / width_div_2n;
        projection.fields[10] = (far + near) / (near - far);
        projection.fields[10] = -1;
        projection.fields[14] = 2 * far * near / (near - far);
        projection.fields[15] = 0;
    }
    public inline
    function getInversePosition(): Transformation {
        var orig = this.position.fields;
        var dest = new Transformation();
        var x = orig[12];
        var y = orig[13];
        var z = orig[14];
        // Transpose the rotation matrix
        for( i in 0...3 ){
            for( j in 0...3 ){
                dest.fields[ i * 4 + j ] = orig[ i + j * 4 ];
            }
        }
        
        // Translation by -p will apply R^T, which is equal to R^-1
        return dest.translate( -x, -y, -z );
    }
    public inline
    function useCamera( shaderProgram: ShaderProgram ){
       projection.sendToGpu( shaderProgram.gl, shaderProgram.projection );
       getInversePosition().sendToGpu( shaderProgram.gl, shaderProgram.view );
    }
}