package webglExample;
import haxe.io.Float32Array;
class VBO{
    var gl: RenderingContext;
    var size: Int; 
    var count: Int;
    var data: Array<Float>;// may need changing.
    public function new( gl: RenderingContext, data: Array<Float>, count: Int ){
        // Creates buffer object in GPU RAM where we can store anything
        var bufferObject = gl.createBuffer()
        // Tell which buffer object we want to operate on as a VBO
        gl.bindBuffer( RenderingContext.ARRAY_BUFFER, bufferObject );
        // Write the data, and set the flag to optimize
        // for rare changes to the data we're writing
        gl.bufferData( RenderingContext.ARRAY_BUFFER
                     , new Float32Array( data ) // likely needs thought.
                     , RenderingContext.STATIC_DRAW), bufferObject );
        this.gl = gl;
        size = Std.int( data.length / count );
        this.count = count;
        this.data = data;
    }
    public inline
    function destroy(){
        // Free memory that is occupied by our buffer object
        gl.deleteBuffer( data );
    }
    public inline
    function bindToAttribute( attribute: Int ){
        // Tell which buffer object we want to operate on as a VBO
        gl.bindBuffer( RenderingContext.ARRAY_BUFFER, data );
        // Enable this attribute in the shader
        gl.enableVertexAttribArray( attribute )
        // Define format of the attribute array. Must match parameters in shader
        gl.vertexAttribPointer( attribute, size, RenderingContext.FLOAT, false, 0, 0 );
    }
}