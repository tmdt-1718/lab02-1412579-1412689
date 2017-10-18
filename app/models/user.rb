require 'bcrypt'

class User < ApplicationRecord
    has_secure_password

	validates :password_digest, presence: true
    validates :fullname, presence: true
    validates :email, presence: true
    validates_confirmation_of :password, presence: true

    has_many :friend
    has_many :mail
   
end
