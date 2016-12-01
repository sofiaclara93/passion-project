get '/users/new' do
  erb :'/users/new'
end

post '/users' do
  user = User.new(params[:user])
  if user.save
    session[:user_id] = user.id
    redirect "/users/#{user.id}"
  else
    @errors = user.errors.full_messages
    erb :'/users/new'
  end
end

get '/users/:user_id' do
  # binding.pry
  @user = User.find_by(id: params[:user_id])
  if logged_in? && current_user.id == @user.id
    erb :'/users/show'
  else
    status 404
  end
end
