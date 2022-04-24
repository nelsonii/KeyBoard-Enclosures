
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

caseWidthX = 64;
caseDepthY = 42;


overlap = 1; // overlap ensures that subtractions go beyond the edges


//MAIN 
difference(){
  union(){
    base();
    ProMicro();
    }
  //minus...
  ProMicro_Cutout();
  NeoPixel_Cutout();
  keyHoles();
  split();
}

module base() {  
    difference(){
      //I'm using p1 setting to zero bottom (z). X/Y are centered on 0,0,0
      color("steelblue")
      cuboid([caseWidthX,caseDepthY,caseHeightZ], fillet=1, p1=[0,0,0]);
      //subtract out the inner cuboid
      cuboid([caseWidthX-wallThickness,caseDepthY-wallThickness,caseHeightZ-wallThickness-2], fillet=0, 
       p1=[(wallThickness/2), (wallThickness/2), (wallThickness/2)]);
    }//difference (base)
}


module keyHoles() {
  translate([6,14.5,13]) switchhole(); //left
  translate([44,14.5,13]) switchhole(); //right
  translate([25,23.5,13]) switchhole(); //top
  translate([25,4.5,13]) switchhole(); //bottom

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


module ProMicro() {
  //riser for ProMicro
    color("teal") translate([(caseWidthX/2)-6, 2, 1]) cube([12,33.5,2.5]);
  //bumper for ProMicro
  color("CadetBlue") translate([(caseWidthX/2)-6, 35.5, 1]) cube([12, 2, 5]);
}

module ProMicro_Cutout() {
      //ProMicro USB -- 1.65 is thickness of the  pcb
    color("peru") translate([(caseWidthX/2)-4, -1, 4+1.65]) cube([8,8,3]); 
}

module NeoPixel_Cutout() {
    color("peru") translate([(caseWidthX/2)-2.5, caseDepthY-3, 3+1.65]) cube([5,5,5]); 
 
}


module split(){

  splitAtZ=13;
  
  //remove the top for split
  color("crimson")  translate([-10,-10,splitAtZ]) cube([caseWidthX+20, caseDepthY+20, caseHeightZ+overlap]);
  // ******* OR ******
  //Remove everything but the top
  //color("crimson") translate([-10,-10,splitAtZ-caseHeightZ])  cube([caseWidthX+20, caseDepthY+20, caseHeightZ+overlap]);

  //-------------------------------------------------------------------------------------------------------
}//split 
