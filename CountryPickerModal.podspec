Pod::Spec.new do |spec|

  spec.name         = "CountryPickerModal"
  spec.version      = "1.0.0"
  spec.summary      = "A simple, customizable view for selecting countries in iOS apps."
  spec.homepage     = "https://github.com/aeke/CountryPickerModal"
  spec.license      = "MIT"
  spec.author       = { "Abdullah EKE" => "abdheke@gmail.com" }
  spec.platform     = :ios, "8.0"
  spec.source       = { :git => "https://github.com/aeke/CountryPickerModal.git", :tag => spec.version }
  spec.source_files  = "CountryPickerModal/**/*.{swift}"
  spec.resource_bundles = {
    'CountryPickerModal' => ['CountryPickerModal/Assets/CountryPickerModal.bundle/*',
    'CountryPickerModal/**/*.{xib}']
  }
  spec.pod_target_xcconfig = { 'SWIFT_VERSION' => '4.2' }

end
