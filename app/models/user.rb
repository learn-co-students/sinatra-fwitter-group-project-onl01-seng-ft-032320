class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  def slug 
    username = self.username
    slug = username.downcase.strip.gsub(" ","-")
  end 

  def self.find_by_slug(slug)
    #binding.pry
    

    User.find do |r| r.slug == slug 
    end 

  end 
end
