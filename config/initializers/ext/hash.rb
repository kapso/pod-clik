class Hash
  def compact!
    reject! { |k, v| v.nil? }
    self
  end

  def compact
    select { |k, v| !v.nil? }
  end
end
