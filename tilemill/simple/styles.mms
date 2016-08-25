#land{
  polygon-fill:@land;
}

#admin_global[zoom>=1][zoom<=8],
#admin_local[zoom>=9]{
  line-join: round;  
  line-cap: round;
  line-width: 0.5;
  line-opacity: 0.6;
  line-color:@admin;
  [zoom>=2][zoom<4] {line-width: 1;}
  [zoom>=4][zoom<6] {line-width: 1.5;}
  [zoom>=6][zoom<8] {line-width: 2;}
  [zoom>=8] {line-width: 3;}
//  line-dasharray: 18, 18;  
}