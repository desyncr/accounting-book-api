require 'sinatra'
require './lib/accounting'

before do
  headers['Access-Control-Allow-Methods'] = 'GET, POST, PUT, DELETE, OPTIONS'
  headers['Access-Control-Allow-Origin'] = '*'
  headers['Access-Control-Allow-Headers'] = 'accept, authorization, origin'
end

options '*' do
  response.headers['Allow'] = 'HEAD,GET,PUT,DELETE,OPTIONS,POST'
  response.headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-HTTP-Method-Override, Content-Type, Cache-Control, Accept'
end

get '/accounts/:account/balance' do
  balance = Accounting::get_balance_for_account params[:account]
  if !balance
    status 400
  else
    status 200
    balance.to_json
  end
end

get '/accounts/:account' do
  balance = Accounting::get_balance_for_account params[:account]
  if !balance
    status 400
  else
    status 200
    balance.to_json
  end
end

post '/accounts/:account/transactions' do
  data = JSON.parse request.body.string
  case data['type']
  when 'debit'
    response = Accounting::debit params[:account], data['amount']
  when 'credit'
    response = Accounting::credit params[:account], data['amount']
  end

  case response[:status]
  when 0
    status 201
    response[:transactions].pop.to_json
  else
    status 400
  end
end

get '/accounts/:account/transactions' do
  transactions = Accounting::get_transactions_for_account params[:account]

  status 200
  transactions.to_json
end

get '/accounts/:account/transactions/:transaction' do
  transaction = Accounting::get_transaction_by_id params[:transaction]
  if !transaction
    status 400
  else
    status 200
    transaction.to_json
  end
end
