#!/usr/bin/env bash
set -e

# Make sure workspace is safe for git inside container
git config --global --add safe.directory "${WORKSPACE_FOLDER:-/workspaces/$(basename "$(pwd)")}"

# Enable web and precache web artifacts
flutter config --enable-web
flutter precache --web

# Doctor (ignore Android/iOS warnings in Codespaces)
flutter doctor -v

echo "✅ Flutter web is ready. Next steps:
1) If this is a fresh repo, create the app in the repo root:
   flutter create .

2) Run the app on a web server bound to all interfaces:
   flutter run -d web-server --web-hostname 0.0.0.0 --web-port 8080

3) When the port forwards, click the URL to open the app in your browser.

4) Commit your changes to save progress to GitHub:
   git add .
   git commit -m 'Initial Flutter app'
   git push
"
