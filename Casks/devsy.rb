cask "devsy" do
  arch arm: "arm64", intel: "x64"

  version "1.27.1"
  sha256 arm:          "fce2b1ffa4d5da51cd6c1ab8e2581aad2c90d2568a9791cdcacbb1bd486c441d",
         intel:        "06d98dcf24ead67babe37b1ba0542ef44d0e9cf874491a16e9361c5cfdc091fc",
         x86_64_linux: "7551a25837bc62608fad8d83c1bf6301b81ed8e67619364697a0072c51fa55f2"

  on_macos do
    url "https://github.com/devsy-org/devsy/releases/download/v#{version}/Devsy_mac_#{arch}.dmg"

    app "Devsy.app"

    zap trash: [
      "~/.devsy",
      "~/Library/Application Support/Devsy",
      "~/Library/Caches/sh.devsy.app*",
      "~/Library/Logs/Devsy",
      "~/Library/Preferences/sh.devsy.app.plist",
      "~/Library/Saved Application State/sh.devsy.app.savedState",
    ]
  end
  on_linux do
    url "https://github.com/devsy-org/devsy/releases/download/v#{version}/Devsy_linux_x86_64.AppImage"

    # The release has no arm64 AppImage.
    depends_on arch: :x86_64

    app_image "Devsy_linux_x86_64.AppImage", target: "Devsy.AppImage"

    zap trash: [
      "~/.config/Devsy",
      "~/.devsy",
    ]
  end

  name "Devsy"
  desc "Secure local and cloud development environments"
  homepage "https://devsy.sh/"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true
end
