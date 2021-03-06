require 'formula'

class Putty < Formula
  homepage 'http://www.chiark.greenend.org.uk/~sgtatham/putty/'
  url 'http://the.earth.li/~sgtatham/putty/0.61/putty-0.61.tar.gz'
  md5 'db0e37f6b82ea62f0ace87927d29b2a4'

  def install
    # use the unix build to make all PuTTY command line tools
    cd "unix" do
      # disable GTK upon configure
      system "./configure", "--prefix=#{prefix}",
                            "--disable-gtktest",
                            "--with-gtk-prefix=/dev/null"
      system "make VER=-DRELEASE=#{version} all-cli"
      # install manually
      bin.install %w{ plink pscp psftp puttygen }
    end
    cd "doc" do
      man1.install %w{ plink.1 pscp.1 psftp.1 puttygen.1 }
    end
  end

  def caveats
    "This formula did not build the Mac OS X GUI PuTTY.app."
  end
end
