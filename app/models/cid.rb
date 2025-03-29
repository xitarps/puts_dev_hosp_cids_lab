class Cid < ApplicationRecord
  has_many :user_cids
  has_many :users, through: :user_cids
end
