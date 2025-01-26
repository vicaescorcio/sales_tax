require_relative "./product"
require_relative "./purchase"

module PurchaseFileManager
  def self.to_purchase(input_file)
    products = []
    File.open(input_file, "r") do |file|
      file.each_line do |line|
        products << Product.initialize_from_string(line)
      end
    end

    Purchase.new(*products)
  end

  def self.to_file(purchase, output_path)
    file = File.new(output_path, "w+")
    file.puts(purchase.to_s)
    file.close
  end
end
