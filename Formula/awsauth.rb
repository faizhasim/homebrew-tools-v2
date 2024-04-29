class Awsauth < Formula
  desc "AWS SAML authorization & assume role utility designed for usage under Linux/OSX with Bash."
  homepage "https://github.com/SEEK-Jobs/aws-auth-bash"
  url "git@github.com:SEEK-Jobs/aws-auth-bash.git",
      using:  :git,
      branch: "master"
  head "git@github.com:SEEK-Jobs/aws-auth-bash.git",
       using:  :git,
       branch: "master"

  version "vCurrent"
  version_scheme 1

  # depends_on 'awscli' # https://forums.developer.apple.com/forums/thread/744998
  depends_on 'curl'
  depends_on 'jq'
  depends_on 'libu2f-host' => :optional

  def install
    bin.install 'auth.sh'
  end

  def caveats
    <<~EOS
      UNOFFICIAL SUPPORT: Use at your own risk!
      
      1.  Ensure you have the AWS CLI installed and configured accordingly.
          Refer to https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html for more information.
      

      2.  To activate awsauth, add the following to your ~/.zshrc for Mac OS X 10.15 (Catalina) and above,
          or ~/.bashrc for older versions of Mac OS X and most Linux distributions.

            function awsauth { #{prefix}/bin/auth.sh "$@"; [[ -r "$HOME/.aws/sessiontoken" ]] && . "$HOME/.aws/sessiontoken"; }
        
            # not needed in ~/.zshrc - leads to function being printed in terminal every time
            export -f awsauth

          You will also need to restart your terminal for this change to take effect.
      
      3.  Verify by calling:
        
            awsauth --help
      
    EOS
  end

  test do
    assert_match("aws-auth-bash", shell_output("#{bin}/auth.sh -v"))
  end
end
