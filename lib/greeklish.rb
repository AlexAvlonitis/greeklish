require "greeklish/version"
require "greeklish/converter"
require "greeklish/bk_tree_builder"
require 'pry'
require 'i18n'

module Greeklish
  I18n.load_path += Dir[File.expand_path('config/locales' + '/*.yml')]
  I18n.available_locales = [:el, :en]
  I18n.default_locale = :el

  @bk_tree ||= BkTreeBuilder.build

  def self.convert(text)
    Converter.run(text, bk_tree)
  end

  def self.bk_tree
    @bk_tree
  end
end
