#buildings[zoom>=14] {
  line-width: 0;
  polygon-opacity: 1;
  polygon-fill: @darkgrey;
}

#residental[zoom>=10] {
  polygon-fill:@grey;
  polygon-opacity: 0;
  [zoom>=10][zoom<14]{
  	polygon-opacity:1;
  }  
  [zoom>=14][zoom<15]{
    polygon-opacity:0.55;
  }  
  [zoom>=15] {
    polygon-opacity:0.5;
  }
}

#industrial[zoom>=10] {
  polygon-fill: @industrial;
  polygon-opacity: 1;
}
