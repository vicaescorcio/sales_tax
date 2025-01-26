# frozen_string_literal: true

require_relative "taxer"

class Purchase
  attr_reader :products, :created_at, :updted_at

  def initialize(*products)
    @products = products
  end

  def add_product(product)
    @products << product
  end

  def remove_product(product)
    @products.delete(product)
  end

  def total_taxes
    Taxer.total_taxes(self)
  end

  def total
    Taxer.tax_purchase(self)
  end

  def to_s
    lines = products.map do |product|
      product.to_tax_string
    end

    lines << "Sales Taxes: #{'%.2f' % total_taxes}"
    lines << "Total: #{'%.2f' % total}"

    lines.join("\n")
  end
end
