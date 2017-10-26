Gem::Specification.new do |s|
  s.name = 'countries_patch'
  s.version = '0.0.0'
  s.date = '2017-10-26'
  s.summary = 'A patch of the countries gem to add more aliases'
  s.author = 'zloh'
  s.files = ['lib/country.rb', 'data/address_aliases.yml']
  s.platform = Gem::Platform::RUBY
  s.add_runtime_dependency 'yaml'
  s.add_runtime_dependency 'countries', '~> 2.0.8'
  s.add_development_dependency 'rspec'
end
