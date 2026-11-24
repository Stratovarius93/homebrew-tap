class Gitree < Formula
  desc "GitKraken-style commit graph for the terminal, built on lazygit's graph renderer"
  homepage "https://github.com/Stratovarius93/gitree"
  url "https://github.com/Stratovarius93/gitree/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "d24ac55cc64443c3d3b7b2b8fc6771696af0b131dca63f509df63991aeab8033"
  license "MIT"
  head "https://github.com/Stratovarius93/gitree.git", branch: "main"

  depends_on "go" => :build
  depends_on "git"

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w -X main.version=v#{version}")
  end

  def caveats
    <<~EOS
      Optional tools gitree uses when available:
        brew install git-delta   # colored diffs
        brew install lazygit     # the L key
        brew install gh          # pull request status
      A Nerd Font is recommended for the branch and PR icons.
    EOS
  end

  test do
    assert_match "gitree v#{version}", shell_output("#{bin}/gitree --version")
    assert_match "not a git repository", shell_output("#{bin}/gitree #{testpath} 2>&1", 1)
  end
end
