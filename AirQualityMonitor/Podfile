# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'
use_frameworks!

def shared_pods
    pod 'RxSwift', '~> 4.0.0'
    pod 'RxCocoa', '~> 4.0.0'
    pod 'Moya/RxSwift', '~> 10.0'
    pod 'RxDataSources', '~> 3.0'
    pod 'Charts', '~> 3.0.4'
end

target 'AirQualityMonitor' do
  shared_pods
end

target 'APITests' do
    pod 'Moya/RxSwift', '~> 10.0'
    pod 'RxSwift', '~> 4.0.0'
end
