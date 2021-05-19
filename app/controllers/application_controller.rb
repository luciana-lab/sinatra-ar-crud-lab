
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    "welcome to CRUD world!"
  end

  #read all instances
  get '/articles' do
    @articles = Article.all
    erb :index
  end

  #create a new instance
  get '/articles/new' do
    erb :new
  end

  #read a specific instance
  get '/articles/:id' do
    @article = Article.find_by_id(params[:id])
    erb :show
  end

  #update an instance
  get '/articles/:id/edit' do
    @article = Article.find_by_id(params[:id])
    erb :edit
  end

  #place the code extract from the '/articles/new' form
  post '/articles' do
    @article = Article.find_or_create_by(title: params[:title], content: params[:content])
    redirect to "/articles/#{@article.id}"
  end

  #place the code extract from the '/article/:id/edit' form
  patch '/articles/:id' do
    @article = Article.find_by_id(params[:id])
    @article.title = params[:title]
    @article.content = params[:content]
    @article.save

    redirect to "/articles/#{@article.id}"
  end

  #delete an object
  delete '/articles/:id' do
    @article = Article.find_by_id(params[:id])
    @article.delete

    redirect to "/articles"
  end

end
