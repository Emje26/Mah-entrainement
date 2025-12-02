# frozen_string_literal: true

# Payment service - Handles payment processing
class Payment
  attr_reader :amount, :currency, :customer_id, :payment_method

  SUPPORTED_CURRENCIES = %w[EUR USD GBP].freeze

  def initialize(amount:, customer_id:, currency: 'EUR', payment_method: 'card')
    @amount = amount.to_f
    @currency = currency.upcase
    @customer_id = customer_id
    @payment_method = payment_method
  end

  def charge
    validate!
    process_payment
  end

  def refund(transaction_id)
    # TODO: Implement refund logic
    puts "[PAYMENT] Refunding transaction: #{transaction_id}"
    { success: true, transaction_id: transaction_id, status: 'refunded' }
  end

  class << self
    def charge(**args)
      new(**args).charge
    end

    def refund(transaction_id)
      new(amount: 0, customer_id: nil).refund(transaction_id)
    end
  end

  private

  def validate!
    raise ArgumentError, 'Amount must be positive' if amount <= 0
    raise ArgumentError, "Unsupported currency: #{currency}" unless SUPPORTED_CURRENCIES.include?(currency)
    raise ArgumentError, 'Customer ID is required' if customer_id.nil?
  end

  def process_payment
    # TODO: Integrate with payment gateway (Stripe, PayPal, etc.)
    transaction_id = generate_transaction_id

    puts "[PAYMENT] Processing #{amount} #{currency} for customer #{customer_id}"
    puts "[PAYMENT] Payment method: #{payment_method}"
    puts "[PAYMENT] Transaction ID: #{transaction_id}"

    {
      success: true,
      transaction_id: transaction_id,
      amount: amount,
      currency: currency,
      status: 'completed'
    }
  end

  def generate_transaction_id
    "TXN_#{Time.now.to_i}_#{SecureRandom.hex(8)}"
  end
end
