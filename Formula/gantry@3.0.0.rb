class GantryAT300 < Formula
  desc "CLI for Gantry CLI"
  homepage "https://github.com/SEEK-Jobs/gantry"
  url "git@github.com:SEEK-Jobs/gantry.git",
      using:    :git,
      tag:      "v3.0.0",
      revision: "6ea21d44a78a17341e426e12511c167d9a63dc10"
  head "git@github.com:SEEK-Jobs/gantry.git",
       using:  :git,
       branch: "master"

  depends_on "go" => :build

  def install
    arch = if Hardware::CPU.arm?
             "arm64"
           else
             "amd64"
           end

    os = if OS.mac?
           "darwin"
         else
           "linux"
         end

    system "make", "generate", "#{os}/#{arch}/gantry"
    bin.install "bin/release/#{os}/#{arch}/gantry"
  end

  def caveats
    <<~EOS
      Early testing period. Please report any issues at #gantry slack channel.
    EOS
  end

  test do
    assert_match("gantry version v3.0.0", shell_output("#{bin}/gantry --version"))
  end
end