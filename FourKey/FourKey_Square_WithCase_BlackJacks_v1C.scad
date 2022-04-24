
//The Belfry OpenSCAD Library
//https://github.com/revarbat/BOSL
include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>

$fn=60;


caseHeightZ = 18;

wallThickness = 4;
plateThickness=wallThickness+2;

lkey=19.05;//Unit square length, from Cherry MX data sheet
holesize=14; //Hole size, from Cherry MX data sheet
width=2; // number of switches wide
height=2; // number of switches deep
cutoutheight = 3; //height of switch clasp cutouts
cutoutwidth = 1; //width of switch clasp cutouts

//calculated
holediff=lkey-holesize;
w=width*lkey*1.0;
h=height*lkey*1.0;

caseWidthX = 52;
caseDepthY = 46;


overlap = 1; // overlap ensures that subtractions go beyond the edges


//MAIN 
difference(){
  union(){base();}
  //minus...
  keyHoles();
  jackHoles();
  split();
}

module base() {  
    difference(){
      //I'm using p1 setting to zero bottom (z). X/Y are centered on 0,0,0
      color("steelblue")
      cuboid([caseWidthX,caseDepthY,caseHeightZ], fillet=1, p1=[-3,-1,0]);
      //subtract out the inner cuboid
      cuboid([caseWidthX-wallThickness,caseDepthY-wallThickness,caseHeightZ-wallThickness-2], fillet=0, 
       p1=[(wallThickness/2)-3, (wallThickness/2)-1, (wallThickness/2)]);
    }//difference (base)
}


module keyHoles() {
  translate([6.5,7,15]) switchhole();
  translate([25.5,7,15]) switchhole();
  translate([6.5,26.5,15]) switchhole();
  translate([25.5,26.5,15]) switchhole();

}

module switchhole(){
	union(){
		cube([holesize,holesize,plateThickness]);
		translate([-cutoutwidth,1,0])
		cube([holesize+2*cutoutwidth,cutoutheight,plateThickness]);
		translate([-cutoutwidth,holesize-cutoutwidth-cutoutheight,0])
		cube([holesize+2*cutoutwidth,cutoutheight,plateThickness]);
	}
}

module jackHoles(){
  height=6;
  diam=8.2;
  //prepare to be confused. since we are xrot: back=Z, down=Y, right=X
  color("pink") xrot(90) back(7) right((1)+diam/2) down(2.5) cylinder(h=height, d=diam);
  color("pink") xrot(90) back(7) right((13)+diam/2) down(2.5) cylinder(h=height, d=diam);
  color("pink") xrot(90) back(7) right((25)+diam/2) down(2.5) cylinder(h=height, d=diam);
  color("pink") xrot(90) back(7) right((37)+diam/2) down(2.5) cylinder(h=height, d=diam);
}



module split(){

  splitAtZ=14;
  
  //remove the top for split
  //color("crimson")  translate([-10,-10,splitAtZ]) cube([caseWidthX+10, caseDepthY+10, caseHeightZ+overlap]);
  // ******* OR ******
  //Remove everything but the top
  color("crimson") translate([-10,-10,splitAtZ-caseHeightZ])  cube([caseWidthX+10, caseDepthY+10, caseHeightZ+overlap]);

  //-------------------------------------------------------------------------------------------------------
}//split 
