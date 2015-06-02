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



