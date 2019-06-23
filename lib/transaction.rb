require 'date'

class Transaction
  TRANSACTION_DEBIT   = 1
  TRANSACTION_CREDIT  = 0

  def self.from_string(str)
    transaction = {}
    transaction[:id]     = str[0..19]
    transaction[:amount] = str[21..32].to_f
    transaction[:type]   = self::enum_to_str(str[33..37].to_i)
    transaction[:time]   = Time.at(str[38..47].to_i).to_datetime

    transaction
  end

  private
  def self.enum_to_str(cod)
    case cod
    when TRANSACTION_DEBIT
      return 'debit'
    when TRANSACTION_CREDIT
      return 'credit'
    end

    'unknown'
  end
end
