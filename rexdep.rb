class Rexdep < Formula
  homepage 'https://github.com/itchyny/rexdep'
  version '0.0.6'

  if Hardware::CPU.is_64_bit?
    url 'https://github.com/itchyny/rexdep/releases/download/v0.0.6/rexdep_darwin_amd64.zip'
    sha256 '72f0473bcb842f56a8022f4340b29050036abe4a66f9f9cf31274cc8889ffeba'
  else
    url 'https://github.com/itchyny/rexdep/releases/download/v0.0.6/rexdep_darwin_386.zip'
    sha256 '49da7f22f3caafd194347c12d355b7608c622f81af45ff09bc4d5cae22f9543f'
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
