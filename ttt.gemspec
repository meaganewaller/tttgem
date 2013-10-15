Gem::Specification.new do |s|
  s.name        = 'ttt_gem_8thlight'
  s.version     = '0.0.9'
  s.date        = '2013-10-15'
  s.summary     = 'My Tic Tac Toe engine with unbeatable AI'
  s.description = 'Tic Tac Toe engine for powering CLI & Sinatra Web App'
  s.authors     = ["Meagan Waller"]
  s.email       = 'meaganewaller@gmail.com'
  s.files       = %w( README.md Rakefile)
  s.files       += Dir.glob("lib/**/*")
  s.files       += Dir.glob("spec/**/*")

  s.add_dependency("rspec")
  s.add_dependency("bundler")
end
