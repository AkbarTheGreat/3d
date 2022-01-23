include <../scad_lib/BOSL2/std.scad>

// Scale to render trophy at
trophy_scale = .75;
// Trophy variant 
render_person = "deb"; // ["deb", "nick"]
// Trophy text
trophy_text = ["Debbiest","Deb"];
// Text size
text_size = 10;

if (render_person == "deb") {
  deb_trophy();
}
if (render_person == "nick") {
  trophy_title();
}

module deb_trophy() {
  scale([trophy_scale, trophy_scale, trophy_scale]) {
    difference() {
      plain_trophy();
      deb_art();
      trophy_title();
    }
  }
}

base_height = 60;

module plain_trophy() {
  trophy_base();
  trophy_body();
  trophy_arms();
}

module trophy_base() {
  translate([0,0,base_height/2])
  cuboid([250,150,base_height], chamfer=2);
}

module trophy_body() {
  translate([0,0,base_height])
    rotate_extrude($fn=200)
      translate([0.009,0,0])
        import("trophy_profile.svg");
}

module trophy_arms() {
  x_move = 32;
  z_move = 65+base_height;
  y_rotate = 18;

  translate([x_move,0,z_move])
    rotate([90,y_rotate,0])
      trophy_arm();
  translate([-x_move,0,z_move])
    rotate([90,y_rotate,180])
      trophy_arm();
}

module trophy_arm() {
  scale_factor = 1.45;
  scale([scale_factor,scale_factor,scale_factor])
  linear_extrude(3)
      import("trophy_handle.svg");
}

module deb_art() {
    translate([-80,-74.501,2])
    rotate([90,00,0])
    scale([.4,.4,1])
    linear_extrude(.5)
      import("deb-art.svg");
}

module trophy_title() {
  height = (text_size + 2) *(len(trophy_text)-1) + (base_height - (text_size + 2) * len(trophy_text))/2;
  translate([-30,-74.501,height])
  rotate([90,00,0])
  linear_extrude(.5)
  union(){
    for (i = [0 : len(trophy_text)-1]) {
      translate([0 , -i * (text_size + 2), 0 ]) text(trophy_text[i], text_size);
    }
  }
}
