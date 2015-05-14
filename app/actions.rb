helpers do
  def current_user
    @current_user = User.find_by(id: session[:user_id]) if session[:user_id]
  end
end

# Homepage (Root path)
get '/' do
  erb :index
end

get '/login' do
  erb :login
end

get '/profile' do
  erb :profile
end

get '/signup' do
  erb :signup
end

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

post 'profile' do
  redirect '/'
end