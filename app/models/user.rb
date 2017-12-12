class User < ApplicationRecord
    def self.find_or_create_by_auth(auth_data)
        data = auth_data.info
        user = User.where(email: data['email']).first

        unless user
            user = User.create(
                name: data['name'],
                email: data['email']
                )
        end

        return user
    end
end
