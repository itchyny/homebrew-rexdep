class Rexdep < Formula
  homepage 'https://github.com/itchyny/rexdep'
  version '0.0.8'

  if Hardware::CPU.is_64_bit?
    url 'https://github.com/itchyny/rexdep/releases/download/v0.0.8/rexdep_darwin_amd64.zip'
    sha256 'd7b9c81a943fd1a20c0b1bcfc55e15bf479aa13fdd99aa489503874ff16b8d8a'
  else
    url 'https://github.com/itchyny/rexdep/releases/download/v0.0.8/rexdep_darwin_386.zip'
    sha256 '8f202ecaa70364a2ce027d26c6f6c1bb5e00a619efa55f06ae16a7837307d7b9'
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
