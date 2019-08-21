class Application
  @@cart = []
  @@items = ["Apples","Carrots","Pears"]

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end
      
    elsif req.path.match(/cart/)
        if @@cart != []
           @@cart.each do |c|
           resp.write "#{c}\n"
           end
        else 
           resp.write "Your cart is empty"
        end
        
    elsif req.path.match(/add/)
    add_item = req.params["item"]
    resp.write handle_add(add_item)
      
    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)
      
    else
      resp.write "Path Not Found"
    end
    resp.finish
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end
  
  def handle_add(add_item)
    if @@items.include?(add_item)
      @@cart << add_item
      return "added Figs"
    else 
      return "We don't have that item"
    end
  end
      
  
end
