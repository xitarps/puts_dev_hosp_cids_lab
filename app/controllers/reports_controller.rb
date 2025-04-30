class ReportsController < ApplicationController
  def by_hosp
    @hosp_user_cids = Reports::ByHospQuery.call(id: params[:hosp_id])
  end

  def by_user
    @user_cids = UserCid.select(cids: [ :number, :description ],
                                hospitals: [ :name ])
                        .joins(:cid, hospital_user_cids: :hospital)
                        .where(user_id: params[:user_id])
                        .order(user_id: :desc)
  end

  def overall
    @user_cids = Reports::OverallQuery.call
  end
end
