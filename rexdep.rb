class Rexdep < Formula
  homepage 'https://github.com/itchyny/rexdep'
  version '0.1.0'

  if Hardware::CPU.is_64_bit?
    url 'https://github.com/itchyny/rexdep/releases/download/v0.1.0/rexdep_darwin_amd64.zip'
    sha256 'b32a10c655999a74860a0b36a62185958e351dff2d132f8c9f2ca67b5a207b45'
  else
    url 'https://github.com/itchyny/rexdep/releases/download/v0.1.0/rexdep_darwin_386.zip'
    sha256 'dc379578161a21b40e702d2d2f22e43a3a55973716bbc6727df9ba11efba23a2'
  end

  head do
    url 'https://github.com/itchyny/rexdep.git'
    depends_on 'go' => :build
    depends_on 'git' => :build
    depends_on 'mercurial' => :build
  end

  def install
    if build.head?
      ENV['GOPATH'] = buildpath/'.go'
      mkdir_p buildpath/'.go/src/github.com/itchyny'
      ln_s buildpath, buildpath/'.go/src/github.com/itchyny/rexdep'
      system 'make', 'build'
      bin.install 'build/rexdep'
    else
      bin.install 'rexdep'
    end
  end

  test do
    system 'rexdep', '--version'
  end
end
