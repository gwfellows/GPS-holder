module topPlate() {
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
		translate([0, 0, -5]) 
			cylinder(h = 0.01, d = 51);
	}
}
module base2() {
	difference() {
		translate([0, 0, ((railD / 2) - 5)]) 
			cylinder(h = (height + (railD / 2)), d = ((puckD + (2 * wallThickness)) + 3), center = true);
		rotate([90, 0, 0]) 
			cylinder(h = 100, center = true, d = (railD + tolerance));
		translate([(-width / 2), 0, 1]) 
			cube([1000, 1000, 14+3.74*2], center = true);//14
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
	sequentialHull() {
		translate([0, 0, 0]) cylinder(d = (pinD + 1), h = 0.1);
		translate([0, 0, 1]) cylinder(d = pinD, h = 0.1);
		translate([0, 0, 3]) cylinder(d = pinD, h = 0.1);
		translate([0, 0, 5]) scale([1, 1.3, 1]) cylinder(d = pinTopD, h = 0.1);
		translate([0, 0, 6]) cylinder(d = (pinTopD - 1), h = 0.1);
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
    	for(i = [(-45 / 2) : 45 : (45 / 2)]) 
    		rotate([0, i, 0]) 
    			translate([0, (x * 10), 0]) 
    				cylinder(d = (smallMagnetD + tolerance), h = ((smallMagnetH + (railD / 2)) + (tolerance / 2)));
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
					cylinder(h = 100, center = true, d = (railD + tolerance));
			}
		}
		magnetCutouts();
	}
}
module rail() {
	rotate([90, 0, 0]) 
		cylinder(h = 300, center = true, d = railD);
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
