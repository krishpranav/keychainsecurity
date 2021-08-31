require 'shellwords'

module Security
    
    class Password
        attr_reader :keychain, :attributes, :password
    
        private_class_method :new
    
        def initialize(keychain, attributes, password)
          @keychain = Keychain.new(keychain)
          @attributes = attributes
          @password = password
        end
    
        class << self
          private
    
          def password_from_output(output)
            return nil if output.match?(/^security: /)
    
            keychain = nil
            attributes = {}
            password = nil
            output.split(/\n/).each do |line|
              case line
              when /^keychain: "(.+)"/
                keychain = Regexp.last_match(1)
              when /"(\w{4})".+="(.+)"/
                attributes[Regexp.last_match(1)] = Regexp.last_match(2)
              when /"(\w{4})"<blob>=0x([[:xdigit:]]+)/
                attributes[Regexp.last_match(1)] = decode_hex_blob(Regexp.last_match(2))
              when /^password: "(.+)"/
                password = Regexp.last_match(1)
              when /^password: 0x([[:xdigit:]]+)/
                password = decode_hex_blob(Regexp.last_match(1))
              end
            end
    
            new(keychain, attributes, password)
          end
    
          def flags_for_options(options = {})
            flags = options.dup
            flags[:a] ||= flags.delete(:account)
            flags[:c] ||= flags.delete(:creator)
            flags[:C] ||= flags.delete(:type)
            flags[:D] ||= flags.delete(:kind)
            flags[:G] ||= flags.delete(:value)
            flags[:j] ||= flags.delete(:comment)
    
            flags.delete_if { |_k, v| v.nil? }.collect { |k, v| "-#{k} #{v.shellescape}".strip }.join(' ')
          end
    
          def decode_hex_blob(string)
            [string].pack('H*').force_encoding('UTF-8')
          end
        end
      end