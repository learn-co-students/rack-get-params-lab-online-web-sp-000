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
    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)
    elsif req.path.match(/cart/)
      if @@cart.empty?
        resp.write "Your cart is empty"
      else
        @@cart.each do |item|
          resp.write "#{item}\n"
        end
      end
    elsif req.path.match(/add/)
      params = req.params
      params.each do |param|
        if @@items.include?(param[1])
          @@cart << param[1]
          resp.write "added #{param[1]}"
        else
          resp.write "We don't have that item"
        end
      end
    else
      resp.write "Path Not Found"
    end

  # elsif req.path.match(/search/)
  #
  #   search_term = req.params["q"]
  #
  #   if @@items.include?(search_term)
  #     resp.write "#{search_term} is one of our items"
  #   else
  #     resp.write "Couldn't find #{search_term}"
  #   end

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
