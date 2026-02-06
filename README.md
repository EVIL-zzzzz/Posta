# Posta

This is the source code for the Posta iOS app.

## Purpose
This app allows users to import `.tendies` files to install wallpapers to the system collections and restart the device.

## ⚠️ Important Limitations
1. **Building**: I cannot generate a signed `.ipa` file directly. You must open this code in Xcode and build it yourself using your Apple ID.
2. **System Access**: Restarting the device and modifying system wallpaper collections (`/Library/Wallpaper/Collections` or similar) are **privileged operations**.
   - This app will **crash or fail silently** on a standard, non-jailbroken device because it lacks the necessary entitlements to escape the sandbox.
   - It is intended for educational purposes or for use in environments where these restrictions are lifted (e.g., specific exploits or jailbreaks).

## How to Build
### Option 1: Xcode (Recommended)
1. Create a new iOS App project in Xcode named "Posta".
2. Replace the generated swift files with the ones in `Sources/`.
3. Configure `Info.plist` to support the `.tendies` file extension as described in `Info_Settings.xml`.
4. Build and run on your device.

### Option 2: Command Line (Makefile)
**Prerequisite:** You MUST have the full **Xcode** application installed from the App Store. The "Command Line Tools" package alone is **not enough** because it does not contain the iOS SDK.

1. Ensure Xcode is selected: `sudo xcode-select -s /Applications/Xcode.app/Contents/Developer`
   (If this fails, you likely don't have Xcode installed).
2. Run `make` in this directory.
3. The output will be `build/Posta.ipa`.

**Note**: This requires the iOS SDK, which comes with Xcode. It will not work with only the Command Line Tools package.
