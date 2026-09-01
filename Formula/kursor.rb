class Kursor < Formula
  desc "Global hotkey LLM text inserter for macOS"
  homepage "https://github.com/bythebug/kursor"
  url "https://github.com/bythebug/kursor/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "9128c50067081b6df3d20f6f4528daf52d1a14a7063ec0b39be9a26b36653a10"
  license "MIT"

  depends_on :macos

  def install
    system "swiftc", "kursor-main.swift", "-o", "kursor-main",
           "-framework", "Cocoa", "-framework", "Security"
    bin.install "kursor-main" => "kursor"
  end

  def caveats
    <<~EOS
      kursor requires skhd for global hotkey support:
        brew install koekeishiya/formulae/skhd

      Add your Groq API key (free at https://console.groq.com):
        security add-generic-password -U -s "com.kursor.app" -a "api_key" -w "YOUR_KEY"

      Add to ~/.config/skhd/skhdrc:
        alt - space : "#{HOMEBREW_PREFIX}/bin/kursor"

      Start skhd:
        skhd --start-service

      Grant skhd Accessibility in:
        System Settings → Privacy & Security → Accessibility
    EOS
  end

  test do
    assert_predicate bin/"kursor", :exist?
  end
end
