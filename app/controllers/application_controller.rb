
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    set :method_override, true
  end

  # get '/' do
  #   erb :inde
  # end

  get '/posts' do
  #pass through to controller(index.erb) to iterate through
  @posts = Post.all
    erb :index
  end

  get '/posts/new' do
    erb :new
  end

  post '/posts' do
    name = params[:name]
    content = params[:content]
    @post = Post.create(name: name, content: content)
      redirect "/posts"
  end

  get '/posts/:id' do
    post_id = params[:id]
    @post = Post.find(post_id)
    erb :show
  end

  get '/posts/:id/edit' do
    #grab book youre trying to edit

    @post = Post.find(params[:id])
    erb :edit
  end

  patch '/posts/:id' do

    @post = Post.find(params[:id])
    @post.update(name: params[:name],
                content: params[:content])
    redirect "/posts/#{@post.id}"
  end

  delete '/posts/:id' do
    @post = Post.find(params[:id])
    @post.destroy
      redirect "/posts"
  end
end
