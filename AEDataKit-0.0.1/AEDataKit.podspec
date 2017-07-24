Pod::Spec.new do |s|
  s.name = "AEDataKit"
  s.version = "0.0.1"
  s.summary = "This is a short description of AEDataKit."
  s.license = {"type"=>"MIT", "file"=>"LICENSE"}
  s.authors = {"${USER_NAME}"=>"${USER_EMAIL}"}
  s.homepage = "https://github.com/AltairEven/AEDataKit.git"
  s.description = "Add long description of the pod here.This is a data interface for AEStructure."
  s.source = { :path => '.' }

  s.ios.deployment_target    = '8.0'
  s.ios.vendored_framework   = 'ios/AEDataKit.framework'
end
