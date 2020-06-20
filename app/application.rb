class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env) #env part of our call function has all info stored in the request

    if req.path.match(/items/) #allows us to see all of our items
      @@items.each do |item|
        resp.write "#{item}\n"
      end
    elsif req.path.match(/search/) #GET parameters key/value pairs.
      #search route that accepts a GET parameter w/ the key q.

      search_term = req.params["q"] #key = q, value = apples, carrots, or pears

      resp.write handle_search(search_term) #not sure what this does

      def handle_search(search_term)
        if @@items.include?(search_term) #?
          return "#{search_term} is one of our items" #we can do different things depending on the search path
        else
          return "Couldn't find #{search_term}"
        end
      end

    elsif req.path.match(/cart/) #empty cart message if cart empty
      if @@cart.empty?
        resp.write "Your cart is empty"

      else
        @@cart.each do |item| #cart list if cart is not empty
          resp.write "#{item}\n"
        end
      end

    elsif req.path.match(/add/) #will add an item that is in @@items list
      search_term = req.params["item"]
      if @@items.include?(search_term)
        @@cart << search_term
        resp.write "added #{search_term}"
      else
        resp.write "We don't have that item" #won't add if not in @@items list
      end

    else
      resp.write "Path Not Found"
    end
    resp.finish
  end
end
