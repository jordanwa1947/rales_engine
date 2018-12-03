module FindMethods
  def find_by_given_param(query_params)
    query = query_params.to_h.first
    if query[0] == "unit_price"
      query[1] = (query[1].to_f * 100).to_i
    elsif query[0] =~ /id/
      query[1] = query[1].to_i
    end
    find_by("#{query[0]} = ?", query[1])
  end

  def find_all_by_given_param(query_params)
    query = query_params.to_h.first
    if query[0] == "unit_price"
      query[1] = (query[1].to_f * 100).to_i
    elsif query[0] =~ /id/
      query[1] = query[1].to_i
    end
    where("#{query[0]} = ?", query[1])
  end
end
