class HospitalUserCid < ApplicationRecord
  belongs_to :user_cid
  belongs_to :hospital
end
