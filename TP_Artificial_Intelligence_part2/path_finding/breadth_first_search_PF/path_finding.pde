class PathFinding{
  private int[][] environment, init_env;
  private int xStart, yStart, target, obstacle, free, robot, env_width, env_height, 
          open=11, closed=12, current=13, succ=14;
  
  public PathFinding(String env_path, String separator, int robot, int target, int free, int obstacle){
      this.robot= robot;
      this.target= target;
      this.free= free;
      this.obstacle= obstacle;
      
      // read environement file:
      String[] lines = loadStrings(env_path);
      // compute environement dimension:
      env_height = lines.length;
      env_width = lines[0].split(separator).length;
      
      // create environment:
      init_env = new int[env_height][];
      for(int i=0; i< env_height; i++){
        init_env[i] = new int[env_width];
        String[] blocs= lines[i].split(separator);
        for(int j=0; j< env_width; j++){
          init_env[i][j] = Integer.parseInt(blocs[j]);
          if(init_env[i][j]== robot){
            xStart=j;
            yStart=i;
          }
        }
      }
      init_environment();
  }
  
  void init_environment(){
    if(environment == null) environment = new int[env_height][];
    for(int i=0; i< env_height; i++){
        if(environment[i] == null)
          environment[i] = new int[env_width];
        for(int j=0; j< env_width; j++)
          environment[i][j] = init_env[i][j];
    }
  }
  
  void update_environment(Node n, int state){
    if(environment[n.get_y()][n.get_x()] != robot) environment[n.get_y()][n.get_x()]= state;
  }
  
  boolean is_target(Node n){
    return init_env[n.get_y()][n.get_x()]== target;
  }
  
  public Set<Node> compute_successors(Node nCurr){
    Set<Node> succs= new HashSet<Node>(); 
    Node n;
    n = go_up(nCurr);
    if(n != null) succs.add(n);
    n = go_down(nCurr);
    if(n != null) succs.add(n);
    n = go_right(nCurr);
    if(n != null) succs.add(n);
    n = go_left(nCurr);
    if(n != null) succs.add(n);
    return succs; 
  }
  
  Node go_left(Node n){
    int x= n.get_x() - 1, y= n.get_y();
    return x>-1 && environment[y][x] != obstacle? new Node(x, y, n): null;
  }
  
  Node go_right(Node n){
    int x= n.get_x()+ 1, y= n.get_y();
    return x<env_width && environment[y][x] != obstacle? new Node(x, y, n): null;
  }
  
  Node go_up(Node n){
    int x= n.get_x(), y= n.get_y()- 1;
    return y>-1 && environment[y][x] != obstacle? new Node(x, y, n): null;
  }
  
  Node go_down(Node n){
    int x= n.get_x(), y= n.get_y()+ 1;
    return y<env_height && environment[y][x] != obstacle? new Node(x, y, n): null;
  }
  
  void draw_path(Stack<Node> path){
    for(Node n: path){
      update_environment(n, current);
    }
  }
  
  void make_step(Stack<Node> path){
    if(!path.isEmpty()){
      Node n= path.pop();
      update_environment(n, robot);
    }
  }
  
  void draw_environement(int win_width, int win_height){
    loadPixels();
    int stepy= win_height/env_height, 
        stepx= win_width/env_width;
    for (int x = 0; x < win_width; x++ ) {
      for (int y = 0; y < win_height; y++ ) {
        color c=color(0, 0, 0);
        int i= y/stepy, j=x/stepx;
        if(environment[i][j]== obstacle) c= color(0, 0, 255);
        else if(environment[i][j]== free) c= color(0, 0, 0);
        else if(environment[i][j]== robot) c= color(255, 0, 0);
        else if(environment[i][j]== target) c= color(0, 255, 0);
        else if(environment[i][j]== current) c= color(255, 100, 100);
        else if(environment[i][j]== open) c= color(50);
        else if(environment[i][j]== closed) c= color(200, 200, 0);
        else if(environment[i][j]== succ) c= color(255, 255, 0);
        pixels[x+ y* width]= c;
     }
   }
   updatePixels();
  }
  
  int get_xStart(){
    return xStart;
  }
  
  int get_yStart(){
    return yStart;
  }
  
  int get_open_code(){
    return open;
  }
  
  int get_closed_code(){
    return closed;
  }
  
  int get_current_code(){
    return current;
  }
  
  int get_succ_code(){
    return succ;
  }

}
