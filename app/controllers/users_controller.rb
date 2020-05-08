class UsersController < ApplicationController

    get '/signup' do
        if logged_in?
            @user = current_user
            redirect '/tweets'
        else
            erb :'/users/create_user'
        end
    end

    post '/signup' do
        @user = User.new(username: params[:username], email: params[:email], password: params[:password])

        if params[:username] == "" || params[:email] == "" || params[:password] == ""
            redirect '/signup'
        else 
            @user.save
            session[:user_id] = @user.id
            redirect to '/tweets'
        end
    end

    get '/login' do
        if logged_in?
            @user = current_user
           redirect to '/tweets'
        else
            erb :'/users/login'
        end
    end

    post '/login' do
        @user = User.find_by(username: params[:username])

        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect to '/tweets'
        else
            redirect to '/login'
        end
    end

    get '/logout' do
        if logged_in?
            session.clear
            redirect '/login'
        else
            redirect '/'
        end
    end

    get '/users/:id' do   
        @user = current_user(session)
        erb :'/users/show'
    end

end
