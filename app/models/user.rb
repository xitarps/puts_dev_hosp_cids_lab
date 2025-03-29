class User < ApplicationRecord
  has_many :user_cids
  has_many :cids, through: :user_cids
end
