class ReportsController < ApplicationController
  def by_hosp
    @hosp_id = params[:hosp_id]
    @hosp_user_cids = HospitalUserCid.all
  end

  def by_user
    @user_id = params[:user_id]
    @user_cids = UserCid.all
  end

  def overall
    @user_cids = UserCid.all
  end
end
