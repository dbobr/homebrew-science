class Phyml < Formula
  desc "Fast maximum likelihood-based phylogenetic inference"

  bottle do
    cellar :any_skip_relocation
    sha256 "fcb726e611ecca738807f1263a942c413bda01eed6f340b17c3a206c9c72d737" => :yosemite
  end

  # tag "bioinformatics"
  # doi "10.1093/sysbio/syq010"
  homepage "http://www.atgc-montpellier.fr/phyml/"
  url "https://github.com/stephaneguindon/phyml/archive/v3.2.0.tar.gz"
  sha256 "9fec8fc26e69cad8d58bf2c9433b531754e4f026dc3464d07958b6c824783fde"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build

  def install
    chmod 0755, 'autogen.sh'
    system "./autogen.sh"

    # separate steps required
    system "./configure", "--prefix=#{prefix}"
    system "make"

    bin.install "src/phyml"
    doc.install "doc/phyml-manual.pdf"
    pkgshare.install Dir["examples/*"]
  end

  def caveats; <<-EOS.undent
    Examples have been installed here:
      #{opt_pkgshare}

    See options for phyml by running:
      phmyl --help

    PhyML must be run with the "-i" option to specify an input or it will
    segfault. Example:
      phyml -i #{opt_pkgshare}/nucleic
    EOS
  end
end
