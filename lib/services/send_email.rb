# frozen_string_literal: true

# SendEmail service - Handles email sending functionality
class SendEmail
  attr_reader :to, :subject, :body, :from

  def initialize(to:, subject:, body:, from: nil)
    @to = to
    @subject = subject
    @body = body
    @from = from || ENV.fetch('DEFAULT_FROM_EMAIL', 'noreply@example.com')
  end

  def call
    validate!
    deliver
  end

  class << self
    def call(**args)
      new(**args).call
    end

    # Send welcome email to new user
    def welcome(user)
      call(
        to: user.email,
        subject: 'Welcome to our platform!',
        body: "Hello #{user.name},\n\nWelcome to our platform. We're excited to have you!"
      )
    end

    # Send password reset email
    def password_reset(user, token)
      call(
        to: user.email,
        subject: 'Password Reset Request',
        body: "Hello #{user.name},\n\nClick here to reset your password: /reset?token=#{token}"
      )
    end

    # Send notification email
    def notification(user, message)
      call(
        to: user.email,
        subject: 'New Notification',
        body: "Hello #{user.name},\n\n#{message}"
      )
    end
  end

  private

  def validate!
    raise ArgumentError, 'Recipient email is required' if to.nil? || to.empty?
    raise ArgumentError, 'Subject is required' if subject.nil? || subject.empty?
    raise ArgumentError, 'Body is required' if body.nil? || body.empty?
  end

  def deliver
    # TODO: Implement actual email delivery (e.g., via SMTP, SendGrid, etc.)
    puts "[EMAIL] To: #{to}"
    puts "[EMAIL] From: #{from}"
    puts "[EMAIL] Subject: #{subject}"
    puts "[EMAIL] Body: #{body}"
    puts '[EMAIL] Sent successfully!'
    true
  end
end
