include <../scad_lib/BOSL2/std.scad>
include <../scad_lib/BOSL2/polyhedra.scad>
echo(bosl_version=bosl_version_str());

// Sizes of chessex dice by whatever standard things are printed (radius often, but in some cases, such as d6, edge length).  This is all experimentally found by comparing to Chessex dice, and isn't corroborated with a micrometer or anything, caveat emptor.

cx_d4_size = 22;
cx_d6_size = 15;
cx_d8_size = 18;
cx_d10_size = 16;
cx_d12_size = 20;
cx_d20_size = 20;

// Sizes to match a larger set of dice I own which are not chessex
non_cx_d4_size = 23;
non_cx_d6_size = 17;
non_cx_d8_size = 19;
non_cx_d10_size = 17;
// The d12 and d20 are about the same size as chessex dice, so there's no change there.

// Uncomment for test build to make sure the size of dice line up with standard Chessex dice
//dice_sample();

module dice_sample() {
 translate([-22,0,0]) d4();
 translate([ 22,0,0]) d6();
 translate([-40,0,0]) d8();
 translate([0,-30,0]) d10();
 translate([0, 30,0]) d12();
 translate([ 0, 0,0]) d20();
}

module d4(size=cx_d4_size) {
    regular_polyhedron("tetrahedron", side=size, anchor=BOTTOM);
}

module d6(size=cx_d6_size) {
    translate([0,0,size/2])
    cube(size, center=true);
}

module d8(size=cx_d8_size) {
    regular_polyhedron("octahedron", side=size, anchor=BOTTOM);
}

module d10(size=cx_d10_size) {
  short_side = sqrt(sqrt(5)-2)*size;
  union(){
    regular_polyhedron("trapezohedron", faces=10, side=short_side, longside=size, anchor=BOTTOM);
    regular_polyhedron("trapezohedron", faces=10, side=short_side, longside=size, anchor=BOTTOM,  rotate_children=false, draw=false);
  }
}

module d12(size=cx_d12_size) {
    regular_polyhedron("dodecahedron", ir=size/2, anchor=BOTTOM);
}

module d20(size=cx_d20_size) {
    regular_polyhedron("icosahedron", ir=size/2, anchor=BOTTOM);
}

