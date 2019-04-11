class Usd < Formula
  desc "Universal Scene Description"
  homepage "http://www.openusd.org"
  url "https://github.com/PixarAnimationStudios/USD/archive/v19.03.tar.gz"
  sha256 "86a3bd3875e7b0b27de2e120fa8149e398d9adb081771db8d28a3799fff35bbe"
  depends_on "cmake" => :build
  depends_on "gcc" => :build
  depends_on "doxygen"
  depends_on "graphviz"
  depends_on "python@2"
  depends_on "tbb"

  def install
    out_dir = "#{prefix}/USDPython"

    system "python build_scripts/build_usd.py --build-args TBB,extra_inc=big_iron.inc --python --no-imaging --docs --no-usdview --build-monolithic #{out_dir}"

    bin.install Dir["#{out_dir}/bin/*"]
    lib.install Dir["#{out_dir}/lib/usd"], Dir["#{out_dir}/lib/python"], "#{out_dir}/lib/libusd_ms.dylib"
    include.install Dir["#{out_dir}/include/pxr"]
    doc.install Dir["#{out_dir}/docs"]
  end

  test do
    test_filename = "test_usd.py"
    (testpath/test_filename).write <<-EOS
import sys
sys.path.append("#{lib}/python")

from pxr import Usd
    EOS
    system "python #{test_filename}"
  end
end

