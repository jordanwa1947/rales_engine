require 'csv'

namespace :import do

  desc "Import merchants from csv"
  task files: :environment do
    merchant_csv = File.join Rails.root, "data/merchants.csv"
    CSV.foreach(merchant_csv, headers: true) do |row|
      Merchant.create(name: row["name"], created_at: row["created_at"], updated_at: row["updated_at"])
    end

    customer_csv = File.join Rails.root, "data/customers.csv"
    CSV.foreach(customer_csv, headers: true) do |row|
      Customer.create(first_name: row["first_name"], last_name: row["last_name"], created_at: row["created_at"], updated_at: row["updated_at"])
    end
  end
end
