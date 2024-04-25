class GantryAT310 < Formula
  desc "CLI for Gantry CLI"
  homepage "https://github.com/SEEK-Jobs/gantry"
  url "git@github.com:SEEK-Jobs/gantry.git",
      using:    :git,
      tag:      "v3.1.0",
      revision: "34117fdc98f87a788975c14fe5f0f0d9c993c9f2"
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
    return if OS.linux?
    "not well tested on linux, please report any issues at #gantry slack channel"
  end

  test do
    assert_match("gantry version v3.1.0", shell_output("#{bin}/gantry --version"))
  end
end