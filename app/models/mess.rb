class Mess < ApplicationRecord
    belongs_to :user, optional: true
end
