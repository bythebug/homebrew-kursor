class Kursor < Formula
  desc "Global hotkey LLM text inserter for macOS"
  homepage "https://github.com/bythebug/kursor"
  url "https://github.com/bythebug/kursor/archive/refs/tags/v1.1.0.tar.gz"
  sha256 "0e71704e3516d9b7995cd6dc27ba0c21bb06b33ba7ae542716cdd0af5b65d629"
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
