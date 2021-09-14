include <../scad_lib/BOSL2/std.scad>
include <../scad_lib/BOSL2/polyhedra.scad>
echo(bosl_version=bosl_version_str());

// Uncomment for test build to make sure the size of dice line up with standard Chessex dice
//dice_sample();

module dice_sample() {
 translate([-22,0,0]) d4(22);
 translate([ 22,0,0]) d6(15);
 translate([-40,0,0]) d8(18);
 translate([0,-30,0]) d10(16);
 translate([0, 30,0]) d12(20);
 translate([ 0, 0,0]) d20(20);
}

module d4(size=22) {
    regular_polyhedron("tetrahedron", side=size, anchor=BOTTOM);
}

module d6(size=15) {
    translate([0,0,size/2])
    cube(size, center=true);
}

module d8(size=18) {
    regular_polyhedron("octahedron", side=size, anchor=BOTTOM);
}

module d10(size=16) {
  short_side = sqrt(sqrt(5)-2)*size;
  union(){
    regular_polyhedron("trapezohedron", faces=10, side=short_side, longside=size, anchor=BOTTOM);
    regular_polyhedron("trapezohedron", faces=10, side=short_side, longside=size, anchor=BOTTOM,  rotate_children=false, draw=false);
  }
}

module d12(size=20) {
    regular_polyhedron("dodecahedron", ir=size/2, anchor=BOTTOM);
}

module d20(size=20) {
    regular_polyhedron("icosahedron", ir=size/2, anchor=BOTTOM);
}

