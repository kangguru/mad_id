module MadID::FinderMethods

  def find_by_mad_id!(id)
    find_by!(mad_id_column => id.to_s.downcase)
  end
  def find_by_mad_id(id)
    find_by(mad_id_column => id.to_s.downcase)
  end

  def mad_id_column
    @mad_id_column || 'id'
  end

  def mad_id_column=(val)
    @mad_id_column = val
  end

end
