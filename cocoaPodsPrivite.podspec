Pod::Spec.new do |s|
s.name             = 'cocoaPodsPrivite'
s.version          = '0.1.3'
s.summary          = 'privite cocoaPod test project.'
s.homepage         = 'https://github.com/Qinzhuni/cocoaPodsPrivite'
s.license          = 'Code is MIT, then custom font licenses.'
s.author           = { 'Lincoln' => 'qinzhuni@163.com' }
s.source           = { :git => 'https://github.com/Qinzhuni/cocoaPodsPrivite.git', :tag => s.version }

s.platform     = :ios, '7.0'
s.requires_arc = true

s.source_files = 'priviteCocoaPod/priviteCocoaPod/Classes/*'

s.frameworks = 'UIKit'
s.module_name = 'cocoaPodsPrivite'
end
