class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []
  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    # if req.path.match(/items/)
    if req.path.match(/cart/)
      if @@cart == []
        resp.write "Your cart is empty"
      else
        @@cart.each do |item|
          resp.write "#{item}\n"
        end
      end
    elsif req.path.match(/add/)
      search_term = req.params["item"]
        if @@items.include?(search_term)
          @@cart << search_term
          resp.write "added #{search_term}"
        else
           resp.write "Couldn't find #{search_term} We don't have that item"
        end
    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)
    else
      resp.write "Path Not Found"
    end
    # response = Rack::Response.new
    #  request = Rack::Request.new()
    #  if request.path.match(/cart)
    #    @@items.each do |item|
    #      response.write "#{item}\n"
    #    end
    #  elsif request.path.match(/add/)
    #    search_term = request.params["get"]
    #    if @@items.include?(search_term)
    #      @@cart << search_term
    #    else
    #       response.write "Couldn't find #{search_term}"
    #    end
    #  else
    #    response.write "Couldn't find #{search_term}"
    #  end
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
