class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart=[]

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end
    elsif req.path.match(/cart/)
      resp.write print_cart
    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)
    elsif req.path.match(/add/)
      resp.write add_items_to_cart(req.params['item'])
    else
      resp.write "Path Not Found"
    end

    resp.finish
  end

  def print_cart
    #binding.pry
    if @@cart==[]
      return "Your cart is empty"
    else
      return @@cart.join("\n")
    end
  end

  def add_items_to_cart(item)
    if @@items.include?(item)
      #binding.pry
      @@cart<<item
      "added #{item}"
    else
      "We don't have that item"
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
