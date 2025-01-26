# frozen_string_literal: true

require_relative "taxer"

class Product
  MATCHING_REGEX = /^(\d+)\s(imported\s)?(.*)\sat\s(\d+\.\d+)$/

  attr_reader :description, :shelf_price, :origin, :quantity

  def initialize(shelf_price:, origin:, description:, quantity:)
    @shelf_price = shelf_price
    @origin = origin
    @quantity = quantity
    @description = description
  end

  def self.initialize_from_string(text)
    match = text.match(MATCHING_REGEX)
    quantity = match[1]
    origin = match[2] ? "imported" : "local"
    description = "#{match[2] ? 'imported ' : ''}#{match[3].strip}"
    shelf_price = match[4]

    Product.new(quantity: quantity, origin: origin, description: description,
                shelf_price: shelf_price)
  end

  def order_price
    shelf_price.to_f * quantity.to_i
  end

  def total_with_taxes
    Taxer.tax_product(self)
  end

  def to_tax_string
    "#{quantity} #{description}: #{'%.2f' % total_with_taxes}"
  end
end
