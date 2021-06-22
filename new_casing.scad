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

translate([-5,10,25])
rotate([-90,90,0])
rotate_extrude(angle=90){
    translate([20,0]) square([5,40]);
}

translate([-27.5,50,25])
rotate([90,0,0])
cylinder(d=5,h=40);