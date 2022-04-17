Gem::Specification.new do |gem_spec|
  gem_spec.name = 'invader_detector'
  gem_spec.version = '0.0.1'
  gem_spec.date = '2022-04-03'
  gem_spec.summary = 'Invader Detector'
  gem_spec.description = 'Lightweight ASCII parser'
  gem_spec.authors = ['Tamas Kamaras']
  gem_spec.email = 'kamaras.tamas.viktor@gmail.com'
  gem_spec.homepage = 'https://github.com/tamaskamaras/invader_detector'
  gem_spec.license = 'MIT'
  gem_spec.files = [
    'lib/invader_detector.rb',
    'lib/app/monitor.rb',
    'lib/app/radar.rb',
    'lib/app/radar/frame.rb',
    'lib/app/radar/invader.rb',
    'lib/app/radar/pixel.rb',
    'lib/app/radar/screen.rb'
  ]
  gem_spec.require_paths = ['lib']
  gem_spec.metadata = {
    'source_code_uri' => 'https://github.com/tamaskamaras/invader_detector.git'
  }
  gem_spec.add_development_dependency('rspec', '~> 3.11', '>= 3.11.0')
end
