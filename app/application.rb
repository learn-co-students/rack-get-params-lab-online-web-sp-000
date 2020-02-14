class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/cart/)
      if @@cart.length > 0
        @@cart.each do |item|
          resp.write "#{item}\n"
        end
      elsif
        resp.write "Your cart is empty"
      end
    end

    # if req.path.match(/add/)
    #   @@items.each do |item|
    #     @@cart << item
    #     resp.write "added #{item}"
    #   end
    #   elsif 
    #     resp.write "We don't have that item"
    # end

    if req.path.match(/add/)
      item = req.params.values[0]
      if @@items.include?(item)
        @@cart << item
        resp.write "added #{item}\n"
      elsif 
        resp.write "We don't have that item"
      end
    end

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
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
