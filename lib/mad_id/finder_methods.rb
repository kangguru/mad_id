module MadID::FinderMethods

  def find_by_mad_id!(id)
    find_by!(identifier: id.to_s.downcase)
  end
  def find_by_mad_id(id)
    find_by(identifier: id.to_s.downcase)
  end

end
