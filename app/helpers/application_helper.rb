# frozen_string_literal: true

# ApplicationHelper - Helper methods for views
module ApplicationHelper
  # Set page title
  def page_title(title = nil)
    base_title = 'Mah Entrainement'
    title.present? ? "#{title} | #{base_title}" : base_title
  end

  # Flash message class mapping
  def flash_class(type)
    case type.to_sym
    when :notice, :success
      'alert-success'
    when :alert, :error, :danger
      'alert-danger'
    when :warning
      'alert-warning'
    else
      'alert-info'
    end
  end

  # Active link helper
  def active_link_to(name, path, options = {})
    css_class = options[:class] || ''
    css_class += ' active' if current_page?(path)
    link_to name, path, options.merge(class: css_class.strip)
  end

  # Format date
  def format_date(date, format = :default)
    return '' if date.nil?

    l(date, format: format)
  end

  # Format currency
  def format_price(amount)
    number_to_currency(amount, unit: '€', format: '%n %u')
  end

  # Truncate text with tooltip
  def truncate_with_tooltip(text, length: 50)
    return '' if text.blank?
    return text if text.length <= length

    content_tag(:span, truncate(text, length: length), title: text, data: { toggle: 'tooltip' })
  end

  # Avatar placeholder
  def avatar_for(user, size: 40)
    initials = user.name.split.map(&:first).join.upcase[0, 2]
    content_tag(:div, initials, class: 'avatar', style: "width: #{size}px; height: #{size}px;")
  end

  # Status badge
  def status_badge(status, type = :default)
    css_class = case type
                when :success then 'badge-success'
                when :danger then 'badge-danger'
                when :warning then 'badge-warning'
                else 'badge-secondary'
                end
    content_tag(:span, status, class: "badge #{css_class}")
  end

  # Yes/No helper
  def yes_no(value)
    value ? t('common.yes') : t('common.no')
  end

  # Markdown rendering (if redcarpet is installed)
  def markdown(text)
    return '' if text.blank?

    # Simple implementation - for full markdown, add 'redcarpet' gem
    simple_format(text)
  end
end
