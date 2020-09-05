// under development

package webglExample.geometry;
import js.lib.Promise;
import js.html.XMLHttpRequest;
// TODO: Needs haxifying!!

// these are ok?
var position: EReg = ~/^v\s+([\d\.\+\-eE]+)\s+([\d\.\+\-eE]+)\s+([\d\.\+\-eE]+)/;
var normal:   EReg = ~/^vn\s+([\d\.\+\-eE]+)\s+([\d\.\+\-eE]+)\s+([\d\.\+\-eE]+)/;
var uv:       EReg = ~/^vt\s+([\d\.\+\-eE]+)\s+([\d\.\+\-eE]+)/;
var face:     EReg = ~/^f\s+(-?\d+)\/(-?\d+)\/(-?\d+)\s+(-?\d+)\/(-?\d+)\/(-?\d+)\s+(-?\d+)\/(-?\d+)\/(-?\d+)(?:\s+(-?\d+)\/(-?\d+)\/(-?\d+))?/;

// Parses an OBJ file, passed as a string
function objParser( src: String ) {
    var lines = src.split( '\n' );
    var positions = [];
    var uvs       = [];
    var normals   = [];
    var faces     = [];
    for( i in 0...lines.length ) {
        var line = lines[ i ];
        // Match each line of the file against various RegEx-es
        if( position.match( line ) ){
            positions.push( new Vector3( Std.parseFloat( position.matched(1) )
                                       , Std.parseFloat( position.matched(2) )
                                       , Std.parseFloat( position.matched(3) )
                                       )
                           );
        } else if ( normal.match( line ) ){
            normals.push( new Vector3( Std.parseFloat( normal.matched(1) )
                                       , Std.parseFloat( normal.matched(2) )
                                       , Std.parseFloat( normal.matched(3) )
                                      )
                        );
        } else if ( uv.match( line ) ){
            uvs.push( new Vector2( Std.parseFloat( uv.matched(1) )
                                 , Std.parseFloat( uv.matched(2) )
                                 )
                    );
        } else if ( face.match( line ) ){
            // Add new face
            var vertices = [];
            // Create three vertices from the passed one-indexed indices
            var i = 1;
            while( i < 10 ){
                var p0 = Std.parseInt( face.matched( i ) );
                var p1 = Std.parseInt( face.matched( i+1 ) );
                var p2 = Std.parseInt( face.matched( i+2 ) );
                var position = positions[ p0 - 1 ];
                var uv       = uvs[ p1 - 1 ];
                var normal   = normals[ p2 - 1 ];
                vertices.push( new Vertex( position, normal, uv ) );
                i+= 3;
            }
            faces.push( new Face( vertices ) );
        }
   }
   return new Geometry( faces );
}

// TODO: unsure on promise to Haxify!!
function loadOBJ( url: String ) {
    return new Promise(function(fulfill, reject) {
        return new Promise(function (resolve, reject2 ) {
            var xhr = new XMLHttpRequest();
            xhr.onreadystatechange = function(){
                if ( xhr.readyState == XMLHttpRequest.DONE ){
                    resolve( objParser( xhr.responseText ) );
                }
            };
            xhr.open( 'GET', url, true );
            xhr.send( null );
        });
    });
}
