class Rexdep < Formula
  homepage 'https://github.com/itchyny/rexdep'
  version '0.0.0'

  if Hardware.is_64_bit?
    url 'https://github.com/itchyny/rexdep/releases/download/v0.0.0/rexdep_darwin_amd64.zip'
    sha256 'af191da1d8f42b6149df43e5eeba37656dd251d754af1ab9eb85272c5b1597da'
  else
    url 'https://github.com/itchyny/rexdep/releases/download/v0.0.0/rexdep_darwin_386.zip'
    sha256 '92d70237de72c06c171131e32af624bf0cc75620485426045f153b9f847139b5'
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
