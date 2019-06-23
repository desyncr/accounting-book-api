require './lib/balance'
require './lib/client'
require './lib/transaction'

class Accounting
  TIME_FORMAT             = "%Y%m%d%H%M%S"
  OPERATION_DEBIT         = 100
  OPERATION_CREDIT        = 101
  OPERATION_BALANCE       = 102
  OPERATION_TRANSACTIONS  = 103
  @client_host           = '127.0.0.1'
  @client_port           = 8080

  def self.set_client_host(host)
    @client_host = host
  end

  def self.set_client_port(port)
    @client_port = port
  end

  def self.get_balance_for_account(account)
    client = Client.new @client_host, @client_port
    payload = sprintf(
      "%020d%03d%14s",
      account.to_i,
      OPERATION_BALANCE,
      Time.now.strftime(TIME_FORMAT)
    )

    response = client.request payload
    response.delete(:transactions)
    response
  end

  def self.get_transactions_for_account(account)
    client = Client.new @client_host, @client_port
    payload = sprintf(
      "%020d%03d%14s",
      account.to_i,
      OPERATION_BALANCE,
      Time.now.strftime(TIME_FORMAT)
    )

    response = client.request payload
    response[:transactions]
  end

  def self.get_transaction_by_id(transaction)
    client = Client.new @client_host, @client_port
    payload = sprintf(
      "%020d%03d%14s",
      transaction.to_i,
      OPERATION_TRANSACTIONS,
      Time.now.strftime(TIME_FORMAT)
    )

    response = client.request payload
    response[:transactions].shift
  end


  def self.debit(account, amount)
    client = Client.new @client_host, @client_port
    payload = sprintf(
      "%020d%03d%14s%04d",
      account.to_i,
      OPERATION_DEBIT,
      Time.now.strftime(TIME_FORMAT),
      amount.to_f
    )

    response = client.request payload
    response
  end

  def self.credit(account, amount)
    client = Client.new @client_host, @client_port
    payload = sprintf(
      "%020d%03d%14s%04d",
      account.to_i,
      OPERATION_CREDIT,
      Time.now.strftime(TIME_FORMAT),
      amount.to_f
    )

    response = client.request payload
    response
  end
end
