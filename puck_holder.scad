module topPlate() {
    difference(){
        union(){
            difference() {
                cylinder(d = ((puckD + (2 * wallThickness)) + 3), h = ((wallThickness + magnetH) + puckRimH));
                translate([0, 0, wallThickness]) 
                    cylinder(d = (magnetD + tolerance), h = 10);
                translate([0, 0, (wallThickness + magnetH)]) 
                    cylinder(d = (puckD + tolerance), h = 10);
                for(i = [1 : 1 : 4]) 
                    rotate([0, 0, ((360 / 4) * i)]) 
                        translate([0, 0, ((wallThickness + magnetH) + 5)]) 
                            cube([20, 100, 10], center = true);
            }
            hull() {
                cylinder(h = 0.01, d = ((puckD + (2 * wallThickness)) + 3));
                translate([0, 0, (2*(((railD / 2) + 5) + 4)-10)/2 - ((puckD + (2 * wallThickness)) + 3)/2]) 
                    cylinder(h = 0.01, d = 2*(((railD / 2) + 5) + 4)-10);
            }
        }
        for (i=[180,0]){
            rotate([0,0,i]){
            translate([-(railD+tolerance)/4,-36,5]) 
                rotate([0,90,0])
                    linear_extrude((railD+tolerance)/2)
                    polygon([[0,0],[100,100],[100,0]]);
            translate([0,5+puckD/2+2.5,0]) cube([(railD+tolerance)/2,10,1000],center=true);
            }
        }
    }
}
module base2() {
	difference() {
		translate([0, 0, ((railD / 2) - 5)]) 
			cylinder(h = (height + (railD / 2)), d = ((puckD + (2 * wallThickness)) + 3), center = true);
		rotate([90, 0, 0]) 
			t_cylinder(h = 100, center = true, d = (railD + tolerance));
		translate([(-width / 2), 0, 1]) 
			cube([1000, 1000, 14+3.658*2], center = true);//14
		for(i = [1 : 1 : 4]) 
			rotate([0, 0, (90 * i)]) 
				translate([(((railD / 2) + 5) + 4), 0, -5]) 
					cube([10, 100, 100], center = true);
	}
}
module sequentialHull() {
	for(i = [0 : ($children - 2)]) hull() {
		children(i);
		children((i + 1));
	}
}
module pin() {
    rotate([0,0,180])
	sequentialHull() {
		translate([0, 0, 0]) scale([1, 1.3, 1]) t_cylinder(d = pinTopD, h = 0.1,v=1);
		translate([0, 0, 1]) t_cylinder(d = pinD, h = 0.1,v=1);
		translate([0, 0, 3]) t_cylinder(d = pinD, h = 0.1,v=1);
		translate([0, 0, 5]) scale([1, 1.3, 1]) t_cylinder(d = pinTopD, h = 0.1,v=1);
		translate([0, 0, 6]) scale([1, 1.3, 1]) t_cylinder(d = pinTopD, h = 0.1,v=1);
	}
}
module pins() {
	for(i = [0 : 10 : 39])
    	translate([((((railD / 2) + 5) + 4) - 5), (-15 + i), 15])
    		rotate([0, 90, 0])
    			rotate([0, 0, 90])
    				pin();
}
module magnetCutouts() {
	for(x = [-1 : 2 : 1]) 
    	for(i = [(-80 / 2) : 80 : (80 / 2)]) 
    		rotate([0, i, 0]) 
    			translate([0, (x * 10), 0]) 
                    translate([0,0,tolerance/2+20])
    				cylinder(d1 = (smallMagnetD + tolerance)+ 11, d2 = (smallMagnetD + tolerance), h = smallMagnetH + (railD / 2)-20);
}
module holder() {
	pins();
	mirror([1, 0, 0]) 
		pins();
	difference() {
		union() {
			base2();
			difference() {
				translate([0, 0, (((height + (railD / 2)) + magnetH) + 2)]) 
					topPlate();
				rotate([90, 0, 0])
					t_cylinder(h = 100, center = true, d = (railD + tolerance));
			}
		}
		magnetCutouts();
	}
}
module rail() {
	rotate([90, 0, 0]) 
		cylinder(h = 300, center = true, d = railD);
}

module t_cylinder(h, center, d, v=1/3){
    hull(){
        cylinder(h=h,center=center,d=d);
        translate([-(d*v)/2,0,-h/2]) cube([d*v,d/2,h]);
    }
}

tolerance     = 0.3;
wallThickness = 2;
magnetD       = 50.89;
magnetH       = 1.85;
puckD         = 57;
puckRimH      = 6-3;//6;
railD         = 43;
height        = 0;
width         = 43;
depth         = 55;
pinD          = 4;
pinTopD       = 5.15;
smallMagnetD  = 8;
smallMagnetH  = 3;
$fn           = 100;

holder();