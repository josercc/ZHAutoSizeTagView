Pod::Spec.new do |s|
  s.name         = "ZHAutoSizeTagView"
  s.version      = "1.0.3"
  s.summary      = "标签控件 类似于京东淘宝双11 黑五 自营等标签，可以自动计算宽度或者高度 可以设置限制行数 其他信息看 reademe"
  s.homepage     = "https://github.com/josercc/ZHAutoSizeTagView"
  s.screenshots  = "http://ipicimage-1251019290.coscd.myqcloud.com/2017-12-14-024428.png", "http://ipicimage-1251019290.coscd.myqcloud.com/2017-12-14-024537.png"
  s.license      = "MIT"
  s.author             = { "josercc" => "josercc@163.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/josercc/ZHAutoSizeTagView.git", :tag => "#{s.version}" }
  s.vendored_frameworks = "FrameWork/ZHAutoSizeTagView_iOS.framework"
end
