class TeamSerializer < ActiveModel::Serializer
  attributes :id,
            :name, 
            :abbr,
            :external_url,
            :division,
            :conference,
            :inaugural_year
end
