Gem::Specification.new do |s|
  s.name               = "datalanche"
  s.version            = "0.0.1"
  s.default_executable = "datalanche"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Datalanche Inc."]
  s.date = %q{2014-04-23}
  s.description = %q{Official Ruby client for Datalanche.}
  s.email = %q{contact@datalanche.com}
  s.files = ["lib/datalanche.rb","lib/datalanche/client.rb", "lib/datalanche/query.rb", "lib/datalanche/exception.rb"]
  s.homepage = %q{https://api.datalanche.com}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.8.23}
  s.summary = %q{datalanche}
  s.license = 'MIT'

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end