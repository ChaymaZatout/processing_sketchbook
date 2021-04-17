import java.util.*;

class BFS{
  Queue<Node> open;
  ArrayList<Node> closed;
  Node init_state, current_state;
  PathFinding pf;
  boolean achieved;
  Set<Node> successors;
  Stack<Node> path= new Stack<Node>();
  
  public BFS(PathFinding pf){
    this.pf= pf;
    init_state= new Node(pf.get_xStart(), pf.get_yStart());
    current_state= new Node(init_state);
    
    this.closed= new ArrayList<Node>();
    this.open= new LinkedList<Node>();
    if(pf.is_target(current_state)){
      closed.add(current_state);
      achieved= true;
    }
    else{
      this.open.add(current_state);
      achieved= false;
    }
  }
  
  public void process(){

    if(!achieved && !open.isEmpty()){
      pf.init_environment();
      for(Node n: open){
        pf.update_environment(n, pf.get_open_code());
      }
      for(Node n: closed){
        pf.update_environment(n, pf.get_closed_code());
      }

      current_state= open.remove(); //<>//
      closed.add(current_state);
      pf.update_environment(current_state, pf.get_current_code());
      successors = pf.compute_successors(current_state);
      for(Node s: successors){
        if(pf.is_target(s)){
          current_state= s;
          closed.add(s);
          achieved = true;
          this.path = path_to_obj();
        }
        else if(!closed.contains(s)){
          if(!open.contains(s)) open.add(s);
          pf.update_environment(s, pf.get_succ_code());
        }
      }
    }
    //if(achieved) println("achieved");
  }
  
  public Stack<Node> path_to_obj(){
    Stack<Node> path= new Stack<Node>();
    Node curr= current_state;
    while(curr != null){
      path.push(new Node(curr));
      curr=curr.get_parent();
    }
    return path;
  }
}
