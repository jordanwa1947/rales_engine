module FindMethods
  def find_by_given_param(query_params)
    query = query_params.to_h.first
    find_by("#{query[0]} = ?", query[1])
  end

  def find_all_by_given_param(query_params)
    query = query_params.to_h.first
    where("#{query[0]} = ?", query[1])
  end
end
