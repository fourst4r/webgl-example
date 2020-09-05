package webglExample;
import js.html.webgl.RenderingContext;
import js.html.webgl.UniformLocation;
import haxe.io.Float32Array;
class Transformation {
    public var fields: Array<Float>;
    public function new(){
        fields = [ 1., 0., 0., 0.
                 , 0., 1., 0., 0.
                 , 0., 0., 1., 0.
                 , 0., 0., 0., 1. ];
    }
    public inline
    function mult( t: Transformation ): Transformation {
        var output = new Transformation();
        for( row in 0...4 ){
            for( col in 0...4 ){
                var sum = 0.;
                for( k in 0...4 ){
                    sum += this.fields[ k * 4 + row ] * t.fields[ col * 4 + k ];
                }
                output.fields[ col*4 + row ] = sum;
            }
        }
        return output;
    }

    // Multiply by translation matrix
    public inline
    function translate( x: Float = 0., y: Float = 0., z: Float = 0. ): Transformation {
        var mat = new Transformation();
        mat.fields[ 12 ] = x;
        mat.fields[ 13 ] = y;
        mat.fields[ 14 ] = z;
        return mult( mat );
    }

    // Multiply by scaling matrix
    public inline
    function scale( x: Float = 0., y: Float = 0., z: Float = 0. ): Transformation {
        var mat = new Transformation();
        mat.fields[  0 ] = x;
        mat.fields[  5 ] = y;
        mat.fields[ 10 ] = z;
        return mult( mat );
    }
    
    // Multiply by rotation matrix around X axis
    public inline 
    function rotateX( angle: Float = 0. ): Transformation{
      var c = Math.cos( angle );
      var s = Math.sin( angle );
      var mat = new Transformation();
      mat.fields[  5 ] = c;
      mat.fields[ 10 ] = c;
      mat.fields[  9 ] = -s;
      mat.fields[  6 ] = s;
      return mult( mat );
    }

    // Multiply by rotation matrix around Y axis
    public inline
    function rotateY( angle: Float = 0. ): Transformation {
      var c = Math.cos( angle );
      var s = Math.sin( angle );
      var mat = new Transformation();
      mat.fields[  0 ] = c;
      mat.fields[ 10 ] = c;
      mat.fields[  2 ] = -s;
      mat.fields[  8 ] = s;
      return this.mult( mat );
    }

    // Multiply by rotation matrix around Z axis
    public inline
    function rotateZ( angle: Float = 0. ): Transformation {
      var c = Math.cos( angle );
      var s = Math.sin( angle );
      var mat = new Transformation();
      mat.fields[ 0 ] = c;
      mat.fields[ 5 ] = c;
      mat.fields[ 4 ] = -s;
      mat.fields[ 1 ] = s;
      return mult( mat );
    }
    public inline
    function sendToGpu( gl:        RenderingContext
                      , uniform:   UniformLocation
                      , transpose: Bool = false ) {
        gl.uniformMatrix4fv( uniform, transpose, cast new Float32Array( cast fields ) );
    }
}