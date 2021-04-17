import java.util.*;

class Huffman{
  private PriorityQueue<Node> nodes;
  private String to_encode;
  
  public Huffman(String str){
    Comparator<Node> nodeOccComparator = new Comparator<Node>() {
      @Override
      public int compare(Node n1, Node n2) {
        return n1.get_nb_occ() - n2.get_nb_occ();
      }
    };
    nodes= new PriorityQueue<Node>(nodeOccComparator);
    to_encode = str;
  }
  public void compute_char_occurences(){
    // compute accurences:
    Map<Character, Integer> charCount = new LinkedHashMap<Character, Integer>();
    for (char c : to_encode.toCharArray()) {
      if (!charCount.containsKey(c)) {
         charCount.put(c, 1);
      }
      else {
       charCount.put(c, charCount.get(c) + 1);
      }
    }
    
    // construct priority queue:
    Iterator iterator = charCount.keySet().iterator();
    while(iterator.hasNext()){
      char val   = (char)(iterator.next());
      int occ = charCount.get(val);
      nodes.add(new Node(val, occ));
    }
  }
  
  public void process(){
    if(nodes.size()> 1){
      Node right= nodes.poll();
      Node left = nodes.poll();
      nodes.add(new Node(right.get_nb_occ()+ left.get_nb_occ(), new Node(left), new Node(right)));
    }
  }
  
  public void process_all(){
    while(nodes.size()> 1){
      Node right= nodes.poll();
      Node left = nodes.poll();
      nodes.add(new Node(right.get_nb_occ()+ left.get_nb_occ(), new Node(left), new Node(right)));
    }
  }
  
  // Create Huffman Table:
  public Map<Character, String> encode(){
    encodings = new LinkedHashMap<Character, String>();
    return encode(encodings, null, "");
  }
  
  private Map<Character, String> encode(Map<Character, String> encodings, Node n, String s){
      if(n == null){
        n = nodes.peek();
      }
      if(n.get_left() == null && n.get_left() == null){
            encodings.put(n.get_value(), new String(s));
            return new LinkedHashMap<Character, String>(encodings);
      }
      else{
          if(n.get_left() != null) encodings= new LinkedHashMap<Character, String>(encode(encodings, n.get_left(), s+'0'));
          if(n.get_right() != null) encodings= new LinkedHashMap<Character, String>(encode(encodings, n.get_right(), s+'1'));
      }
     return new LinkedHashMap<Character, String>(encodings);
  }
  
  public Node get_head(){
    return nodes.peek();
  }
  
  public PriorityQueue<Node> get_nodes(){
    return nodes;
  }
}
