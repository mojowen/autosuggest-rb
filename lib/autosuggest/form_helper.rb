module ActionView
  module Helpers
    module FormHelper
      def autosuggest_field(object_name, method, source, options={})
        text_field_class = "autosuggest_#{object_name}_#{method}"
        options[:class] = "#{options[:class].to_s} #{text_field_class}"
        autosuggest_options = options.delete(:autosuggest_options) || {}
        autosuggest_options.reverse_merge!("selectedItemProp" => "name", "searchObjProps" => "name", "neverSubmit" => "true", "asHtmlName" => "#{object_name}[set_#{method}]")

        _out = text_field(object_name, method, options)
        _out << raw(%{
          <script type="text/javascript">
            $(document).ready(function(){
              $('.#{text_field_class}').autoSuggest('#{source}', #{autosuggest_options.to_json});
            });
          </script>
        })
        _out
      end
    end

    module FormTagHelper
      def autosuggest_field_tag(name, value, source, options={})
        raise "todo"
      end
    end
  end
end

class ActionView::Helpers::FormBuilder #:nodoc:
  def autosuggest_field(method, source, options = {})
    @template.autosuggest_field(@object_name, method, source, objectify_options(options))
  end
end

