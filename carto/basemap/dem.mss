#global_relief[zoom<8] {
  raster-opacity: 1;
  raster-scaling: bilinear;
}

#hillshading[zoom>=8]{
  raster-opacity: 0.6;
  raster-scaling: bilinear;
  raster-comp-op: multiply;
}
