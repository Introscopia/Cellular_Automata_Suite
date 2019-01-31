/*
TO-DO
[✓] neighborhood widget buttons (editor, clear, delete)
  [ ] handling very large radii
[✓] nbhood list
   [✓] scrolling, transferring inputs, greek letters
   [✓] adding new ones
   [✓] deleting
[ ]States bar
  [ ] adding
  [ ] deleting
  [ ] type in number of states
  [ ] auto-grayscale
  [ ] color editor
  [ ] horizontal scrollbar
[✓]rule widget
  [ ] right-side buttons, stacked vertically ( X, ^, v ) (move up and down)
[✓]rule list
  [✓] adding new ones
  * Dragging widgets ?
    [ ] drag into trashcan to delete
    [ ] change order
  [ ] handling very large neighborhoods
  
[] nbhood editor
   geometric tools, stamps, value slider, mirroring
   
[] playing field size controls

[]the actual algorythm

[] mouse tools (paint brushes)
[] random fills
[] pattern saving / loading
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
  rules = new ArrayList();
  rules.add( new Rule( 0, neighborhoods, 0, 0, 1 ) );
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
    // mostrar o CA propriamente dito
  }
  else{
    background(240);
    ui.display();
    if( add_neigh.b ){
      neighborhoods.add( new float[(2 * neigh_radius.n) +1][(2 * neigh_radius.n) +1] );
      ui.set[0].add( neighborhoods.get(neighborhoods.size()-1) );
      nbh_counts.append( 0 );
      add_neigh.b = false;
    }
    if( del_neigh.n >= 0 ){
      neighborhoods.remove( del_neigh.n );
      nbh_counts.remove( del_neigh.n );
      del_neigh.n = -1;
    }
    if( add_rule.b ){
      rules.add( new Rule( 0, neighborhoods, 0, 0, 1 ) );
      ui.set[1].add( rules.get(rules.size()-1), neighborhoods, states );
      add_rule.b = false;
    }
    if( add_else_rule.b ){
      rules.add( new Rule( 0, 1 ) );
      ui.set[1].add( rules.get(rules.size()-1), neighborhoods, states );
      add_else_rule.b = false;
    }
  }
}

class Rule{
  int neighborhood, target_state, count_state, resulting_state;
  boolean[] range;
  boolean ELSE;
  Rule( int n, ArrayList<float[][]> N, int ts, int cs, int rs ){
    neighborhood = n;
    range = new boolean[ cell_count( N.get(n) ) ] ;
    target_state = ts;
    count_state = cs;
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
