package webglExample;
import js.html.webgl.Texture;
import js.html.webgl.UniformLocation;
import js.html.webgl.RenderingContext;
class Texture{
    var data: 
    public function new( gl: js.html.webgl.RenderingContext, image: ImageElement ){
        var texture = gl.createTexture();
        // Set the newly created texture context as active texture
        gl.bindTexture( RenderingContext.TEXTURE_2D, texture );
        // Set texture parameters, and pass the image that the texture is based on
        var rgba = RenderingContext.RGBA;
        var _2d = RenderingContext.TEXTURE_2D;
        var linear = RenderingContext.LINEAR;
        gl.texImage2D( RenderingContext.TEXTURE_2D, 0, rgba, rgba, RenderingContext.UNSIGNED_BYTE, image );
        // Set filtering methods
        // Very often shaders will query the texture value between pixels,
        // and this is instructing how that value shall be calculated
        gl.texParameteri( _2d, RenderingContext.TEXTURE_MAG_FILTER, linear );
        gl.texParameteri( _2d, RenderingContext.TEXTURE_MIN_FILTER, linear );
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
    function activateTexture( texture: Texture, imageIndex: Int ){
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
    public static function load( gl: RenderContext, url: String) {
      return new Promise(function (resolve) {
        var image = new Image()
        image.onload = function () {
          resolve(new Texture(gl, image))
        }
        image.src = url
      })
    }
}
