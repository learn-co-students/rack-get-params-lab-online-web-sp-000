# If we were creating a simple shopping cart application, for example, we can think of a few different paths that are required:
# Path	    Description
#/items	  List all items available
#/cart	  List items in cart

#The path lives in the HTTP request, and to get to it we have to inspect the env part of our #call function.
# In the env variable is all of the information contained in the request. 
# Rack::Request instance now has a ton of useful methods. If we look through the documentation, it has a method called #path.
# This will return the path that was requested.

class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = [] #Create a new class array called @@cart to hold any items in your cart

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/) #the response based on which specific path you enter.
                               #  filter so that this only works for the /items path using the #path method of our Rack::Request object:
      @@items.each do |item| #if someone wanted to see all of our items (if I don't have above code), but with it I am iterating through items on #path
        resp.write "#{item}\n"
      end
    elsif req.path.match(/search/)
      #***
      search_term = req.params["q"]
      resp.write handle_search(search_term)
    elsif req.path.match(/cart/) #Create a new route called /cart to show the items in your cart
      if @@cart.empty?
        resp.write "Your cart is empty"
      else
        @@cart.each do |item|
          resp.write "#{item}\n"
        end
      end
    elsif req.path.match(/add/)#Create a new route called /add that takes in a GET param with the key item. This should check to see if that item is in @@items and then add it to the cart if it is. Otherwise give an error
      item_to_add = req.params["item"]
      if @@items.include? item_to_add 
        @@cart << item_to_add
        resp.write "added #{item_to_add}"
      else
        resp.write "We don't have that item!"
      end
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
#***
#https://github.com/search?q=apples. We have a domain of github.com, path of search, and then a ? character.
#After that character comes q=apples. There is our search!
#The section after the ? is called the GET parameters.
#GET params come in key/value pairs. The key would be q and the value is apples.
#The matching Ruby data structure that is also a key/value store would be a Hash!
# Rack provides the mechanism to parse the GET params and return them to us in a standard Hash.
# If we wanted to implement a /search route that accepted a GET param with the key q it would look something like this: