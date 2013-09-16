require 'active_record/endoscope/version'

module ActiveRecord
  module Endoscope
    def scope(name, body, &block)
      super

      instance_method_name = "#{name.to_s.sub(/^have_/, 'has_')}?"

      define_method(instance_method_name) do |*args|
        self.class.send(name, *args).arel.to_ruby.call([self]).present?
      end
    end
  end
end
