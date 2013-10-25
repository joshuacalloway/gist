Gem::Specification.new do |s|
  s.name        = 'gistmeetup'
  s.version     = '0.0.1'
  s.date        = '2013-10-15'
  s.summary     = "gistmeetup"
  s.description = "A gem that uploads to gist and meetup"
  s.authors     = ["Joshua Calloway"]
  s.email       = 'joshua.calloway@gmail.com'
  s.files       = ["lib/gistmeetup.rb"]
  s.homepage    =
    'http://rubygems.org/gems/gistmeetup'
  s.executables << 'gistmeetup'
  s.add_dependency "gist", ">= 4.1.1"
  s.add_dependency "rubymeetup", ">= 3.0" 
  s.add_dependency "parse-ruby-client", "~> 0.2.0"
  s.add_dependency "json", ">= 1.8.1"
  s.license       = 'MIT'
end
