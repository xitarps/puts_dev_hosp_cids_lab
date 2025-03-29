class Hosptial < ApplicationRecord
  has_many :hospital_user_cids
  has_many :user_cids, through: :hospital_user_cids
end
