class ReportsController < ApplicationController
  def by_hosp
    @hosp_user_cids = HospitalUserCid.select(cid: [ :number, :description ],
                                             hospital: [ :name ])
                                     .select("COUNT(user_cids.id) AS quantity")
                                     .joins(:hospital, user_cid: :cid)
                                     .where(hospital_id: params[:hosp_id].to_i)
                                     .group(user_cids: :cid_id,
                                            cid: [ :number, :description ],
                                            hospital: [ :name ])
                                     .order(cid_id: :asc)
  end

  def by_user
    @user_cids = UserCid.select(cids: [ :number, :description ],
                                hospitals: [ :name ])
                        .joins(:cid, hospital_user_cids: :hospital)
                        .where(user_id: params[:user_id])
                        .order(user_id: :desc)
  end

  def overall
    @user_cids = UserCid.select("COUNT(cids.id) AS total",
                                cids: [ :number, :description ])
                        .joins(:cid)
                        .group(cids: :id)
                        .order(cids: { id: :asc })
  end
end
