class Balance
  def self.from_string(str)
    balance = {}
    balance[:account]  = str[0..19]
    balance[:status]   = str[21..24].to_i
    balance[:balance]  = str[25..34].to_f
    balance
  end
end
