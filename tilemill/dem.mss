#hillshading {
  raster-opacity:0.5;
  raster-scaling:bilinear;
  raster-comp-op:multiply;
}

#contour[zoom>=13][zoom<15] {
  line-smooth:1.0;
  line-width:0.5;
  line-opacity: 0.25;  
  line-color:@contour;
  
  [elev =~ ".*00"][zoom >=14] {
    line-opacity: 0.5;  
    text-size: 9;
  	text-name:'[elev]';
  	text-face-name:@sans;
  	text-placement:line;
  	text-fill:@contour_text;
  	text-halo-fill: fadeout(white, 80%);
  	text-halo-radius:1.5;
  }
  
}


#contourhigh[zoom>=15] {
  line-smooth:1.0;
  line-width:0.5;
  line-opacity: 0.25;  
  line-color:@contour;
  [elev =~ ".*00"][zoom >=14] {
    line-opacity: 0.5;  
    text-size: 9;
  	text-name:'[elev]';
  	text-face-name:@sans;
  	text-placement:line;
  	text-fill:@contour_text;
  	text-halo-fill: fadeout(white, 80%);
  	text-halo-radius:1.5;
  }
}
