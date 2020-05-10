class UsersController < ApplicationController

    get '/' do
     erb :'/users/index'
    end

    get '/login' do
        if logged_in?
            redirect '/tweets'
        end
        erb :'/users/login'
    end

    post '/login' do
        user = User.find_by(username: params[:username])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id 
            redirect '/tweets'
        end
        redirect '/login'
    end

    get '/signup' do
        if logged_in?
            redirect '/tweets'
            
        end
            erb :'/users/signup'
    end

    post '/signup' do  
       unless params[:username] == "" || params[:email] == ""
        user = User.new(params) 
            if user.save
            session[:user_id] = user.id
            redirect '/tweets'
            end
        end
        redirect '/signup'
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
        @user = User.find_by(params[:id])
        erb :'/users/show'
    end

end
