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
  [✓] adding
  [✓] deleting
  [ ] type in number of states
  [✓] auto-grayscale
  [ ] color editor
  [ ] horizontal scrollbar
[ ]rule widget
  [✓] right-side buttons, stacked vertically ( X, ^, v ) (move up and down)
  [✓] dragging on the range doesn't leave gaps.
  [ ] ELSE widget
[ ]rule list
  [✓] adding
  [ ] handling very large neighborhoods
  
[] nbhood editor
   geometric tools, stamps, value slider, mirroring
   
[] playing field size controls

[✓]the actual algorythm
  [] list of neighbors to check instead of the grid with values
  [] multithreading

[] visual confirmation that the save has completed.

[] running UI:
  [✓] back
  [✓] screenshot
  [✓] mouse tools (paint brushes)
    [] different brush sizes
  [✓] random fills
  [✓] play/pause
  [] speed controls
  [] pattern saving / loading
  [✓] zoom and drag
*/

ArrayList<Neighborhood> neighborhoods;
ArrayList<Rule> rules;
IntList states;
PFont georgia_big, arial;

PImage A, B;
boolean turn;
float zoom, zI;
int sx, sy;
float tx, ty;

boolean bake;
HashMap<Integer,Integer> statemap;
//boolean[][] applicable_nbhs;
int[] duplicate_searches;

String[] loaded;
boolean load_sync;

char moment = 'c';
boolean paused_turn;

void setup() {
  size( displayWidth, 705 );
  surface.setLocation(-3, -3);
  surface.setResizable(true);
  noSmooth();
  strokeCap(SQUARE);
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
  turn = true;
  paused_turn = false;

  zoom = 2.0;
  zI = 7.27254089;
  sx = round( 0.5* (width - (zoom * A.width) ) );
  sy = 80;
  
  //build_ui(); // load rebuilds the ui.
  
  loaded = loadStrings( "Conway's Game of Life.txt" );
  load();
  loaded = null;
}

void draw() {
  
  switch( moment ){
    case 'o'://-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*- "OBSERVE" screen -*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
      background(240);
      
      observe.display();
      fill(0);
      text( "FPS: "+nf(frameRate, 1, 1 ), 4, height-30 );
      
      if( play.changed() ){
        if( !play.b ){
          if( paused_turn ) A.loadPixels();
          else B.loadPixels();
          paused_turn = turn;
          turn = !turn;
        }
        else{
          turn = !paused_turn;
        }
        play.set();
      }
      
      clip( sx, sy, 1000, 600 );
      translate( sx + tx, sy +ty );
      scale( zoom );
      
      if( play.b ){
        if( turn ){
          run_algorythm( B, A, neighborhoods, rules, states );
          image( A, 0, 0 );
          if( PrtSc.b ){
            A.save("Cellular Automata "+now()+".png");
            PrtSc.b = false;
          }
        }
        else{
          run_algorythm( A, B, neighborhoods, rules, states );
          image( B, 0, 0 );
          if( PrtSc.b ){
            B.save("Cellular Automata "+now()+".png");
            PrtSc.b = false;
          }
        }
      }
      else{
        if( paused_turn ){
          image( A, 0, 0 );
          if( PrtSc.b ){
            A.save("Cellular Automata "+now()+".png");
            PrtSc.b = false;
          }
        }
        else{
          image( B, 0, 0 );
          if( PrtSc.b ){
            B.save("Cellular Automata "+now()+".png");
            PrtSc.b = false;
          }
        }
      }
      noClip();
      turn = !turn;
      
      if( fill.b ){
        B.loadPixels();
        for (int i = 0; i < B.pixels.length; i++) {
          B.pixels[i] = ( random(10) > fill_ratio.n )? states.get(0) : states.get(states.size()-1);
        }
        if( play.b ) turn = true;
        else paused_turn = false;
        
        B.updatePixels();
        fill.b = false;
      }
      
      if( run.b ){
        moment = 'c';
        run.b = false;
      }
      break;
      
    case 'c'://-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*- "CREATE" screen -*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
      background(240);
      create.display();
      
      if( add_state.b ){
        if( gradient.b ){
          states.append( gradient_b.p );
          float q = 1 / float(states.size());
          states.set( 0, gradient_a.p );
          for( int i = 1; i < states.size()-1; ++i ){
            states.set( i, lerpColor( gradient_a.p, gradient_b.p, i*q ) );
          }
        }
        create.set[2].update();
        add_state.b = false;
      }
      if( del_state.n >= 0 ){
        states.remove( del_state.n );
        create.set[1].update();
        create.set[2].update();
        del_state.n = -1;
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
        
        saveStrings( "data\\Cellular Automata "+now()+".txt",
                     out.array() );
        
        save.b = false;
      }
      
      if( load.b ){
        load_sync = true;
        selectInput("Load Cellular Automata", "callback");
        while( load_sync ){
          print(" ");// this line is actually necessary for some reason?
        }
        if( loaded != null ){
          load();
        }
        loaded = null;
        load.b = false;
      }
      
      if( run.b ){
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
        
        for(int i = 0; i < neighborhoods.size(); ++i ){
          neighborhoods.get(i).bake_lists();
        }
        
        for (int i = 0; i < A.pixels.length; i++) {
          A.pixels[i] = states.get(0);
          B.pixels[i] = states.get(0);
        }
        
        run.b = false;
        moment = 'o';
        if( states.size() == 0 || neighborhoods.size() == 0 || rules.size() == 0 ) moment = 'c';
      }
      break;
  }
}

String now(){
  return year()+"-"+month()+"-"+day()+" "+nf( hour(), 2 )+"."+nf( minute(), 2 )+"."+nf(second(), 2);
}

void callback(File selection) {
  if( selection != null ) loaded = loadStrings( selection.getAbsolutePath() );
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
}

class Neighborhood{
  float[][] hood;
  int count, radius;
  
  short[] x_list, y_list;
  short[][][] sectors;
  //short[] tl_list, t_list, tr_list, r_list, br_list, b_list, bl_list, l_list;
  //short[] ntl_list, nt_list, ntr_list, nr_list, nbr_list, nb_list, nbl_list, nl_list;
  Neighborhood( int r ){
    hood = new float[(2 * r) +1][(2 * r) +1];
    count = 0;
    radius = r;
  }
  void bake_lists(){
    x_list = new short[ count ];
    y_list = new short[ count ];
    {
      int c = 0;
      for( int i = 0; i < hood.length; ++i ){
        for( int j = 0; j < hood[0].length; ++j ){
          if( hood[i][j] > 0 && c < count){
            x_list[c] = (short) (i - radius);
            y_list[c] = (short) (j - radius);
            ++c;
          }
        }
      }
    }
    sectors = new short[8][count][2];
    int[][] c = new int[8][2];
    for( int i = 0; i < 8; ++i ){
      c[i][0] = 0;
      c[i][1] = 0;
    }
    
    for( short i = 0; i < count; ++i ){
      for( int k = 0; k < 8; ++k ) sectors[k][i][0] = -1;
      for( int k = 0; k < 8; ++k ) sectors[k][i][1] = -1;
      boolean xn = x_list[i] < 0;
      boolean yn = y_list[i] < 0;
      boolean xp = x_list[i] > 0;
      boolean yp = y_list[i] > 0;
      if( xn || yn ){ //.............TOP LEFT
        sectors[0][ c[0][0] ][0] = i;
        ++c[0][0];
      } else{
        sectors[0][ c[0][1] ][1] = i;
        ++c[0][1];
      }
      if( yn ){ //...................TOP
        sectors[1][ c[1][0] ][0] = i;
        ++c[1][0];
      } else{
        sectors[1][ c[1][1] ][1] = i;
        ++c[1][1];
      }
      if( xp || yn ){ //.............TOP RIGHT
        sectors[2][ c[2][0] ][0] = i;
        ++c[2][0];
      } else{
        sectors[2][ c[2][1] ][1] = i;
        ++c[2][1];
      }
      if( xp ){ //...................RIGHT
        sectors[3][ c[3][0] ][0] = i;
        ++c[3][0];
      } else{
        sectors[3][ c[3][1] ][1] = i;
        ++c[3][1];
      }
      if( xp || yp ){ //.............BOTTOM RIGHT
        sectors[4][ c[4][0] ][0] = i;
        ++c[4][0];
      } else{
        sectors[4][ c[4][1] ][1] = i;
        ++c[4][1];
      }
      if( yp ){ //...................BOTTOM
        sectors[5][ c[5][0] ][0] = i;
        ++c[5][0];
      } else{
        sectors[5][ c[5][1] ][1] = i;
        ++c[5][1];
      }
      if( xn || yp ){ //.............BOTTOM LEFT
        sectors[6][ c[6][0] ][0] = i;
        ++c[6][0];
      } else{
        sectors[6][ c[6][1] ][1] = i;
        ++c[6][1];
      }
      if( xn ){ //...................LEFT
        sectors[7][ c[7][0] ][0] = i;
        ++c[7][0];
      } else{
        sectors[7][ c[7][1] ][1] = i;
        ++c[7][1];
      }
    }
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
        
        if( duplicate_searches[j] >= 0 ){
          counts[j] = counts[ duplicate_searches[j] ];
        }
        else{
          //counts[j] = naive_count( old, neighborhoods.get( rules.get(j).neighborhood ), rules.get(j), i );
          counts[j] = list_count( old, neighborhoods.get( rules.get(j).neighborhood ), rules.get(j), i );
        }
        if( rules.get(j).range[ floor( counts[j] ) ] ){
          neo.pixels[ i ] = states.get( rules.get(j).resulting_state );
        }
      }
    }
  }
  neo.updatePixels();
}

float naive_count( PImage old, Neighborhood neighborhood, Rule rule, int i ){
  int Y = floor( i / float(old.width) );
  int X = i - old.width*Y;
  int xs = ( X < neighborhood.radius )? 0 : X - neighborhood.radius;
  int xe = ( X >= old.width - neighborhood.radius )? old.width-1 : X + neighborhood.radius;
  int ys = ( Y < neighborhood.radius )? 0 : Y - neighborhood.radius;
  int ye = ( Y >= old.height - neighborhood.radius )? old.height-1 : Y + neighborhood.radius;
  
  int C = 0;
  for( int x = xs; x <= xe; ++x ){
    for( int y = ys; y <= ye; ++y ){
      int S = statemap.get( old.pixels[ (old.width * y) + x ] );
      int hoodX = x -X +neighborhood.radius;
      int hoodY = y -Y +neighborhood.radius;
      C += neighborhood.hood[ hoodX ][ hoodY ] * (( S == rule.count_state )? 1 : 0 );
    }
  }
  return C;
}

float list_count( PImage old, Neighborhood nbh, Rule rule, int i ){
  int C = 0;
  int Y = floor( i / float(old.width) );
  int X = i - old.width*Y;
  byte one = 1;
  byte xl = X < nbh.radius ? one : 0;
  byte yt = Y < nbh.radius ? one : 0;
  byte xr = X >= old.width - nbh.radius ? one : 0;
  byte yb = Y >= old.height - nbh.radius ? one : 0;
  int L = xl<<3 | yt<<2 | xr<<1 | yb;

  switch( L ){
    case 0: // MIDDLE
      for( int q = 0; q < nbh.count; ++q ){
        if ( statemap.get( old.pixels[ (old.width * (Y + nbh.y_list[ q ]) ) + (X + nbh.x_list[ q ]) ] ) == rule.count_state ){
          C += nbh.hood[nbh.radius + nbh.x_list[ q ] ][nbh.radius + nbh.y_list[ q ] ];
      }}
      break;
    case 1: // BOTTOM
      for( int q = 0; q < nbh.count; ++q ){
        int s = nbh.sectors[5][q][0];
        if( s == -1 ) break;
        if( Y + nbh.y_list[ s ] < old.height ){
          if ( statemap.get( old.pixels[ (old.width * (Y + nbh.y_list[ s ]) ) + (X + nbh.x_list[ s ]) ] ) == rule.count_state ){
            C += nbh.hood[nbh.radius + nbh.x_list[ s ] ][nbh.radius + nbh.y_list[ s ] ];
      }}}
      for( int q = 0; q < nbh.count; ++q ){
        int s = nbh.sectors[5][q][1];
        if( s == -1 ) break;
        if ( statemap.get( old.pixels[ (old.width * (Y + nbh.y_list[ s ]) ) + (X + nbh.x_list[ s ]) ] ) == rule.count_state ){
            C += nbh.hood[nbh.radius + nbh.x_list[ s ] ][nbh.radius + nbh.y_list[ s ] ];
      }}
      break;
    case 2: // RIGHT
      for( int q = 0; q < nbh.count; ++q ){
        int s = nbh.sectors[3][q][0];
        if( s == -1 ) break;
        if( X + nbh.x_list[ s ] < old.width ){
          if ( statemap.get( old.pixels[ (old.width * (Y + nbh.y_list[ s ]) ) + (X + nbh.x_list[ s ]) ] ) == rule.count_state ){
            C += nbh.hood[nbh.radius + nbh.x_list[ s ] ][nbh.radius + nbh.y_list[ s ] ];
      }}}
      for( int q = 0; q < nbh.count; ++q ){
        int s = nbh.sectors[3][q][1];
        if( s == -1 ) break;
        if ( statemap.get( old.pixels[ (old.width * (Y + nbh.y_list[ s ]) ) + (X + nbh.x_list[ s ]) ] ) == rule.count_state ){
            C += nbh.hood[nbh.radius + nbh.x_list[ s ] ][nbh.radius + nbh.y_list[ s ] ];
      }}
      break;
    case 3: // BOTTOM RIGHT
      for( int q = 0; q < nbh.count; ++q ){
        int s = nbh.sectors[4][q][0];
        if( s == -1 ) break;
        if( X + nbh.x_list[ s ] < old.width && Y + nbh.y_list[ s ] < old.height ){
          if ( statemap.get( old.pixels[ (old.width * (Y + nbh.y_list[ s ]) ) + (X + nbh.x_list[ s ]) ] ) == rule.count_state ){
            C += nbh.hood[nbh.radius + nbh.x_list[ s ] ][nbh.radius + nbh.y_list[ s ] ];
      }}}
      for( int q = 0; q < nbh.count; ++q ){
        int s = nbh.sectors[4][q][1];
        if( s == -1 ) break;
        if ( statemap.get( old.pixels[ (old.width * (Y + nbh.y_list[ s ]) ) + (X + nbh.x_list[ s ]) ] ) == rule.count_state ){
            C += nbh.hood[nbh.radius + nbh.x_list[ s ] ][nbh.radius + nbh.y_list[ s ] ];
      }}
      break;
    case 4: // TOP
      for( int q = 0; q < nbh.count; ++q ){
        int s = nbh.sectors[1][q][0];
        if( s == -1 ) break;
        if( Y + nbh.y_list[ s ] > 0 ){
          if ( statemap.get( old.pixels[ (old.width * (Y + nbh.y_list[ s ]) ) + (X + nbh.x_list[ s ]) ] ) == rule.count_state ){
            C += nbh.hood[nbh.radius + nbh.x_list[ s ] ][nbh.radius + nbh.y_list[ s ] ];
      }}}
      for( int q = 0; q < nbh.count; ++q ){
        int s = nbh.sectors[1][q][1];
        if( s == -1 ) break;
        if ( statemap.get( old.pixels[ (old.width * (Y + nbh.y_list[ s ]) ) + (X + nbh.x_list[ s ]) ] ) == rule.count_state ){
            C += nbh.hood[nbh.radius + nbh.x_list[ s ] ][nbh.radius + nbh.y_list[ s ] ];
      }}
      break;
    case 6: // TOP RIGHT
      for( int q = 0; q < nbh.count; ++q ){
        int s = nbh.sectors[2][q][0];
        if( s == -1 ) break;
        if( X + nbh.x_list[ s ] < old.width && Y + nbh.y_list[ s ] > 0 ){
          if ( statemap.get( old.pixels[ (old.width * (Y + nbh.y_list[ s ]) ) + (X + nbh.x_list[ s ]) ] ) == rule.count_state ){
            C += nbh.hood[nbh.radius + nbh.x_list[ s ] ][nbh.radius + nbh.y_list[ s ] ];
      }}}
      for( int q = 0; q < nbh.count; ++q ){
        int s = nbh.sectors[2][q][1];
        if( s == -1 ) break;
        if ( statemap.get( old.pixels[ (old.width * (Y + nbh.y_list[ s ]) ) + (X + nbh.x_list[ s ]) ] ) == rule.count_state ){
            C += nbh.hood[nbh.radius + nbh.x_list[ s ] ][nbh.radius + nbh.y_list[ s ] ];
      }}
      break;
    case 8: // LEFT
      for( int q = 0; q < nbh.count; ++q ){
        int s = nbh.sectors[7][q][0];
        if( s == -1 ) break;
        if( X + nbh.x_list[ s ] > 0 ){
          if ( statemap.get( old.pixels[ (old.width * (Y + nbh.y_list[ s ]) ) + (X + nbh.x_list[ s ]) ] ) == rule.count_state ){
            C += nbh.hood[nbh.radius + nbh.x_list[ s ] ][nbh.radius + nbh.y_list[ s ] ];
      }}}
      for( int q = 0; q < nbh.count; ++q ){
        int s = nbh.sectors[7][q][1];
        if( s == -1 ) break;
        if ( statemap.get( old.pixels[ (old.width * (Y + nbh.y_list[ s ]) ) + (X + nbh.x_list[ s ]) ] ) == rule.count_state ){
            C += nbh.hood[nbh.radius + nbh.x_list[ s ] ][nbh.radius + nbh.y_list[ s ] ];
      }}
      break;
    case 9: // BOTTOM LEFT
      for( int q = 0; q < nbh.count; ++q ){
        int s = nbh.sectors[6][q][0];
        if( s == -1 ) break;
        if( X + nbh.x_list[ s ] > 0 && Y + nbh.y_list[ s ] < old.height ){
          if ( statemap.get( old.pixels[ (old.width * (Y + nbh.y_list[ s ]) ) + (X + nbh.x_list[ s ]) ] ) == rule.count_state ){
            C += nbh.hood[nbh.radius + nbh.x_list[ s ] ][nbh.radius + nbh.y_list[ s ] ];
      }}}
      for( int q = 0; q < nbh.count; ++q ){
        int s = nbh.sectors[6][q][1];
        if( s == -1 ) break;
        if ( statemap.get( old.pixels[ (old.width * (Y + nbh.y_list[ s ]) ) + (X + nbh.x_list[ s ]) ] ) == rule.count_state ){
            C += nbh.hood[nbh.radius + nbh.x_list[ s ] ][nbh.radius + nbh.y_list[ s ] ];
      }}
      break;
    case 12:// TOP LEFT
      for( int q = 0; q < nbh.count; ++q ){
        int s = nbh.sectors[0][q][0];
        if( s == -1 ) break;
        if( X + nbh.x_list[ s ] > 0 && Y + nbh.y_list[ s ] > 0 ){
          //println( i, q, s, nbh.x_list[ s ], nbh.y_list[ s ], (old.width * (Y + nbh.y_list[ s ]) ) + (X + nbh.x_list[ s ]) );
          if ( statemap.get( old.pixels[ (old.width * (Y + nbh.y_list[ s ]) ) + (X + nbh.x_list[ s ]) ] ) == rule.count_state ){
            C += nbh.hood[nbh.radius + nbh.x_list[ s ] ][nbh.radius + nbh.y_list[ s ] ];
      }}}
      for( int q = 0; q < nbh.count; ++q ){
        int s = nbh.sectors[0][q][1];
        if( s == -1 ) break;
        if ( statemap.get( old.pixels[ (old.width * (Y + nbh.y_list[ s ]) ) + (X + nbh.x_list[ s ]) ] ) == rule.count_state ){
            C += nbh.hood[nbh.radius + nbh.x_list[ s ] ][nbh.radius + nbh.y_list[ s ] ];
      }}
      break;
  }
  return C;
}
