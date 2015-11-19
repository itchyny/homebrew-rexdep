class Rexdep < Formula
  homepage 'https://github.com/itchyny/rexdep'
  version '0.0.2'

  if Hardware.is_64_bit?
    url 'https://github.com/itchyny/rexdep/releases/download/v0.0.2/rexdep_darwin_amd64.zip'
    sha256 '506cdfdf831bac909f04e1d4ee149d48ed4d23aa1de2799b949d4783d9359abf'
  else
    url 'https://github.com/itchyny/rexdep/releases/download/v0.0.2/rexdep_darwin_386.zip'
    sha256 '66faeb12e6a01d5ce4cf9bfd2cdda67f606180d5167971ee28230d6e899ef796'
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
