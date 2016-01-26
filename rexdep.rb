class Rexdep < Formula
  homepage 'https://github.com/itchyny/rexdep'
  version '0.0.5'

  if Hardware.is_64_bit?
    url 'https://github.com/itchyny/rexdep/releases/download/v0.0.5/rexdep_darwin_amd64.zip'
    sha256 '3f0cad06e1a53bf013a82b01d61a510689f084848a63159c16bd75be40bafb8a'
  else
    url 'https://github.com/itchyny/rexdep/releases/download/v0.0.5/rexdep_darwin_386.zip'
    sha256 'dbd9a30fd69054bcdea35abccfc52d396384a36377d7d17a5a40103cf7ebcd76'
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
