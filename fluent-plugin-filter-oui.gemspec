# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "fluent-plugin-filter-oui"
  spec.version       = "0.0.7"
  spec.authors       = ["HomeSOC"]
  spec.email         = ["github@homesoc.io"]

  spec.summary       = %q{Return vendor ID from MAC address.}
  spec.description   = %q{Return vendor ID from MAC address.}
  spec.homepage      = "https://github.com/homesoc/fluent-plugin-filter-oui"
  spec.license           = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
