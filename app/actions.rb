helpers do
  def current_user
    @current_user = User.find_by(id: session[:user_id]) if session[:user_id]
  end
end

before do
  redirect '/login' if !current_user && request.path != '/' && request.path != '/login' && request.path != '/signup'
end

# Homepage (Root path)
get '/' do
  @pins = Pin.all.limit(9)
  erb :index
end

# login page
get '/login' do
  erb :login
end

# logout page
get '/logout' do
  session[:user_id] = nil
  redirect '/login'
end

# edit profile page
get '/profile/edit' do
  current_user
  erb :profile
end

# new user
get '/signup' do
  erb :signup
end

# new pin
get '/pins/new' do
  erb :new_pin
end

# existing pin
get '/pins/:id' do
  @pin = Pin.find(params[:id])
  erb :pin
end

# create new session
post '/login' do
  username = params[:login_username]
  password = params[:login_password]

  user = User.find_by(username: username)
  if user.password == password
    session[:user_id] = user.id
    redirect '/'
  else
    redirect'/login'
  end
end

# create new user
post '/signup' do
  username = params[:signup_username]
  password = params[:signup_password]
  email = params[:signup_email]

  user = User.find_by(username: username)
  if user
    redirect '/login'
  else
    user = User.create(username: username, password: password, email: email)
    session[:user_id] = user.id
    redirect '/'
  end
end

# edit user profile
post '/profile/edit' do
  username = params[:username]
  email = params[:email]
  password = params[:password]

  current_user.update username: username, email: email, password: password
  redirect '/'
end

# create new pin
post '/pins/create' do
  description = params[:pin_descr]
  new_pin = current_user.pins.create(description: description)
  redirect '/pins/#{new_pin.id}'
end