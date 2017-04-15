class Rexdep < Formula
  homepage 'https://github.com/itchyny/rexdep'
  version '0.0.7'

  if Hardware::CPU.is_64_bit?
    url 'https://github.com/itchyny/rexdep/releases/download/v0.0.7/rexdep_darwin_amd64.zip'
    sha256 'd7d8205ec8c20527cc5e77a306557b408911f908139ec358db34dd957d1ad595'
  else
    url 'https://github.com/itchyny/rexdep/releases/download/v0.0.7/rexdep_darwin_386.zip'
    sha256 'c1ba779414b1b80fbc8055b948e6abf813d37f863aba36596edcafeb51ad3b22'
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
