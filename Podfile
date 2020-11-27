# Podfile
use_frameworks!


def common_pods_for_target
  pod 'RxSwift', '~> 5'
  pod 'RxCocoa', '~> 5'
  pod 'Moya-ModelMapper', '~> 10.0'
  pod 'Moya-ModelMapper/RxSwift', '~> 10.0'
  pod 'Kingfisher'
  pod 'ProgressHUD'
  pod 'Swinject'
  pod 'SwinjectStoryboard' , :git => 'https://github.com/Swinject/SwinjectStoryboard.git', :branch => 'master'
  pod 'pop', '1.0.10'
  pod 'ReachabilitySwift'
  pod 'RealmSwift'
end

target 'TinderSwipeCards' do
  common_pods_for_target
end

# RxTest and RxBlocking make the most sense in the context of unit/integration tests
target 'TinderSwipeCardsTests' do
    pod 'RxSwift', '~> 5'
    pod 'RxCocoa', '~> 5'
    pod 'RxBlocking', '~> 5'
    pod 'RxTest', '~> 5'
    pod 'RealmSwift'
end

target 'TinderSwipeCardsUITests' do
    pod 'RxSwift', '~> 5'
    pod 'RxCocoa', '~> 5'
    pod 'RxBlocking', '~> 5'
    pod 'RxTest', '~> 5'
    pod 'SwinjectStoryboard' , :git => 'https://github.com/Swinject/SwinjectStoryboard.git', :branch => 'master'
end
