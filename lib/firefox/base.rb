module Firefox
  class UnsupportedOSError < Exception # :nodoc:
    def initialize message
      super message
    end
  end
  
  class Base
    class <<self
      def bin_path
        return ENV['FIREFOX_PATH'] if ENV['FIREFOX_PATH']
        
        @bin_path = ''
        case platform(RUBY_PLATFORM)
        when :osx
          @bin_path = '/Applications/Firefox.app/Contents/MacOS/firefox-bin'
        when :win
          @bin_path = '"C:\Program Files\Mozilla Firefox\firefox.exe"'
        when :linux
          @bin_path = '/usr/bin/firefox'
        else
          raise UnsupportedOSError.new("I don't really know what OS you're on, sorry")
        end
      end
      
      def platform(host_os)
        return :osx if host_os =~ /darwin/
        return :linux if host_os =~ /linux/
        return :windows if host_os =~ /mingw32|mswin32/
        return :unknown
      end
      
    end
  end
end

/darwin/
/linux/
/mingw32/