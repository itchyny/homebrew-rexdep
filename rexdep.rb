class Rexdep < Formula
  homepage 'https://github.com/itchyny/rexdep'
  version '0.0.9'

  if Hardware::CPU.is_64_bit?
    url 'https://github.com/itchyny/rexdep/releases/download/v0.0.9/rexdep_darwin_amd64.zip'
    sha256 '2ffa3003010a45e97dc0fe2cb0bbc38b6121ff43adb1c590bc072cdffd9a14a9'
  else
    url 'https://github.com/itchyny/rexdep/releases/download/v0.0.9/rexdep_darwin_386.zip'
    sha256 '35b762ab595924ad9f3b97df4e51d4aa046ce1f9e030311bdc376659feb6c1b9'
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
