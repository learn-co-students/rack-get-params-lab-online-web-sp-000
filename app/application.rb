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
    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)
    elsif req.path.match(/cart/)
      resp.write handle_cart
    elsif req.path.match(/add/)
      resp.write handle_add(req.params["item"])
    else
      resp.write "Path Not Found"
    end

    resp.finish
  end

  def handle_add(param)    
    if @@items.include?(param)
      @@cart << param
      return "added #{param}"
    else
      return "We don't have that item"
    end    
  end

  def handle_cart
    if @@cart.empty?
      return "Your cart is empty"
    else
      return @@cart.join("\n")
    end
  end


  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end
end
