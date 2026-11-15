cask "devsy" do
  arch arm: "arm64", intel: "x64"

  version "1.27.0"
  sha256 arm:          "bd974a105a13efff72f1379d2f665b24eb69cf7b61b76ba2eff67f6b2340e751",
         intel:        "75b62df5298f22879fb8090d5dd6ad8fdfe11bbd41d4a802c9fe6f34d2ced9ca",
         x86_64_linux: "60f96959fc749504c84858caa060248c91be88536eb5fe68b64be6d42c094668"

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
