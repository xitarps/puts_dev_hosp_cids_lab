class UserCid < ApplicationRecord
  belongs_to :user
  belongs_to :cid

  has_many :hospital_user_cids
  has_many :hospitals, through: :hospital_user_cids
end
