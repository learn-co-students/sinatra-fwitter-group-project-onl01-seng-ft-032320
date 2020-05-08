class UsersController < ApplicationController

    #signing up 
    get '/signup' do 
        if logged_in? 
            redirect '/tweets'
        else 
            erb :"users/create_user"
        end 
    end 

    post '/signup' do 
        #create the new user
        if !params[:username].empty? && !params[:email].empty? && !params[:password].empty?
            user = User.new(params)
            if user.save 
                session[:user_id] = user.id
                redirect '/tweets'
            else
                redirect '/signup'
            end 
        else 
            redirect '/signup'
        end 
    end 

    #loggin/logout
    get '/login' do
        if logged_in? 
            redirect '/tweets'
        else 
            erb :"users/login"
        end
    end 

    post '/login' do 

        user = User.find_by(username: params[:username])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect "/tweets"
        else 
            redirect "/login"
        end 
    end 

    get '/logout' do 
        if logged_in?
            session.clear
            redirect "/login"
        else 
            redirect "/"
        end 
    end 


    get "/users/:slug" do 
        @user = User.find_by_slug(params[:slug])
        erb :"/users/show"
    end 
end
