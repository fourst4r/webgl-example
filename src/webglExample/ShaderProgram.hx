package webglExample;
import js.html.webgl.RenderingContext;
import js.html.webgl.UniformLocation;
import js.html.webgl.Program;
import js.html.webgl.Shader;
import js.lib.Promise;
import js.html.XMLHttpRequest;
class ShaderProgram{
    public var gl:             RenderingContext;
    public var position:       Int;
    public var normal:         Int;
    public var uv:             Int;
    public var model:          UniformLocation;
    public var view:           UniformLocation;
    public var projection:     UniformLocation;
    public var ambientLight:   UniformLocation;
    public var lightDirection: UniformLocation;
    public var diffuse:        UniformLocation;
    public var vert:           Shader;
    public var frag:           Shader;
    public var program:        Program;
    
    public function new( gl: RenderingContext, vertSrc: String, fragSrc: String ){
        vert = gl.createShader( RenderingContext.VERTEX_SHADER );
        gl.shaderSource( vert, vertSrc );
        gl.compileShader( vert );
        if( !gl.getShaderParameter( vert, RenderingContext.COMPILE_STATUS ) ){
            trace( gl.getShaderInfoLog( vert ) );
            js.Browser.console.error( 'Failed to compile shader' );
        }
        frag = gl.createShader( RenderingContext.FRAGMENT_SHADER );
        gl.shaderSource( frag, fragSrc );
        gl.compileShader( frag );
        if( !gl.getShaderParameter( frag, RenderingContext.COMPILE_STATUS ) ){
            trace( gl.getShaderInfoLog( frag ) );
            js.Browser.console.error('Failed to compile shader');
        }
        program = gl.createProgram();
        gl.attachShader( program, vert );
        gl.attachShader( program, frag );
        gl.linkProgram( program );
        if( !gl.getProgramParameter( program, RenderingContext.LINK_STATUS ) ){
            trace( gl.getProgramInfoLog( program ) );
            js.Browser.console.error('Failed to link program');
        }
        this.gl        = gl;
        
        position       = gl.getAttribLocation( program, 'position' );
        normal         = gl.getAttribLocation( program, 'normal' );
        uv             = gl.getAttribLocation( program, 'uv' );
        
        model          = gl.getUniformLocation( program, 'model' );
        view           = gl.getUniformLocation( program, 'view' );
        projection     = gl.getUniformLocation( program, 'projection' );
        ambientLight   = gl.getUniformLocation( program, 'ambientLight' );
        lightDirection = gl.getUniformLocation( program, 'lightDirection' );
        diffuse        = gl.getUniformLocation( program, 'diffuse' );
    }
    // Loads shader files from the given URLs, and returns a program as a promise
    public static inline
    function load( gl: RenderingContext, vertUrl: String, fragUrl: String ) {
        return Promise.all( [ loadFile( vertUrl ), loadFile( fragUrl ) ] ).then(
            function ( files ) {
                return new ShaderProgram( gl, files[ 0 ], files[ 1 ] );
            });
    }
    public static inline
    function loadFile ( url: String ) {
        return new Promise( 
            function( resolve, reject ){
                var xhr = new XMLHttpRequest();
                xhr.onreadystatechange = function () {
                    if( xhr.readyState == XMLHttpRequest.DONE ){
                        resolve( xhr.responseText );
                    }
                }
                xhr.open( 'GET', url, true );
                xhr.send( null );
            }
        );
    }
    public function useShader(){
        gl.useProgram( program );
    }
}