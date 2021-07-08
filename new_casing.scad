$fn = 200;

difference(){
    linear_extrude(5)
        difference(){
        fillet(5){
            square([130-6,86]);
            translate([-10,10+6]) square([10,40]);
        }
        translate([-15,10]) square([10,40]);
    }
    for(x=[0,60]) for(y=[0,45]){
        translate([x+130/2-60/2,y+90/2-45/2,-0.01]) cylinder(h=3, d=19);
        translate([x+130/2-60/2,y+90/2-45/2,-0.01]) cylinder(h=1, d1=20, d2=19);
    }

}
    
module fillet(r){
     offset(-r) offset(r) offset(r) offset(-r) children();
}




difference(){
    union(){
        difference(){
            translate([-25+6,10+6,5]) cube([10,40,10]);
            translate([-15+6,52.5+6,15]) rotate([90,0,0]) cylinder(d=20,h=45,$fn=4);
}
        translate([-25+6,10+6,0]) cube([20-6,40,5]);
        translate([-30+6,10+6,0]) cube([5,40,25]);
    }
    translate([-80,0,50]) rotate([0,45,0]) cube([100,100,13]);
}


translate([-27.5+6,50+6,25])
rotate([90,0,0])
cylinder(d=5,h=40);