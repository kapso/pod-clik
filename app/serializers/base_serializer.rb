class BaseSerializer < ActiveModel::Serializer
  def attributes
    super.compact
  end
end
