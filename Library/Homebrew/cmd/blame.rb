module Homebrew extend self
  def blame
    cd HOMEBREW_REPOSITORY
    if ARGV.named.empty?
      exec "git", "blame", *ARGV.options_only
    else
      exec "git", "blame", *ARGV.options_only + ARGV.formulae.map(&:path)
    end
  end
end
