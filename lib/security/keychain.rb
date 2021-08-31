require 'shellwords'

module Security

    class Keychain

        attr_reader :filename
        
        def initialize(filename)
            @filename = filename
        end

        def info
            system %(security show-keychain-info #{@filename.shellescape})
        end

        class << self
            def create(filename, password)
                raise NotImplementedError
            end

            def keychain_from_output(output)
                output.split(/\n/).collect { |line| new(line.strip.gsub(/^"|"$/, '')) }
            end
        end
    end
end
