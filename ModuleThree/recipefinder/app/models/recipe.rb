class Recipe
  include HTTParty

  key_value=ENV["FOOD2FORK_KEY"]
  hostport=ENV["FOOD2FORK_SERVER_AND_PORT"] || "www.food2fork.com"
  base_uri "http://#{hostport}/api"
  default_params key: key_value, fields: "image_url, source_url, title, social_rank"
  format :json

  def self.hostport
    @@hostport
  end

  def self.key_value
    @@key_value
  end

  def self.for (keyword)
    get("/search", query: {q: keyword})["recipes"]
  end

end
