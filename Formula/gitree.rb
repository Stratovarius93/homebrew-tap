class Gitree < Formula
  desc "GitKraken-style commit graph for the terminal, built on lazygit's graph renderer"
  homepage "https://github.com/Stratovarius93/gitree"
  url "https://github.com/Stratovarius93/gitree/archive/refs/tags/v0.4.0.tar.gz"
  sha256 "a30a84088dcdd412114182681a6cb69c85570265253a3cacb7d3b593f8d17695"
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
