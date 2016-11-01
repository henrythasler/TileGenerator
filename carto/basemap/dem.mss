#global_relief[zoom<8] {
  raster-opacity: 1;
  raster-scaling: bilinear;
}

#hillshading[zoom>=8]{
  raster-opacity: 0.6;
  raster-scaling: bilinear;
  raster-comp-op: multiply;
}

#contours_low[zoom=14]{
  line-smooth: 1;
  line-width: 1;
  line-opacity: 0.25;
  line-color:@contour;
  [ele =~ ".*00"] {
    line-opacity: 0.5;
  }
  [ele =~ ".*500"],[ele =~ ".*000"] {
    text-size: 18;
    text-name:'[ele]';
    text-face-name: @sans;
    text-placement: line;
    text-spacing: 400;
    text-fill:@contour_text;
    text-halo-fill: @text_halo_weak;
    text-halo-radius: 3;
  }
}

#contours_high[zoom>=16],
#contours_med[zoom=15]{
  line-smooth: 1;
  line-width: 1;
  line-opacity: 0.25;
  line-color:@contour;
  [ele =~ ".*00"] {
    line-opacity: 0.5;
    text-size: 18;
    text-name:'[ele]';
    text-face-name:@sans;
    text-placement:line;
    text-spacing: 800;
    [zoom>=16] {text-spacing: 600;}
    text-fill:@contour_text;
    text-halo-fill: @text_halo_weak;
    text-halo-radius: 3;
  }
}
