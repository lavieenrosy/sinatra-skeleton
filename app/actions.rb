# Homepage (Root path)

helpers do
  def current_user
    @current_user = User.find_by(id: session[:user_id]) if session[:user_id]
    #assign the current user to an instance variable called @current_user
    #the session[:user_id] simply refers to the session we set-up below and refers to user id
    #so if that id is 1, we're finding, in our user's table, the row with id 1 and then populating in this current user
    #throw a condition in; we're only doing this if there is a session user id
    #if it's nil, ignore it
  end
end

before do
  redirect '/login' if !current_user && request.path != '/login' && request.path != '/signup'
end

get '/' do
  @posts = Post.all.reverse #always define an instance variable first because this is the glue that ties your actions to your views
  #reverse shows the newest one on the page
  erb :index
end

get '/signup' do
  erb :signup
end

post '/signup' do
  # binding.pry
  
  first_name = params[:first_name] #use params to create a user
  last_name = params[:last_name]
  email = params[:email]
  password = params[:password]

  user = User.create(first_name: first_name, last_name: last_name, email: email, password: password)
  
  session[:user_id] = user.id #here you're setting the session's user_id to the id of the new variable user that was just created in line 19
  
  redirect '/'
end

get '/login' do
  erb :login
end

post '/login' do
  email = params[:email] #1. get the email/passwords from params
  password = params[:password]

  user = User.where(email: email, password: password).first #look up the user

  if user.present? #or if user.password == password #Here we're checking if the password (from params) matches
    session[:user_id] = user.id
    redirect '/'
  else
    redirect '/login'
  end

end

post '/logout' do
  redirect 'login'
end

get '/posts/new' do
  erb :new_post
end

post '/posts/create' do
  title = params[:title]
  image = params[:image]

  new_post = current_user.posts.create(title: title, image: image) #this is an association

  if new_post
    redirect "/posts/#{new_post.id}"
  else
    redirect '/posts/new'
  end

end

get '/posts/:id' do
  @new_post = Post.find(params[:id])
  erb :show_post
end

get '/profile/edit' do
  current_user
  erb :profile
end

post '/profile/edit' do
  first_name = params[:first_name]
  last_name = params[:last_name]
  email = params[:email]
  password = params[:email]

  current_user.update(first_name: first_name, last_name: last_name, email: email, password: password)

  redirect '/'


end

