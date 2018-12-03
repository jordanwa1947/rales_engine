# README

Rales Engine

Rales, (a play on words) is a Rails based API compliant with the JSON API spec through use of the fast_jsonapi gem.

Setup

Clone the Repository

$ git clone https://github.com/jordanwa1947/rales_engine

Bundle Gems

$ bundle
$ bundle update

Next,

$ rake db:{create,migrate}

Import CSV files

$ rake import:files

To see routes

$ rake routes

To run the test suite

$ rspec

Endpoints

All endpoints serialize and render a JSON response with the requested record(s). Each resource has an index and show endpoint/action for multiple and single records respectively. Also included are single finders and multi-finders for querying resources by attributes or a random action for a random resource.

Index Actions

/api/v1/merchants
/api/v1/invoices
/api/v1/items
/api/v1/invoice_items
/api/v1/customers
/api/v1/transactions

Show Actions

/api/v1/merchants/:id
/api/v1/invoices/:id
/api/v1/items/:id
/api/v1/invoice_items/:id
/api/v1/customers/:id
/api/v1/transactions/:id

Find Actions

Single Finders

Pass in query parameters associated with the the record by appending '?example_param=value' to the end.

/api/v1/merchants/find
/api/v1/invoices/find
/api/v1/items/find
/api/v1/invoice_items/find
/api/v1/customers/find
/api/v1/transactions/find

Example: GET /api/v1/merchants/find?name=Schroeder-Jerde

Multi-Finders

Multi-finders work much the same as the single finders.
Note that the single record is still in an array.

/api/v1/merchants/find_all
/api/v1/invoices/find_all
/api/v1/items/find_all
/api/v1/invoice_items/find_all
/api/v1/customers/find_all
/api/v1/transactions/find_all

Example: GET /api/v1/merchants/find_all?name=Schroeder-Jerde

Random

To get a random record, visit these endpoints

api/v1/merchants/random

Coming Soon:
api/v1/invoices/random
api/v1/items/random
api/v1/invoice_items/random
api/v1/customers/random
api/v1/transactions/random

Relationship Endpoints

Relationship Endpoints allow you to request associated records. For instance, a Merchant has many associated invoices, items, customers, and invoice_items that can be requested through Rales Engine with relationship endpoints.

Merchants
returns a collection of items associated with that merchant.

GET /api/v1/merchants/:id/items

Invoices
returns a collection of invoices associated with that merchant from their known orders.
GET /api/v1/merchants/:id/invoices
GET /api/v1/invoices/:id/transactions returns a collection of associated transactions.
GET /api/v1/invoices/:id/invoice_items returns a collection of associated invoice items.
GET /api/v1/invoices/:id/items returns a collection of associated items.
GET /api/v1/invoices/:id/customer returns the associated customer.
GET /api/v1/invoices/:id/merchant returns the associated merchant.
Invoice Items

GET /api/v1/invoice_items/:id/invoice returns the associated invoice.
GET /api/v1/invoice_items/:id/item returns the associated item.
Items

GET /api/v1/items/:id/invoice_items returns a collection of associated invoice items.
GET /api/v1/items/:id/merchant returns the associated merchant.
Transactions

GET /api/v1/transactions/:id/invoice returns the associated invoice.
Customers

GET /api/v1/customers/:id/invoices returns a collection of associated invoices.
GET /api/v1/customers/:id/transactions returns a collection of associated transactions.

Business Intelligence Endpoints

Business intelligence endpoints sort and rank resources based on attributes ass well as calculate revenue for some given situations.

All Merchants

returns the top x merchants ranked by total revenue.
GET /api/v1/merchants/most_revenue?quantity=x

returns the top x merchants ranked by total number of items sold.
GET /api/v1/merchants/most_items?quantity=x

returns the total revenue for date x across all merchants.
GET /api/v1/merchants/revenue?date=x

Single Merchant

returns the total revenue for that merchant across successful transactions.
GET /api/v1/merchants/:id/revenue

returns the total revenue for that merchant for a specific invoice date x.
GET /api/v1/merchants/:id/revenue?date=x

returns the customer who has conducted the most total number of successful transactions.
GET /api/v1/merchants/:id/favorite_customer

Items

returns the top x items ranked by total revenue generated.
GET /api/v1/items/most_revenue?quantity=x

returns the top x item instances ranked by total number sold.
GET /api/v1/items/most_items?quantity=x

returns the date with the most sales for the given item using the invoice date. If there are multiple days with equal number of sales, return the most recent day.
GET /api/v1/items/:id/best_day

Customers

returns a merchant where the customer has conducted the most successful transactions.
GET /api/v1/customers/:id/favorite_merchant

Software Versions


Ruby 2.4.1
Rails 5.2.1
© 2018 GitHub, Inc.
Terms
Privacy
Security
Status
Help
