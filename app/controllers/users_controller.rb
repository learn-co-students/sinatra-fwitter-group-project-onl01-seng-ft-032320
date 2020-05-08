class UsersController < ApplicationController

    #signing up 
    get '/signup' do 
        binding.pry
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

        user = User.find_by(email: params[:email])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect "/tweets"
        else 
            redirect "/login"
        end 
    end 

    get '/logout' do 
        session.clear
        redirect "/login"
    end 
end
