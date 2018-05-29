@version = "2.0.0"
@podName = "ZHAutoSizeTagView"
@baseURL = "github.com"
@basePath = "josercc/#{@podName}"
@baseSourcePath = "#{@podName} Example/#{@podName}"
@baseFilePath = "**/*.{swift}"
@source_files = "#{@baseSourcePath}/#{@baseFilePath}"
@frameworkName = "#{@podName}"
Pod::Spec.new do |s|
  s.name          = "#{@podName}"
  s.version       = @version
  s.summary       = "自动计算宽度和高度的标签控件"
  s.homepage      = "https://#{@baseURL}/#{@basePath}"
  s.license       = { :type => 'MIT', :file => 'LICENSE' }
  s.author        = { "josercc" => "josercc@163.com" }
  s.platform      = :ios, '8.0'
  s.source        = { :git => "#{s.homepage}.git", :tag => "#{s.version}" }
  s.framework     = "UIKit"
  s.subspec 'Source' do |source|
    source.source_files = @source_files
  end
  s.subspec 'Framework' do |framework|
    framework.vendored_frameworks = "Carthage/build/iOS/#{@frameworkName}.framework"

  end
  s.resource_bundles = {
    @podName => ["#{@baseSourcePath}/images/*.{png}"]
  }
  # s.prepare_command =  <<-CMD
  # touch Cartfile
  # echo 'git "git@#{@baseURL}:#{@basePath}.git" == #{@version}' > Cartfile
  # Carthage update --platform iOS
  # CMD
  s.default_subspecs = 'Source'

end
