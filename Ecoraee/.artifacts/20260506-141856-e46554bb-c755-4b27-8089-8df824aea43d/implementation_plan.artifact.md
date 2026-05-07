# Fix Development Environment Issues

Guided steps to resolve the errors shown in `flutter doctor`.

## Proposed Changes

### Android Toolchain Fixes

1.  **Install Command-line Tools**:
    - Open Android Studio.
    - Go to **Settings** (or **Settings > Languages & Frameworks > Android SDK**).
    - Select the **SDK Tools** tab.
    - Check **Android SDK Command-line Tools (latest)**.
    - Click **Apply** to install.

2.  **Accept Licenses**:
    - Run `flutter doctor --android-licenses` in the terminal and accept all prompts.

### Windows Development Fixes (Optional)

1.  **Install Visual Studio**:
    - Download and install Visual Studio Community.
    - Select **Desktop development with C++**.

### Web Development Fixes (Optional)

1.  **Install/Configure Chrome**:
    - Ensure Chrome is installed or set the `CHROME_EXECUTABLE` environment variable.

## Verification Plan

### Manual Verification
- Run `flutter doctor` again and ensure the "Android toolchain" section has a green checkmark.
- Try running the app on a connected device or emulator.
