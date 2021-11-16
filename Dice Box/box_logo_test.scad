use <box_lid.scad>
use <box_inset.scad>

difference() {
  translate([0,0,.5])
    cube([114,85,1], true);
  translate([0,0,-.001])
    medic_logo(114,85);
}

translate([0,100,0])
  medic_inset();