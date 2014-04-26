
install:
	gem install xcpretty  --no-ri --no-rdoc

ci:
	xcodebuild -project NSStringFromAnyObjectApp.xcodeproj/ -scheme NSStringFromAnyObjectAppTests -sdk iphonesimulator7.1 -configuration Release clean test | xcpretty -c
	
