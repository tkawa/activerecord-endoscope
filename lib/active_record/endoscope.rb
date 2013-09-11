require 'active_record/endoscope/version'

module ActiveRecord
  module Endoscope
    def scope(name, scope_options = {})
      super

      instance_method_name = "#{name.to_s.sub(/^have_/, 'has_')}?"
      class_eval <<-ENDOSCOPE, __FILE__, __LINE__ + 1
        def #{instance_method_name}
          self.class.#{name}.arel.to_ruby.call([self]).present?
        end
      ENDOSCOPE
    end
  end
end
