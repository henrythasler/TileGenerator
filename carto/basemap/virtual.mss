#residental[zoom>=11] {
  polygon-fill:@grey;
  polygon-opacity: 0;
  [zoom>=11][zoom<15] { polygon-opacity:1; }
  [zoom>=15] { polygon-opacity:0.5; }
}

#industrial[zoom>=11] {
  polygon-fill: @industrial;
  polygon-opacity: 1;
}

#military[zoom>=9][zoom<11][area>=2000000],
#military[zoom>=11][zoom<13][area>=500000],
#military[zoom>=13][zoom<15][area>=5000],
#military[zoom>=15]
{
  polygon-pattern-file:url(img/stripes-red.png);
  polygon-pattern-opacity: 0.2;
  line-width: 0.4;
  line-color: red;
}

#nature_reserve[zoom>=9][zoom<11][area>=80000000],
#nature_reserve[zoom>=11][zoom<13][area>=20000000],
#nature_reserve[zoom>=13][zoom<14][area>=200000],
#nature_reserve[zoom>=14][zoom<15][area>=50000],
#nature_reserve[zoom>=15]
{
  ::outer {
    line-width: 4;
    line-opacity: 0.6;
    line-color: green;
    line-cap: round;
    line-join: round;
    [zoom<=10] {
      line-width: 2;
      }
    }
  ::inner {
    line-width: 16;
    line-offset: -6;
    line-opacity: 0.3;
    line-color: green;
    line-cap: round;
    line-join: round;
    [zoom<=10] {
      line-width: 8;
      line-offset: -2;
      }
    [zoom=11] {
      line-width: 12;
      line-offset: -4;
      }
    }
}

#admin_claim[zoom>=6][zoom<8]{
  line-width: 2;
  line-color: @admin;
  line-dasharray: 4, 4;
}

#admin_global[zoom>=2][zoom<8],
#admin2[zoom>=8]{
  line-join: round;
  line-cap: round;
  line-width: 1;
  line-opacity: 0.6;
  #admin2{line-opacity: 0.3;}
  line-color:@admin;
  [zoom>=3][zoom<5] {line-width: 2;}
  [zoom>=5][zoom<7] {line-width: 3;}
  [zoom>=7][zoom<9] {line-width: 4;}
  [zoom>=9] {line-width: 6;}
}


#admin4[zoom>=6]{
  line-join: round;
  line-cap: round;
  line-width: 2;
  [zoom>=9][zoom<11] {line-width: 4;}
  [zoom>=11] {line-width: 6;}
  line-opacity: 0.3;
  line-color:@admin;
/*
  text-size: 18;
  text-character-spacing: 1.6;
  text-name:'[name]';
  text-face-name:@sans_italic;
  text-placement:line;
  text-fill:@peak_text;
  text-halo-fill: @text_halo_weak;
  text-halo-radius:3;
  text-dy: 0;
*/
}


/*
#countries[zoom<8]{
  [MAPCOLOR7=1]{polygon-fill:@mapcolor1;}
  [MAPCOLOR7=2]{polygon-fill:@mapcolor2;}
  [MAPCOLOR7=3]{polygon-fill:@mapcolor3;}
  [MAPCOLOR7=4]{polygon-fill:@mapcolor4;}
  [MAPCOLOR7=5]{polygon-fill:@mapcolor5;}
  [MAPCOLOR7=6]{polygon-fill:@mapcolor6;}
  [MAPCOLOR7=7]{polygon-fill:@mapcolor7;}
  polygon-opacity: 1;
}
*/

#ne10mgeographiclines[zoom>=2][zoom<9] {
  line-width:1.6;
  line-color:@darkgrey;
  line-dasharray: 16, 16;

  text-size: 22;
  [zoom>=2][zoom<3] {text-size: 14;}
  [zoom>=3][zoom<5] {text-size: 16;}
  [zoom>=5][zoom<7] {text-size: 18;}
  [zoom=7] {text-size: 20;}
  text-character-spacing: 1.6;
  text-name:'[name]';
  text-face-name:@sans_italic;
  text-placement:line;
  text-fill:@peak_text;
  text-halo-fill: @text_halo_weak;
  text-halo-radius:3;
  text-dy: -7;
}
