# frozen_string_literal: true

require_relative "../lib/tax_sale"
require "tempfile"
require "pry"

describe TaxSale do
  describe "#run" do
    subject do
      TaxSale.new(arguments).run
    end
    let(:arguments) { [input_file.path, output_file.path] }
    let(:input_file_name) { "purchases.txt" }
    let(:output_file_name) { "taxed_purchases.txt" }

    let(:input_file) do
      Tempfile.new(input_file_name).tap do |file|
        file.write(purchase_entries)
        file.close
      end
    end
    let(:output_file) do
      Tempfile.new(output_file_name)
    end

    after do
      input_file.unlink
      output_file.unlink
    end

    context "case #1" do
      let(:purchase_entries) do
        <<~HERE
          2 book at 12.49
          1 music CD at 14.99
          1 chocolate bar at 0.85
        HERE
      end

      let(:taxed_purchase_output) do
        <<~HERE
          2 book: 24.98
          1 music CD: 16.49
          1 chocolate bar: 0.85
          Sales Taxes: 1.50
          Total: 42.32
        HERE
      end

      it "prints the right balance" do
        subject
        expect(output_file.read).to eq(
          taxed_purchase_output
        )
      end
    end

    context "case #2" do
      let(:purchase_entries) do
        <<~HERE
          1 imported box of chocolates at 10.00
          1 imported bottle of perfume at 47.50
        HERE
      end

      let(:taxed_purchase_output) do
        <<~HERE
          1 imported box of chocolates: 10.50
          1 imported bottle of perfume: 54.65
          Sales Taxes: 7.65
          Total: 65.15
        HERE
      end

      it "prints the right balance" do
        subject
        expect(output_file.read).to eq(
          taxed_purchase_output
        )
      end
    end

    context "case #3" do
      let(:purchase_entries) do
        <<~HERE
          1 imported bottle of perfume at 27.99
          1 bottle of perfume at 18.99
          1 packet of headache pills at 9.75
          3 imported boxes of chocolates at 11.25
        HERE
      end

      let(:taxed_purchase_output) do
        <<~HERE
          1 imported bottle of perfume: 32.19
          1 bottle of perfume: 20.89
          1 packet of headache pills: 9.75
          3 imported boxes of chocolates: 35.55
          Sales Taxes: 7.90
          Total: 98.38
        HERE
      end
      it "prints the right balance" do
        subject
        expect(output_file.read).to eq(
          taxed_purchase_output
        )
      end
    end
  end
end
