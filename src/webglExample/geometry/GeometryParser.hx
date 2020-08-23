// under development

package webglExample.geometry;

// TODO: Needs haxifying!!

// these are ok?
var position: EReg = ~/^v\s+([\d\.\+\-eE]+)\s+([\d\.\+\-eE]+)\s+([\d\.\+\-eE]+)/;
var normal:   EReg = ~/^vn\s+([\d\.\+\-eE]+)\s+([\d\.\+\-eE]+)\s+([\d\.\+\-eE]+)/;
var uv:       EReg = ~/^vt\s+([\d\.\+\-eE]+)\s+([\d\.\+\-eE]+)/;
var face:     EReg = ~/^f\s+(-?\d+)\/(-?\d+)\/(-?\d+)\s+(-?\d+)\/(-?\d+)\/(-?\d+)\s+(-?\d+)\/(-?\d+)\/(-?\d+)(?:\s+(-?\d+)\/(-?\d+)\/(-?\d+))?/;

// Parses an OBJ file, passed as a string
function objParser( src: String ) {
  lines = src.split('\n')
  var positions = []
  var uvs = []
  var normals = []
  var faces = []
  lines.forEach(function (line) {
    // Match each line of the file against various RegEx-es
    var result
    if ((result = position.exec(line)) != null) {
      // Add new vertex position
      positions.push(new Vector3(parseFloat(result[1]), parseFloat(result[2]), parseFloat(result[3])))
    } else if ((result = normal.exec(line)) != null) {
      // Add new vertex normal
      normals.push(new Vector3(parseFloat(result[1]), parseFloat(result[2]), parseFloat(result[3])))
    } else if ((result = uv.exec(line)) != null) {
      // Add new texture mapping point
      uvs.push(new Vector2(parseFloat(result[1]), 1 - parseFloat(result[2])))
    } else if ((result = face.exec(line)) != null) {
      // Add new face
      var vertices = []
      // Create three vertices from the passed one-indexed indices
      for (var i = 1; i < 10; i += 3) {
        var part = result.slice(i, i + 3)
        var position = positions[parseInt(part[0]) - 1]
        var uv = uvs[parseInt(part[1]) - 1]
        var normal = normals[parseInt(part[2]) - 1]
        vertices.push(new Vertex(position, normal, uv))
      }
      faces.push(new Face(vertices))
    }
  })
  return new Geometry(faces)
}

// TODO: unsure on promise to Haxify!!
function loadOBJ( url: String ) {
  return new Promise(function (resolve) {
    var xhr = new XMLHttpRequest()
    xhr.onreadystatechange = function () {
      if (xhr.readyState == XMLHttpRequest.DONE) {
        resolve(parseOBJ(xhr.responseText))
      }
    }
    xhr.open('GET', url, true)
    xhr.send(null)
  })

