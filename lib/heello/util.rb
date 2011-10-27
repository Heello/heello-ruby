class Hash
  def to_query
    parts = []
    self.each do |key, value|
      parts.push "#{key.to_s}=#{URI.escape(value.to_s)}"
    end
    
    parts.join "&"
  end
end