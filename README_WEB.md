# Hosting the Posta Install Site

To install the app directly from your browser ("Over-The-Air" or OTA), you need to host the files in the `web/` directory on a server that supports **HTTPS**.

## Quick Start (GitHub Pages)
1.  Create a new public GitHub repository.
2.  Upload the contents of the `web/` folder to the repository.
3.  Go to **Settings > Pages** and enable GitHub Pages (Source: Main branch).
4.  Get your site URL (e.g., `https://username.github.io/repo/`).

## Configuration
You **MUST** edit two files to point to your actual URL:

1.  **Edit `web/manifest.plist`**:
    *   Change `https://YOUR_DOMAIN_HERE/Posta.ipa` to your actual IPA URL (e.g., `https://username.github.io/repo/Posta.ipa`).

2.  **Edit `web/index.html`**:
    *   Change `https://YOUR_DOMAIN_HERE/manifest.plist` to your actual manifest URL (e.g., `https://username.github.io/repo/manifest.plist`).

## ⚠️ Requirements for OTA Installation
For the "Install" button to work, one of the following must be true:
1.  **Enterprise Certificate**: The IPA is signed with an Apple Enterprise certificate.
2.  **UDID Registration**: The IPA is signed with a Developer certificate that includes your device's UDID.
3.  **Jailbreak/AppSync**: The device is jailbroken with AppSync Unified installed (bypasses signature checks).
4.  **TrollStore**: If using TrollStore, do not use the "Install" button. Instead, use the "Download .ipa" link and open it in TrollStore.
