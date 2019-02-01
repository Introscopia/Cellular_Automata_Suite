/*
TO-DO
[ ] neighborhood widget 
  [✓] buttons (editor, clear, delete)
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
[ ]rule widget
  [ ] right-side buttons, stacked vertically ( X, ^, v ) (move up and down)
  [ ] ELSE widget
[ ]rule list
  [✓] adding
  * Dragging widgets ?
    [ ] drag into trashcan to delete
    [ ] change order
  [ ] handling very large neighborhoods
  
[] nbhood editor
   geometric tools, stamps, value slider, mirroring
   
[] playing field size controls

[]the actual algorythm

[] running UI:
  [] back
  [] screenshot
  [] mouse tools (paint brushes)
  [] random fills
  [] speed controls
  [] pattern saving / loading
*/

ArrayList<Neighborhood> neighborhoods;
ArrayList<Rule> rules;
IntList states;
PFont georgia_big, arial;

PImage A, B;
boolean turn;
float zoom;
int sx, sy;

boolean bake;
HashMap<Integer,Integer> statemap;
//boolean[][] applicable_nbhs;
int[] duplicate_searches;

String[] loaded;
boolean load_sync;

void setup() {
  size( displayWidth, 705 );
  surface.setLocation(-3, -3);
  surface.setResizable(true);
  noSmooth();
  //frameRate(30);
  
  neighborhoods = new ArrayList();
  //neighborhoods.add( new Neighborhood( 1 ) );
  rules = new ArrayList();
  //rules.add( new Rule( 0, neighborhoods, 0, 0, 1 ) );
  states = new IntList();
  //states.append( color(255) );
  //states.append( color( 0 ) );

  ui_font = loadFont( "Georgia-16.vlw" );
  georgia_big = loadFont( "Georgia-23.vlw" );
  arial = loadFont( "ArialMT-24.vlw" );
  
  A = createImage( 500, 300, ARGB );
  B = createImage( 500, 300, ARGB );
  for (int i = 0; i < A.pixels.length; i++) {
    A.pixels[i] = color(0);
    B.pixels[i] = (random(10)>6)? color(255) : color(0);
  }
  
  zoom = 2.0;
  sx = round( 0.5* (width - (zoom * A.width) ) );
  sy = 70;
  turn = true;
  
  build_ui();
  
  loaded = loadStrings( "Conway's Game of Life.txt" );
  load();
}

void draw() {
  if( run.b ){
    if( bake ){
      statemap = new HashMap<Integer,Integer>();
      for(int i = 0; i < states.size(); ++i ) statemap.put( states.get(i), i );
      
      duplicate_searches = new int[ rules.size() ];
      for(int k = 0; k < rules.size(); ++k ){
        duplicate_searches[ k ] = -1;
        for(int l = 0; l < k; ++l ){
          if( rules.get(k).neighborhood == rules.get(l).neighborhood &&
              rules.get(k).target_state == rules.get(l).target_state &&
              rules.get(k).count_state  == rules.get(l).count_state ){
                
            duplicate_searches[ k ] = l;
          }              
        }
      }
      bake = false;
    }
    background(240);
    
    translate( sx, sy );
    scale( zoom );
    if( turn ){
      run_algorythm( B, A, neighborhoods, rules, states );
      image( A, 0, 0 );
    }
    else{
      run_algorythm( A, B, neighborhoods, rules, states );
      image( B, 0, 0 );
    }
    turn = !turn;
  }
  else{
    background(240);
    ui.display();
    if( add_neigh.b ){
      neighborhoods.add( new Neighborhood( neigh_radius.n ) );
      ui.set[0].add( neighborhoods.get(neighborhoods.size()-1).hood );
      add_neigh.b = false;
    }
    if( del_neigh.n >= 0 ){
      neighborhoods.remove( del_neigh.n );
      del_neigh.n = -1;
    }
    if( add_rule.b ){
      rules.add( new Rule( 0, neighborhoods, 0, 0, 0 ) );
      ui.set[1].add( rules.get(rules.size()-1), neighborhoods, states );
      add_rule.b = false;
    }
    if( add_else_rule.b ){
      rules.add( new Rule( 0, 1 ) );
      ui.set[1].add( rules.get(rules.size()-1), neighborhoods, states );
      add_else_rule.b = false;
    }
    
    if( save.b ){
      StringList out = new StringList();
      String line = "";
      for( int i = 0; i < states.size(); ++i ){
        line += hex( states.get(i) );
        if( i < states.size()-1 ) line += " ";
      }
      out.append( line );
      out.append( "" );
      
      for( int i = 0; i < rules.size(); ++i ){
        line = "";
        //Rule( int n, ArrayList<Neighborhood> N, int ts, int cs, int rs, String r )
        line += rules.get(i).neighborhood + " " +
                rules.get(i).target_state + " " +
                rules.get(i).count_state + " " +
                rules.get(i).resulting_state + " ";
        for( int k = 0; k < rules.get(i).range.length; ++k ) line += rules.get(i).range[k]? "1" : "0";
        out.append( line );
      }
      out.append( "" );
      
      for( int i = 0; i < neighborhoods.size(); ++i ){
        for( int j = 0; j < neighborhoods.get(i).hood.length; ++j ){
          line = "";
          for( int k = 0; k < neighborhoods.get(i).hood.length; ++k ){
            line += neighborhoods.get(i).hood[k][j];
            if( k < neighborhoods.get(i).hood.length-1 ) line += " ";
          }
          out.append( line );
        }
      }
      
      saveStrings( "Cellular Automata "+year()+"-"+month()+"-"+day()+" "
                   +nf( hour(), 2 )+"."+nf( minute(), 2 )+"."+nf(second(), 2)+".txt",
                   out.array() );
      
      save.b = false;
    }
    
    if( load.b ){
      load_sync = true;
      selectInput("Load Cellular Automata", "callback");
      while( load_sync ){
        print(".");// this line is actually necessary for some reason?
      }
      if( loaded != null ){
        load();
      }
      loaded = null;
      load.b = false;
    }
    bake = true;
  }
}

void callback(File selection) {
  loaded = loadStrings( selection.getAbsolutePath() );
  load_sync = false;
}

void load(){
  int step = 0;
  states = new IntList();
  rules = new ArrayList();
  neighborhoods = new ArrayList();
  String[] s;
  for( int i = 0; i < loaded.length; ++i ){
    
    if( loaded[i].length() == 0 ){
      ++i;
      ++step;
    }
    
    switch( step ){
      case 0:
        s = split( loaded[i], ' ' );
        for( int j = 0; j < s.length; ++j ){
          states.append( unhex( s[j] ) );
        }
        break;
      case 1:
        s = split( loaded[i], ' ' );
        if( s.length == 5 ){
          rules.add( new Rule( int(s[0]), int(s[1]), int(s[2]), int(s[3]), s[4] ) );
        }
        break;
      case 2:
        s = split( loaded[i], ' ' );
        int n = s.length;
        int q = neighborhoods.size();
        neighborhoods.add( new Neighborhood( (n-1)/2 ) );
        for( int j = 0; j < n; ++j ){
          for( int k = 0; k < s.length; ++k ){
            neighborhoods.get(q).hood[k][j] = float( s[k] );
          }
          if( j < n-1 ){
            ++i;
            s = split( loaded[i], ' ' );
          }
        }
        neighborhoods.get(q).count = cell_count( neighborhoods.get(q).hood );
        break;
    }
  }
  build_ui();
  for( int i = 0; i < neighborhoods.size(); ++i ){
    ui.set[0].add( neighborhoods.get(i).hood );
  }
  for( int i = 0; i < rules.size(); ++i ){
    ui.set[1].add( rules.get(i), neighborhoods, states );
  }
}

class Neighborhood{
  float[][] hood;
  int count, radius;
  Neighborhood( int r ){
    hood = new float[(2 * r) +1][(2 * r) +1];
    count = 0;
    radius = r;
  }
}

class Rule{
  int neighborhood, target_state, count_state, resulting_state;
  boolean[] range;
  boolean ELSE;
  Rule( int n, ArrayList<Neighborhood> N, int ts, int cs, int rs ){
    neighborhood = n;
    range = new boolean[ cell_count( N.get(n).hood ) + 1 ] ;
    target_state = ts;
    count_state = cs;
    resulting_state = rs;
    ELSE = false;
  }
  Rule( int n, int ts, int cs, int rs, String r ){
    neighborhood = n;
    target_state = ts;
    count_state = cs;
    resulting_state = rs;
    range = new boolean[ r.length() ] ;
    for(int j = 0; j < r.length(); j++){
      range[j] = (r.charAt(j) == '1')? true : false;
    }
    ELSE = false;
  }
  Rule( int ts, int rs ){
    target_state = ts;
    resulting_state = rs;
    ELSE = true;
  }
  void print_ln(){
    println( "neighborhood:", neighborhood, "target_state:", target_state, "count_state:", count_state, "resulting_state:", resulting_state );
    for(int i = 0; i < range.length; ++i ) print( range[i]+", " );
    println();
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

void run_algorythm( PImage old, PImage neo, ArrayList<Neighborhood> neighborhoods, ArrayList<Rule> rules, IntList states ){
  //neo = old.copy();
  old.loadPixels();
  neo.loadPixels();
  for( int i = 0; i < old.pixels.length; ++i ){
    neo.pixels[ i ] = old.pixels[ i ] ;
    float[] counts = new float[ rules.size() ];
    int target = statemap.get( old.pixels[i] );
    
    for(int j = 0; j < rules.size(); ++j ){
      //rules.get(j).print_ln();
      if( target == rules.get(j).target_state ){
        int N = rules.get(j).neighborhood;
        
        if( duplicate_searches[j] >= 0 ){
          counts[j] = counts[ duplicate_searches[j] ];
        }
        else{
          int Y = floor( i / float(old.width) );
          int X = i - old.width*Y;
          int xs = ( X < neighborhoods.get(N).radius )? 0 : X - neighborhoods.get(N).radius;
          int xe = ( X >= old.width - neighborhoods.get(N).radius )? old.width-1 : X + neighborhoods.get(N).radius;
          int ys = ( Y < neighborhoods.get(N).radius )? 0 : Y - neighborhoods.get(N).radius;
          int ye = ( Y >= old.height - neighborhoods.get(N).radius )? old.height-1 : Y + neighborhoods.get(N).radius;
          
          counts[j] = 0;
          for( int x = xs; x <= xe; ++x ){
            for( int y = ys; y <= ye; ++y ){
              int S = statemap.get( old.pixels[ (old.width * y) + x ] );
              int hoodX = x -X +neighborhoods.get(N).radius;
              int hoodY = y -Y +neighborhoods.get(N).radius;
              counts[j] += neighborhoods.get(N).hood[ hoodX ][ hoodY ] * (( S == rules.get(j).count_state )? 1 : 0 );
            }
          }
        }
        if( rules.get(j).range[ floor( counts[j] ) ] ){
          neo.pixels[ i ] = states.get( rules.get(j).resulting_state );
        }
      }
    }
  }
  neo.updatePixels();
}
