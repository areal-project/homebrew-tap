class Areal < Formula
  desc "Agent harness with a terminal UI and local tool runtime"
  homepage "https://github.com/areal-project/AReaL-Harness"
  version "0.1.19"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64
    depends_on macos: :sequoia
    depends_on xcode: :clt
    url "https://github.com/areal-project/AReaL-Harness/releases/download/v0.1.19/areal-harness-v0.1.19-aarch64-apple-darwin.tar.gz"
    sha256 "66ecd08d858635793d3d6fbb747eec3b6d4ae4fa413ffd9dae3051c7278c3050"
  end
  on_linux do
    depends_on arch: :x86_64
    url "https://github.com/areal-project/AReaL-Harness/releases/download/v0.1.19/areal-harness-v0.1.19-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "57067044abb8ad707e60503ab3171538d4d9d44cf32ff90791b2b8149247301e"
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
    assert_equal "areal 0.1.19", shell_output("#{bin}/areal --version").strip
    assert_path_exists prefix/"libexec/areal/areal-runtime"
    assert_path_exists prefix/"libexec/areal/areal-runtime-fs"
    assert_path_exists prefix/"libexec/areal/areal-runtime-reaper" if OS.linux?
  end
end
