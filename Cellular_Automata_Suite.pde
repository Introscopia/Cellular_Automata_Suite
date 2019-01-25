/*
TO-DO
[✓] neighborhood widget buttons
   editor, clear, delete
[] nbhood list
   scrolling, transferring inputs, adding new ones, greek letters
[]States bar
[]rule bar
[]rule list

[]the actual algorythm

[] nbhood editor
   geometric tools, stamps, value slider, mirroring
   
[] mouse tools
*/

boolean running;
ArrayList<float[][]> neighborhoods;
IntList states;
PFont georgia_big;

void setup() {
  size( displayWidth, 705 );
  surface.setLocation(-3, -3);
  surface.setResizable(true);
  
  neighborhoods = new ArrayList();
  neighborhoods.add( new float[13][13] );
  neighborhoods.add( new float[5][5] );
  neighborhoods.add( new float[21][21] );
  
  ui_font = loadFont( "Georgia-16.vlw" );
  georgia_big = loadFont( "Georgia-23.vlw" );
  build_ui();
}

void draw() {
  if( running ){
    
  }
  else{
    ui.display();
  }
}
