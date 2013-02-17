require 'open-uri'
require 'rubygems'
require 'progressbar'

module Firefox
  class Installer
    attr_reader :os, :lang, :version
    
    def initialize os, language = nil, version = nil, opts = {}
      # set dmg if specified
      if opts[:dmg]
        @dmg_file = opts.delete(:dmg) 
        raise "#{@dmg_file} not found" unless File.exist?(@dmg_file)
      end
      @os = os
      @lang = language || 'en-US'
      @version = version || get_current_version
    end
    
    def install!
      # if no dmg was specified, download an installer
      unless @dmg_file
        download_url = "http://download.mozilla.org/?lang=#{lang}&product=firefox-#{version}&os=#{os}"
        pbar = nil
        installer = open(download_url,
          :content_length_proc => lambda {|t|
            if t && 0 < t
              pbar = ProgressBar.new("Downloading", t)
              pbar.bar_mark = '='
              pbar.file_transfer_mode
            end
          },
          :progress_proc => lambda {|s|
            pbar.set s if pbar
          }
        )
        pbar.finish
      end
      
      case os
      when :osx
        tmp_path = @dmg_file ? @dmg_file : File.join(Dir.tmpdir,'firefox.dmg')
        unless @dmg_file
          File.open(tmp_path,'w') { |f| f.write(installer.read) }
          puts "Downloaded installer in #{tmp_path}"
        end
        
        puts "hdiutil mount #{tmp_path} 2>&1"
        mount_response = `hdiutil mount #{tmp_path} 2>&1`
        raise mount_response if mount_response =~ /mount failed/
        volume = mount_response.split.last
        puts "Mounted on #{volume}"
        FileUtils.cp_r(File.join(volume,'Firefox.app'), '/Applications/Firefox.app')
        puts 'Copied App in /Applications'
        unmount_response = `hdiutil unmount #{volume} 2>&1`
        raise unmount_response if unmount_response =~ /unmount failed/
        puts "Unmounted #{volume}"
      end
    end
    
    def get_current_version
      page = open("http://www.mozilla.org/en-US/").read
      page.scan(/download\.html\?product\=firefox\-([^&]*)/).first.first
    end
  end
end