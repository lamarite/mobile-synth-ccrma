include <../lib/iPhone5.scad>

difference () {
difference () {
hull(){
scale([.4,1,1])difference() {
    sphere(r=61.9, $fn=100);
    translate([0,-56.5,0])
   //rotate(90,0,0) 
    cube([150,150,150],center=true);
}



//rotate ([90, 0, 0])
translate([-iPhone5_Width/2,10,-iPhone5_Height/2]) 
iPhone5();

}
 //thumbhole
    rotate([0,90,0])
    translate([0,33,-19])
    cylinder(h=50,r=11, center = true);
}

//drumpads
   translate([95,105,0])
   sphere(r=105, $fn=50);
        rotate([-39,90,0])
        translate([0,25,60])
        cylinder(h=50,r=10, center = true);
    
    translate([0,95,120])
    sphere(r=100, $fn=50); 
        rotate([0,-39,-90])
        translate([0,0,78])
        cylinder(h=50,r=10, center = true);
  

    translate([0,95,-120])
    sphere(r=100, $fn=50);
        rotate([0,39,-90])
        translate([0,0,-78])
        cylinder(h=50,r=10, center = true);
//cavity
        
   translate([0,20,37])
    rotate([45,0,0])
   cube([35,16,40],center=true);

//Small holes   
    translate ([0,35,60])
    rotate([-45,0,0])
    scale ([1.1,.2,1])
    #cylinder(r=5, h=40, center= true);
  
    translate ([0,20,-10])
    rotate([10,0,0])
    scale ([1.1,.2,1])
    #cylinder(r=5, h=100, center= true);
    
    translate ([30,42,0])
    rotate([90,90,-45])
    scale ([1.1,.2,1])
    #cylinder(r=5, h=40, center= true);
    
    
}


  



