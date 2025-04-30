require "ostruct"

class Reports::OverallQuery < BaseQuery
  private

  def run
    UserCid.select("COUNT(cids.id) AS total", cids: [ :number, :description ])
           .joins(:cid)
           .group(cids: :id)
           .order(cids: { id: :asc })
  end
end
