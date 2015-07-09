#hillshading[zoom>=8] {
  raster-opacity:0.5;
  raster-scaling:bilinear;
  raster-comp-op:multiply;
}

#global_relief[zoom<8] {
  raster-opacity:1;
  raster-scaling:bilinear;
//  [zoom=7] {raster-opacity:0.3;}
}

#bathymetry[zoom<10] {
  raster-scaling:bilinear;
  raster-opacity:1;
//  raster-comp-op:multiply;
}

#contour[zoom>=13][zoom<15] {
  line-smooth:1.0;
  line-width:0.5;
  line-opacity: 0.25;  
  line-color:@contour;
  [elev =~ ".*00"] {
    line-opacity: 0.5;  
    
    text-size: 9;
  	text-name:'[elev]';
  	text-face-name:@sans;
  	text-placement:line;
  	text-fill:@contour_text;
  	text-halo-fill: @text_halo_weak;
  	text-halo-radius:1.5;
    
  } 
}

/*
#contour_label[zoom>=13][zoom<15] {
  [elev =~ ".*00"] {
    text-size: 9;
  	text-name:'[elev]';
  	text-face-name:@sans;
  	text-placement:line;
  	text-fill:@contour_text;
  	text-halo-fill: @text_halo_weak;
  	text-halo-radius:1.5;
  } 
}
*/
#contourhigh[zoom>=15] {
  line-smooth:1.0;
  line-width:0.5;
  line-opacity: 0.25;  
  line-color:@contour;
  [elev =~ ".*00"] {
    line-opacity: 0.5;  
    text-size: 9;
  	text-name:'[elev]';
  	text-face-name:@sans;
  	text-placement:line;
  	text-fill:@contour_text;
  	text-halo-fill: @text_halo_weak;
  	text-halo-radius:1.5;
  }
}

#ne10mgeographiclines[zoom>=2][zoom<=7] {
  line-width:0.8;
  line-color:@darkgrey;
  line-dasharray: 8, 8;  

  text-size: 11;
  [zoom>=2][zoom<=3] {text-size: 8;}
  [zoom>=4][zoom<=5] {text-size: 9;}
  [zoom=6] {text-size: 10;}
  text-character-spacing: 0.8;
  text-name:'[name]';
  text-face-name:@sans_italic;
  text-placement:line;
  text-fill:@peak_text;
  text-halo-fill: @text_halo_weak;
  text-halo-radius:1.5;
  text-dy: 7;
}


