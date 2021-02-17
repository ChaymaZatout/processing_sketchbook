import java.util.*; 

class Taquin{
  private Node init_state;
  private Node curr_state;
  private Node obj_state;
  private int free;
  
  private Taquin(Node init_state, int free){
    this.free=free;
    this.init_state= new Node(init_state);
    compute_initial_pos();
    this.curr_state= new Node(this.init_state);
  }
  
  public Taquin(Node init_state, Node obj_state, int free){
    this(init_state, free);
    this.obj_state= new Node(obj_state);
  }
  
  
  public void set_curr_state(Node noeud){
    this.curr_state= noeud;
  }
  
  public boolean is_objective(){
    for(int i=0; i< this.curr_state.get_nb_rows(); i++){
      for(int j=0; j< this.curr_state.get_nb_columns(); j++){
        if(this.curr_state.element_at(i, j) != this.obj_state.element_at(i, j)) return false;
      }
    }
    return true;
  }
  
  public boolean is_objective(Node n){
    for(int i=0; i< n.get_nb_rows(); i++){
      for(int j=0; j< n.get_nb_columns(); j++){
        if(n.element_at(i, j) != this.obj_state.element_at(i, j)) return false;
      }
    }
    return true;
  }
  
  public Stack<Node> path_to_obj(){
    Stack<Node> path= new Stack<Node>();
    Node curr= this.curr_state;
    while(curr != null){
      path.push(new Node(curr));
      curr=curr.get_parent();
    }
    return path;
  }
  
  public Set<Node> compute_successors(){
    Set<Node> succs= new HashSet<Node>(); 
    Node n;
    n = go_up();
    if(n != null) succs.add(n);
    n = go_down();
    if(n != null) succs.add(n);
    n = go_right();
    if(n != null) succs.add(n);
    n = go_left();
    if(n != null) succs.add(n);
    return succs; 
  }
  
  public Node go_up(){
    int l_pos = this.curr_state.get_l_pos()-1; //<>// //<>//
    Node n=null; //<>// //<>//
    if(l_pos >= 0){
      n= new Node(this.curr_state.get_state(), this.curr_state, l_pos, this.curr_state.get_c_pos());
      n.set_element(n.element_at(l_pos, n.get_c_pos()),
                      this.curr_state.get_l_pos(), n.get_c_pos());
      n.set_element(this.free, n.get_l_pos(), n.get_c_pos());
    }
    return n;
  } //<>// //<>//
  
  public Node go_down(){
    int l_pos = this.curr_state.get_l_pos()+1;
    Node n =null;
    if(l_pos < this.curr_state.get_nb_rows()){
      n= new Node(this.curr_state.get_state(), this.curr_state, l_pos, this.curr_state.get_c_pos());
      n.set_element(n.element_at(l_pos, n.get_c_pos()), 
                    this.curr_state.get_l_pos(), n.get_c_pos());
      n.set_element(this.free, n.get_l_pos(), n.get_c_pos()); //<>// //<>//
    }
    return n;
  } //<>// //<>//
  
  public Node go_right(){
    int c_pos = this.curr_state.get_c_pos()+1;
    Node n =null;
    if(c_pos < this.curr_state.get_nb_columns()){
      n= new Node(this.curr_state.get_state(), this.curr_state, this.curr_state.get_l_pos(), c_pos);
      n.set_element(n.element_at(n.get_l_pos(), c_pos), 
                        n.get_l_pos(), this.curr_state.get_c_pos());
      n.set_element(this.free, n.get_l_pos(), n.get_c_pos()); //<>// //<>//
    }
    return n;
  } //<>// //<>//
  
  public Node go_left(){
    int c_pos = this.curr_state.get_c_pos()-1; //<>// //<>//
    Node n =null;
    if(c_pos>= 0){
      n= new Node(this.curr_state.get_state(), this.curr_state, this.curr_state.get_l_pos(), c_pos);
      n.set_element(n.element_at(n.get_l_pos(), c_pos), n.get_l_pos(), this.curr_state.get_c_pos());
      n.set_element(this.free, n.get_l_pos(), n.get_c_pos());
    }
    return n;
  }
  
  private void compute_initial_pos(){
    int i=0; //<>// //<>//
    int j=0;
    while(i< this.init_state.get_nb_rows() && j< this.init_state.get_nb_columns() &&
          this.init_state.element_at(i, j) != this.free){
      j++;
      if(j==this.init_state.get_nb_columns()){
        j=0; i++;
      }
    }
    this.init_state.set_l_pos(i); //<>// //<>//
    this.init_state.set_c_pos(j); //<>// //<>//
  } 
  
  public int get_free(){
    return this.free;
  }
  public Node get_obj_state(){
    return this.obj_state;
  }
  
  public Node get_curr_state(){
    return this.curr_state;
  }
  
  public Node get_init_state(){
    return this.init_state;
  }
}
