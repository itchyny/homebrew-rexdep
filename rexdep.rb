class Rexdep < Formula
  homepage 'https://github.com/itchyny/rexdep'
  version '0.0.1'

  if Hardware.is_64_bit?
    url 'https://github.com/itchyny/rexdep/releases/download/v0.0.1/rexdep_darwin_amd64.zip'
    sha256 '8759fbd18cd6f2afa313d9b8ce6e9cdb26ec1cff349e77dbd83337f66bd35efa'
  else
    url 'https://github.com/itchyny/rexdep/releases/download/v0.0.1/rexdep_darwin_386.zip'
    sha256 '93323c6cc4035cf4dc46db7d693946eaefcc81cb5c67c32760a367340f8a4df6'
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
