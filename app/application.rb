class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = ["iPad Air", "MacBook Air", "Google Pixel 2"]

  def call(env)
    rspns = Rack::Response.new
    rqst = Rack::Request.new(env)

    if rqst.path.match(/items/)
      @@items.each do |item|
        rspns.write "#{item}\n"
      end
    elsif rqst.path.match(/cart/)
      if @@cart.empty?
        rspns.write "Your cart is empty"
      else
        @@cart.each do |item|
          rspns.write "#{item}\n"
        end
      end
    elsif rqst.path.match(/search/)
      search_term = rqst.params["q"]
      rspns.write handle_search(search_term)
    elsif rqst.path.match(/add/)
      add_item = rqst.params["item"]
      rspns.write handle_add(add_item)
    else
      rspns.write "Path Not Found"
    end

    rspns.finish
  end

  def handle_add(add_item)
    if @@items.include?(add_item)
      @@cart << add_item
      return "added #{add_item}"
    else
      return "We don't have that item"
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
