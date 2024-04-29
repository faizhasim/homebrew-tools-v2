module GantryFormulaGenerator
  Config = {
    :desc => 'CLI for Gantry - SEEK\'s tool for managing containerised workloads on AWS.',
    :homepage => 'https://backstage.myseek.xyz/docs/default/Component/gantry',
    :sourceCode => 'git@github.com:SEEK-Jobs/gantry.git',
  }
  
  def self.generate_formula(name, version, git_commit)
    Class.new(Formula) do
      desc Config[:desc]

      homepage Config[:homepage]

      url Config[:sourceCode],
          using:    :git,
          tag:      version,
          revision: git_commit

      head Config[:sourceCode],
           using:  :git,
           branch: "master"

      depends_on "go" => :build

      define_method(:install) do
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

      define_method(:caveats) do
        <<~EOS
          ⚠ Early testing period. Please report any issues at #gantry slack channel. ⚠  
            
            Documentation: #{Config[:homepage]}
            
        EOS
      end

      define_method(:name) { name }
    end
  end
end
