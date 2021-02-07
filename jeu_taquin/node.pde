class Node{
  private int[][] state;
  private Node parent;
  private int l_pos, c_pos;
  
  public Node(int [][] state, Node parent, int l_pos, int c_pos){
    this.parent= parent;
    this.l_pos= l_pos;
    this.c_pos= c_pos;
    this.state = new int[state.length][];
    //copy state:
    for(int i = 0; i < this.state.length; i++){
      this.state[i]= new int[state[i].length];
      for(int j = 0; j < this.state[0].length; j++) 
        this.state[i][j] = state[i][j];
    }
  }
  
  public Node(int [][] state){
    this(state, null, -1, -1);
  }
  
  public Node(Node noeud){
    this(noeud.state, noeud.parent, noeud.l_pos, noeud.c_pos);
  }
  
  //public boolean is_objective(){
  //  int i=0, j=0;
  //  int n_rows= this.state.length, 
  //      n_columns= this.state[0].length;
  //  while(i< n_rows && j< n_columns && this.state[i][j]== i*n_columns+j+1){
  //    j++;
  //    if(j== n_columns){
  //      j=0;
  //      i++;
  //    }
  //  } 
  //  return i == n_rows && j == n_columns;
  //}
  
  public int element_at(int ligne, int column){
    return state[ligne][column];
  }
  
  public void set_element(int val, int ligne, int column){
    state[ligne][column]=val;
  }
  
  public int[][] get_state(){
    return this.state;
  }
  
  public void set_l_pos(int l_pos){
    this.l_pos=l_pos;
  }
  
  public void set_c_pos(int c_pos){
    this.c_pos=c_pos;
  }
  
  public int get_l_pos(){
    return this.l_pos;
  }
  
  public int get_c_pos(){
    return this.c_pos;
  }
  
  public Node get_parent(){
    return this.parent;
  }
  
  public int get_nb_rows(){
    return this.state.length;
  }
  
  public int get_nb_columns(){
    return this.state[0].length;
  }
  
  @Override
  public boolean equals(Object o){
    if(o instanceof Node){
      Node n= (Node) o;
      int n_rows= this.state.length, 
          n_columns= this.state[0].length;
      for(int i=0; i< n_rows; i++)
        for(int j=0; j< n_columns; j++)
          if(this.state[i][j] != n.state[i][j]) return false;
      return true;
    }
    return false;
  }
}
