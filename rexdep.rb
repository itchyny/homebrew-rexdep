class Rexdep < Formula
  homepage 'https://github.com/itchyny/rexdep'
  version '0.0.4'

  if Hardware.is_64_bit?
    url 'https://github.com/itchyny/rexdep/releases/download/v0.0.4/rexdep_darwin_amd64.zip'
    sha256 'c650379ed30a751784c47c982cb3dea156164da06c4f1ab886341aace158840d'
  else
    url 'https://github.com/itchyny/rexdep/releases/download/v0.0.4/rexdep_darwin_386.zip'
    sha256 '5e2f663fc341d6f4044001b82ed579539d07bd747a6175bcff2353d13fb2aad7'
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
