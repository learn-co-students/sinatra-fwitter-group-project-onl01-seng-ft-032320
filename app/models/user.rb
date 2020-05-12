class User < ActiveRecord::Base
    has_secure_password
    has_many :tweets

    def slug
        "#{self.username.gsub(/\s/,'-')}"
    end

    def self.find_by_slug(comparison)
        @user = nil
        self.all.each do |user|
            if user.slug == comparison
                @user = user
            end
        end
        @user
    end
end
