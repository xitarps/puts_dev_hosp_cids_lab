require "ostruct"

class Reports::ByHospQuery < BaseQuery
  private

  # def run
  #   HospitalUserCid.select(cid: [ :number, :description ],
  #                          hospital: [ :name ])
  #                   .select("COUNT(user_cids.id) AS quantity")
  #                   .joins(:hospital, user_cid: :cid)
  #                   .where(hospital_id: @id)
  #                   .group(user_cids: :cid_id,
  #                          cid: [ :number, :description ],
  #                          hospital: [ :name ])
  #                   .order(cid_id: :asc)
  # end

  def run
    query

    result = ActiveRecord::Base.connection.execute(
      ApplicationRecord.sanitize_sql_array(
        [ query, hosp_id: @id ]
      )
    )

    result = JSON.parse(result.to_json, symbolize_names: true)

    result.map do |item|
      object = OpenStruct.new
      item.keys.each { |key| object.send("#{key}=", item[key]) }
      object
    end

    # result.map do |item|
    #   item = HospitalUserCid.new.attributes(item)
    #   item.instance_variable_set(:@new_record, false)
    # end
  end

  def query
    %(
      SELECT cid.number, cid.description, hospital.name, COUNT(user_cids.id) AS quantity
      FROM hospital_user_cids
    ) << joins << filters << group_clause << order
  end

  def joins
    "
      INNER JOIN hospitals hospital
        ON hospital.id = hospital_user_cids.hospital_id
      INNER JOIN user_cids
        ON user_cids.id = hospital_user_cids.user_cid_id
      INNER JOIN cids cid
        ON cid.id = user_cids.cid_id
    "
  end

  def filters
    " WHERE hospital_user_cids.hospital_id = :hosp_id"
  end

  def order
    " ORDER BY cid_id ASC"
  end

  def group_clause
    " GROUP BY user_cids.cid_id, cid.number, cid.description, hospital.name"
  end

end
