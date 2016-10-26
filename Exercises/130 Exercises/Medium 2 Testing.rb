# Setup the Test Class - Cash Register
require 'minitest/autorun'
require 'minitest/reporters'
Minittest::Reporters.use!

require_relative 'cash_register'

class CashRegisterTest < MiniTest::Test

  def setup
    #logic
  end

  def test_accept_money
    #logic
  end
end

# Test Accept Money Method - Cash Register
require 'minitest/autorun'
require 'minitest/reporters'
Minitest::Reporters.use!

require_relative 'cash_register'
require_relative 'transaction'

class CashRegisterTest < Minitest::Test
  def test_accept_money
    register = CashRegister.new(1000)
    transaction = Transaction.new(20)
    transaction.amount_paid = 20

    previous_amount = register.total_money
    register.accept_money(transaction)
    current_amount = register.total_money

    assert_equal previous_amount + 20, current_amount
  end
end

# Test Change Method - Cash Register
  def test_change
    register = CashRegister.new(1000)
    transaction = Transaction.new(20)
    transaction.amount_paid = 50

    expected_change = transaction.amount_paid - transaction.item_cost
    assert_equal(expected_change, register.change(transaction))
  end

# Test Give Receipt Method - Cash Register
  def test_give_receipt
    item = 20
    register = CashRegister.new(1000)
    transaction = Transaction.new(item)
    assert_output("You've paid $#{item}.\n") do 
      register.give_receipt(transaction)
    end
  end

# Test Prompt For Payment Method- Transaction
class TransactionTest < MiniTest::Test
  def test_prompt_payment
    transaction = Transaction.new(20)
    input = StringIO.new("20\n")
    transaction.prompt_for_payment(input: input)
    assert_equal(20, transaction.amount_paid)
  end
end

# Alter Prompt For Payment Method - Transaction
class TransactionTest < MiniTest::Test
  def test_prompt_payment
    transaction = Transaction.new(20)
    input = StringIO.new("20\n")
    output = StringIO.new
    transaction.prompt_for_payment(input: input, output: output)
    assert_equal(20, transaction.amount_paid)
  end
end

  def prompt_for_payment(input: $stdin, output: $stdout) # We've set a default parameter for stdin
  loop do
    output.puts "You owe $#{item_cost}.\nHow much are you paying?"
    @amount_paid = input.gets.chomp.to_f # notice that we call gets on that parameter
    break if valid_payment? && sufficient_payment?
    output.puts 'That is not the correct amount. ' \
         'Please make sure to pay the full cost.'
  end
end

# Test swap method - Text
require 'minitest/autorun'
require 'minitest/reporters'
Minitest::Reporters.use!

require_relative 'text'


class TextTest < Minitest::Test
  def setup
    @file = File.open('sample.txt', 'r')
  end

  def teardown
    @file.close
  end

  def test_swap
    text = Text.new(@file.read)
    actual_text = text.swap('a','e')
    expected_text = <<~TEXT
    Lorem ipsum dolor sit emet, consectetur edipiscing elit. Cres sed vulputete ipsum.
    Suspendisse commodo sem ercu. Donec e nisi elit. Nullem eget nisi commodo, volutpet
    quem e, viverre meuris. Nunc viverre sed messe e condimentum. Suspendisse ornere justo
    nulle, sit emet mollis eros sollicitudin et. Etiem meximus molestie eros, sit emet dictum
    dolor ornere bibendum. Morbi ut messe nec lorem tincidunt elementum vitee id megne. Cres
    et verius meuris, et pheretre mi.
    TEXT

    assert_equal(expected_text, actual_text)
  end
end

# Test word_count method - Text
  def test_word_count
    text = Text.new(@file.read)
    actual_count = text.word_count
    expected_count = 72

    assert_equal(expected_count, actual_count)
  end