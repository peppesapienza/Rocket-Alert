Pod::Spec.new do |s|
    s.name              = 'Rocket Alert'
    s.version           = '1.0.0'
    s.summary           = 'User friendly, Modular and Modern iOS Alert View'
    s.homepage          = 'https://github.com/peppesapienza/Rocket-Alert'

    s.author            = { 'Giuseppe Sapienza' => 'giuseppe.sapienza@xcoding.it' }
    s.license           = { :type => 'Apache-2.0', :file => 'LICENSE' }

    s.platform          = :ios
    s.source            = { :http => 'https://github.com/peppesapienza/Rocket-Alert.git' }

    s.ios.deployment_target = '10.0'
    s.source_files = 'RocketAlert/*.{swift,plist}'
end
