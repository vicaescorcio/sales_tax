module Taxer
  TAX_AMOUNT = 0.10
  TAX_OVER_IMPORTED = 0.05

  NOT_TAXABLE_PRODUCTS_REGEX = /(?:book|chocolates?|headache pills|medicine|chocolate bar)/i

  def self.product_taxes(product)
    price = product.shelf_price.to_f

    tax = 0.00

    tax = (price * Taxer::TAX_AMOUNT) unless not_taxable?(product)

    tax += (price * Taxer::TAX_OVER_IMPORTED) if product.origin == "imported"

    product.quantity.to_i * ((tax * 20).ceil / 20.0) # had to this to avoid losing per product unity rouding
  end

  def self.tax_product(product)
    product.order_price + product_taxes(product)
  end

  def self.tax_purchase(purchase)
    purchase.products.reduce(0) do |total, product|
      total += tax_product(product)
      total
    end
  end

  def self.total_taxes(purchase)
    purchase.products.reduce(0) do |total, product|
      total += product_taxes(product)
      total
    end
  end

  def self.not_taxable?(product)
    !product.description.match(NOT_TAXABLE_PRODUCTS_REGEX).nil?
  end
end
