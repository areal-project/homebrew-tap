class Areal < Formula
  desc "Agent harness with a terminal UI and local tool runtime"
  homepage "https://github.com/areal-project/AReaL-Harness"
  version "0.1.7"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64
    depends_on macos: :sequoia
    depends_on xcode: :clt
    url "https://github.com/areal-project/AReaL-Harness/releases/download/v0.1.7/areal-harness-v0.1.7-aarch64-apple-darwin.tar.gz"
    sha256 "dacf244929ef92773e2c4f5d45df2ea9eeed28f303f82c196b0a72c54ae49df7"
  end
  on_linux do
    depends_on arch: :x86_64
    url "https://github.com/areal-project/AReaL-Harness/releases/download/v0.1.7/areal-harness-v0.1.7-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "9174426016708f7b861aefee375da251171764b6ff1332b0c5b1de92edbd60cd"
  end

  def install
    if OS.linux?
      glibc = Utils.safe_popen_read("/usr/bin/getconf", "GNU_LIBC_VERSION").split.last
      odie "AReaL requires host glibc >= 2.35" if Version.new(glibc) < Version.new("2.35")
      odie "Install system bubblewrap at /usr/bin/bwrap" unless File.executable?("/usr/bin/bwrap")
    end
    prefix.install "bin", "libexec", "manifest.json", "LICENSE"
  end

  def caveats
    <<~EOS
      Configure your model in ~/.areal/config.toml before starting a task.
      Homebrew may remove old kegs: finish tasks and stop shared services before upgrading.
      Use areal service list to inspect services; upgrade never stops them automatically.
      macOS binaries are ad-hoc signed, without Developer ID signing or Apple notarization.
      Python 3.9+ is required for standalone installation and upgrades.
    EOS
  end

  test do
    assert_equal "areal 0.1.7", shell_output("#{bin}/areal --version").strip
    assert_path_exists prefix/"libexec/areal/areal-runtime"
    assert_path_exists prefix/"libexec/areal/areal-runtime-fs"
    assert_path_exists prefix/"libexec/areal/areal-runtime-reaper" if OS.linux?
  end
end
