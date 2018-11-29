require 'csv'

namespace :import do

  desc "Import from csvs"
  task files: :environment do


    merchant_csv = File.join Rails.root, "data/merchants.csv"
    CSV.foreach(merchant_csv, headers: true) do |row|
      Merchant.create(id: row["id"],
                      name: row["name"],
                      created_at: row["created_at"],
                      updated_at: row["updated_at"])
    end

    customer_csv = File.join Rails.root, "data/customers.csv"
    CSV.foreach(customer_csv, headers: true) do |row|
      Customer.create(id: row["id"],
                      first_name: row["first_name"],
                      last_name: row["last_name"],
                      created_at: row["created_at"],
                      updated_at: row["updated_at"])
    end

    items_csv = File.join Rails.root, "data/items.csv"
    CSV.foreach(items_csv, headers: true) do |row|
      Item.create(id: row["id"],
                  name: row["name"],
                  description: row["description"],
                  unit_price: row["unit_price"],
                  created_at: row["created_at"],
                  updated_at: row["updated_at"])
    end


    invoices_csv = File.join Rails.root, "data/invoices.csv"
    CSV.foreach(invoices_csv, headers: true) do |row|
      Invoice.create(id: row["id"],
                     status: row["status"],
                     created_at: row["created_at"],
                     updated_at: row["updated_at"],
                     merchant_id: row["merchant_id"],
                     customer_id: row["customer_id"])
    end

    transactions_csv = File.join Rails.root, "data/transactions.csv"
    CSV.foreach(transactions_csv, headers: true) do |row|
      Transaction.create(id: row["id"],
                         credit_card_number: row["credit_card_number"],
                         credit_card_expiration_date: row["credit_card_expiration_date"],
                         result: row["result"],
                         created_at: row["created_at"],
                         updated_at: row["updated_at"],
                         invoice_id: row["invoice_id"])
    end

    invoice_items_csv = File.join Rails.root, "data/invoice_items.csv"
    CSV.foreach(invoice_items_csv, headers: true) do |row|
      InvoiceItem.create(id: row["id"],
                         quantity: row["quantity"],
                         unit_price: row["unit_price"],
                         created_at: row["created_at"],
                         updated_at: row["updated_at"],
                         item_id: row["item_id"],
                         invoice_id: row["invoice_id"])
    end



  end
end
