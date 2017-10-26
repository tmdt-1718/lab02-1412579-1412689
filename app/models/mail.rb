class Mail < ApplicationRecord

    belongs_to :user, optional: true
end
