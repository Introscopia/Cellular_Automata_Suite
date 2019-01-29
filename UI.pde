int textsize = 16;
PFont ui_font;

class integer{
  int n;
  integer(){ }
  integer(int x){ n = x; }
  int p(){ return n; }
  boolean changed() { return false; }
  void set( int x ){
    n = x; 
  }
  void set(){}
  void add( int x ) { n += x; }
  int diff(){ return 0; }
}

class integer_p extends integer{
  int p;
  integer_p(){ }
  integer_p(int x){ 
    n = x; 
    p = n;
  }
  int p(){ return p; }
  boolean changed() { return n != p; }
  void set( int x ){
    n = x;
    p = n;
  }
  void set(){
    p = n;
  }
  void add( int x ) {
    n += x; 
    p = n;
  }
  int diff(){ return n-p; }
}

class floating_point{
  float n;
  floating_point(){ }
  floating_point(float x){ n = x; }
  float p(){ return n; }
  boolean changed() { return false; }
  void set( float x ){
    n = x; 
  }
  void set(){}
  void add( float x ) { n += x; }
  float diff(){ return 0; }
}

class floating_point_p extends floating_point{
  float p;
  floating_point_p(){ }
  floating_point_p(float x){ 
    n = x; 
    p = n;
  }
  float p(){ return p; }
  boolean changed() { return n != p; }
  void set( float x ){
    n = x;
    p = n;
  }
  void set(){
    p = n;
  }
  void add( float x ) { 
    n += x; 
    p = n;
  }
  float diff(){ return n-p; }
}

class bool{
  boolean b;
  bool(){ }
  bool(boolean x){ b = x; }
  boolean changed() { return false; }
  void set( boolean x ){
    b = x; 
  }
  void set(){}
}

class bool_p extends bool{
  boolean p;
  bool_p(){ }
  bool_p(boolean x){ 
    b = x; 
    p = b;
  }
  boolean changed() { return b != p; }
  void set( boolean x ){
    b = x;
    p = b;
  }
  void set(){
    p = b;
  }
}

class letter{
  char l;
  letter(){ }
  letter(char x){ l = x; }
  boolean changed() { return false; }
  void set( char x ){
    l = x; 
  }
  void set(){}
}

class letter_p extends letter{
  char p;
  letter_p(){ }
  letter_p(char x){ 
    l = x; 
    p = l;
  }
  boolean changed() { return l != p; }
  void set( char x ){
    l = x;
    p = l;
  }
  void set(){
    p = l;
  }
}

class word {
  String w;
  word() {
    w = "";
  }
  word(String w) {
    this.w = w;
  }
}

class pigment {
  color p;
  pigment() {
  }
  pigment(color p) {
    this.p = p;
  }
}
//()H()H()H()H()H()H()H()H()H()H()H()H()H()H()H()H()H()H()H()H()H()H()H()H()H()H()H()H()H()H()H()H()H()H()H()H()H()H()H()H()H()H()H()H|
//)H()H()H()H()H()H()H()H()H()H()H()H()H()H()H()H()H()H()H()H()H()H()H()H()H()H()H()H()H()H()H()H()H()H()H()H()H()H()H()H()H()H()H()H(|

class ColorScheme {
  public color dimmer, dim, bright, brighter;
  ColorScheme() {
  }
  ColorScheme( color root, float contrast ) {
    dimmer = color( red(root) - 1.5*contrast, green(root) - 1.5*contrast, blue(root) - 1.5*contrast );
    dim = color( red(root) - 0.5*contrast, green(root) - 0.5*contrast, blue(root) - 0.5*contrast );
    bright = color( red(root) + 0.5*contrast, green(root) + 0.5*contrast, blue(root) + 0.5*contrast );
    brighter = color( red(root) + 1.5*contrast, green(root) + 1.5*contrast, blue(root) + 1.5*contrast );
  }
}

//()H()H()H()H()H()H()H()H()H()H()H()H()H()H()H()H()H()H()H()H()H()H()H()H()H()H()H()H()H()H()H()H()H()H()H()H()H()H()H()H()H()H()H()H|
//)H()H()H()H()H()H()H()H()H()H()H()H()H()H()H()H()H()H()H()H()H()H()H()H()H()H()H()H()H()H()H()H()H()H()H()H()H()H()H()H()H()H()H()H(|

class UISet {
  ColorScheme CS;
  float X, Y, W, H;
  float margin, column_width, line_height, Hx, Vx;
  UIElement[] set;
  Label[] labels;
  boolean columning, rowing;
  int[][] indices;
  int I, J, C; // counters for columning/lining
  UISet( float m, float l, float c ) {
    margin = m;
    column_width = (width - 2 * margin)/l;
    line_height = (height - 2 * margin)/c;
    Hx = 1;
    Vx = 1;
    set = new UIElement[0];
    labels = new Label[0];
    X = 0;
    Y = 0;
    W = width;
    H = height;
    indices = new int[int(l)][int(c)];
    for(int i = 0; i < int(l); i++) for(int j = 0; j < int(c); j++) indices[i][j] = -1;
  }
  UISet( float m, float l, float c, float hp, float vp ) {
    margin = m;
    column_width = (width - 2 * margin)/l;
    line_height = (height - 2 * margin)/c;
    Hx = hp;
    Vx = vp;
    set = new UIElement[0];
    labels = new Label[0];
    X = 0;
    Y = 0;
    W = width;
    H = height;
    indices = new int[int(l)][int(c)];
    for(int i = 0; i < int(l); i++) for(int j = 0; j < int(c); j++) indices[i][j] = -1;
  }
  UISet( float x, float y, float w, float h, float m, float l, float c ) {
    X = x;
    Y = y;
    W = w;
    H = h;
    margin = m;
    column_width = (W - 2 * margin)/l;
    line_height = (H - 2 * margin)/c;
    Hx = 1;
    Vx = 1;
    set = new UIElement[0];
    labels = new Label[0];
    indices = new int[int(l)][int(c)];
    for(int i = 0; i < int(l); i++) for(int j = 0; j < int(c); j++) indices[i][j] = -1;
  }
  UISet( float x, float y, float w, float h, float m, float l, float c, float hp, float vp  ) {
    X = x;
    Y = y;
    W = w;
    H = h;
    margin = m;
    column_width = (W - 2 * margin)/l;
    line_height = (H - 2 * margin)/c;
    Hx = hp;
    Vx = vp;
    set = new UIElement[0];
    labels = new Label[0];
    indices = new int[int(l)][int(c)];
    for(int i = 0; i < int(l); i++) for(int j = 0; j < int(c); j++) indices[i][j] = -1;
  }
  
  void setScheme(color root, int contrast ) {
    CS = new ColorScheme(root, contrast);
  }
  
  void beginColumn(int l, int c) {
    columning = true;
    rowing = false;
    I = l;
    J = c;
    C = 0;
  }
  void beginRow(int l, int c) {
    rowing = true;
    columning = false;
    I = l;
    J = c;
    C = 0;
  }
  void endRow() {
    rowing = false;
  }
  void endColumn() {
    columning = false;
  }
  
  void display_background(){
    rect(X+1, Y+1, W-2, H-2);
  }
  
  void display_indices(){
    this.display_grid();
    for(int n = 0; n < indices.length; ++n){
      for(int m = 0; m < indices[0].length; ++m){
        if( indices[n][m] >= 0 ) text( indices[n][m], margin + (n + 0.5) * column_width, margin + (m + 0.5) * line_height );
      }
    }
  }

  void display_grid() {
    noFill();
    rect( X + margin, Y + margin, W - 2*margin, H - 2 * margin );
    for (float x = X + margin; x < X+W - 2*margin; x += column_width) {
      line(x, Y+margin, x, Y+H - 2*margin);
    }
    for (float y = Y + margin; y < Y+H - 2*margin; y += line_height) {
      line(X+margin, y, X+W - 2*margin, y);
    }
  }
  //d[0], d[1], d[2], d[3]
  float[] returnDimensions( int l, int c ){
    float[] d = new float[4];
    d[0] = X + margin + (l * column_width) + ( ( (ceil(Hx) - Hx) * column_width ) / 2f );
    d[1] = Y + margin + (c * line_height) + ( ( (ceil(Vx) - Vx ) * line_height) / 2f );
    d[2] = column_width * Hx;
    d[3] = line_height * Vx;    
    return d;
  }
  
  void mouseMoved(){
    int i = floor((mouseX - X - margin)/column_width);
    int j = floor((mouseY - Y - margin)/line_height);
    if( i >= 0 && j >= 0 && i < indices.length && j < indices[0].length ){
      if( indices[i][j] >= 0 ){
        set[ indices[i][j] ].mouseMoved(true);
        for (int k = 0; k < indices[i][j]; k++) set[k].mouseMoved(false);
        for (int k = indices[i][j]+1; k < set.length; k++) set[k].mouseMoved(false);
      }
      else for (int k = 0; k < set.length; k++) set[k].mouseMoved(false);
    }
    else for (int k = 0; k < set.length; k++) set[k].mouseMoved(false);
  }
  void mousePressed(){
    int i = floor((mouseX - X - margin)/column_width);
    int j = floor((mouseY - Y - margin)/line_height);
    if( i >= 0 && j >= 0 && i < indices.length && j < indices[0].length ){
      if( indices[i][j] >= 0 ){
        set[ indices[i][j] ].mousePressed(true);
        for (int k = 0; k < indices[i][j]; k++) set[k].mousePressed(false);
        for (int k = indices[i][j]+1; k < set.length; k++) set[k].mousePressed(false);
      }
      else for (int k = 0; k < set.length; k++) set[k].mousePressed(false);
    }
    else for (int k = 0; k < set.length; k++) set[k].mousePressed(false);
  }
  void mouseReleased(){
    int i = floor((mouseX - X - margin)/column_width);
    int j = floor((mouseY - Y - margin)/line_height);
    if( i >= 0 && j >= 0 && i < indices.length && j < indices[0].length ){
      if( indices[i][j] >= 0 ){
        set[ indices[i][j] ].mouseReleased(true);
        for (int k = 0; k < indices[i][j]; k++) set[k].mouseReleased(false);
        for (int k = indices[i][j]+1; k < set.length; k++) set[k].mouseReleased(false);
      }
      else for (int k = 0; k < set.length; k++) set[k].mouseReleased(false);
    }
    else for (int k = 0; k < set.length; k++) set[k].mouseReleased(false);
  }
  void mouseDragged(){
    int i = floor((mouseX - X - margin)/column_width);
    int j = floor((mouseY - Y - margin)/line_height); 
    if( i >= 0 && j >= 0 && i < indices.length && j < indices[0].length ){
      if( indices[i][j] >= 0 ){
        set[ indices[i][j] ].mouseDragged(true);
        for (int k = 0; k < indices[i][j]; k++) set[k].mouseDragged(false);
        for (int k = indices[i][j]+1; k < set.length; k++) set[k].mouseDragged(false);
      }
      else for (int k = 0; k < set.length; k++) set[k].mouseDragged(false);
    }
    else for (int k = 0; k < set.length; k++) set[k].mouseDragged(false);
  }
  
  void keyTyped(){
    for (int i = 0; i < set.length; i++) {
      set[i].keyTyped();
    }
  }
  void keyReleased(){
    for (int i = 0; i < set.length; i++) {
      set[i].keyReleased();
    }
  }

  void display(){
    textFont(ui_font, textsize);
    textAlign(LEFT, TOP);
    stroke(0);
    for (int i = 0; i < set.length; i++) {
      set[i].display(CS);
    }
    for (int i = 0; i < labels.length; i++) {
      labels[i].display();
    }
  }
  
  void addToIndices( int l, int c ){
    for(int n = l; n < l + ceil(Hx); ++n){
      for(int m = c; m < c + ceil(Vx); ++m){
        if( n >= 0 && n < indices.length && m >= 0 && m < indices[0].length ) indices[n][m] = set.length;
        else println( "Tried to add to the indices at position " + n + ", " + m + "( size is " + indices.length + " x " + indices[0].length + " )" );
      }
    }
  }
  
  void addLabel(Label l) {
    labels = (Label[]) append( labels, l );//labels.add( l );
  }

  //void addLabel(float x, float y, String s){
  //  labels.add( new Label( s, '0', x, y, 0, 0) );
  //}

  void addLabel(int l, int c, String s, String pos) {
    float x = X + margin + (l * column_width);
    float y = Y + margin + (c * line_height);
    labels = (Label[]) append( labels, new Static_String_Label( s, pos, x, y, column_width * Hx, line_height * Vx) );
  }
  void addLabel(String s, String pos) {
    if ( columning ) {
      this.addLabel( I, J + C, s, pos );
      C += ceil( Vx );
    } else if ( rowing ) {
      this.addLabel( I + C, J, s, pos );
      C += ceil( Hx );
    } else println( "addLabel", s, "failed: not columning nor rowing." );
  }
  void setLabel(int index, int l, int c, String s, String pos) {
    float x = X + margin + (l * column_width);
    float y = Y + margin + (c * line_height);
    if( index < labels.length ) labels[index] = new Static_String_Label( s, pos, x, y, column_width * Hx, line_height * Vx);
    else println( "ERROR: setLabel(", index, l, c, s, pos, ")" );
  }

  void addLabel(int l, int c, letter inc) {
    float x = X + margin + (l * column_width);
    float y = Y + margin + (c * line_height);
    labels = (Label[]) append( labels, new Dynamic_Letter_Label( inc, "C", x, y, column_width * Hx, line_height * Vx) );
  }
  
  void addLabel(int l, int c, integer inc) {
    float x = X + margin + (l * column_width);
    float y = Y + margin + (c * line_height);
    labels = (Label[]) append( labels, new Dynamic_Integer_Label( inc, x, y, column_width * Hx, line_height * Vx) );
  }
  void addLabel(int l, int c, String logue, integer inc, String pos ) {
    float x = X + margin + (l * column_width);
    float y = Y + margin + (c * line_height);
    labels = (Label[]) append( labels, new Dynamic_Integer_Label_with_prologue( logue, inc, pos, x, y, column_width * Hx, line_height * Vx) );
  }
  void addLabel(String logue, integer inc, String pos) {
    if ( columning ) {
      this.addLabel( I, J + C, logue, inc, pos );
      C += ceil( Vx );
    } else if ( rowing ) {
      this.addLabel( I + C, J, logue, inc, pos );
      C += ceil( Hx );
    } else println( "addLabel", logue, "failed: not columning nor rowing." );
  }
  void addLabel(int l, int c, integer inc, String logue, String pos ) {
    float x = X + margin + (l * column_width);
    float y = Y + margin + (c * line_height);
    labels = (Label[]) append( labels, new Dynamic_Integer_Label_with_epilogue( inc, logue, pos, x, y, column_width * Hx, line_height * Vx) );
  }
  void addLabel( integer inc, String logue, String pos) {
    if ( columning ) {
      this.addLabel( I, J + C, inc, logue, pos );
      C += ceil( Vx );
    } else if ( rowing ) {
      this.addLabel( I + C, J, inc, logue, pos );
      C += ceil( Hx );
    } else println( "addLabel", logue, "failed: not columning nor rowing." );
  }
  void addLabel(int l, int c, floating_point inc) {
    float x = X + margin + (l * column_width);
    float y = Y + margin + (c * line_height);
    labels = (Label[]) append( labels, new Dynamic_Float_Label( inc, x, y, column_width * Hx, line_height * Vx) );
  }
  void addLabel(int l, int c, String logue, floating_point inc, String pos ) {
    float x = X + margin + (l * column_width);
    float y = Y + margin + (c * line_height);
    labels = (Label[]) append( labels, new Dynamic_Float_Label_with_prologue( logue, inc, pos, x, y, column_width * Hx, line_height * Vx) );
  }
  void addLabel( String logue, floating_point inc, String pos ) {
    if ( columning ) {
      this.addLabel( I, J + C, logue, inc, pos );
      C += ceil( Vx );
    } else if ( rowing ) {
      this.addLabel( I + C, J, logue, inc, pos );
      C += ceil( Hx );
    } else println( "addLabel", logue, "failed: not columning nor rowing." );
  }
  void addLabel(int l, int c, floating_point inc, String logue, String pos ) {
    float x = X + margin + (l * column_width);
    float y = Y + margin + (c * line_height);
    labels = (Label[]) append( labels, new Dynamic_Float_Label_with_epilogue( inc, logue, pos, x, y, column_width * Hx, line_height * Vx) );
  }
   void addLabel( floating_point inc, String logue, String pos ) {
    if ( columning ) {
      this.addLabel( I, J + C, inc, logue, pos );
      C += ceil( Vx );
    } else if ( rowing ) {
      this.addLabel( I + C, J, inc, logue, pos );
      C += ceil( Hx );
    } else println( "addLabel", logue, "failed: not columning nor rowing." );
  }
  void addCoeffLabel(int l, int c, floating_point inc) {
    float x = X + margin + (l * column_width);
    float y = Y + margin + (c * line_height);
    labels = (Label[]) append( labels, new Dynamic_Coeff_Label( inc, x, y, column_width * Hx, line_height * Vx) );
  }

  void addLabel(int l, int c, word inc, String sample, String pos) {
    float x = X + margin + (l * column_width);
    float y = Y + margin + (c * line_height);
    labels = (Label[]) append( labels, new Dynamic_Word_Label( inc, sample, pos, x, y, column_width * Hx, line_height * Vx) );
  }
  
  void addElement( UIElement E ) {
    set = (UIElement[]) append( set, E ); //set = (UIElement[]) append( set, E );
  }
  //&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
  //&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
  void addToggle(int l, int c, String label, String pos, bool i) {
    addToIndices( l, c );
    float x = X + margin + (l * column_width) + ( ( (ceil(Hx) - Hx) * column_width ) / 2f );
    float y = Y + margin + (c * line_height) + ( ( (ceil(Vx) - Vx ) * line_height) / 2f );
    set = (UIElement[]) append( set, new ToggleButton( x, y, Hx * column_width, Vx * line_height, label, pos, i) );  
  }
  void addToggle(String label, String pos, bool inc) {
    if ( columning ) {
      this.addToggle( I, J + C, label, pos, inc );
      C += ceil( Vx );
    } else if ( rowing ) {
      this.addToggle( I + C, J, label, pos, inc );
      C += ceil( Hx );
    } else println( "addToggle", label, "failed: not columning nor rowing." );
  }
  void addToggle(int l, int c, String label_1, String label_2, String pos, bool i) {
    addToIndices( l, c );
    float x = X + margin + (l * column_width) + ( ( (ceil(Hx) - Hx) * column_width ) / 2f );
    float y = Y + margin + (c * line_height) + ( ( (ceil(Vx) - Vx ) * line_height) / 2f );
    set = (UIElement[]) append( set, new Two_Label_Toggle( x, y, Hx * column_width, Vx * line_height, label_1, label_2, pos, i) );  
  }
  void addToggle(String label_1, String label_2, String pos, bool inc) {
    if ( columning ) {
      this.addToggle( I, J + C, label_1, label_2, pos, inc );
      C += ceil( Vx );
    } else if ( rowing ) {
      this.addToggle( I + C, J, label_1, label_2, pos, inc );
      C += ceil( Hx );
    } else println( "addToggle", label_1, "failed: not columning nor rowing." );
  }
  
  //LockableToggleButton(float x, float y, float w, float h, String str, String pos, bool i, boolean c) {
  void addToggle(int l, int c, String label, String pos, bool i, boolean condition) {
    addToIndices( l, c );
    float x = X + margin + (l * column_width) + ( ( (ceil(Hx) - Hx) * column_width ) / 2f );
    float y = Y + margin + (c * line_height) + ( ( (ceil(Vx) - Vx ) * line_height) / 2f );
    set = (UIElement[]) append( set, new LockableToggleButton( x, y, Hx * column_width, Vx * line_height, label, pos, i, condition) );  
  }
  void addToggle(String label, String pos, bool inc, boolean condition ) {
    if ( columning ) {
      this.addToggle( I, J + C, label, pos, inc, condition );
      C += ceil( Vx );
    } else if ( rowing ) {
      this.addToggle( I + C, J, label, pos, inc, condition );
      C += ceil( Hx );
    } else println( "addToggle", label, "failed: not columning nor rowing." );
  } 
  //&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
  void addNumSet(int l, int c, String label, String pos, integer i, int s) {
    addToIndices( l, c );
    float x = X + margin + (l * column_width) + ( ( (ceil(Hx) - Hx) * column_width ) / 2f );
    float y = Y + margin + (c * line_height) + ( ( (ceil(Vx) - Vx ) * line_height) / 2f );
    set = (UIElement[]) append( set, new NumSetButton( x, y, Hx * column_width, Vx * line_height, label, pos, i, s) );
  }
  void addNumSet(String label, String pos, integer inc, int s) {
    if ( columning ) {
      this.addNumSet( I, J + C, label, pos, inc, s );
      C += ceil( Vx );
    } else if ( rowing ) {
      this.addNumSet( I + C, J, label, pos, inc, s );
      C += ceil( Hx );
    } else println( "addNumSet failed: not columning nor rowing." );
  }
  //&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
  void addCharSet(int l, int c, String label, String pos, letter i, char s) {
    addToIndices( l, c );
    float x = X + margin + (l * column_width) + ( ( (ceil(Hx) - Hx) * column_width ) / 2f );
    float y = Y + margin + (c * line_height) + ( ( (ceil(Vx) - Vx ) * line_height) / 2f );
    set = (UIElement[]) append( set, new CharSetButton( x, y, Hx * column_width, Vx * line_height, label, pos, i, s) );
  }
  void addCharSet(String label, String pos, letter inc, char s) {
    if ( columning ) {
      this.addCharSet( I, J + C, label, pos, inc, s );
      C += ceil( Vx );
    } else if ( rowing ) {
      this.addCharSet( I + C, J, label, pos, inc, s );
      C += ceil( Hx );
    } else println( "addCharSet failed: not columning nor rowing." );
  }
  //&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
  void addNumAdd(int l, int c, floating_point i, float step ) {
    addToIndices( l, c );
    float x = X + margin + (l * column_width) + ( ( (ceil(Hx) - Hx) * column_width ) / 2f );
    float y = Y + margin + (c * line_height) + ( ( (ceil(Vx) - Vx ) * line_height) / 2f );
    set = (UIElement[]) append( set, new NumAddButton_Flo( x, y, Hx * column_width, Vx * line_height, i, step ) );
  }
  void addNumAdd(floating_point inc, float step, float min, float max) {
    if ( columning ) {
      this.addNumAdd( I, J + C, inc, step);
      C += ceil( Vx );
    } else if ( rowing ) {
      this.addNumAdd( I + C, J, inc, step);
      C += ceil( Hx );
    } else println( "addNumAdd failed: not columning nor rowing." );
  }
  //&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
  void addNumAdd(int l, int c, integer i, int step) {
    addToIndices( l, c );
    float x = X + margin + (l * column_width) + ( ( (ceil(Hx) - Hx) * column_width ) / 2f );
    float y = Y + margin + (c * line_height) + ( ( (ceil(Vx) - Vx ) * line_height) / 2f );
    set = (UIElement[]) append( set, new NumAddButton_Int( x, y, Hx * column_width, Vx * line_height, i, step) );
  }
  void addNumAdd(integer inc, int step ) {
    if ( columning ) {
      this.addNumAdd( I, J + C, inc, step );
      C += ceil( Vx );
    } else if ( rowing ) {
      this.addNumAdd( I + C, J, inc, step );
      C += ceil( Hx );
    } else println( "addNumAdd failed: not columning nor rowing." );
  }
  //&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
  void addPlusMinus(int l, int c, String label, String pos, floating_point i, float step) {
    addToIndices( l, c );
    float x = X + margin + (l * column_width) + ( ( (ceil(Hx) - Hx) * column_width ) / 2f );
    float y = Y + margin + (c * line_height) + ( ( (ceil(Vx) - Vx ) * line_height) / 2f );
    set = (UIElement[]) append( set, new PlusMinus_Flo( x, y, Hx * column_width, Vx * line_height, label, pos, i, step ) );
  }
  void addPlusMinus( String label, String pos, floating_point inc, float step ) {
    if ( columning ) {
      this.addPlusMinus( I, J + C, label, pos, inc, step);
      C += ceil( Vx );
    } else if ( rowing ) {
      this.addPlusMinus( I + C, J, label, pos, inc, step);
      C += ceil( Hx );
    } else println( "addPlusMinus failed: not columning nor rowing." );
  }
  //&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
  void addPlusMinus(int l, int c, String label, String pos, integer i, int step) {
    addToIndices( l, c );
    float x = X + margin + (l * column_width) + ( ( (ceil(Hx) - Hx) * column_width ) / 2f );
    float y = Y + margin + (c * line_height) + ( ( (ceil(Vx) - Vx ) * line_height) / 2f );
    set = (UIElement[]) append( set, new PlusMinus_Int( x, y, Hx * column_width, Vx * line_height, label, pos, i, step ) );
  }
  void addPlusMinus( String label, String pos, integer inc, int step ) {
    if ( columning ) {
      this.addPlusMinus( I, J + C, label, pos, inc, step);
      C += ceil( Vx );
    } else if ( rowing ) {
      this.addPlusMinus( I + C, J, label, pos, inc, step);
      C += ceil( Hx );
    } else println( "addPlusMinus failed: not columning nor rowing." );
  }
  //&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
  void addSlider(int l, int c, String label, String pos, floating_point i, float min, float max) {
    addToIndices( l, c );
    float x = X + margin + (l * column_width) + ( ( (ceil(Hx) - Hx) * column_width ) / 2f );
    float y = Y + margin + (c * line_height) + ( ( (ceil(Vx) - Vx ) * line_height) / 2f );
    set = (UIElement[]) append( set, new Slider( x, y, Hx * column_width, Vx * line_height, label, pos, i, min, max) );
  }
  
  void addSlider( String label, String pos, floating_point inc, float min, float max) {
    if ( columning ) {
      this.addSlider( I, J + C, label, pos, inc, min, max);
      C += ceil( Vx );
    } else if ( rowing ) {
      this.addSlider( I + C, J, label, pos, inc, min, max);
      C += ceil( Hx );
    } else println( "addSlider failed: not columning nor rowing." );
  }
  //cool_slider(float x, float y, float w, float h, String str, String pos, floating_point i, float min, float max, color cb, color cf)
  void addSlider(int l, int c, String label, String pos, floating_point i, float min, float max, color cb, color cf) {
    addToIndices( l, c );
    float x = X + margin + (l * column_width) + ( ( (ceil(Hx) - Hx) * column_width ) / 2f );
    float y = Y + margin + (c * line_height) + ( ( (ceil(Vx) - Vx ) * line_height) / 2f );
    set = (UIElement[]) append( set, new cool_Slider( x, y, Hx * column_width, Vx * line_height, label, pos, i, min, max, cb, cf, column_width) );
  }
  
  void addSlider( String label, String pos, floating_point inc, float min, float max, color cb, color cf) {
    if ( columning ) {
      this.addSlider( I, J + C, label, pos, inc, min, max, cb, cf);
      C += ceil( Vx );
    } else if ( rowing ) {
      this.addSlider( I + C, J, label, pos, inc, min, max, cb, cf);
      C += ceil( Hx );
    } else println( "addSlider failed: not columning nor rowing." );
  }
  
  void addSlider(int l, int c, String label, String pos, integer i, int min, int max) {
    addToIndices( l, c );
    float x = X + margin + (l * column_width) + ( ( (ceil(Hx) - Hx) * column_width ) / 2f );
    float y = Y + margin + (c * line_height) + ( ( (ceil(Vx) - Vx ) * line_height) / 2f );
    set = (UIElement[]) append( set, new integer_Slider( x, y, Hx * column_width, Vx * line_height, label, pos, i, min, max) );
  }
  
  void addSlider( String label, String pos, integer inc, int min, int max) {
    if ( columning ) {
      this.addSlider( I, J + C, label, pos, inc, min, max);
      C += ceil( Vx );
    } else if ( rowing ) {
      this.addSlider( I + C, J, label, pos, inc, min, max);
      C += ceil( Hx );
    } else println( "addSlider failed: not columning nor rowing." );
  }

  void addSlider(int l, int c, String label, String pos, integer i, int min, int max, color cb, color cf) {
    addToIndices( l, c );
    float x = X + margin + (l * column_width) + ( ( (ceil(Hx) - Hx) * column_width ) / 2f );
    float y = Y + margin + (c * line_height) + ( ( (ceil(Vx) - Vx ) * line_height) / 2f );
    set = (UIElement[]) append( set, new cool_integer_Slider( x, y, Hx * column_width, Vx * line_height, label, pos, i, min, max, cb, cf, column_width) );
  }
  
  void addSlider( String label, String pos, integer inc, int min, int max, color cb, color cf) {
    if ( columning ) {
      this.addSlider( I, J + C, label, pos, inc, min, max, cb, cf);
      C += ceil( Vx );
    } else if ( rowing ) {
      this.addSlider( I + C, J, label, pos, inc, min, max, cb, cf);
      C += ceil( Hx );
    } else println( "addSlider failed: not columning nor rowing." );
  }
  //&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
  void addDropDown(int l, int c, String label, String pos, letter i) {
    addToIndices( l, c );
    float x = X + margin + (l * column_width) + ( ( (ceil(Hx) - Hx) * column_width ) / 2f );
    float y = Y + margin + (c * line_height) + ( ( (ceil(Vx) - Vx ) * line_height) / 2f );
    set = (UIElement[]) append( set, new DropDown( x, y, Hx * column_width, Vx * line_height, label, pos, i ) );
  }
  void addDropDown( String label, String pos, letter inc) {
    if ( columning ) {
      this.addDropDown( I, J + C, label, pos, inc );
      C += ceil( Vx );
    } else if ( rowing ) {
      this.addDropDown( I + C, J, label, pos, inc );
      C += ceil( Hx );
    } else println( "addDropDown", label, "failed: not columning nor rowing." );
  }  
  //&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
  void addYanker(int l, int c, String label, String pos, floating_point i, float dom, float base, float coeff) {
    addToIndices( l, c );
    float x = X + margin + (l * column_width) + ( ( (ceil(Hx) - Hx) * column_width ) / 2f );
    float y = Y + margin + (c * line_height) + ( ( (ceil(Vx) - Vx ) * line_height) / 2f );
    set = (UIElement[]) append( set, new Yanker( x, y, Hx * column_width, Vx * line_height, label, pos, i, dom, base, coeff) );
  }
  void addYanker( String label, String pos, floating_point inc, float dom, float base, float coeff, float min, float max) {
    if ( columning ) {
      this.addYanker( I, J + C, label, pos, inc, dom, base, coeff);
      C += ceil( Vx );
    } else if ( rowing ) {
      this.addYanker( I + C, J, label, pos, inc, dom, base, coeff);
      C += ceil( Hx );
    } else println( "addYanker failed: not columning nor rowing." );
  }    
  //&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
  void addColorSelector(int l, int c, pigment p) {
    addToIndices( l, c );
    float x = X + margin + (l * column_width) + ( ( (ceil(Hx) - Hx) * column_width ) / 2f );
    float y = Y + margin + (c * line_height) + ( ( (ceil(Vx) - Vx ) * line_height) / 2f );
    set = (UIElement[]) append( set, new ColorSelector( x, y, Hx * column_width, Vx * line_height, p) );
  }
  void addColorSelector(pigment p) {
    if ( columning ) {
      this.addColorSelector( I, J + C, p);
      C += ceil( Vx );
    } else if ( rowing ) {
      this.addColorSelector( I + C, J, p);
      C += ceil( Hx );
    } else println( "addColorSelector failed: not columning nor rowing." );
  }
  //&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
  void addTextDisplay_vertical(int l, int c, String label, String pos, word w) {
    addToIndices( l, c );
    float x = X + margin + (l * column_width) + ( ( (ceil(Hx) - Hx) * column_width ) / 2f );
    float y = Y + margin + (c * line_height) + ( ( (ceil(Vx) - Vx ) * line_height) / 2f );
    set = (UIElement[]) append( set, new TextDisplay_vertical( x, y, Hx * column_width, Vx * line_height, label, pos, w, CS ) );
  }
  void addTextDisplay_vertical(String label, String pos, word w) {
    if ( columning ) {
      this.addTextDisplay_vertical( I, J + C, label, pos, w );
      ++C;
    }
    else if ( rowing ) {
      this.addTextDisplay_vertical( I + C, J, label, pos, w );
      ++C;
    }
    else println( "addTextDisplay failed: not columning nor rowing." );
  }
  //&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
  //TextField(float x, float y, float w, float h, String label_, String pos, word i) {
  void addTextField_vertical(int l, int c, String label, String pos, word w) {
    addToIndices( l, c );
    float x = X + margin + (l * column_width) + ( ( (ceil(Hx) - Hx) * column_width ) / 2f );
    float y = Y + margin + (c * line_height) + ( ( (ceil(Vx) - Vx ) * line_height) / 2f );
    set = (UIElement[]) append( set, new TextField_vertical( x, y, Hx * column_width, Vx * line_height, label, pos, w, CS ) );
  }
  void addTextField_vertical(String label, String pos, word w) {
    if ( columning ) {
      this.addTextField_vertical( I, J + C, label, pos, w );
      ++C;
    }
    else if ( rowing ) {
      this.addTextField_vertical( I + C, J, label, pos, w );
      ++C;
    }
    else println( "addTextField failed: not columning nor rowing." );
  }
   //&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
  void addTextDisplay_horizontal(int l, int c, String label, String pos, word w) {
    addToIndices( l, c );
    float x = X + margin + (l * column_width) + ( ( (ceil(Hx) - Hx) * column_width ) / 2f );
    float y = Y + margin + (c * line_height) + ( ( (ceil(Vx) - Vx ) * line_height) / 2f );
    set = (UIElement[]) append( set, new TextDisplay_horizontal( x, y, Hx * column_width, Vx * line_height, label, pos, w, CS ) );
  }
  void addTextDisplay_horizontal(String label, String pos, word w) {
    if ( columning ) {
      this.addTextDisplay_horizontal( I, J + C, label, pos, w );
      ++C;
    }
    else if ( rowing ) {
      this.addTextDisplay_horizontal( I + C, J, label, pos, w );
      ++C;
    }
    else println( "addTextField failed: not columning nor rowing." );
  }
  //&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
  //TextField(float x, float y, float w, float h, String label_, String pos, word i) {
  void addTextField_horizontal(int l, int c, String label, String pos, word w) {
    addToIndices( l, c );
    float x = X + margin + (l * column_width) + ( ( (ceil(Hx) - Hx) * column_width ) / 2f );
    float y = Y + margin + (c * line_height) + ( ( (ceil(Vx) - Vx ) * line_height) / 2f );
    set = (UIElement[]) append( set, new TextField_horizontal( x, y, Hx * column_width, Vx * line_height, label, pos, w, CS ) );
  }
  void addTextField_horizontal(String label, String pos, word w) {
    if ( columning ) {
      this.addTextField_horizontal( I, J + C, label, pos, w );
      ++C;
    }
    else if ( rowing ) {
      this.addTextField_horizontal( I + C, J, label, pos, w );
      ++C;
    }
    else println( "addTextField failed: not columning nor rowing." );
  }
  //&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
  //ListSelect( float x, float y, float w, float h, String[] l, floating_point n ){ 
  void addListSelect(int l, int c, String label, String pos, String[] li, integer nu) {
    for(int n = l; n < l + ceil(Hx); ++n){
      for(int m = c; m < c + ceil(Vx); ++m){
        indices[n][m] = set.length;
      }
    }
    float x = X + margin + (l * column_width) + ( ( (ceil(Hx) - Hx) * column_width ) / 2f );
    float y = Y + margin + (c * line_height) + ( ( (ceil(Vx) - Vx ) * line_height) / 2f );
    set = (UIElement[]) append( set, new ListSelect( x, y, Hx * column_width, Vx * line_height, label, pos, li, nu, CS ) );
  }
  void addListSelect(String label, String pos, String[] l, integer n) {
    if ( columning ) {
      this.addListSelect( I, J + C, label, pos, l, n  );
      C += ceil( Vx );
    }
    else if ( rowing ) {
      this.addListSelect( I + C, J, label, pos, l, n  );
      C += ceil( Hx );
    }
    else println( "addListSelect failed: not columning nor rowing." );
  }  
  //&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
  //FilterBar( float x, float y, float w, float h, String label_, String pos, String[] l, integer s, ColorScheme c )
  void addFilterBar (int l, int c, String label, String pos, String[] li, integer s, bool e ) {
    addToIndices( l, c );
    float x = X + margin + (l * column_width) + ( ( (ceil(Hx) - Hx) * column_width ) / 2f );
    float y = Y + margin + (c * line_height) + ( ( (ceil(Vx) - Vx ) * line_height) / 2f );
    set = (UIElement[]) append( set, new FilterBar( x, y, Hx * column_width, Vx * line_height, label, pos, li, s, e, CS ) );
  }
  void addFilterBar(String label, String pos, String[] l, integer n, bool e) {
    if ( columning ) {
      this.addFilterBar( I, J + C, label, pos, l, n, e  );
      C += ceil( Vx );
    }
    else if ( rowing ) {
      this.addFilterBar( I + C, J, label, pos, l, n, e  );
      C += ceil( Hx );
    }
    else println( "addListSelect failed: not columning nor rowing." );
  }
  //&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
  void addNeighborhood_list (int l, int c, integer o_e, bool a, integer dn, integer nr, IntList nbhc ) {
    addToIndices( l, c );
    float x = X + margin + (l * column_width) + ( ( (ceil(Hx) - Hx) * column_width ) / 2f );
    float y = Y + margin + (c * line_height) + ( ( (ceil(Vx) - Vx ) * line_height) / 2f );
    set = (UIElement[]) append( set, new Neighborhood_list( x, y, Hx * column_width, Vx * line_height, o_e, a, dn, nr, nbhc ) );
  }
  //&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
  void addRule_list ( int l, int c, IntList nbhc ){
    addToIndices( l, c );
    float x = X + margin + (l * column_width) + ( ( (ceil(Hx) - Hx) * column_width ) / 2f );
    float y = Y + margin + (c * line_height) + ( ( (ceil(Vx) - Vx ) * line_height) / 2f );
    set = (UIElement[]) append( set, new Rule_list( x, y, Hx * column_width, Vx * line_height, nbhc ) );
  }
  //&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
  void addState_bar ( int l, int c, IntList i ) {
    addToIndices( l, c );
    float x = X + margin + (l * column_width) + ( ( (ceil(Hx) - Hx) * column_width ) / 2f );
    float y = Y + margin + (c * line_height) + ( ( (ceil(Vx) - Vx ) * line_height) / 2f );
    set = (UIElement[]) append( set, new State_bar( x, y, Hx * column_width, Vx * line_height, i ) );
  }
}


//8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8
// 8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8
//  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8


class Label {
  float x, y, w, ts;
  color c;
  Label() {
  }
  Label(float x_, float y_) {
    x = x_;
    y = y_;
    c = color(0);
  }
  Label(String str, String pos, float x_, float y_, float w, float h ) {
    int pad = 5;
    this.w = w;
    this.define_ts( str );
    //println( str, x_, y_, w, h );
    pushStyle();
    textSize( ts );
    float tw = textWidth(str);
    float line_height = textAscent()+textDescent()*1.5;
    popStyle();
    int lines = split(str, '\n').length;
    if( pos.length() == 4 ){
      if (pos.charAt(1) == 'I') {        // ~ ~ ~ ~ ~ ~ Inside
        switch(pos.charAt(0)) {
        case 'T': //Top
          y = y_ + pad - floor(ts/4f);
          break;
        case 'C': //Center
          y = y_ + ((h - (lines * line_height)) * 0.5 ) + 3;
          break;
        case 'B': //Bottom
          y = y_ + (h - ts) - pad ;
          break;
        }
      } else if (pos.charAt(1) == 'O') { // ~ ~ ~ ~ ~ ~ Outside
        switch(pos.charAt(0)) {
        case 'T': //Top
          y = y_ - ts -pad; 
          break;
        case 'C': //Center (this one should never be used)
          y = y_ + ((h - (lines * line_height)) * 0.5 );
          break;
        case 'B': //Bottom
          y = y_ + h + pad; 
          break;
        }
      }
      if (pos.charAt(3) == 'I') { 
        switch(pos.charAt(2)) {
        case 'L': //Left
          x = x_ + pad;
          break;
        case 'C': //Center
          x = x_ + (w/2f) - (tw/2f);
          break;
        case 'R': //Right
          x = x_ + w - tw - pad;
          break;
        }
      } else if (pos.charAt(3) == 'O') {
        switch(pos.charAt(2)) {
        case 'L': //Left
          x = x_ - tw - pad;
          break;
        case 'C': //Center (nor this one)
          x = x_ + (w/2f) - (tw/2f);
          break;
        case 'R': //Right
          x = x_ + w + pad;
          break;
        }
      }
    }
    else if( pos.equals("C") ){
      x = x_ + (w/2f) - (tw/2f);
      y = y_ + ((h - (lines * line_height)) * 0.5 ) + 3;
    }
    else{
      println("BAD POS ENTRY @ LABEL \""+str+"\": "+pos);
    }
    c = color(0);
  }
  
  void define_ts( String str ){
    ts = textsize;
    pushStyle();
    while( textWidth( str )+8 > w && ts > 10 ){
      --ts;
      textSize( ts );
    }
    popStyle();
  }
  
  void set( String str ){}
  
  void display() {
  }
  
  String return_str() { 
    return " ";
  }
}

// \|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\

class Static_String_Label extends Label {
  String s;
  Static_String_Label(String st) {
    s = st;
  }
  
  Static_String_Label(String st, String pos, float x_, float y_, float w, float h) {
    super( st, pos, x_, y_, w, h );
    s = st;
  }
  void set( String str ){
    s = str;
  }
  void display() {
    pushStyle();
    textSize( ts );
    textLeading( ts * 0.85 );
    fill(c);
    text(s, x, y);
    popStyle();
  }
  String returnS() { 
    return s;
  }
}

// \|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\

class Dynamic_Word_Label extends Label {
  public word w;
  Dynamic_Word_Label(word w_, String st, String pos, float x_, float y_, float w, float h) {
    super( st, pos, x_, y_, w, h );
    this.w = w_;
  }
  void display() {
    fill(c);
    text(w.w, x, y);
  }
}

// \|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\

class Dynamic_Integer_Label extends Label {
  integer incumbency;
  Dynamic_Integer_Label(integer i, float x_, float y_, float w, float h) {
    super( x_ + (w/2f), y_ + (h/2f));
    incumbency = i;
  }
  void display() {
    pushStyle();
    textAlign( CENTER, CENTER );
    fill(c);
    text( incumbency.n, x, y );
    popStyle();
  }
}

// \|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\

class Dynamic_Integer_Label_with_prologue extends Label {
  integer incumbency;
  String prologue;
  Dynamic_Integer_Label_with_prologue(String p, integer i, String pos, float x_, float y_, float w, float h) {
    super( p + str(i.n), pos, x_, y_, w, h ); //super( x_ + (w/2f), y_ + (h/2f));
    incumbency = i;
    prologue = p;
  }
  void display() {
    fill(c);
    text( prologue + incumbency.n, x, y );
  }
}

// \|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\

class Dynamic_Integer_Label_with_epilogue extends Label {
  integer incumbency;
  String epilogue;
  Dynamic_Integer_Label_with_epilogue(integer i, String e, String pos, float x_, float y_, float w, float h) {
    super( str(i.n) + e, pos, x_, y_, w, h ); //super( x_ + (w/2f), y_ + (h/2f));
    incumbency = i;
    epilogue = e;
  }
  void display() {
    fill(c);
    text( incumbency.n + epilogue, x, y );
  }
}

// \|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\

class Dynamic_Float_Label extends Label {
  floating_point incumbency;
  Dynamic_Float_Label(floating_point i, float x_, float y_, float w, float h) {
    super( x_ + (w/2f), y_ + (h/2f));
    incumbency = i;
  }
  void display() {
    pushStyle();
    textAlign( CENTER, CENTER );
    fill(c);
    text( nf(incumbency.n, 1, 1), x, y );
    popStyle();
  }
}

// \|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\

class Dynamic_Float_Label_with_prologue extends Label {
  floating_point incumbency;
  String prologue;
  Dynamic_Float_Label_with_prologue(String p, floating_point i, String pos, float x_, float y_, float w, float h) {
    super( p + nf(i.n, 1, 1), pos, x_, y_, w, h ); //super( x_ + (w/2f), y_ + (h/2f));
    incumbency = i;
    prologue = p;
  }
  void display() {
    fill(c);
    text( prologue + nf(incumbency.n, 1, 1), x, y );
  }
}

// \|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\

class Dynamic_Float_Label_with_epilogue extends Label {
  floating_point incumbency;
  String epilogue;
  Dynamic_Float_Label_with_epilogue(floating_point i, String e, String pos, float x_, float y_, float w, float h) {
    super( nf(i.n, 1, 1) + e, pos, x_, y_, w, h ); //super( x_ + (w/2f), y_ + (h/2f));
    incumbency = i;
    epilogue = e;
  }
  void display() {
    fill(c);
    text( nf(incumbency.n, 1, 1) + epilogue, x, y );
  }
}

// \|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\

class Dynamic_Coeff_Label extends Label { // takes a floating_point ranging from 0 to 1 and displays as a percentage.
  floating_point incumbency;
  Dynamic_Coeff_Label(floating_point i, float x_, float y_, float w, float h) {
    super( x_ + (w/2f), y_ + (h/2f));
    incumbency = i;
  }
  void display() {
    pushStyle();
    textAlign( CENTER, CENTER );
    fill(c);
    text( round(incumbency.n * 100) + "%", x, y );
    popStyle();
  }
}

// \|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\|/|\

class Dynamic_Letter_Label extends Label {
  letter incumbency;
  Dynamic_Letter_Label(letter i, String pos, float x_, float y_, float w, float h) {
    super("M", pos, x_, y_, w, h);
    incumbency = i;
  }
  void display() {
    fill(c);
    text(str(incumbency.l), x, y);
  }
}

//D)D)D)D)D)D)D)D)D)D)D)D)D)D)D)D)D)D)D)D)D)D)D)D)D)D)D)D)D)D)D)D)D)D)D)D)D)D)D)D)D)D)D)D)D)D)D)D)D)D)

class Vertical_Scrollbar{
  floating_point incumbency;
  NumAddButton_Flo up, down;
  float x, y, w, h, bh, hy, hh, min, max, K;
  boolean dragging;
  PGraphics tri;
  
  Vertical_Scrollbar( float x, float y, float w, float h, floating_point n, float step, float min, float max ) {
    incumbency = n;
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.min = min;
    this.max = max;
    hy = y + w;
    bh = h-(2*w);
    up = new  NumAddButton_Flo(x, y, w, w, n, step);
    //up.face = char(11205);//11165);
    down = new  NumAddButton_Flo(x, y + h - w, w, w, n, -step);
    //down.face = char(11206);//11167);
    tri = createGraphics( floor(w), floor(w) );
    float r = 0.3*w;
    float c = 0.5*w;
    tri.beginDraw();
    tri.fill(0);
    tri.noStroke();
    tri.triangle( c, c-r, c+(r*cos( PI/6.0 )), c+(r*sin( PI/6.0 )), c+(r*cos( PI*(5/6.0) )), c+(r*sin( PI*(5/6.0) )) );
    tri.endDraw();
  }
  void update(){
    float yi = y + w;
    float yf = y + h - w;
    hy = constrain( map( incumbency.n, min, 0, yf, yi ) - hh*0.5, yi, yf - hh );
  }
  void update( float content_height ){
    hh = constrain( bh * ( bh / content_height ), 0, bh);
    min = constrain( -( content_height - h), -999999, 0 );
    //up.min = min; @TODO I might have fucked this thing with the numADD re-do
    //down.min = min;
    //hy = y + h - w - hh;
    K = ( max-min )/( (h-2*w)-hh );
    if( K != K ) K = 0;
  }
  
  //mouseReleased and mouseDragged() assume the bar is at the right edge,
  //and that the mouse has already been checked to be withing the bar's owner's box.
  void mouseReleased(){
    dragging = false;
    float yi = y + w;
    float yf = y + h - w;
    if( mouseX > x ){
      if( mouseY < yi ) up.mouseReleased( true );
      else if( mouseY > yi && mouseY < yf ){
        incumbency.n += K*( pmouseY - mouseY );
      }
      else down.mouseReleased( true );
    }
    incumbency.n = constrain( incumbency.n, min, max );
    if( min < 0 ) hy = map( incumbency.n, min, 0, yf- hh, yi );
  }
  void mouseDragged(){
    float yi = y + w;
    float yf = y + h - w;
    if( dragging ){
      incumbency.n = constrain( incumbency.n + (K*( pmouseY - mouseY )), min, max );
      if( min < 0 ) hy = map( incumbency.n, min, 0, yf- hh, yi );
    }
    else{
      // this assumes the scrollbar is inside the rect of a UIElement (or whatever)
      // and that the mouse has already been checked to be inside this rect.
      if( mouseX > x && mouseY > yi && mouseY < yf ){
        dragging = true;
      }
    }
  }
  void display(ColorScheme CS){
    fill(CS.dim);
    rect( x, y, w, h );
    fill(CS.bright);
    rect( x, hy, w, hh );
    up.display(CS);
    down.display(CS);
    image( tri, x, y+2 );
    pushMatrix();
    translate(x, y+h);
    scale(1, -1);
    image(tri, 0 , 0);
    popMatrix();
  }
  void display(ColorScheme CS, PGraphics pg){
    pg.fill(CS.dim);
    pg.rect( x, y, w, h );
    pg.fill(CS.bright);
    pg.rect( x, hy, w, hh );
    up.display(CS, pg);
    down.display(CS, pg);
  }
}

//8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8
// 8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8
//  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8

class UIElement {
  float x, y, w, h;
  boolean pushed;
  Label label;
  UIElement(float x, float y, float w, float h) { // p = label position
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    //label = new Label(l, p, x, y, w, h);
  }
  
  float bottom(){ return y+h; }
  float right(){ return x+w; }
  
  void mouseMoved( boolean Q ){}
  void mouseMoved( boolean Q, float mx, float my ){}
  void mousePressed( boolean Q ){}
  boolean mousePressed( boolean Q, float mx, float my ){ return false; }
  void mouseReleased( boolean Q ){}
  void mouseReleased( boolean Q, float mx, float my ){}
  void mouseDragged( boolean Q ){}
  boolean mouseDragged( boolean Q, float mx, float my ){ return false; }
  void keyTyped(){}
  void keyReleased(){}
  
  boolean mouseOver(){
    return ( mouseX > x && mouseY > y && mouseX < x+w && mouseY < y+h );
  }
  
  //void set_label_color( color k ){ label.c = k; }
  void setLabel( String str, String pos ){
    label = new Static_String_Label( str, pos, x, y, w, h );
  }  
  void Rect() {
    rect(x, y, w, h);
  }
  void Rect(PGraphics pg) {
    pg.rect(x, y, w, h);
  }
  void display(ColorScheme CS) {
  }
  void add(char set, String label, String posos) {
  }
  void add( float[][] a ){
  }
  void add( Rule r, ArrayList<float[][]> N, IntList S ){
  }
  void setColor( color c ) {
  }
  void update(){
  }
  void set_condition( boolean c ){}
  float getmax_f(){ return 0; }
  int getmax_i(){ return 0; }
  void setmax( float m ){
  }
  void set_show_lines( boolean b ){
  }
  //boolean event(){ 
  //  return false;
  //}
}

//8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8
// 8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8
//  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8  8

class ToggleButton extends UIElement {
  bool incumbency;
  boolean highlighted;
  ToggleButton(float x, float y, float w, float h, String str, String pos, bool i) {
    super(x, y, w, h);
    this.setLabel( str, pos );
    incumbency = i;
  }
  
  void increment_y( float a ){
    y += a;
    label.y += a;
  }
  
  void mouseMoved( boolean Q ){ highlighted = Q; }
  void mouseReleased( boolean Q ){ if( Q ) incumbency.b = !incumbency.b; }
  
  void display(ColorScheme CS) {
    if ( incumbency.b ) fill(CS.brighter);
    else if ( highlighted ) fill(CS.bright);
    else fill(CS.dim);
    Rect();
    label.display();
  }
}

class Two_Label_Toggle extends ToggleButton {
  Label alt_label;
  Two_Label_Toggle(float x, float y, float w, float h, String label_1, String label_2, String pos, bool i) {
    super( x, y, w, h, label_1, pos, i );
    alt_label = new Static_String_Label( label_2, pos, x, y, w, h );
  }
  void display(ColorScheme CS) {
    if ( highlighted ) fill(CS.bright);
    else fill(CS.dim);
    Rect();
    if ( incumbency.b ) label.display();
    else alt_label.display();
  }
}

//==================================================================================

class LockableToggleButton extends UIElement {
  bool incumbency;
  boolean condition;
  boolean highlighted;
  LockableToggleButton(float x, float y, float w, float h, String str, String pos, bool i, boolean c) {
    super(x, y, w, h);
    this.setLabel( str, pos );
    incumbency = i;
    this.set_condition( c );
  }
  void set_condition( boolean c ){
    condition = c;
    if( c ) label.c = ( label.c & 16777215 ) | -16777216;
    else label.c = ( label.c & 16777215 ) | 2130706432; 
    //color( red(label.c), green(label.c), blue(label.c), 255 );
  }
  void mouseMoved( boolean Q ){ if( condition ) highlighted = Q; }
  void mouseReleased( boolean Q ){ if( Q && condition ) incumbency.b = !incumbency.b; }
  
  void display(ColorScheme CS) {
    if( condition ){
      if ( incumbency.b ) fill(CS.brighter);
      else if ( highlighted ) fill(CS.bright);
      else fill(CS.dim);
    }
    else fill( CS.dimmer );
    Rect();
    label.display();
  }
}

//==================================================================================

class NumSetButton extends UIElement {
  integer incumbency;
  int set;
  boolean highlighted;
  NumSetButton(float x, float y, float w, float h, String str, String pos, integer i, int s) {
    super(x, y, w, h);
    incumbency = i;
    set = s;
    this.setLabel( str, pos );
  }
  void mouseMoved( boolean Q ){ highlighted = Q; }
  void mouseReleased( boolean Q ){ if( Q ) incumbency.n = set; }
  
  void display(ColorScheme CS) {
    if ( incumbency.n == set ) fill(CS.brighter);
    else if ( highlighted ) fill(CS.bright);
    else fill(CS.dim);
    Rect();
    label.display();
  }
}

//==================================================================================

class CharSetButton extends UIElement {
  letter incumbency;
  char set;
  boolean highlighted;
  CharSetButton(float x, float y, float w, float h, String str, String pos, letter i, char s) {
    super(x, y, w, h);
    incumbency = i;
    set = s;
    this.setLabel( str, pos );
  }
  void mouseMoved( boolean Q ){ highlighted = Q; }
  void mouseReleased( boolean Q ){ if( Q ) incumbency.l = set; }
  
  void display(ColorScheme CS) {
    if ( incumbency.l == set ) fill(CS.brighter);
    else if ( highlighted ) fill(CS.bright);
    else fill(CS.dim);
    Rect();
    label.display();
  }
}

//==================================================================================

class DropDown extends UIElement {
  CharSetButton[] set;
  boolean open, highlighted;
  letter incumbency;
  DropDown(float x, float y, float w, float h, String str, String pos, letter i) {
    super(x, y, w, h);
    set = new CharSetButton[0];
    incumbency = i; 
    this.setLabel( str, pos );
  }
  void set_label_color( color k ){
    label.c = k; 
    for(int s = 0; s < set.length; ++s){
      set[s].label.c = k;
    }
  }
  void add(char set, String label, String pos) {
    this.set = (CharSetButton[]) append( this.set, new CharSetButton( x, y + ( (this.set.length+1) * h ), w, h, label, pos, incumbency, set) );
  }
  void mouseMoved( boolean Q ){
    highlighted = Q;
    if( open ){
      int j = -1;
      if( (mouseX - x) > 0 && (mouseX - x) < w ){
        if( (mouseY > y+h) && mouseY < y+( (set.length+1) * h ) ){
          j = floor((mouseY - (y+h)) / h);
          set[j].mouseMoved(true);
        }
      }
      if( j >= 0 ) for(int k = 0; k < set.length; k++) if( k != j ) set[k].mouseMoved(false);
    }
  }
  void mouseReleased( boolean Q ){
    if( open ){
      int j = -1;
      if( (mouseX - x) > 0 && (mouseX - x) < w ){
        if( (mouseY > y+h) && mouseY < y+( (set.length+1) * h ) ){
          j = floor((mouseY - (y+h)) / h);
          set[j].mouseReleased(true);
        }
      }
      if( j >= 0 ) for(int k = 0; k < set.length; k++) if( k != j ) set[k].mouseReleased(false);
    }
    
    if( Q ) open = !open;
    else open = false;
  }
  
  void display(ColorScheme CS) {
    if ( highlighted ) fill(CS.bright);
    else fill(CS.dim);
    Rect();
    boolean u = true;
    for(int k = 0; k < set.length; k++){
      if( incumbency.l == set[k].set ){
        pushMatrix();
        translate( 0, -(k+1)*h );
        set[k].label.display();
        popMatrix();
        u = false;
        break;
      }
    }
    if( u ) label.display();
    if( open ) for(int k = 0; k < set.length; k++) set[k].display(CS);
  }
}

//==================================================================================

class NumAddButton_Flo extends UIElement {
  floating_point incumbency;
  float step;
  char face;
  boolean highlighted;
  NumAddButton_Flo(float x, float y, float w, float h, floating_point i, float step) {
    super(x, y, w, h);
    incumbency = i;
    this.step = step;
    if( step > 0 ) face = '+';//char(10133);
    else if( step < 0 ) face = '-';//char(10134);
    else face = '•';
  }
  
  void mouseMoved( boolean Q ){ highlighted = Q; }
  
  void mouseReleased(){
    if ( this.mouseOver() ){
      incumbency.n += step;
    }
  } 
  void mouseReleased( boolean Q ){
    if (Q){
      incumbency.n += step;
    }
  } 
  void display(ColorScheme CS) {
    if ( highlighted ) fill(CS.bright);
    else fill(CS.dim);
    Rect();
    pushStyle();
    fill(0);
    textFont( ui_font );
    textAlign( CENTER, CENTER );
    textSize(16);
    text( face, x + w * 0.5, y + h * 0.5 );
    popStyle();
  }
  void display(ColorScheme CS, PGraphics pg) {
    if ( highlighted ) pg.fill(CS.bright);
    else pg.fill(CS.dim);
    Rect(pg);
    pg.pushStyle();
    pg.fill(255);
    pg.textAlign( CENTER, CENTER );
    pg.textSize(16);
    pg.text( face, x + w * 0.5, y + h * 0.5 );
    pg.ellipse( x + w * 0.5, y + h * 0.5, 4, 4 );
    pg.popStyle();
  }
}

//==================================================================================

class NumAddButton_Int extends UIElement {
  integer incumbency;
  int step;
  char face;
  boolean highlighted;
  
  NumAddButton_Int(float x, float y, float w, float h, integer i, int step) {
    super(x, y, w, h);
    incumbency = i;
    this.step = step;
    if( step > 0 ) face = '+';//char(10133);
    else if( step < 0 ) face = '-';//char(10134);
    else face = '•';
  }
  void mouseMoved( boolean Q ){ highlighted = Q; }
  
  void mouseReleased( boolean Q ){
    if( Q ){
      incumbency.n += step;
    }
  }  
  void display(ColorScheme CS) {
    if ( highlighted ) fill(CS.bright);
    else fill(CS.dim);
    Rect();
    pushStyle();
    fill(0);
    textFont( ui_font );
    textAlign( CENTER, CENTER );
    textSize(16);
    text( face, x + w * 0.5, y + h * 0.5 );
    popStyle();
  }
  void display(ColorScheme CS, PGraphics pg) {
    if ( highlighted ) pg.fill(CS.bright);
    else pg.fill(CS.dim);
    Rect(pg);
    pg.pushStyle();
    pg.fill(255);
    pg.textAlign( CENTER, CENTER );
    pg.textSize(16);
    pg.text( face, x + w * 0.5, y + h * 0.5 );
    pg.ellipse( x + w * 0.5, y + h * 0.5, 4, 4 );
    pg.popStyle();
  }
}

//==================================================================================

class PlusMinus_Flo extends UIElement {
  floating_point incumbency;
  NumAddButton_Flo plus;
  NumAddButton_Flo minus;
  Label n_label;
  PlusMinus_Flo(float x, float y, float w, float h, String str, String pos, floating_point i, float step) {
    super(x, y, w, h);//(x+h, y, w-(2*h), h);
    incumbency = i; 
    plus = new NumAddButton_Flo(x + (w-h), y, h, h, i, step);
    minus = new NumAddButton_Flo(x, y, h, h, i, -step);
    n_label = new Dynamic_Float_Label( i, x+h, y, w-(2*h), h );
    this.setLabel( str, pos );
  }
  
  void mouseMoved( boolean Q ){
    if( Q ){
      plus.mouseMoved( mouseX > x + (w-h) );
      minus.mouseMoved( mouseX < h );
    }
    else{
      plus.mouseMoved(Q);
      minus.mouseMoved(Q);
    }
  }
  void mouseReleased( boolean Q ){
    if( Q ){
      plus.mouseReleased( mouseX > x + w - h );
      minus.mouseReleased( mouseX < x + h );
    }
    else{
      plus.mouseReleased(false);
      minus.mouseReleased(false);
    }
  }
  
  void display(ColorScheme CS) {
    fill(CS.dim);
    Rect();
    n_label.display();
    label.display();
    plus.display(CS);
    minus.display(CS);
  }
}

//==================================================================================

class PlusMinus_Int extends UIElement {
  integer incumbency;
  NumAddButton_Int plus;
  NumAddButton_Int minus;
  Label n_label;
  PlusMinus_Int(float x, float y, float w, float h, String str, String pos, integer i, int step) {
    super(x, y, w, h);//(x+h, y, w-(2*h), h);
    incumbency = i;
    plus = new NumAddButton_Int(x + (w-h), y, h, h, i, step);
    minus = new NumAddButton_Int(x, y, h, h, i, -step);
    n_label = new Dynamic_Integer_Label( i, x+h, y, w-(2*h), h );
    this.setLabel( str, pos );
  }
  
  void increment_y( float a ){
    y += a;
    n_label.y += a;
    plus.y += a;
    minus.y += a;
  }
  
  void mouseMoved( boolean Q ){
    if( Q ){
      plus.mouseMoved( mouseX > x + (w-h) );
      minus.mouseMoved( mouseX < h );
    }
    else{
      plus.mouseMoved(Q);
      minus.mouseMoved(Q);
    }
  }
  void mouseMoved( boolean Q, float mx, float my ){
    if( Q ){
      plus.mouseMoved( mx > x +w -h );
      minus.mouseMoved( mx < x + h );
    }
    else{
      plus.mouseMoved(Q);
      minus.mouseMoved(Q);
    }
  }
  void mouseReleased( boolean Q ){
    if( Q ){
      plus.mouseReleased( mouseX > x + w - h );
      minus.mouseReleased( mouseX < x + h );
    }
    else{
      plus.mouseReleased(false);
      minus.mouseReleased(false);
    }
  }
  void mouseReleased( boolean Q, float mx, float my ){
    if( Q ){
      plus.mouseReleased( mx > x +w -h );
      minus.mouseReleased( mx < x + h );
    }
    else{
      plus.mouseReleased(false);
      minus.mouseReleased(false);
    }
  }
  
  void display(ColorScheme CS) {
    fill(CS.dim);
    Rect();
    n_label.display();
    label.display();
    plus.display(CS);
    minus.display(CS);
  }
}
//==================================================================================

class Slider extends UIElement {
  floating_point incumbency;
  float min, max;
  boolean highlighted;
  Slider(float x, float y, float w, float h, String str, String pos, floating_point i, float min, float max) {
    super(x, y, w, h);
    this.setLabel( str, pos );
    incumbency = i;
    this.min = min;
    this.max = max;
  }
  float getmax_f(){ return max; }
  void setmax( float m ){ max = m; }
  void receive_input(boolean Q){
    if( Q ){
      incumbency.n = map(mouseX, x+4, x+w-4, min, max);
      incumbency.n = constrain(incumbency.n, min, max);
    }
  }
  void mouseMoved( boolean Q ){ highlighted = Q; }
  void mouseDragged( boolean Q ){
    receive_input(Q);
  }
  void mouseReleased( boolean Q ){
    receive_input(Q);
  }
  void display(ColorScheme CS) {
    fill(CS.dim);
    Rect();
    if ( highlighted ) fill(CS.bright);
    else fill(CS.dim);
    rect(map(constrain(incumbency.n, min, max), min, max, x+4, x+w-4)-4, y-1, 8, h+2);  
    label.display();
  }
}
//==================================================================================

class cool_Slider extends Slider{
  color b, f;
  Label nlabel;
  //boolean E;
  cool_Slider(float x, float y, float w, float h, String str, String pos, floating_point i, float min, float max, color cb, color cf, float uw) {
    super( x, y, w, h, str, pos, i, min, max );
    b = cb;
    f = cf;
    nlabel = new Dynamic_Float_Label( i, x+w, y, uw, h );
  }
  /*
  void mouseDragged( boolean Q ){
    receive_input(Q);
    E = true;
  }
  void mouseReleased( boolean Q ){
    receive_input(Q);
    E = true;
  }
  boolean event(){
    if( E ){
      E = false;
      return true;
    }
    return false;
  }
  */
  void display(ColorScheme CS) {
    fill(b);
    Rect();
    if ( highlighted ) fill(CS.bright);
    else fill(CS.dim);
    float iw = map(constrain(incumbency.n, min, max), min, max, 0, w-8);
    fill(f);
    rect( x, y, iw, h );
    if ( highlighted ) fill(CS.brighter);
    else fill(CS.bright);
    rect( x+4+iw - 4, y-1, 8, h+2);  
    label.display();
    nlabel.display();
  }
}
//==================================================================================

class integer_Slider extends UIElement {
  integer incumbency;
  int min, max;
  boolean highlighted;
  integer_Slider(float x, float y, float w, float h, String str, String pos, integer i, int min, int max) {
    super(x, y, w, h);
    this.setLabel( str, pos );
    incumbency = i;
    this.min = min;
    this.max = max;
  }
  int getmax_i(){ return max; }
  void setmax( int m ){ max = m; }
  void receive_input(boolean Q){
    if( Q ){
      incumbency.n = round( constrain( map(mouseX, x+4, x+w-4, min, max), min, max ) );
    }
  }
  void mouseMoved( boolean Q ){ highlighted = Q; }
  void mouseDragged( boolean Q ){
    receive_input(Q);
  }
  void mouseReleased( boolean Q ){
    receive_input(Q);
  }
  void display(ColorScheme CS) {
    fill(CS.dim);
    Rect();
    if ( highlighted ) fill(CS.bright);
    else fill(CS.dim);
    rect(map(constrain(incumbency.n, min, max), min, max, x+4, x+w-4)-4, y-1, 8, h+2);  
    label.display();
  }
}
//==================================================================================

class cool_integer_Slider extends integer_Slider{
  color b, f;
  Label nlabel;
  
  cool_integer_Slider(float x, float y, float w, float h, String str, String pos, integer i, int min, int max, color cb, color cf, float uw) {
    super( x, y, w, h, str, pos, i, min, max );
    b = cb;
    f = cf;
    nlabel = new Dynamic_Integer_Label( i, x+w, y, uw, h );
  }
  void display(ColorScheme CS) {
    fill(b);
    Rect();
    if ( highlighted ) fill(CS.bright);
    else fill(CS.dim);
    float iw = map(constrain(incumbency.n, min, max), min, max, 0, w-8);
    fill(f);
    rect( x, y, iw, h );
    if ( highlighted ) fill(CS.brighter);
    else fill(CS.bright);
    rect( x+4+iw - 4, y-1, 8, h+2);  
    label.display();
    nlabel.display();
  }
}

//==================================================================================

class subSlider extends UIElement {
  float n;
  float min, max;
  subSlider(float x, float y, float w, float h, float min, float max) {
    super(x, y, w, h);
    //n = max/2f;
    n = min;
    this.min = min;
    this.max = max;
  }
  void mousePressed(){
    if (mouseX>x && mouseX<(x+w) && mouseY>y && mouseY<(y+h)){
      n = constrain(map(mouseY, y+4, y+h-4, max, min), min, max);
    }
  }
  void mouseDragged(){
    if (mouseX>x && mouseX<(x+w) && mouseY>y && mouseY<(y+h)){
      n = constrain(map(mouseY, y+4, y+h-4, max, min), min, max);
    }
  }
  void display(ColorScheme CS) {
    fill(CS.dim);
    rect( x, map(n, min, max, y+h-6, y+3)-3, w, 6);
  }
}

//==================================================================================

class ColorSelector extends UIElement {
  pigment incumbency;
  subSlider red, green, blue;
  float bw;
  float bh;
  float N;
  float margin;
  
  ColorSelector(float x, float y, float w, float h, pigment p) {
    super(x, y, w, h);
    incumbency = p;
    margin = 2;
    bw = (w - (4*margin))/3f;
    bh = (h - (w/3f)) - 3*margin;
    red =   new subSlider(margin + x, y, bw, bh, 0, 255);
    green = new subSlider(2*margin + bw + x, y, bw, bh, 0, 255);
    blue =  new subSlider(3*margin + 2*bw + x, y, bw, bh, 0, 255);
    N = 90;
    label = new Static_String_Label("colorSelector");
  }
  void setColor( color c ) {
    red.n = red(c);
    green.n = green(c);
    blue.n = blue(c);
  }
  void mousePressed( boolean Q ){
    if( Q ){
      red.mousePressed();
      green.mousePressed();
      blue.mousePressed();
      incumbency.p = color(red.n, green.n, blue.n);
    }
  }
  void mouseDragged( boolean Q ){
    if( Q ){
      red.mouseDragged();
      green.mouseDragged();
      blue.mouseDragged();
      incumbency.p = color(red.n, green.n, blue.n);
    }
  }
  
  void display(ColorScheme CS) {
    fill(0);
    stroke(0);
    Rect();

    for (float i = 1; i<=N; i++) {
      color co = lerpColor(color(255, green(incumbency.p), blue(incumbency.p)), color(0, green(incumbency.p), blue(incumbency.p)), i/N);
      fill(co);
      stroke(co);
      rect(x + margin, y + margin + ((i-1)*(bh/N)), bw, bh/N);
    }
    x += bw+margin;
    for (float i = 1; i<=N; i++) {
      color co = lerpColor(color(red(incumbency.p), 255, blue(incumbency.p)), color(red(incumbency.p), 0, blue(incumbency.p)), i/N);
      fill(co);
      stroke(co);
      rect(x + margin, y + margin + ((i-1)*(bh/N)), bw, bh/N);
    }
    x += bw+margin;
    for (float i = 1; i<=N; i++) {
      color co = lerpColor(color(red(incumbency.p), green(incumbency.p), 255), color(red(incumbency.p), green(incumbency.p), 0), i/N);
      fill(co);
      stroke(co);
      rect(x + margin, y + margin + ((i-1)*(bh/N)), bw, bh/N);
    }
    x -= 2*(bw+margin);
    stroke(0);
    red.display(CS);
    green.display(CS);
    blue.display(CS);
    fill(incumbency.p);
    rect(x + margin, y + bh + 3*margin, w - 2*margin, (w/3f) -2*margin); //+ 7.5*margin
  }
}

//==================================================================================

class Yanker extends UIElement {
  floating_point incumbency;
  float X, domain, base, coeff;
  int ps;
  boolean held, highlighted;
  PGraphics lines;
  Yanker(float x, float y, float w, float h, String label_, String pos, floating_point i, float d, float b, float c) {
    super(x, y, w, h);
    label = new Static_String_Label(label_, pos, x, y, w, h);
    incumbency = i;
    domain = d;
    base = b;
    coeff = c;

    lines = createGraphics(int(w), int(h));
    lines.beginDraw();
    lines.stroke(255);
    int l = ceil((w-10)/4f);
    float eqs = map(w, 4, w-4, -domain, domain);
    float m = exponential_term(eqs) + eqs*coeff;
    float hh = h/2f;
    for (int n = 0; n < l; n++) {
      int mx = 6+(n*4);
      eqs = map(mx, 4, w-4, -domain, domain);
      float wai = exponential_term( eqs ) + eqs*coeff;
      lines.line(mx, hh, mx, map(wai, -m, m, h-5, 5));
    }
    lines.line(w/2f, 4, w/2f, h-4);
    lines.endDraw();
  }
  float exponential_term(float a){
    if( a < 0 ) return -pow(base, -a);
    else return pow(base, a);
  }
  
  void mouseOver( boolean Q ){ highlighted = Q; }
  void mousePressed( boolean Q ){
    if( Q ){
      held = true;
      X = map(mouseX, x+4, x+w-4, -domain, domain);
    }
  }
  void mouseDragged( boolean Q ){
    if( Q ){
      held = true; 
      X = map(mouseX, x+4, x+w-4, -domain, domain);
    }
  }
  void mouseReleased( boolean Q ){
    held = false;
  }
  
  void display(ColorScheme CS) {
    if(held){
      incumbency.n += ( exponential_term(X) + coeff*X ) * ((millis()-ps) / 1000.0);
      ps = millis();
    }
    else {
      if (abs(X)<0.05) X = 0;
      else X *= 0.3;
    }
    pushStyle();
    imageMode( CORNER );
    fill(CS.dim);
    Rect();
    image(lines, x, y);
    if ( highlighted ) fill(CS.brighter);
    else fill(CS.bright);
    rect(map(constrain(X, -domain, domain), -domain, domain, x+4, x+w-4)-4, y-1, 8, h+2);  
    label.display();
    popStyle();
  }
}

//==================================================================================
String lineWrap( String[] in, float w ){ // use lineWrap( split( XXX, '\n' ), www ); otherwise
  String out = "";
  for( int i = 0; i < in.length-1; ++i ){
    out += lineWrap( in[i], w ) + "\n";
  }
  out += lineWrap( in[in.length-1], w );
  return out;
}

String lineWrap( String in, float w ){ // use this one if you're sure your string has no line breaks in it.
  String[] words = split( in, ' ' );
  float line_total = 0;
  float stw = textWidth( " " );
  String out = "";
  for( int i = 0; i < words.length; ++i ){
    float tw = textWidth( words[i] );
    if( tw > w ){
      for( int j = 0; j < words[i].length(); ++j ){
        float ctw = textWidth( words[i].charAt(j) );
        if( line_total + ctw < w ){
          line_total += ctw;
          out += words[i].charAt(j);
        }
        else{
          line_total = ctw;
          out += "\n" + words[i].charAt(j);
        }
      }
    }
    else if( line_total + stw + tw < w ){
      line_total += stw + tw;
      out += words[i];
      if( i < words.length-1 ) out += " ";
    }
    else{
      line_total = tw;
      out += "\n" + words[i];
    }
  }
  return out;
}

//=================================================================================

class TextDisplay_vertical extends UIElement {
  word incumbency;
  floating_point scroll;
  Vertical_Scrollbar scrollbar;
  ColorScheme CS;
  float line_height, tx;
  int pil, max_lines, line_count; // previous incumbency length
  String wrapped;
  PGraphics d;
  boolean show_lines;

  TextDisplay_vertical( float x, float y, float w, float h, String label_, String pos, word i, ColorScheme c ) {
    super(x, y, w, h);
    label = new Static_String_Label(label_, pos, x, y, w, h);
    incumbency = i;
    CS = c;
    wrapped = "";
    textFont( ui_font );
    textSize( textsize );
    line_height = ( textAscent() + textDescent() ) * 1.2767;
    max_lines = floor( h / line_height );
    scroll = new floating_point( 0 );
    float bar_w = (h < 32)? floor((h-1)*0.5) : 16;
    float min = -(((split( wrapped, '\n' ).length + 2) * line_height ) - h);
    scrollbar = new Vertical_Scrollbar( x + w - bar_w, y, bar_w, h, scroll, line_height, min, 0 );
    this.update();
  }
  void set_show_lines( boolean b ){
    show_lines = b;
  }
  
  void update(){
    pil = incumbency.w.length();
    wrapped = lineWrap( split( incumbency.w, '\n' ), w - scrollbar.w  ); 
    String[] split = split( wrapped, '\n' );
    line_count = split.length; 
    if( line_count > max_lines ){//1 && lines * line_height > h
      this.dlh();
      float content_height = (line_count+1) * line_height;
      //scroll.n = constrain( -( content_height - h), -999999, 0 );
      this.render();
      scrollbar.update( content_height );
    }
    else{
      d = null;
      tx = 0;
      line_height = ( textAscent() + textDescent() ) * 1.2767;
      String[] spl = split( incumbency.w, '\n' );
      line_count = spl.length;
      wrapped = lineWrap( spl, w );
    }
  }
  
  void dlh(){// this is only necessary because FX2D and the defaut renderer render text totally differently for some ungodly reason.
    d = createGraphics( int(w), int(h) );
    d.beginDraw();
    d.textFont( ui_font );
    d.textSize(textsize);
    d.textAlign(LEFT, TOP);
    line_height = ( d.textAscent() + d.textDescent() ) * 1.2767;
    d.endDraw();
  }
  
  void render(){
    d = createGraphics( int(w), int(h) );
    d.beginDraw();
    d.textFont( ui_font );
    d.textSize(textsize);
    //d.textLeading(27);
    d.textAlign(LEFT, TOP);
    d.stroke( 0 );
    d.fill(0);
    d.rect(0, 0, w-1, h-1);
    d.pushMatrix();
    d.translate( 0, scroll.n );
    if( show_lines ){
      int cs = str( line_count -2 ).length();
      d.fill( 170 );
      for( int i = -1; i < line_count-1; ++i ){
        d.text( nf( i, cs ), 5, 8 + ( (i+1) * line_height ) );
      }
      tx = d.textWidth( str( line_count -2 )+" " ) + 5;
    }
    d.fill(255);
    d.text( wrapped, 5 + tx, 8 );
    d.popMatrix();
    d.stroke( CS.bright );
    d.noFill();
    d.rect(0, 0, w-1, h-1);
    d.endDraw();
    println("redered");
  }
  
  void mouseReleased( boolean Q ){
    if( Q ){
      if( d != null ){
        scrollbar.mouseReleased();
        this.render();
      }
    }
  }
  void mouseDragged( boolean Q ){
    if( Q ){
      if( d != null ){
        scrollbar.mouseDragged();
        this.render();
      }
    }
  }
  void mouseWheel( boolean Q, MouseEvent E ){
    if( Q ){
      if( d != null ){
        scroll.n = constrain( scroll.n - (12*E.getAmount()), scrollbar.min, scrollbar.max );
        scrollbar.update();
        this.render();
      }
    }
  }
  
  void display(ColorScheme CS){
    fill(255);
    label.display();
    if( incumbency.w == null ) incumbency.w = "";
    
    if( pil != incumbency.w.length() ) this.update();
    
    if( d == null ){
      pushStyle();
      stroke( CS.bright );
      fill( 0 );
      Rect();
      if( show_lines ){
        int cs = str( line_count -2 ).length();
        fill( 170 );
        for( int i = -1; i < line_count-1; ++i ){
          text( nf( i, cs ), x+5, y+6 + ( (i+1) * line_height ) );
        }
        tx = textWidth( str( line_count -2 )+" " ) + 5;
      }
      fill(255);
      text( wrapped, x+5 + tx, y+5 );
      popStyle();
    }
    else{
      image( d, x, y );
      scrollbar.display(CS);
    }
  }
}

//==================================================================================

class TextDisplay_horizontal extends UIElement {
  word incumbency;
  floating_point scroll;
  ColorScheme CS;
  int pil; // previous incumbency length
  float scroll_min;
  PGraphics d;
  NumAddButton_Flo left, right;

  TextDisplay_horizontal( float x, float y, float w, float h, String label_, String pos, word i, ColorScheme c ) {
    super(x, y, w, h);
    label = new Static_String_Label(label_, pos, x, y, w, h);
    incumbency = i;
    CS = c;
    scroll = new floating_point( 0 );
    scroll_min = textWidth( incumbency.w ) - w;
    right = new  NumAddButton_Flo(x, y+1, h * 0.75, h-3, scroll, 16);
    right.face = '<';
    left = new  NumAddButton_Flo(x+w - (h * 0.75) , y+1, h * 0.75, h-3, scroll, -16);
    left.face = '>';
    pil = incumbency.w.length();
  }
  
  void render(){
    d = createGraphics( int(w), int(h) );
    d.beginDraw();
    d.textFont( ui_font );
    d.textSize(textsize);
    //d.textLeading(27);
    d.textAlign(LEFT, TOP);
    d.stroke( 0 );
    d.fill(0);
    d.rect(0, 0, w-1, h-1);
    d.pushMatrix();
    d.translate( scroll.n, 0 );
    d.fill(255);
    d.text( incumbency.w, 5, 8 );
    d.popMatrix();
    d.stroke( CS.bright );
    d.noFill();
    d.rect(0, 0, w-1, h-1);
    d.endDraw();
  }
  
  void mouseReleased( boolean Q ){
    if( Q ){
      if( d != null ){
        left.mouseReleased();
        right.mouseReleased();
        scroll.n = constrain( scroll.n, scroll_min, left.w );
        this.render();
      }
    }
  }
  void mouseWheel( boolean Q, MouseEvent E ){
    if( Q ){
      if( d != null ){
        scroll.n = constrain( scroll.n - (8*E.getAmount()), scroll_min, left.w );
        this.render();
      }
    }
  }
  
  void display(ColorScheme CS){
    fill(255);
    label.display();
    if( incumbency.w == null ) incumbency.w = "";
    
    if( pil != incumbency.w.length() ){
      pil = incumbency.w.length();
      scroll_min = w - 2*h - textWidth( incumbency.w );
      if( scroll_min < 0 ){
        if( d == null ) scroll.n += left.w;
        this.render();
      }
      else{
        scroll.n = 0;
        d = null;
      }
      //scroll.n = constrain( scroll.n, scroll_min, left.w );
    }
    
    
    if( d == null ){
      pushStyle();
      stroke( CS.bright );
      fill( 0 );
      Rect();
      fill(255);
      text( incumbency.w, x+5, y+5 );
      popStyle();
    }
    else{
      image( d, x, y );
      left.display(CS);
      right.display(CS);
    }
  }
}
//==================================================================================
class TextField_vertical extends TextDisplay_vertical {
  int cursor, nCursorBlink;
  float cursorX, cursorY, cursorH;

  TextField_vertical( float x, float y, float w, float h, String label_, String pos, word i, ColorScheme c ){
    super(x, y, w, h, label_, pos, i, c);
    cursor = -1;
  }
  void set_show_lines( boolean b ){
    show_lines = b;
  }
  
  void refresh_cursor_pos(){
    if( cursor >= incumbency.w.length() ) cursor = incumbency.w.length();
    if( cursor >= 0 && wrapped.length() >= 0 ){
      String until = wrapped.substring(0, cursor);
      String[] s = split( until, '\n' );
      cursorH = line_height * 0.85;
      float U = (s.length - 1) * line_height;
      cursorY = y + scroll.n + U + 4;
      float d = (y + h - 1.3 * line_height) - cursorY;
      if( d < 0 ) scroll.n += d;
      cursorX = round(x + textWidth( s[s.length - 1] ) + 5);
      nCursorBlink = millis() + 1000;
    }
  }
  
  void mouseDragged( boolean Q ){
    if( Q ){
      super.mouseDragged(Q);
      refresh_cursor_pos();
    }
  }
  
  void mouseReleased( boolean Q ){
    if( Q && incumbency.w != null ){
      super.mouseReleased(Q);
      
      int l = floor((mouseY - scroll.n - y) / line_height);
      String[] lines = split( wrapped, '\n' );
      if( l >= lines.length ) l = lines.length-1;
      cursor = 0;
      for( int i = 0; i < l; ++i ) cursor += lines[i].length();
      float tw = 0;
      boolean on_line = true;
      if( l >= 0 ){
        for( int i = 0; i < lines[l].length(); ++i ){
          tw += textWidth( lines[l].charAt(i) );
          if( mouseX - x - 5 < tw ){
            cursor += i + 1;
            on_line = false;
            break;
          }
        }
      }
      if( on_line ) cursor += lines[l].length() + l;
    }
    else cursor = -1;
    refresh_cursor_pos();
  }
  
  void keyTyped(){
    if ( cursor >= 0 && cursor <= incumbency.w.length() ){
      if( incumbency.w == null ) incumbency.w = "";
      if(key != CODED ){
        switch ( key ) {
        case BACKSPACE:
          if ( cursor > 0 ) {
            StringBuilder b = new StringBuilder(incumbency.w);
            b.deleteCharAt( cursor - 1 );
            incumbency.w = b.toString();
            --cursor;
          }
          break;
        case DELETE:
          if ( cursor < incumbency.w.length() ) {
            StringBuilder b = new StringBuilder(incumbency.w);
            b.deleteCharAt( cursor );
            incumbency.w = b.toString();
          }
          break;
        case 0x16: // Ctrl+V
          {
          //if( cursor < 0 ) cursor = 0;
          //StringBuilder b = new StringBuilder(incumbency.w);
          //String clip = GetTextFromClipboard();
          //b.insert( cursor, clip );
          //incumbency.w = b.toString();
          //cursor += clip.length();
          }
          break;
        case 0x18: // Ctrl+X
          //writeTextToClipboard( incumbency.w );
          //incumbency.w = "";
          break;
        case 0x03: // Ctrl+C
          //writeTextToClipboard( incumbency.w );
          break;
        default:
          StringBuilder b = new StringBuilder(incumbency.w);
          b.insert( cursor, key );
          incumbency.w = b.toString();
          ++cursor;
          break;
        }
      }
    }
    wrapped = lineWrap( incumbency.w, w-10 );
    refresh_cursor_pos();
  }
  
  void keyReleased(){
    if ( cursor >= 0 && incumbency.w != null ){
      if(key == CODED ){
        switch ( keyCode ){
        case LEFT:
          if ( cursor > 0 ) --cursor;
          break;
        case RIGHT:
          if ( cursor < incumbency.w.length() ) ++cursor;
          break;
        case 35:
          cursor = incumbency.w.length();
          break;
        case 36:
          cursor = 0;
        }
      }
      refresh_cursor_pos();
    }
  }
  
  void display_cursor(){
    pushStyle();
    stroke(#FFFFFF);
    //println( cursor, incumbency.w.length() );
    if( cursor >= 0 && cursor <= incumbency.w.length() && cursorY > y && cursorY < y+h-cursorH ){
      if( nCursorBlink > millis() ){
        line(cursorX + tx, cursorY, cursorX + tx, cursorY+cursorH );
      }
      else if( millis() > nCursorBlink + 200 ) nCursorBlink = millis() + 1000;
    }
    popStyle();
  }
  
  void display(ColorScheme CS) {
    super.display(CS);
    if( incumbency.w == null ) incumbency.w = "";
    
    this.display_cursor();
  }
}

//==================================================================================

class TextField_horizontal extends TextDisplay_horizontal {
  int cursor, nCursorBlink;
  float cursorX, cursorY, cursorH;
  
  // TextDisplay( float x, float y, float w, float h, String label_, String pos, word i )
  TextField_horizontal( float x, float y, float w, float h, String label_, String pos, word i, ColorScheme c ){
    super(x, y, w, h, label_, pos, i, c);
    cursor = -1;
    cursorY = y + h * 0.075;
    cursorH = h * 0.85;
  }
  
  void refresh_cursor_pos(){
    if( cursor >= incumbency.w.length() ) cursor = incumbency.w.length();
    if( cursor >= 0 && incumbency.w.length() >= 0 ){
      String until = incumbency.w.substring(0, cursor);
      String[] spl = split( until, '\n' );
      float tw = ( d == null )? textWidth( spl[spl.length - 1] ) : d.textWidth( spl[spl.length - 1] );
      cursorX = round(x + tw + 5);
      nCursorBlink = millis() + 1000;
    }
  }
  
  void mouseDragged( boolean Q ){
    super.mouseDragged(Q);
  }
  
  void mouseReleased( boolean Q ){
    if( Q ){
      if( incumbency.w == null ) incumbency.w = "";
      if( mouseX < x + left.w || mouseX > x + w - right.w ) super.mouseReleased(Q);
      else{
        float X = mouseX - 5 - scroll.n;
        float TW = textWidth( incumbency.w );
        if( X >= TW ) {
          cursor = incumbency.w.length();
          cursorX = textWidth( incumbency.w.substring( 0, cursor ) );
        }
        else{
          cursor = round( X * ( incumbency.w.length() / TW ) );
          cursorX = textWidth( incumbency.w.substring( 0, cursor ) );
          float dif = abs( cursorX - X );
          boolean done = false;
          boolean ok = false;
          for( int i = cursor + 1; i < incumbency.w.length()-1; ++i ){
            float tw = textWidth( incumbency.w.substring( 0, i+1 ) );
            float ndif = abs( tw - X );
            if( ndif < dif ){
              ok = true;
              dif = ndif;
              cursor = i+1;
              cursorX = tw;
            }
            else if( ok ){
              done = true;
              cursor = i;
              cursorX = tw;
              break;
            }
            else break;
          }
          if( !done ){
            for( int i = cursor - 1; i > 0; --i ){
              float tw = textWidth( incumbency.w.substring( 0, i+1 ) );
              float ndif = abs( tw - X );
              if( ndif < dif ){
                ok = true;
                dif = ndif;
                cursor = i+1;
                cursorX = tw;
              }
              else if( ok ){
                done = true;
                cursor = i+1;
                cursorX = tw;
                break;
              }
              else break;
            }
          }
        }
      }
    }
    else cursor = -1;
    refresh_cursor_pos();
  }
  
  void keyTyped(){
    if ( cursor >= 0 && cursor <= incumbency.w.length() ){
      if( incumbency.w == null ) incumbency.w = "";
      if(key != CODED ){
        switch ( key ) {
        case BACKSPACE:
          if ( cursor > 0 ) {
            StringBuilder b = new StringBuilder(incumbency.w);
            b.deleteCharAt( cursor - 1 );
            if( d != null ){
              scroll.n += d.textWidth( incumbency.w.charAt( cursor - 1 ) );
            }
            incumbency.w = b.toString();
            --cursor;
          }
          break;
        case DELETE:
          if ( cursor < incumbency.w.length() ) {
            StringBuilder b = new StringBuilder(incumbency.w);
            b.deleteCharAt( cursor );
            incumbency.w = b.toString();
          }
          break;
        case 0x16: // Ctrl+V
          {
          //if( cursor < 0 ) cursor = 0;
          //StringBuilder b = new StringBuilder(incumbency.w);
          //String clip = GetTextFromClipboard();
          //b.insert( cursor, clip );
          //if( d != null ){
          //  scroll.n -= d.textWidth( clip );
          //}
          //incumbency.w = b.toString();
          //cursor += clip.length();
          }
          break;
        case 0x18: // Ctrl+X
          //writeTextToClipboard( incumbency.w );
          //incumbency.w = "";
          break;
        case 0x03: // Ctrl+C
          //writeTextToClipboard( incumbency.w );
          break;
        default:
          StringBuilder b = new StringBuilder(incumbency.w);
          b.insert( cursor, key );
          if( d != null ){
            scroll.n -= d.textWidth( key );
          }
          incumbency.w = b.toString();
          ++cursor;
          break;
        }
      }
    }
    refresh_cursor_pos();
  }
  
  void keyReleased(){
    if ( cursor >= 0 && incumbency.w != null ){
      if(key == CODED ){
        switch ( keyCode ){
        case LEFT:
          if ( cursor > 0 ) --cursor;
          break;
        case RIGHT:
          if ( cursor < incumbency.w.length() ) ++cursor;
          break;
        case 35:
          cursor = incumbency.w.length();
          break;
        case 36:
          cursor = 0;
        }
      }
      refresh_cursor_pos();
    }
  }
  
  void display(ColorScheme CS) {
    super.display(CS);
    if( incumbency.w == null ) incumbency.w = "";
    
    pushStyle();
    stroke(#FFFFFF);
    //println( cursor, incumbency.w.length() );
    if( nCursorBlink > millis() ){
      float X = cursorX + scroll.n;
      //if( d != null ) X += 3;
      if( cursor >= 0 && X > x && X < x+w ){
        line( X, cursorY, X, cursorY + cursorH );
      }
    }
    else if( millis() > nCursorBlink + 200 ) nCursorBlink = millis() + 1000;
    popStyle();
  }
}
//==================================================================================
// this thing needs: a "none" item at the top by default, 
    // method for changing the list contents on the fly (for toggling between 'mine' and 'all',
    // keypress takes you to first instance of that letter on the list
    // color information for each item. 
class ListSelect extends UIElement{
  String[] thelist;
  integer selected;
  floating_point scroll;
  PGraphics pg;
  Vertical_Scrollbar scrollbar;
  ColorScheme CS;
  int moused_over_unit;
  float m, unit_h;
  ListSelect( float x, float y, float w, float h, String str, String pos, String[] l, integer n, ColorScheme c ){
    super(x, y, w, h);
    this.setLabel( str, pos );
    CS = c;
    selected = n;
    m = 6;
    unit_h = textAscent()+textDescent() * 2;
    scroll = new floating_point( 0 );
    scrollbar = new Vertical_Scrollbar( x + w - 16, y, 16, h, scroll, unit_h+m, 0, 0 );
    thelist = l;
    scrollbar.update( unit_h * thelist.length );
    this.render();
  }
  int Y(){
    int Y = floor(( mouseY - scroll.n - y ) / (unit_h) );//, 0, cb.settlement.directive_queue.length -1 );
    if( Y < 0 || Y >= thelist.length ) Y = -1;
    return Y;
  }
  void update(){
    //scrollbar.update( max( m +((unit_h + m) * this.directive_count()) + rects_h, h ) );
    this.render();
    //println("update: ", this.directive_count(), z, h );
  }
  void mouseMoved( boolean Q ){
    int pmou = moused_over_unit;
    if( Q ){
      moused_over_unit = this.Y();
    }
    else moused_over_unit = -1;
    if( pmou != moused_over_unit ) this.render();
  }
  void mouseDragged( boolean Q ){
    if( Q ){
      scrollbar.mouseDragged();
    }
  }
  void mouseReleased( boolean Q ){
    if( Q ){
      if( mouseX > scrollbar.x ) scrollbar.mouseReleased();
      else{
        int Y = this.Y();
        if( Y != selected.n ){
          //if( selected instanceof integer_p ) selected.set( this.Y() );
          selected.n = Y; 
          this.render();
        }
      }
    }
  }
  void render(){
    pg = createGraphics( int(w-16), int(h) );    
    pg.beginDraw();
    pg.textFont( ui_font, textsize );
    pg.textAlign( LEFT, TOP );
  
    pg.stroke( CS.dim );
    pg.fill( 40 );
    pg.rect( 1, 1, pg.width-2, h-2, 3, 3, 3, 3 );
    pg.strokeCap(SQUARE);
    pg.noStroke();
    
    if( moused_over_unit >= 0 ){
      pg.noStroke();
      pg.fill( #AED0E5, 60 );
      pg.rect( 1, unit_h * moused_over_unit, pg.width, unit_h );
    }
    if( selected.n >= 0 ){
      pg.noStroke();
      pg.fill( #AED0E5, 120 );
      pg.rect( 1, unit_h * selected.n, pg.width, unit_h );
    }
    
    pg.translate( 0, scroll.n );
    pg.fill(255);
    for( int i = 0; i < thelist.length; ++i ){
      pg.text( thelist[i], m, unit_h*i + m ); 
    }
    
    pg.endDraw();
  }
  
  void display(ColorScheme CS){
    pushStyle();
    imageMode( CORNER );
    image( pg, x, y );
    popStyle();
    scrollbar.display(CS);
  }
}
//==================================================================================

class FilterBar extends TextDisplay_horizontal {
  String[] theList, shortlist;
  int[] shortlist_index;
  int cursor, nCursorBlink;
  float cursorX, cursorY, cursorH;
  integer selected;
  integer_p ls_selected;
  ListSelect LS;
  bool enter;
  
  FilterBar( float x, float y, float w, float h, String label_, String pos, String[] l, integer s, bool e, ColorScheme c ){
    super(x, y, w, h, label_, pos, new word(), c);
    cursor = -1;
    theList = l;
    shortlist = null;
    shortlist_index = null;
    selected = s;
    enter = e;
  }
  
  void update_shortlist(){
    if( incumbency.w.length() > 0 ){
      StringList tmp = new StringList();
      IntList ind = new IntList();
      for(int i = 0; i < theList.length; i++){
        if( incumbency.w.length() < theList[i].length() && theList[i].substring(0, incumbency.w.length() ).equals( incumbency.w ) ){
          tmp.append( str(i+1) +". "+theList[i] );
          ind.append( i );
        }
      }
      if( tmp.size() > 0 ){
        shortlist = tmp.array();
        shortlist_index = ind.array();
        ls_selected = new integer_p(-1);
        LS = new ListSelect( x, y+h, w, constrain( shortlist.length, 1, 8 ) * h, "", "C", shortlist, ls_selected, new ColorScheme( color(200), 25 ) );
      }
      else{
        shortlist = null;
        shortlist_index = null;
        LS = null;
      }
    }
  }
  
  void refresh_cursor_pos(){
    if( cursor >= incumbency.w.length() ) cursor = incumbency.w.length();
    if( cursor >= 0 && incumbency.w.length() >= 0 ){
      String until = incumbency.w.substring(0, cursor);
      String[] spl = split( until, '\n' );
      float tw = ( d == null )? textWidth( spl[spl.length - 1] ) : d.textWidth( spl[spl.length - 1] );
      cursorX = round(x + tw + 5);
      nCursorBlink = millis() + 1000;
    }
  }
  
  void mouseDragged( boolean Q ){
    super.mouseDragged(Q);
  }
  
  void mouseReleased( boolean Q ){
    if( Q ){
      if( incumbency.w == null ) incumbency.w = "";
      if( mouseX < x + left.w || mouseX > x + w - right.w ) super.mouseReleased(Q);
      else{
        float X = mouseX - 5 - scroll.n;
        float TW = textWidth( incumbency.w );
        if( X >= TW ) {
          cursor = incumbency.w.length();
          cursorX = textWidth( incumbency.w.substring( 0, cursor ) );
        }
        else{
          cursor = round( X * ( incumbency.w.length() / TW ) );
          cursorX = textWidth( incumbency.w.substring( 0, cursor ) );
          float dif = abs( cursorX - X );
          boolean done = false;
          boolean ok = false;
          for( int i = cursor + 1; i < incumbency.w.length()-1; ++i ){
            float tw = textWidth( incumbency.w.substring( 0, i+1 ) );
            float ndif = abs( tw - X );
            if( ndif < dif ){
              ok = true;
              dif = ndif;
              cursor = i+1;
              cursorX = tw;
            }
            else if( ok ){
              done = true;
              cursor = i;
              cursorX = tw;
              break;
            }
            else break;
          }
          if( !done ){
            for( int i = cursor - 1; i > 0; --i ){
              float tw = textWidth( incumbency.w.substring( 0, i+1 ) );
              float ndif = abs( tw - X );
              if( ndif < dif ){
                ok = true;
                dif = ndif;
                cursor = i+1;
                cursorX = tw;
              }
              else if( ok ){
                done = true;
                cursor = i+1;
                cursorX = tw;
                break;
              }
              else break;
            }
          }
        }
      }
    }
    else cursor = -1;
    refresh_cursor_pos();
  }
  
  void keyTyped(){
    if ( cursor >= 0 && cursor <= incumbency.w.length() ){
      if( incumbency.w == null ) incumbency.w = "";
      if(key != CODED ){
        switch ( key ) {
        case BACKSPACE:
          if ( cursor > 0 ) {
            StringBuilder b = new StringBuilder(incumbency.w);
            b.deleteCharAt( cursor - 1 );
            incumbency.w = b.toString();
            --cursor;
          }
          break;
        case DELETE:
          if ( cursor < incumbency.w.length() ) {
            StringBuilder b = new StringBuilder(incumbency.w);
            b.deleteCharAt( cursor );
            incumbency.w = b.toString();
          }
          break;
        case ENTER:
          enter.b = true;
          break;
        default:
          StringBuilder b = new StringBuilder(incumbency.w);
          char k = key;
          if( cursor == 0 && int(k) >= 97 ) k = char(int(k)-32);
          b.insert( cursor, k );
          incumbency.w = b.toString();
          ++cursor;
          break;
        }
      }
    }
    refresh_cursor_pos();
    update_shortlist();
  }
  
  void keyReleased(){
    if ( cursor >= 0 && incumbency.w != null ){
      if(key == CODED ){
        switch ( keyCode ){
        case LEFT:
          if ( cursor > 0 ) --cursor;
          break;
        case RIGHT:
          if ( cursor < incumbency.w.length() ) ++cursor;
          break;
        case UP:
          if( shortlist != null ){
            ls_selected.n--;
            if( ls_selected.n < 0 ) ls_selected.n = shortlist.length-1;
            incumbency.w = shortlist[ ls_selected.n ];
            selected.n = shortlist_index[ ls_selected.n ];
            cursor = 0;
          }
          break;
        case DOWN:
          if( shortlist != null ){
            ls_selected.n++;
            if( ls_selected.n >= shortlist.length ) ls_selected.n = 0;
            incumbency.w = shortlist[ ls_selected.n ];
            selected.n = shortlist_index[ ls_selected.n ];
            cursor = 0;
          }
          break;  
        case 35:
          cursor = incumbency.w.length();
          break;
        case 36:
          cursor = 0;
        }
      }
      refresh_cursor_pos();
    }
  }
  
  void display(ColorScheme CS) {
    super.display(CS);
    if( incumbency.w == null ) incumbency.w = "";
    
    pushStyle();
    stroke(#FFFFFF);
    //println( cursor, incumbency.w.length() );
    if( cursor >= 0 && cursor <= incumbency.w.length() ){
      if( nCursorBlink > millis() ){
        line(cursorX, cursorY, cursorX, cursorY+cursorH );
      }
      else if( millis() > nCursorBlink + 200 ) nCursorBlink = millis() + 1000;
    }
    popStyle();
    
    if( shortlist != null ){
      LS.display(CS);
    }
  }
}

//==================================================================================

class Neighborhood_widget extends UIElement {
  float[][] incumbency;
  float e, m, p, c;
  boolean highlighted;
  bool clear, delete;
  NumSetButton edt;
  ToggleButton clr, del;
  Neighborhood_widget (float x, float y, float w, float h, float[][] a, integer o_e, int order ) {
    super(x, y, w, h);
    incumbency = a;
    e = ( w * 0.90 ) / float(incumbency.length);
    m = w * 0.05;
    c = incumbency.length / 2;
    //(float x, float y, float w, float h, String str, String pos, integer i, int s)
    //println(w, h, m);
    float yt = (h -(w * 0.9) -m)*0.8;
    h = (h -(w * 0.9) -m)*0.6;
    w = (w-(2*m))/3.0;
    clear = new bool();
    delete = new bool();
    edt = new NumSetButton( 0,   this.h -yt, w, h, "Editor", "C", o_e, order );
    clr = new ToggleButton( w,   this.h -yt, w, h, "Clear", "C", clear );
    del = new ToggleButton( 2*w, this.h -yt, w, h, "Delete", "C", delete );
  }
  
  void mouseMoved( boolean Q ){ 
    highlighted = Q;
    float mx = mouseX - x;
    float my = mouseY - y;
    int p = -1;
    if( mx > m && mx < w-m && my > edt.y && my < edt.bottom() ) p = floor((mx-m)/edt.w);
    edt.mouseMoved( p == 0 );
    clr.mouseMoved( p == 1 );
    del.mouseMoved( p == 2 );
  }
  void mouseMoved( boolean Q, float mx, float my ){ 
    highlighted = Q;
    int p = -1;
    my -= y;
    if( mx > m && mx < w-m && my > edt.y && my < edt.bottom() ) p = floor((mx-m)/edt.w);
    edt.mouseMoved( p == 0 );
    clr.mouseMoved( p == 1 );
    del.mouseMoved( p == 2 );
  }
  
  void mousePressed( boolean Q ){
    if( Q ){
      float mx = mouseX - x - m;
      float my = mouseY - y - m;
      int i = floor( mx / e );
      int j = floor( my / e );
      if( i >= 0 && i < incumbency.length && j >= 0 && j < incumbency.length ){
        if( incumbency[i][j] == 0 ) incumbency[i][j] = 1;
        else if( incumbency[i][j] == 1 ) incumbency[i][j] = 0;
        else incumbency[i][j] = 0;
        p = incumbency[i][j];
      }
    }
  }
  boolean mousePressed( boolean Q, float mx, float my  ){
    if( Q ){
      mx -= m;
      my -= y + m;
      int i = floor( mx / e );
      int j = floor( my / e );
      if( i >= 0 && i < incumbency.length && j >= 0 && j < incumbency.length ){
        if( incumbency[i][j] == 0 ) incumbency[i][j] = 1;
        else if( incumbency[i][j] == 1 ) incumbency[i][j] = 0;
        else incumbency[i][j] = 0;
        p = incumbency[i][j];
        return true;
      }
    }
    return false;
  }
  
  void mouseDragged( boolean Q ){
    if( Q ){
      float mx = mouseX - x - m;
      float my = mouseY - y - m;
      int i = floor( mx / e );
      int j = floor( my / e );
      if( i >= 0 && i < incumbency.length && j >= 0 && j < incumbency.length ){
        incumbency[i][j] = p;
      }                                                                                                                                                                                                               
    }
  }
  boolean mouseDragged( boolean Q, float mx, float my ){
    if( Q ){
      mx -= m;
      my -= y + m;
      int i = floor( mx / e );
      int j = floor( my / e );
      if( i >= 0 && i < incumbency.length && j >= 0 && j < incumbency.length ){
        incumbency[i][j] = p;
        return true;
      }                                                                                                                                                                                                               
    }
    return false;
  }
  
  void mouseReleased( boolean Q ){
    float mx = mouseX - x;
    float my = mouseY - y;
    if( mx > m && mx < w-m && my > edt.y && my < edt.bottom() ){
      int p = floor((mx-m)/edt.w);
      edt.mouseReleased( p == 0 );
      clr.mouseReleased( p == 1 );
      del.mouseReleased( p == 2 );
    }
    if( clear.b ){
      for(int i = 0; i < incumbency.length; i++){
        for(int j = 0; j < incumbency.length; j++){
          incumbency[i][j] = 0;
        }
      }
      clear.b = false;
    }
  }
  void mouseReleased( boolean Q, float mx, float my ){
    my -= y;
    if( mx > m && mx < w-m && my > edt.y && my < edt.bottom() ){
      int p = floor((mx-m)/edt.w);
      edt.mouseReleased( p == 0 );
      clr.mouseReleased( p == 1 );
      del.mouseReleased( p == 2 );
    }
    if( clear.b ){
      for(int i = 0; i < incumbency.length; i++){
        for(int j = 0; j < incumbency.length; j++){
          incumbency[i][j] = 0;
        }
      }
      clear.b = false;
    }
  }
  
  void display(ColorScheme CS) {
    if ( highlighted ) fill(CS.bright);
    else fill(CS.dim);    
    Rect();
    pushMatrix();
    translate( x + m, y + m );
    for(int i = 0; i < incumbency.length; i++){
      for(int j = 0; j < incumbency.length; j++){
        if( i == c && j == c ){
          fill( 0, 0, 255 );
          rect( i*e, j*e, e, e );
        }
        fill( 255, 0, 0, 255*incumbency[i][j] );
        rect( i*e, j*e, e, e );
      }
    }
    translate( 0, -m );
    edt.display( CS );
    clr.display( CS );
    del.display( CS );
    popMatrix();
  }
}

//==================================================================================

class Neighborhood_list extends UIElement {
  ArrayList<Neighborhood_widget> set;
  IntList counts;
  integer o_e, dn;
  floating_point scroll;
  Vertical_Scrollbar scrollbar;
  float unit_h, m, lm;
  PlusMinus_Int PM;
  ToggleButton TB;
  Neighborhood_list (float x, float y, float w, float h, integer o, bool an, integer dn, integer nr, IntList nbhc ) {
    super(x, y, w, h);
    label = new Static_String_Label( "Neighborhoods", "TOLI", x, y, w, h );
    o_e = o;
    this.dn = dn;
    set = new ArrayList();
    counts = nbhc;
    m = 6;
    lm = 0.15 * (w-16);
    unit_h = 1.2 * (w -lm -16 -m -m);
    scroll = new floating_point( 0 );
    scrollbar = new Vertical_Scrollbar( x + w - 16, y, 16, h, scroll, unit_h+m, 0, 0 );
    scrollbar.update( h );
    float bw = (w-3*m-16)*0.5;
    PM = new PlusMinus_Int( m, m, bw, 32, "", "C", nr, 1 );
    TB = new ToggleButton( 2*m +bw, m, bw, 32, "add", "C", an );
  }
  
  void add( float[][] a ){
    set.add( new Neighborhood_widget( lm, m+set.size()*(unit_h+m), (0.85 * (w-16))-m, unit_h, a, o_e, set.size() ) );
    scrollbar.update( m + set.size()*(unit_h+m) +32 +m );
    PM.increment_y( unit_h+m );
    TB.increment_y( unit_h+m );
  }
  
  void mouseMoved( boolean Q ){
    if( Q ){
      float mx = mouseX - x;
      float my = mouseY - y - scroll.n -m;
      int p = -1;
      p = floor( my/(unit_h+m) );
      if( p < set.size() ){
        if( mx > lm ){
          for(int i = 0; i <set.size(); i++){
            set.get(i).mouseMoved( p == i, mx-lm, my );
          }
        }
        PM.mouseMoved( false, 0 , 0 );
        TB.mouseMoved( false );
      }
      else{
        PM.mouseMoved( mx > m && mx < m +PM.w && my < PM.y +PM.h -m, mx, my );
        TB.mouseMoved( mx > (2*m) +PM.w && mx < (2*m)+(2*PM.w) && my < PM.y +PM.h -m );
        for(int i = 0; i <set.size(); i++) set.get(i).mouseMoved( false, 0 , 0 );
      }
    }
    else{
      for(int i = 0; i <set.size(); i++) set.get(i).mouseMoved( false, 0 , 0 );
      PM.mouseMoved( false, 0 , 0 );
      TB.mouseMoved( false );
    }
  }
  void mousePressed( boolean Q ){
    if( Q ){
      float mx = mouseX - x;
      float my = mouseY - y - scroll.n -m;
      int p = -1;
      if( mx > lm && mx < w-16-m ) p = floor( my/(unit_h+m) );
      for(int i = 0; i <set.size(); i++){
        if( set.get(i).mousePressed( p == i, mx-lm, my+m ) ){
          counts.set( i, cell_count( set.get(i).incumbency ) );
        }
      }
    }
  }
  void mouseDragged( boolean Q ){
    if( Q ){
      if( mouseX > scrollbar.x ) scrollbar.mouseDragged();
      else{
        float mx = mouseX - x;
        float my = mouseY - y - scroll.n -m;
        int p = -1;
        if( mx > lm && mx < w-16-m ) p = floor( my/(unit_h+m) );
        for(int i = 0; i <set.size(); i++){
          if( set.get(i).mouseDragged( p == i, mx-lm, my+m ) ){
            counts.set( i, cell_count( set.get(i).incumbency ) );
          }
        }
      }                                                                                                                                                                                                              
    }
  }
  void mouseReleased( boolean Q ){
    if(Q){
      if( mouseX > scrollbar.x ) scrollbar.mouseReleased();
      else{
        float mx = mouseX - x;
        float my = mouseY - y - scroll.n -m;
        int p = -1;
        p = floor( my/(unit_h+m) );
        if( p < set.size() ){
          if( mx > lm ){
            for(int i = 0; i <set.size(); i++){
              set.get(i).mouseReleased( p == i, mx-lm, my );
            }
          }
        }
        else{
          PM.mouseReleased( mx > m && mx < m+PM.w && my < PM.y +PM.h -m, mx, my );
          TB.mouseReleased( mx > (2*m)+PM.w && mx < (2*m)+(2*PM.w) && my < PM.y +PM.h -m );
        }
      }
      for(int i = set.size()-1; i >= 0; i--){
        if( set.get(i).delete.b ){
          set.remove(i);
          dn.n = i;
          for( int j = i; j < set.size(); ++j ){
            set.get(j).y -= (unit_h+m);
          }
          scrollbar.update( m + set.size()*(unit_h+m) +32 +m );
          PM.increment_y( -(unit_h+m) );
          TB.increment_y( -(unit_h+m) );
          break;
        }
      }
    }
  }
  
  void display(ColorScheme CS) {
    fill(CS.dimmer);    
    Rect();
    clip( x, y+1, w, h-2 );
    pushMatrix();
    translate( x, y +scroll.n );
    for(int i = 0; i <set.size(); i++){
      fill(0);
      textFont(georgia_big, 23);
      text(char(945+i), 15, (i+0.5)*(unit_h+m) );
      textFont(ui_font, textsize);
      set.get(i).display( CS );
    }
    PM.display(CS);
    TB.display(CS);
    popMatrix();
    noClip();
    scrollbar.display(CS);
    label.display();
  }
}
//==================================================================================

class Greek_letter_Cycler extends UIElement {
  ArrayList<float[][]> size_ref;
  integer incumbency;
  boolean highlighted;
  float cx, cy;
  Greek_letter_Cycler (float x, float y, float w, float h, integer i, ArrayList<float[][]> sr ) {
    super(x, y, w, h);
    cx = x + (w*0.5);
    cy = y + (h*0.5);
    incumbency = i;
    size_ref = sr;
  }
  void mouseMoved( boolean Q ){
    highlighted = Q;
  }
  void mouseReleased( boolean Q ){
    if( Q ){
      incumbency.n++;
      if( incumbency.n >= size_ref.size() ) incumbency.n = 0;
    }
  }
  void display(ColorScheme CS) {
    if( highlighted ) fill( CS.bright );
    else fill(CS.dim);
    Rect();
    pushStyle();
    fill(0);
    textFont(georgia_big, 23);
    textAlign( CENTER, CENTER );
    text(char(945+incumbency.n), cx, cy );
    popStyle();
  }
}
//==================================================================================

class Color_Cycler extends UIElement {
  IntList list;
  integer incumbency;
  Color_Cycler (float x, float y, float w, float h, integer i, IntList l ) {
    super(x, y, w, h);
    incumbency = i;
    list = l;
  }
  void mouseReleased( boolean Q ){
    if( Q ){
      incumbency.n++;
      if( incumbency.n >= list.size() ) incumbency.n = 0;
    }
  }
  void display(ColorScheme CS) {
    pushStyle();
    fill( list.get(incumbency.n) );
    Rect();
    popStyle();
  }
}
//==================================================================================

class Rule_widget extends UIElement {
  Rule incumbency;
  Greek_letter_Cycler glc;
  Color_Cycler cct, ccr;
  float m = 6, E;
  float[] tri;
  float unit_e, bx, bw;
  ArrayList<float[][]> N;
  boolean p;
  Rule_widget (float x, float y, float w, float h, Rule r, ArrayList<float[][]> N, IntList S ) {
    super(x, y, w, h);
    incumbency = r;
    unit_e = h-m-m;
    this.N = N;
    glc = new Greek_letter_Cycler( m, m, unit_e, unit_e, new integer(0), N );
    cct = new Color_Cycler( unit_e + (4*m), m, unit_e, unit_e, new integer(0), S );
    ccr = new Color_Cycler( 2*unit_e + (8*m), m, unit_e, unit_e, new integer(0), S );
    tri = new float[6];
    tri[0] =  2*unit_e + (5*m);
    tri[1] =  m + (unit_e*0.35);
    tri[2] =  2*unit_e + (7*m);
    tri[3] =  m + (unit_e*0.5);
    tri[4] =  2*unit_e + (5*m);
    tri[5] =  m + (unit_e*0.65);
    bx = 3*unit_e + (9*m);
    bw = (w-m) - bx;
  }
  
  boolean mousePressed( boolean Q, float mx, float my ){
    if( Q ){
      mx -= bx;
      int i = floor( mx / ( bw / float(incumbency.range.length) ) );
      if( i >= 0 && i < incumbency.range.length ){
        if( incumbency.range[i] == false ) incumbency.range[i] = true;
        else if( incumbency.range[i] == true ) incumbency.range[i] = false;
        else incumbency.range[i] = false;
        p = incumbency.range[i];
      }                                                                                                                                                                                                               
    }
    return false;
  }
  boolean mouseDragged( boolean Q, float mx, float my ){
    if( Q ){
      mx -= bx;
      int i = floor( mx / ( bw / float(incumbency.range.length) ) );
      if( i >= 0 && i < incumbency.range.length ){
        incumbency.range[i] = p;
      }
    }
    return false;
  }
  void mouseReleased( boolean Q, float mx, float my ){
    if( Q ){
      if( my > m && my < y+h-m ){
        if( mx > m && mx < m + unit_e ) glc.mouseReleased( true );
      }
    }
  }
  
  void display(ColorScheme CS, int C ) {
    fill(CS.dim);    
    Rect();
    pushMatrix();
    translate( x, y );
    glc.display(CS);
    cct.display(CS);
    fill(0);
    triangle( tri[0], tri[1], tri[2], tri[3], tri[4], tri[5] );
    ccr.display(CS);
    //fill(CS.dimmer);
    //rect( bx, m, bw, unit_e );
    if( incumbency.range.length != C ){
      boolean[] tmp = new boolean[ incumbency.range.length ];
      arrayCopy( incumbency.range, tmp );
      incumbency.range = new boolean[ C ];
      for(int i=0; i < min(incumbency.range.length, tmp.length); i++) incumbency.range[i] = tmp[i];
      E = bw/float(C);
    }
    for(int i=0; i < C; i++){
      if( incumbency.range[i] ) fill(255, 0, 0 );
      else fill(CS.dimmer);
      rect( bx + (E*i), m, E, unit_e );
    }
    popMatrix();
  }
}

//==================================================================================

class Rule_list extends UIElement {
  ArrayList<Rule_widget> set;
  IntList counts;
  float unit_h, m;
  floating_point scroll;
  Vertical_Scrollbar scrollbar;
  Rule_list (float x, float y, float w, float h, IntList nbhc ) {
    super(x, y, w, h);
    set = new ArrayList();
    counts = nbhc;
    label = new Static_String_Label( "Rules", "TOLI", x, y, w, h );
    m = 6;
    unit_h = (w-16) * 0.08;
    scroll = new floating_point( 0 );
    scrollbar = new Vertical_Scrollbar( x + w - 16, y, 16, h, scroll, unit_h+m, 0, 0 );
    scrollbar.update( h );
  }
  void add( Rule r, ArrayList<float[][]> N, IntList S ){
    set.add( new Rule_widget( m, m+(set.size()*(unit_h+m)), w-16-m-m, unit_h, r, N, S ) );
    scrollbar.update( m + set.size()*(unit_h+m) +32 +m );
  }
  
  void mousePressed( boolean Q ){
    if( Q ){
      if( mouseX > scrollbar.x ) scrollbar.mouseDragged();
      else{
        float mx = mouseX - x;
        float my = mouseY - y - scroll.n -m;
        int p = -1;
        p = floor( my/(unit_h+m) );
        for(int i = 0; i <set.size(); i++){
          if( set.get(i).mousePressed( p == i, mx, my+m ) ){}
        }
      }
    }
  }
  void mouseDragged( boolean Q ){
    if( Q ){
      if( mouseX > scrollbar.x ) scrollbar.mouseDragged();
      else{
        float mx = mouseX - x;
        float my = mouseY - y - scroll.n -m;
        int p = -1;
        p = floor( my/(unit_h+m) );
        for(int i = 0; i <set.size(); i++){
          if( set.get(i).mouseDragged( p == i, mx, my+m ) ){}
        }
      }
    }
  }
  void mouseReleased( boolean Q ){
    if( Q ){
      if( mouseX > scrollbar.x ) scrollbar.mouseReleased();
      else{
        float mx = mouseX - x;
        float my = mouseY - y - scroll.n -m;
        int p = -1;
        p = floor( my/(unit_h+m) );
        if( p < set.size() ){
          for(int i = 0; i <set.size(); i++){
            set.get(i).mouseReleased( p == i, mx, my );
          }
        }
      }
    }
  }
  void display(ColorScheme CS) {
    fill(CS.dimmer);    
    Rect();
    clip( x, y+1, w, h-2 );
    pushMatrix();
    translate( x, y +scroll.n );
    for(int i = 0; i <set.size(); i++){
      set.get(i).display( CS, counts.get( set.get(i).glc.incumbency.n ) );
    }
    popMatrix();
    noClip();
    scrollbar.display(CS);
    label.display();
  }
}

//==================================================================================

class State_bar extends UIElement {
  IntList incumbency;
  State_bar (float x, float y, float w, float h, IntList i ) {
    super(x, y, w, h);
    label = new Static_String_Label( "States", "TOLI", x, y, w, h );
    incumbency = i;
  }
  void display(ColorScheme CS) {
    fill(CS.dimmer);    
    Rect();
    label.display();
  }
}
