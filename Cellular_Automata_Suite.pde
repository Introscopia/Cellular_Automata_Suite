/*
TO-DO
[✓] neighborhood widget buttons
   editor, clear, delete
[✓] nbhood list
   scrolling, transferring inputs, greek letters
   [✓] adding new ones
   [✓] deleting
[]States bar
[]rule bar
[]rule list

[]the actual algorythm

[] nbhood editor
   geometric tools, stamps, value slider, mirroring
   
[] mouse tools
*/

ArrayList<float[][]> neighborhoods;
IntList nbh_counts;
ArrayList<Rule> rules;
IntList states;
PFont georgia_big, arial;

void setup() {
  size( displayWidth, 705 );
  surface.setLocation(-3, -3);
  surface.setResizable(true);
  
  neighborhoods = new ArrayList();
  neighborhoods.add( new float[5][5] );
  nbh_counts = new IntList();
  nbh_counts.append( 0 );
  states = new IntList();
  states.append( color(255) );
  states.append( color( 0 ) );
  
  ui_font = loadFont( "Georgia-16.vlw" );
  georgia_big = loadFont( "Georgia-23.vlw" );
  arial = loadFont( "ArialMT-24.vlw" );
  build_ui();
}

void draw() {
  if( run.b ){
    background(240);
  }
  else{
    background(240);
    ui.display();
    if( add_neigh.b ){
      neighborhoods.add( new float[(2 * neigh_radius.n) +1][(2 * neigh_radius.n) +1] );
      ui.set[0].add( neighborhoods.get(neighborhoods.size()-1) );
      add_neigh.b = false;
    }
    if( del_neigh.n >= 0 ){
      neighborhoods.remove( del_neigh.n );
      del_neigh.n = -1;
    }
  }
}

class Rule{
  int neighborhood, target_state, resulting_state;
  boolean[] range;
  boolean ELSE;
  Rule( int n, ArrayList<float[][]> N, int ts, int rs ){
    neighborhood = n;
    range = new boolean[ cell_count( N.get(n) ) ] ;
    target_state = ts;
    resulting_state = rs;
    ELSE = false;
  }
  Rule( int ts, int rs ){
    target_state = ts;
    resulting_state = rs;
    ELSE = true;
  }
}

int cell_count( float[][] N ){
  int c = 0;
  for(int i=0; i < N.length; i++){
    for(int j=0; j < N[0].length; j++){
      if( N[i][j] > 0 ) c += 1;
    }
  }
  return c;
}
