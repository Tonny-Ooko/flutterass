# flutterass
# Flutter User Management App 
A modern Flutter application for managing user data, built with Provider for state management and REST API integration. 
The app allows users to browse, edit, and update user details seamlessly with a clean and interactive UI.

# Screenshots (Add screenshots here)
 User List Screen – Displays a list of users fetched from the API.
 Edit User Screen – Allows modifying user details with a modern form.
 Update Confirmation – Provides feedback upon successful updates.
 Error Handling – Displays clear messages when an update fails.
# 🛠 Features
📜 User Listing – Fetches and displays users from an API.
✏️ Edit User Details – Update name, email, phone, address, etc.
💾 State Management – Uses Provider to manage app state.
⚡ Optimized Performance – Loads users only when needed.
🚀 Modern UI – Responsive and appealing design with Material UI.
🔄 Error Handling – Displays popups for failed API calls.

# User Interface (How It Works)
1️⃣ Home Screen (User List)
Fetches and displays users.
Click on any user to edit their details.
2️⃣ Edit User Screen
Pre-filled form with user details.
Modify name, email, occupation, bio, phone, and address.
Press "Update User" to save changes.
3️⃣ Success & Error Handling
If update is successful → Shows a green success message.
If update fails  → Shows an error popup with retry option.

# 📦 Installation & Setup
Clone the repository:
git clone https://github.com/Tonny-Ooko/flutterass.git
cd flutterass
Install dependencies:
flutter pub get
Run the app:
flutter run

#  📲 Building the APK
To generate the release APK, run:
flutter build apk --release
The APK will be available in:

swift
build/app/outputs/flutter-apk/app-release.apk
