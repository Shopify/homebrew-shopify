# This was copied from  https://github.com/Homebrew/homebrew-core/blob/431e7b2fd379b3a604dd8a1964603ef022d9761d/Formula/libgraphqlparser.rb
# As our gem version is outdated and doesn't support 0.5.0 yet
class ShopifyLibgraphqlparser < Formula
  desc "GraphQL query parser in C++ with C and C++ APIs"
  homepage "https://github.com/graphql/libgraphqlparser"
  url "https://github.com/graphql/libgraphqlparser/archive/v0.4.1.tar.gz"
  sha256 "2ed66fd38b6e8a4a39c646fe713b5893d3d6b076dcd34be28a356cb3cb879595"

  bottle do
    sha256 cellar: :any, el_capitan: "52afe0dcec93ec9b886c3d7ecacf64c81f3887e299d3238aff7b4fd295a24329"
    sha256 cellar: :any, yosemite: "4fed85aba87c4cb54168cb1e8c73d6e7d4eee9689b09f18c07137ffdfb850ac3"
    sha256 cellar: :any, mavericks: "1dfc83c494e8ceef8eb5d757190312d13ecafeb1b88464c44073417989bf5488"
  end

  bottle do
    root_url "http://burkelibbey.s3.amazonaws.com"
    cellar :any
    rebuild 1
    sha256 "6b9f8ed85728208f184cd5a2fd218a768d6e7052200d21f3504593e05b1fc3ca" => :sierra
  end

  bottle do
    cellar :any
    rebuild 2
    root_url "https://github.com/Shopify/homebrew-shopify/releases/download/bag-of-holding"
    sha256 "1b8878441192cc22b9dc03dd4071346c970bcdc7d0af7068cdf7d6138bc65f42" => :catalina
  end

  conflicts_with "libgraphqlparser", :because => "shopify-libgraphqlparser is different"

  depends_on "cmake" => :build

  def install
    system "cmake", ".", *std_cmake_args
    system "make"
    system "make", "install"
    libexec.install "dump_json_ast"
  end

  test do
    require "utils/json"

    sample_query = <<~EOS
      { user }
    EOS

    sample_ast = { "kind"=>"Document",
                   "loc"=>{ "start"=>1, "end"=>9 },
                   "definitions"=>
        [{ "kind"=>"OperationDefinition",
           "loc"=>{ "start"=>1, "end"=>9 },
           "operation"=>"query",
           "name"=>nil,
           "variableDefinitions"=>nil,
           "directives"=>nil,
           "selectionSet"=>
           { "kind"=>"SelectionSet",
             "loc"=>{ "start"=>1, "end"=>9 },
             "selections"=>
             [{ "kind"=>"Field",
                "loc"=>{ "start"=>3, "end"=>7 },
                "alias"=>nil,
                "name"=>
                { "kind"=>"Name", "loc"=>{ "start"=>3, "end"=>7 }, "value"=>"user" },
                "arguments"=>nil,
                "directives"=>nil,
                "selectionSet"=>nil }] } }] }

    test_ast = Utils::JSON.load pipe_output("#{libexec}/dump_json_ast", sample_query)
    assert_equal sample_ast, test_ast
  end
end
