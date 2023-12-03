Pod::Spec.new do |spec|
  spec.name         = "ThreadWatcher"
  spec.version      = "0.0.1"
  spec.summary      = "Detect and observe main thread hangouts with ThreadWatcher."
  spec.description  = <<-DESC
                      The "ThreadWatcher" library is a Swift framework designed to facilitate the monitoring and observation of thread behavior within a Swift application. This library aims to provide developers with a set of tools to track and analyze the execution of threads, particularly in scenarios where thread hangs or unexpected delays may impact application performance.
                      DESC
  
  spec.homepage     = "https://github.com/harryngict/ThreadWatcher"
  spec.source       = { :git => "git@github.com:harryngict/ThreadWatcher.git", :tag => "#{spec.version}" }
  spec.authors      = { "Hoang Nguyen" => "harryngict@gmail.com" }
  spec.license      = { :type => "MIT", :text => "Copyright (c) 2023" }
  spec.swift_version = '5.0'
  spec.platform     = :ios, "12.0"
  spec.requires_arc = true
  spec.static_framework = true
  spec.source_files  = "Sources/ThreadWatcher/**/**/*.{swift}"
end
