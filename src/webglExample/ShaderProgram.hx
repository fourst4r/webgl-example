package webglExample;
import js.html.webgl.UniformLocation;
import js.html.webgl.Shader;
class ShaderPrograme{
    var gl:             RenderingContext;
    var positon:        Int;
    var normal:         Int;
    var uv:             Int;
    var model:          UniformLocation;
    var view:           UniformLocation;
    var projection:     UniformLocation;
    var ambientLight:   UniformLocation;
    var lightDirection: UniformLocation;
    var diffuse:        UniformLocation;
    var vert:           Shader;
    var frag:           Shader;
    
    public function new( gl: RenderingContext, vertSrc: String, fragSrc: String ){
        vert = gl.createShader( RenderingContext.VERTEX_SHADER );
        gl.shaderSource( vert, vertSrc );
        gl.compileShader( vert );
        if( !gl.getShaderParameter( vert, RenderingContext.COMPILE_STATUS ) ){
            trace( gl.getShaderInfoLog( vert ) );
            throw new Error( 'Failed to compile shader' );
        }
        frag = gl.createShader( RenderingContext.FRAGMENT_SHADER );
        gl.shaderSource( frag, fragSrc );
        gl.compileShader( frag );
        if( !gl.getShaderParameter( frag, RenderingContext.COMPILE_STATUS ) ){
            trace( gl.getShaderInfoLog( frag ) );
            throw new Error('Failed to compile shader')
        }
        program = gl.createProgram();
        gl.attachShader( program, vert );
        gl.attachShader( program, frag );
        gl.linkProgram( program );
        if( !gl.getProgramParameter( program, gl.LINK_STATUS ) ){
            trace( gl.getProgramInfoLog( program ) );
            throw new Error('Failed to link program')
        }
        this.gl = gl;
        position = gl.getAttribLocation( program, 'position' );
        normal = gl.getAttribLocation(program, 'normal' );
        uv = gl.getAttribLocation(program, 'uv' );
        model = gl.getUniformLocation(program, 'model' );
        view = gl.getUniformLocation(program, 'view' );
        projection = gl.getUniformLocation(program, 'projection' );
        ambientLight = gl.getUniformLocation(program, 'ambientLight' );
        lightDirection = gl.getUniformLocation(program, 'lightDirection' );
        diffuse = gl.getUniformLocation(program, 'diffuse' );
    }
    // Loads shader files from the given URLs, and returns a program as a promise
    public static inline
    function load( gl: RendingContext, vertUrl: String, fragUrl: String ) {
        return Promise.all([loadFile(vertUrl), loadFile(fragUrl)]).then(function (files) {
            return new ShaderProgram(gl, files[0], files[1])
            });
    }
    public static inline
    function loadFile ( url: String ) {
        return new Promise( function (resolve) {
            var xhr = new XMLHttpRequest();
            xhr.onreadystatechange = function () {
            if( xhr.readyState == XMLHttpRequest.DONE ){
                  resolve( xhr.responseText );
              }
            }
            xhr.open( 'GET', url, true );
            xhr.send( null )
        } );
    }
    public function useShader(){
        gl.useProgram( program );
    }
}