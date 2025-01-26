#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative "./purchase_file_manager"
class TaxSale
  attr_accessor :purchase_file_path, :taxed_purchase_file_path

  def initialize(args)
    @purchase_file_path = args[0]
    @taxed_purchase_file_path = args[1] || "taxed_sale_output.txt"
  end

  def run
    @purchase = PurchaseFileManager.to_purchase(purchase_file_path)
    PurchaseFileManager.to_file(@purchase, taxed_purchase_file_path)
  end
end

# make code testable and runnable
TaxSale.new(ARGV).run if $PROGRAM_NAME == __FILE__
