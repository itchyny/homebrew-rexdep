class Rexdep < Formula
  homepage 'https://github.com/itchyny/rexdep'
  version '0.0.3'

  if Hardware.is_64_bit?
    url 'https://github.com/itchyny/rexdep/releases/download/v0.0.3/rexdep_darwin_amd64.zip'
    sha256 '7928c576e50b80851d967799d8ce939610fd5916486df3eb00ecf0060af52abb'
  else
    url 'https://github.com/itchyny/rexdep/releases/download/v0.0.3/rexdep_darwin_386.zip'
    sha256 'ed062c0f5d129d4b7a873ba90bd8e3a72f904817e4ab2a40bb99fc643c66f78d'
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
