require 'pry'

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
      handle_cart(resp)
    elsif req.path.match(/add/)
      item = req.params["item"]
      item_found?(item) ? add_item_to_cart(resp, item) : public_message(resp)
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

  def handle_cart(resp)
    resp.write @@cart.empty? ? "Your cart is empty" : print_cart_items
  end

  def print_cart_items
    @@cart.join("\n")
  end

  def item_found?(item)
    if @@items.include?(item)
      return true
    else
      return false
    end
  end

  def add_item_to_cart(resp, item)
    @@cart << item
    resp.write "added #{item}"
  end

  def public_message(resp)
    resp.write "We don't have that item"
  end

end
