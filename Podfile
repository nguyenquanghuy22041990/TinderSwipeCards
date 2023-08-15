# Podfile
use_frameworks!


def common_rx_swift_pods_for_targets
  pod 'RxSwift'
  pod 'RxCocoa'
end

def common_pods_for_target
  common_rx_swift_pods_for_targets
  pod 'Moya-ModelMapper', '~> 10.0'
  pod 'Moya-ModelMapper/RxSwift', '~> 10.0'
  pod 'Kingfisher'
  pod 'ProgressHUD'
  pod 'ReachabilitySwift'
  pod 'RealmSwift'
  pod "Koloda"
end


target 'TinderSwipeCards' do
  common_pods_for_target
end

# RxTest and RxBlocking make the most sense in the context of unit/integration tests

def common_rx_swift_for_test_targets
  pod 'RxBlocking'
  pod 'RxTest'
end

target 'TinderSwipeCardsTests' do
    common_rx_swift_pods_for_targets
    common_rx_swift_for_test_targets
    pod 'RealmSwift'
end

target 'TinderSwipeCardsUITests' do
  common_rx_swift_pods_for_targets
  common_rx_swift_for_test_targets
end
