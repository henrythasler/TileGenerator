#peaks[zoom>=12] {
  marker-file: url(img/triangle.svg);
  marker-fill:black;
  marker-allow-overlap:true;
  marker-ignore-placement:true;
  [zoom >=12][zoom<13] {  
	marker-width:3;
  }  
  [zoom >=13][zoom<14] {  
	marker-width:5;
  }  
  [zoom >=14] {
	marker-width:6;
    [name != null]{
      [ele = null] {
      text-size: 9;
      text-character-spacing: 0.8;
      text-name:[name];
      text-face-name:@sans_bold_italic;
      text-placement:point;
      text-fill:@peak_text;
      text-halo-fill: @text_halo;
      text-halo-radius:1.5;  
      text-dy: 6; 
      }  
      [ele != null] {
      text-size: 9;
      text-character-spacing: 0.8;
      text-name:[name] + '\n' + [ele];
      text-face-name:@sans_bold_italic;
      text-placement:point;
      text-fill:@peak_text;
      text-halo-fill: @text_halo;
      text-halo-radius:1.5;  
      text-dy: 6;
      }  
    }  
  }  
}


#station[zoom>=12] {
  ::outer {
    marker-file: url(img/square.svg);
    marker-width:1;
    [zoom>=12][zoom<14] {marker-width:5;}
    [zoom>=14] {marker-width:7;}
    marker-fill:black;
    marker-allow-overlap:true;
    marker-ignore-placement:true;
  }  
  ::inner {
    marker-file: url(img/square.svg);
    marker-width:3;
    [zoom>=12][zoom<14] {marker-width:3;}
    [zoom>=14] {marker-width:5;}
    marker-fill:red;
    marker-allow-overlap:true;
    marker-ignore-placement:true;
  }  
  ::label[name != null][zoom>=12] {
    text-size: 8;
    [zoom>=13][zoom<14] {text-size:9;}
    [zoom>=14] {text-size:10;}
    text-character-spacing: 0.8;
    text-name:[name];
    text-face-name:@sans;
    text-placement:point;
    text-fill:@peak_text;
    text-halo-fill: @text_halo_strong;
    text-halo-radius:1.5;  
	text-wrap-width: 50;
    text-wrap-before: true;
    text-dy: 6; 
  }  
}
