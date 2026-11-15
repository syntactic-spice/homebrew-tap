cask "logseq-og" do
  arch arm: "arm64", intel: "x64"
  os macos: "darwin", linux: "linux"

  version "1.0.0"
  sha256 arm:          "82af43917c0aa0ce2e12949f741c527b8eaf71522223981317751c51487d7797",
         intel:        "f1480c81a0ef12efc5de1b46d59ed2adb5b17b4c32061bab29779b1e84b9c1e5",
         x86_64_linux: "a6bf51a79c523a4572d5c21cbfa133bb764ec99081cb56db82616daa30ff94d1"

  on_macos do
    url "https://github.com/logseq/og/releases/download/#{version}/Logseq-OG-#{os}-#{arch}-#{version}.dmg"

    app "Logseq-OG.app"

    # ~/.logseq (plugins, graph metadata) is shared with the regular Logseq app, so it is left alone.
    zap trash: [
      "~/Library/Application Support/Logseq OG",
      "~/Library/Preferences/com.logseq.logseq-og.plist",
      "~/Library/Saved Application State/com.logseq.logseq-og.savedState",
    ]
  end
  on_linux do
    url "https://github.com/logseq/og/releases/download/#{version}/Logseq-OG-#{os}-#{arch}-#{version}.AppImage"

    # The release has no arm64 AppImage.
    depends_on arch: :x86_64

    app_image "Logseq-OG-#{os}-#{arch}-#{version}.AppImage", target: "Logseq-OG.AppImage"

    # ~/.logseq (plugins, graph metadata) is shared with the regular Logseq app, so it is left alone.
    zap trash: "~/.config/Logseq OG"

    caveats <<~EOS
      If #{token} aborts with "The SUID sandbox helper binary was found, but is not
      configured correctly", AppArmor is blocking the user namespaces Electron needs.
      Allow them for Logseq OG with an AppArmor profile (run the following):

        sudo tee /etc/apparmor.d/logseq-og >/dev/null <<'EOF'
        abi <abi/5.0>,
        include <tunables/global>

        profile logseq-og /tmp/.mount_Logseq*/Logseq-OG flags=(unconfined) {
          userns,
          @{exec_path} mr,

          include if exists <local/logseq-og>
        }
        EOF
        sudo apparmor_parser -r /etc/apparmor.d/logseq-og
    EOS
  end

  name "Logseq OG"
  desc "Markdown version of the Logseq knowledge base"
  homepage "https://logseq.com/"

  livecheck do
    url :url
    strategy :github_latest
  end
end
