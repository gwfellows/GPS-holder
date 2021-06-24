$fn = 200;

difference(){
    linear_extrude(5)
        difference(){
        fillet(5){
            square([130,90]);
            translate([-10,10]) square([10,40]);
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

translate([-25,10,0]) cube([20,40,5]);

difference(){
    translate([-25,10,5]) cube([5,40,5]);
    translate([-20,52.5,10]) rotate([90,0,0]) cylinder(d=10,h=45);
}


translate([-30,10,0]) cube([5,40,25]);


translate([-27.5,50,25])
rotate([90,0,0])
cylinder(d=5,h=40);