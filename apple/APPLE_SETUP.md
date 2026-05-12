# Apple App Store — Complete Setup Guide
## FairValueAuto iOS Publishing

**Time required:** ~2 hours (most is waiting for Apple)
**Cost:** $99/year Apple Developer Program

---

## STEP 1 — Join Apple Developer Program

1. Go to: https://developer.apple.com/programs/enroll/
2. Sign in with your Apple ID (or create one)
3. Choose: **Individual** (not Organization, unless you have a business)
4. Pay $99/year with a credit card
5. Wait for approval email (usually instant, sometimes 24-48hrs)

---

## STEP 2 — Create App Store Connect API Key

This lets GitHub Actions upload your app WITHOUT needing your password.

1. Go to: https://appstoreconnect.apple.com/access/integrations/api
2. Click **"+"** to generate a new key
3. Name: `FairValueAuto GitHub Actions`
4. Access: **App Manager**
5. Click **Generate**
6. **DOWNLOAD THE .p8 FILE NOW** (you can only download it once!)
7. Note your:
   - **Key ID** (10-character code shown on the page)
   - **Issuer ID** (shown at top of the page)

---

## STEP 3 — Create the App in App Store Connect

1. Go to: https://appstoreconnect.apple.com/apps
2. Click **"+"** → **New App**
3. Fill in:
   - Platforms: **iOS**
   - Name: **FairValueAuto — Best Car Deal Finder**
   - Primary Language: **English (U.S.)**
   - Bundle ID: **app.fairvalueauto** (create this in Developer portal first)
   - SKU: **fairvalueauto-001**
4. Click **Create**

---

## STEP 4 — Create Bundle ID in Developer Portal

1. Go to: https://developer.apple.com/account/resources/identifiers/list
2. Click **"+"**
3. Select **App IDs** → **App**
4. Description: `FairValueAuto`
5. Bundle ID: **Explicit** → `app.fairvalueauto`
6. Capabilities: Check **Push Notifications**
7. Click **Register**

---

## STEP 5 — Create Distribution Certificate

1. Go to: https://developer.apple.com/account/resources/certificates/list
2. Click **"+"**
3. Select **Apple Distribution**
4. Follow prompts to create a CSR from your Mac (or use a service like Codemagic)
5. Download the certificate (.cer file)
6. Double-click to install in Keychain
7. Export as .p12 from Keychain with a password
8. Convert to base64:
   ```
   base64 -i certificate.p12 | pbcopy
   ```

---

## STEP 6 — Create Provisioning Profile

1. Go to: https://developer.apple.com/account/resources/profiles/list
2. Click **"+"**
3. Select **App Store Connect**
4. Choose your Bundle ID: `app.fairvalueauto`
5. Select your Distribution Certificate
6. Name: `FairValueAuto Distribution`
7. Download the .mobileprovision file
8. Convert to base64:
   ```
   base64 -i FairValueAuto_Distribution.mobileprovision | pbcopy
   ```

---

## STEP 7 — Add GitHub Secrets

Go to: https://github.com/FairValueAuto-app/fairvalueauto-mobile/settings/secrets/actions

Add these secrets (click "New repository secret" for each):

| Secret Name | Value |
|-------------|-------|
| `BUILD_CERTIFICATE_BASE64` | Base64 of your .p12 certificate |
| `P12_PASSWORD` | Password you set for the .p12 |
| `BUILD_PROVISION_PROFILE_BASE64` | Base64 of your .mobileprovision |
| `KEYCHAIN_PASSWORD` | Any random password (e.g. `FVAuto2024!`) |
| `APP_STORE_CONNECT_API_KEY_ID` | Your Key ID from Step 2 |
| `APP_STORE_CONNECT_API_ISSUER_ID` | Your Issuer ID from Step 2 |
| `APP_STORE_CONNECT_API_KEY_CONTENT` | Contents of your .p8 file |
| `APPLE_ID` | Your Apple ID email |

---

## STEP 8 — Upload App Icon

Your app icon must be exactly **1024x1024 pixels, PNG, no alpha channel, no rounded corners**.

Create it at: https://www.canva.com (free)
- Use the FairValueAuto car logo
- Dark navy background (#0F172A)
- White/blue car icon centered
- Export as PNG at 1024x1024

Place it in: `fastlane/screenshots/en-US/` folder

---

## STEP 9 — Take Screenshots

Apple requires screenshots for:
- iPhone 6.9" (iPhone 15 Pro Max): **1320 x 2868 pixels**
- iPhone 6.7" (iPhone 14 Plus): **1290 x 2796 pixels**

Easiest way on Windows:
1. Open: https://velox-satisfied-deal-flow.base44.app on your phone
2. Screenshot each key page (home, deal score, VIN decoder, finance calc)
3. Upload to the App Store listing manually at appstoreconnect.apple.com

---

## STEP 10 — Trigger the Build

Once all secrets are added, run:
```
git commit --allow-empty -m "Trigger iOS build" && git push
```

GitHub Actions will automatically:
1. Boot a macOS server in Apple's cloud
2. Install Xcode and dependencies
3. Build your iOS app
4. Sign it with your certificate
5. Upload directly to App Store Connect

Then go to App Store Connect and submit for review!

---

## Apple Review Timeline
- First submission: 1-3 days
- Common rejection reasons (all fixable):
  - Missing privacy policy URL ✅ (already set)
  - App crashes on launch ✅ (pre-tested)
  - Metadata doesn't match app ✅ (already written)
