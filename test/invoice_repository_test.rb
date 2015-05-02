require_relative 'test_helper'


class InvoiceRepositoryTest < Minitest::Test
  attr_reader :engine, :invoices

  def setup
    @engine = SalesEngine.new('./test/fixtures')
    @invoices = engine.invoice_repository
  end

  #-------------------- Relationship Method Tests --------------------

  #-------------------- Base Method Tests --------------------
  def test_invoices_can_exist
    assert invoices
  end

  def test_invoices_contain_data
    assert_equal 100, invoices.all.length
  end

  def test_invoice_repository_returns_all_invoices
    assert_equal 100, invoices.all.length
  end

  def test_invoice_repository_returns_random_invoice
    invoice1, invoice2 = invoices.random, invoices.random

    total_random_invoices = 0
    until total_random_invoices == 100
      total_random_invoices += 1 if invoice1 == invoice2
      return total_random_invoices
    end

    assert_equal 100, total_random_invoices
  end

#-------------------- Find_by Method Tests --------------------
  def test_invoice_repository_returns_invoices_by_id
    by_id = invoices.find_by_id(4)
    assert_equal 4, by_id.id
  end

  def test_invoice_repository_returns_invoices_by_customer_id
    by_customer_id = invoices.find_by_customer_id(4)
    assert_equal 4, by_customer_id.customer_id
  end

  def test_invoice_repository_returns_invoices_by_merchant_id
    by_merchant_id = invoices.find_by_merchant_id(96)
    assert_equal 9, by_merchant_id.customer_id
  end

  def test_invoice_repository_returns_invoices_by_status
    by_status = invoices.find_by_status("shipped")
    assert_equal 1, by_status.id
  end

  def test_invoice_repository_returns_invoices_by_created_at
    by_created_at = invoices.find_by_created_at("2012-03-25 09:54:09 UTC")
    assert_equal 1, by_created_at.customer_id
  end

  def test_invoice_repository_returns_invoices_by_updated_at
    by_updated_at = invoices.find_by_updated_at("2012-03-07 21:54:10 UTC")
    assert_equal 1, by_updated_at.customer_id
  end

#-------------------- Find_all_by Method Tests --------------------
  def test_invoice_repository_returns_all_invoices_by_id
    all_by_id = invoices.find_all_by_id(1)
    assert_equal 1, all_by_id.count
  end

  def test_invoice_repository_returns_all_invoices_by_customer_id
    all_by_customer_id = invoices.find_all_by_customer_id(4)
    assert_equal 8, all_by_customer_id.count
  end

  def test_invoice_repository_returns_all_invoices_by_merchant_id
    all_by_merchant_id = invoices.find_all_by_merchant_id(86)
    assert_equal 3, all_by_merchant_id.count
  end

  def test_invoice_repository_returns_all_invoices_by_status
    all_by_status = invoices.find_all_by_status("shipped")
    assert_equal 100, all_by_status.count
  end

  def test_invoice_repository_returns_all_by_created_at
    all_by_created_at = invoices.find_all_by_created_at("2012-03-25 09:54:09 UTC")
    assert_equal 1, all_by_created_at.count
  end

  def test_invoice_repository_returns_all_by_updated_at
    all_by_updated_at = invoices.find_all_by_updated_at("2012-03-07 21:54:10 UTC")
    assert_equal 1, all_by_updated_at.count
  end































  def test_invoices_have_a_repository
    assert invoices
  end

  def test_invoices_have_an_id
    refute invoices.any? { |invoice| invoice.id.nil? }
  end

  def test_invoices_have_a_customer_id
    refute invoices.any? { |invoice| invoice.customer_id.nil? }
  end

  def test_invoices_have_a_merchant_id
    refute invoices.any? { |invoice| invoice.merchant_id.nil? }
  end

  def test_invoice_has_a_status
    refute invoices.any? { |invoice| invoice.status.nil? }
  end

  def test_invoice_knows_when_it_was_created
    refute invoices.any? { |invoice| invoice.created_at.nil? }
  end

  def test_invoice_knows_when_it_was_updated
    refute invoices.any? { |invoice| invoice.updated_at.nil? }
  end
end


