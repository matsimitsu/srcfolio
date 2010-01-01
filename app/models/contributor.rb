class Contributor
  include MongoMapper::Document

  key :login,         String
  key :name,          String
  key :description,   String
  key :company,       String
  key :location,      String
  key :website,       String
  key :email,         String
  key :contributions, Array
  key :visible,       Boolean, :default => true
  timestamps!

  def best_name
    (name.nil? || name.empty?) ? login : name
  end

  def  gravatar_url(size = nil)
    "http://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(email || '')}.jpg?s=#{size||80}"
  end

  def visible_contributions_with_projects
    visible_contributions = contributions.select do |c|
      c['visible']
    end
    
    visible_contributions_with_projects = visible_contributions.map do |c|
      c.merge({'project' => Project.find(c['project'])})
    end
    
    visible_contributions_with_projects.sort_by do |c|
      [c['order'] || 0, - (c['stopped_at'] ? c['stopped_at'].to_i : 0)]
    end
  end
end
