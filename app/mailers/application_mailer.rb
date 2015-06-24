# app/mailers/application_mailer.rb
class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  layout 'mailer'

  def base_url
    host = "http://#{default_url_options[:host]}"
    return host unless default_url_options[:port]

    "#{host}:#{default_url_options[:port]}"
  end
end
