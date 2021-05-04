class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)
    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end
    elsif req.path.match(/cart/)
      if @@cart.empty?
        resp.write "Your cart is empty"
      else  
        @@cart.each do |item|
          resp.write "#{item}\n"
        end
      end 
    elsif req.path.match(/add/)
    #search_term represents item that im trying to add to cart 
       search_term = req.params["item"]
       #iterate over list of items to see if search term is in there 
       #if search term is there then write added _ 
       #if search term is not in item list then write ___ 
       if @@items.include?(search_term)
          resp.write "added #{search_term}"
          @@cart << search_term
      else
          resp.write "We don't have that item"
       end
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
  
end

