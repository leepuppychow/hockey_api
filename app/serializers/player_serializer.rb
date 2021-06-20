class PlayerSerializer < ActiveModel::Serializer
    attributes :id,
              :team_id, 
              :first_name,
              :last_name,
              :external_url,
              :jersey_number,
              :position
  end
  