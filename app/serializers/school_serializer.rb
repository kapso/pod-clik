class SchoolSerializer < BaseSerializer
  attributes :id, :name, :address, :city, :state, :zip, :coordinates

  def coordinates
    object.coordinates.reverse
  end
end
