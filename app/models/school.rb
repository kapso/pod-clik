class School < ActiveRecord::Base
  extend Enumerize

  normalize_attribute :name, :address, :city, :state, :zip, :s_type, with: [:blank, :squish]

  enumerize :state_enum, in: { active: 1, inactive: 2 }, default: :active, predicates: true, scope: true
  enumerize :type_enum, in: { public: 1, other: 2 }, default: :public

  def self.near(lat, lon, limit: 20)
    select("*, coordinates <-> point '(#{lon},#{lat})' as distance").order('distance asc').limit(limit)
  end
end
