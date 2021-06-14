class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []

  def call(env)
    request = Rack::Request.new(env)
    response = Rack::Response.new

    if request.path.match(/items/)
      @@items.each do |item|
        response.write "#{items}\n"
      end

    elsif request.path.match(/search/)
      search_item = request.params["q"]
      response.write handle_search(search_item)

    elsif request.path.match(/cart/)
      if @@cart.empty?
        response.write "Your cart is empty"
      else 
        @@cart.each do |item|
          response.write "#{item}\n"
        end
      end
  
    elsif request.path.match(/add/)
      item_to_add = request.params["item"]
      if @@items.include? item_to_add
        @@cart << item_to_add
        response.write "added #{item_to_add}"
      else
        response.write "We don't have that item!"
      end

    else 
      response.status = 404
      response.write "Path Not Found"
    end

    response.finish
  end

  def handle_search(search_item)
    if @@items.include?(search_item)
      return "#{search_item} is one of our items"
    else
      return "Couldn't find #{search_item}"
    end
  end 
end
