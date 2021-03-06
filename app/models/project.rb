class Project
  include MongoMapper::Document

  key :name,        String
  key :namespace,   String
  key :owner,       Contributor
  key :github_url,  String
  key :description, String
  key :homepage,    String
  key :fork,        Boolean
  key :commits,     Integer
  timestamps!
  
  many :links
end
