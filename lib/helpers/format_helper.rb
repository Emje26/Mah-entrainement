# frozen_string_literal: true

# FormatHelper - Utility methods for formatting data in views and controllers
module FormatHelper
  module_function

  # Format currency
  def format_currency(amount, currency: 'EUR', locale: :fr)
    symbol = case currency.upcase
             when 'EUR' then "\u20AC"
             when 'USD' then '$'
             when 'GBP' then "\u00A3"
             else currency
             end

    formatted = format('%.2f', amount.to_f)
    locale == :fr ? "#{formatted} #{symbol}" : "#{symbol}#{formatted}"
  end

  # Format date
  def format_date(date, format: :default)
    return '' if date.nil?

    date = Date.parse(date.to_s) unless date.is_a?(Date) || date.is_a?(Time)

    case format
    when :default
      date.strftime('%d/%m/%Y')
    when :long
      date.strftime('%d %B %Y')
    when :short
      date.strftime('%d/%m')
    when :iso
      date.strftime('%Y-%m-%d')
    else
      date.strftime(format.to_s)
    end
  end

  # Format datetime
  def format_datetime(datetime, format: :default)
    return '' if datetime.nil?

    datetime = Time.parse(datetime.to_s) unless datetime.is_a?(Time)

    case format
    when :default
      datetime.strftime('%d/%m/%Y %H:%M')
    when :long
      datetime.strftime('%d %B %Y at %H:%M')
    when :short
      datetime.strftime('%d/%m %H:%M')
    when :iso
      datetime.strftime('%Y-%m-%dT%H:%M:%S%z')
    else
      datetime.strftime(format.to_s)
    end
  end

  # Truncate text
  def truncate(text, length: 100, omission: '...')
    return '' if text.nil?

    text = text.to_s
    return text if text.length <= length

    text[0, length - omission.length] + omission
  end

  # Pluralize word
  def pluralize(count, singular, plural = nil)
    word = count == 1 ? singular : (plural || "#{singular}s")
    "#{count} #{word}"
  end

  # Format phone number (French format)
  def format_phone(phone)
    return '' if phone.nil?

    digits = phone.to_s.gsub(/\D/, '')
    return phone if digits.length != 10

    digits.gsub(/(\d{2})(\d{2})(\d{2})(\d{2})(\d{2})/, '\1 \2 \3 \4 \5')
  end

  # Sanitize HTML
  def sanitize_html(text)
    return '' if text.nil?

    text.to_s
        .gsub('&', '&amp;')
        .gsub('<', '&lt;')
        .gsub('>', '&gt;')
        .gsub('"', '&quot;')
        .gsub("'", '&#39;')
  end

  # Format file size
  def format_file_size(bytes)
    return '0 B' if bytes.nil? || bytes.zero?

    units = %w[B KB MB GB TB]
    exp = (Math.log(bytes) / Math.log(1024)).to_i
    exp = units.length - 1 if exp >= units.length

    format('%.2f %s', bytes.to_f / (1024**exp), units[exp])
  end

  # Format percentage
  def format_percentage(value, precision: 1)
    return '0%' if value.nil?

    "#{format("%.#{precision}f", value.to_f)}%"
  end
end
