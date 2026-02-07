# Makefile for Posta
# Requires Xcode Command Line Tools and iOS SDK

TARGET_NAME = Posta
BUNDLE_ID = com.example.Posta
SDK = iphoneos
TARGET = arm64-apple-ios14.0

SWIFT_SOURCES = $(wildcard Sources/*.swift)
OUTPUT_DIR = build
APP_BUNDLE = $(OUTPUT_DIR)/$(TARGET_NAME).app
EXECUTABLE = $(APP_BUNDLE)/$(TARGET_NAME)
IPA_NAME = $(TARGET_NAME).ipa

all: check_xcode clean ipa

check_xcode:
	@echo "Checking for iOS SDK..."
	@xcrun --sdk iphoneos --show-sdk-path > /dev/null 2>&1 || (echo "Error: iOS SDK not found. You must install the full Xcode app from the App Store, not just Command Line Tools." && exit 1)

$(APP_BUNDLE):
	@mkdir -p $(APP_BUNDLE)
	@echo "Compiling Swift sources..."
	xcrun -sdk $(SDK) swiftc $(SWIFT_SOURCES) \
		-target $(TARGET) \
		-o $(EXECUTABLE) \
		-Xlinker -rpath -Xlinker @executable_path/Frameworks \
		-parse-as-library

	@echo "Copying Info.plist..."
	cp Info.plist $(APP_BUNDLE)/Info.plist
	
	@echo "Creating PkgInfo..."
	echo "APPL????" > $(APP_BUNDLE)/PkgInfo

sign:
	@echo "Cleaning extended attributes..."
	xattr -cr $(APP_BUNDLE)
	@echo "Signing..."
	# Ad-hoc signing. Replace with valid identity if needed.
	codesign -s - --entitlements entitlements.plist --force --deep $(APP_BUNDLE)

ipa: $(APP_BUNDLE) sign
	@echo "Packaging into IPA..."
	@mkdir -p $(OUTPUT_DIR)/Payload
	@cp -r $(APP_BUNDLE) $(OUTPUT_DIR)/Payload/
	@cd $(OUTPUT_DIR) && zip -r $(IPA_NAME) Payload
	@rm -rf $(OUTPUT_DIR)/Payload
	@echo "Done! IPA is at $(OUTPUT_DIR)/$(IPA_NAME)"
	@mkdir -p docs
	@cp $(OUTPUT_DIR)/$(IPA_NAME) docs/
	@echo "Copied IPA to docs/ directory for hosting."

clean:
	rm -rf $(OUTPUT_DIR)

.PHONY: all clean sign ipa
