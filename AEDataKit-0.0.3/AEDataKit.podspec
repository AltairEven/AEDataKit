Pod::Spec.new do |s|
  s.name = "AEDataKit"
  s.version = "0.0.3"
  s.summary = "This is a short description of AEDataKit."
  s.license = {"type"=>"MIT", "file"=>"LICENSE"}
  s.authors = {"Altair"=>"evendipper@163.com"}
  s.homepage = "https://github.com/AltairEven/AEDataKit.git"
  s.description = "Add long description of the pod here.This is a data interface for AEStructure."
  s.source = { :git => 'https://github.com/AltairEven/AEDataKit.git', :tag => s.version.to_s }

  s.ios.deployment_target    = '8.0'
  s.ios.vendored_framework   = 'AEDataKit-0.0.3/ios/AEDataKit.framework'
end
