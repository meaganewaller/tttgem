Gem::Specification.new do |s|
  s.name        = 'ttt_gem_8thlight'
  s.version     = '0.0.4'

  s.date        = '2013-10-06'
  s.summary     = 'Tic Tac Toe'
  s.description = 'Tic Tac Toe Gem'
  s.authors     = ["Meagan Waller"]
  s.email       = 'meaganewaller@gmail.com'
  s.files       = ["README.md", "Rakefile"]
  s.files       += Dir.glob("lib/**/*")
  s.files       += Dir.glob("spec/**/*")

  s.add_dependency("rspec")
  s.add_dependency("bundler")


  
  s.homepage    =
      'http://rubygems.org/gems/ttt_gem_8thlight'
  s.license     = 'MIT'
end
