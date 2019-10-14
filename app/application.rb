class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []                           #create a new class array called cart to hold items

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
          resp.write "#{item}\n"          #responds with a cart list if there is something in there
        end
      end

    elsif req.path.match(/add/)
      item_to_add = req.params["item"]
      if @@items.include? item_to_add
        @@cart << item_to_add             #Will add an item that is in the @@items list
        resp.write "added #{item_to_add}"
      else
        resp.write "We don't have that item!"
      end
    else
      resp.write "Path Not Found"         #Will not add an item that is not in the @@items list
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
