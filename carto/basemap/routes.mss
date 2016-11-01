#shiproute[zoom>=11] {
  line-width:1;
  line-color:@shiproute;
  line-dasharray: 4,4;
  [zoom>=12][zoom<13] { line-width:1.2;line-dasharray: 6,6; }
  [zoom>=13][zoom<14] { line-width:1.4;line-dasharray: 8,8; }
  [zoom>=14][zoom<15] { line-width:1.6;line-dasharray: 10,10; }
  [zoom>=15] { line-width:2;line-dasharray: 12,12; }
}

#piste[zoom>=16] {
  line-smooth: 1;
  line-width:6;
  line-opacity: 0.5;
  line-cap: round;
  line-join: round;
  line-color:black;
  [difficulty=1] { line-color:red; }
  [difficulty=2] { line-color:blue; }
}

#cycleroute[zoom>=13] {
  line-width:8;
  line-color:blue;
  line-opacity: 0.25;
  line-cap: round;
  line-join: round;
  [zoom>=14][zoom<15] { line-opacity: 0.2; line-width:12; }
  [zoom>=15][zoom<16] { line-opacity: 0.15; line-width:18; }
  [zoom>=16] { line-opacity: 0.15; line-width:24; }
}

#subway[zoom>=16]{
    line-width: 9;
    line-opacity: 0.75;
    line-color: @subway;
}

#tram[zoom>=16]{
  line-width: 3;
  [zoom>=17] {line-width: 4;}
  line-color: red;
}
