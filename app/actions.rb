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
  redirect '/'
end

post '/signup' do
  redirect '/'
end

post 'profile' do
  redirect '/'
end