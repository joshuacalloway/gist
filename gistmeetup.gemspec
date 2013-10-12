Gem::Specification.new do |s|
  s.name        = 'gistmeetup'
  s.version     = '0.0.0'
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
  s.add_dependency "rMeetup", ">= 3.0" 
  s.license       = 'MIT'
end
