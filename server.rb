require "csv"
require "sinatra"
require "sinatra/reloader"
require "pry"


get "/" do
  @articles = get_articles
  erb :index

end

get "/new" do
  erb :new
end

post "/new" do
  title = params["title"]
  url = params["url"]
  description = params["description"]

  CSV.open("articles.csv", "a+") do |csv|
    if !csv.include?("url")
      csv << [title, url, description]
    end
  end

  redirect "/"

end



def get_articles
  articles = []
  CSV.foreach("articles.csv", :headers => true) do |csv|
    articles << csv
  end
  articles
end

