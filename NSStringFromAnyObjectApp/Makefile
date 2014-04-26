
install:
	gem install cocoapods --no-ri --no-rdoc
	gem install xcpretty  --no-ri --no-rdoc
	pod install

ci:
	xcodebuild -project NSStringFromAnyObjectApp.xcodeproj/ -scheme NSStringFromAnyObjectAppTests -sdk iphonesimulator7.1 -configuration Release clean test | xcpretty -c
	
