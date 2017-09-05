class ApplicationController < ActionController::Base
  include HttpAcceptLanguage::AutoLocale
  #protect_from_forgery with: :exception
end
