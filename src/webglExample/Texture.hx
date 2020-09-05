package webglExample;
import js.html.webgl.Texture;
import js.html.ImageElement;
import js.html.Image;
import js.html.webgl.UniformLocation;
import js.html.webgl.RenderingContext;
import js.lib.Promise;
class Texture{
    var gl: RenderingContext;
    var data: js.html.webgl.Texture;
    public function new( gl: js.html.webgl.RenderingContext, image: ImageElement ){
        var texture = gl.createTexture();
        // Set the newly created texture context as active texture
        gl.bindTexture( RenderingContext.TEXTURE_2D, texture );
        // Set texture parameters, and pass the image that the texture is based on
        var rgba = RenderingContext.RGBA;
        var _2d = RenderingContext.TEXTURE_2D;
        var linear = RenderingContext.LINEAR;
        var mag = RenderingContext.TEXTURE_MAG_FILTER;
        var min = RenderingContext.TEXTURE_MIN_FILTER;
        var unsigned = RenderingContext.UNSIGNED_BYTE;
        gl.texImage2D( _2d, 0, rgba, rgba, unsigned, image );
        // Set filtering methods
        // Very often shaders will query the texture value between pixels,
        // and this is instructing how that value shall be calculated
        gl.texParameteri( _2d, mag, linear );
        gl.texParameteri( _2d, min, linear );
        data = texture;
        this.gl = gl;
    }
    public inline
    function useTexture( uniform: UniformLocation, binding: Int ){
        // We can bind multiple textures, and here we pick which of the bindings
        // we're setting right now
        activateTexture( data, binding );
        // Finally, we pass to the uniform the binding ID we've used
        gl.uniform1i( uniform, binding );
        // The previous 3 lines are equivalent to:
        // texture[i] = this.data
        // uniform = i
    }
    public inline
    function activateTexture( texture: js.html.webgl.Texture, imageIndex: Int ){
        var _2D = RenderingContext.TEXTURE_2D;
        switch( imageIndex ){
            case 0: gl.activeTexture( RenderingContext.TEXTURE0 );
            case 1: gl.activeTexture( RenderingContext.TEXTURE1 );
            case 2: gl.activeTexture( RenderingContext.TEXTURE2 );
            case 3: gl.activeTexture( RenderingContext.TEXTURE3 );
            case 4: gl.activeTexture( RenderingContext.TEXTURE4 );
            case 5: gl.activeTexture( RenderingContext.TEXTURE5 );
            case 6: gl.activeTexture( RenderingContext.TEXTURE6 );
            default: gl.activeTexture( RenderingContext.TEXTURE7 );
        }
        gl.bindTexture( _2D, texture );
    }
    public static function load( gl: RenderingContext, url: String) {
        return new Promise( function( resolve, reject ) {
            var image = new Image();
            image.onload = function () {
                resolve( new Texture( gl, image ) );
            }
            image.src = url;
      });
    }
}
