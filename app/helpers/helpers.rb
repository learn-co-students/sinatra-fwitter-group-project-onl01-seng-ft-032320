  
class Helpers

    def self.current_user(hash)
      #binding.pry
      @user = User.find(hash[:user_id])  
    end 

    def self.is_logged_in?(hash)
        !!hash[:user_id]

    end 
end

