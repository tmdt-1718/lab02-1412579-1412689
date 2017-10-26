# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'bcrypt'

# (1..30).each do |number|
#     User.create!(email: "tangliang#{number}@gmail.com", password_digest: BCrypt::Password.create("123456"), fullname: "tangliang#{number}")
# end

User.create!(email: "content.itvmtri@gmail.com", password_digest: BCrypt::Password.create("1"), fullname: "Vũ Minh Trí")
