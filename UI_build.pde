UISet create, observe;

integer open_editor, del_state;
bool add_state;
bool save, load, run, PrtSc;
bool_p play;

floating_point fill_ratio;
bool fill;

bool gradient;
pigment gradient_a, gradient_b;

integer brush_color;
integer brush_radius;

void build_ui(){
  
  play = new bool_p( false );
  run = new bool();
  save = new bool();
  load = new bool();
  PrtSc = new bool();
  open_editor = new integer(-1);
  add_state = new bool();
  del_state = new integer(-1);
  fill_ratio = new floating_point( 5 );
  fill = new bool();
  gradient = new bool( true );
  gradient_a = new pigment( color( 0 ) );
  gradient_b = new pigment( color(255) );
  brush_color = new integer( states.size()-1 );
  brush_radius = new integer(1);
  
  create = new UISet( 3, 14, 28, 14, 1 );
  create.setScheme( #7C7570, 20 );//#9DABAF 
  
  create.addLabel( 0, 0, "Cellular Automata Suite 1.0", "C" );
  
  create.Hx = 2.9;  create.Vx = 25.8;
  create.addNeighborhood_list( 0, 2, open_editor, neighborhoods );
  
  create.Hx = 10.9;  create.Vx = 18.8;
  create.addRule_list( 3, 2, rules, neighborhoods, states );
  
  create.Hx = 8.9;  create.Vx = 5.8;
  create.addState_bar( 3, 22, states, add_state, del_state );
  
  create.Vx = 1.8;  create.Hx = 1.9;
  create.addToggle( 12, 22, "Save", "C", save );
  create.addToggle( 12, 24, "Load", "C", load );
  create.addToggle( 12, 26, "Run", "C", run );
  
  //=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-==-=-=-
  
  observe = new UISet( 3, 18, 28, 18, 1 );
  observe.setScheme( #7C7570, 20 );
  
  observe.addLabel( 0, 0, "Cellular Automata Suite 1.0", "C" );
  observe.Hx = 1.9;
  observe.addToggle( 0, 1, "Pause", "Play", "C", play );
  observe.Hx = 1.9;
  observe.addSlider( 4, 1, "Brush:", "COLO", brush_radius, 1, 25 );
  observe.addColor_Cycler ( 6, 1, brush_color, states );
  observe.addSlider(  9, 1, "", "C", fill_ratio, 0, 10 );
  observe.addToggle( 11, 1, "Fill", "C", fill );
  observe.addToggle( 14, 1, "Print Screen", "C", PrtSc );
  observe.addToggle( 16, 1, "Back", "C", run );
}
