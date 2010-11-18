module UniformNotifier
  class JavascriptConsole < Base
    def self.active?
      UniformNotifier.console
    end

    def self.inline_notify( notice )
      return '' unless active?

      code = <<-CODE
        if (typeof(console) !== 'undefined') {
          if (console.groupCollapsed && console.groupEnd && console.log) {
            console.groupCollapsed(#{notice.title.inspect});
            console.log(#{notice.body_with_caller.inspect});
            console.groupEnd();

          } else if (console.log) {
            console.log(#{notice.full_notice.inspect});
          }
        }
      CODE

      wrap_js_association code
    end
  end
end