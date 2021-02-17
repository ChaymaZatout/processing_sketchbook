import java.util.*;

class BFS{
  Queue<Node> open;
  ArrayList<Node> closed;
  Taquin taquin;
  boolean achieved;
  Set<Node> successors;
  Stack<Node> path= new Stack<Node>();
  
  public BFS(Node init_state, Node obj_state, int free){
    this(new Taquin(init_state, obj_state, free));
  }
  
  public BFS(Taquin taquin){
    this.taquin= taquin;
    this.closed= new ArrayList<Node>();
    this.open= new LinkedList<Node>();
    if(taquin.is_objective()){
      this.closed.add(taquin.get_init_state());
      achieved= true;
    }
    else{
      this.open.add(taquin.get_init_state());
      achieved= false;
    }
  }
  
  public void process(){
    if(!achieved && !this.open.isEmpty()){ //<>// //<>//
      this.taquin.set_curr_state(this.open.remove());
      this.closed.add(taquin.get_curr_state());
      this.successors = this.taquin.compute_successors();
      for(Node s: successors){ //<>// //<>//
        if(!this.taquin.is_objective(s) && !this.closed.contains(s)){
          this.open.add(s);
        }
        else if(this.taquin.is_objective(s)){
          this.taquin.set_curr_state(s);
          this.closed.add(s);
          this.achieved = true;
          this.path = this.taquin.path_to_obj();
        }
      }
    }
    if(achieved) println("achieved");
  }
  
  public Stack<Node> get_path(){
    return this.path;
  }
  
  public Taquin get_taquin(){
    return this.taquin;
  }
  
  public boolean is_achieved(){
    return this.achieved;
  }
  
  public boolean open_is_empty(){
    return this.open.isEmpty();
  }
 
  
}
