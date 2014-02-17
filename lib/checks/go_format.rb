# Encoding: utf-8
require 'util'

module Checks
    # Author: David Tucker
    # Created: 2014/01/28
    # Description:
    #   Enforces go formatting of go files
  class GoFormat

    # Checks if the file is a go file and executes the go fmt command
    # on it, failing if there are any files with syntax errors or just
    # simply unformatted
    def self.apply
      err = false
      Util.staged_files.each do |file_path|
        # check if the file is a go file
        next unless file_path.realpath.to_s =~ /\.go$/i
        # call go fmt on the file
        fmt_output = `go fmt #{file_path.to_s} 2>&1`.split(/\n/)
        next if fmt_output.empty? # no output so all is fine
        # check if there is a syntax error in the file
        fmt_output_arr = fmt_output
        if fmt_output.length > 1
          puts "[POLICY] Fail: You attempted to commit a go syntax error:"
          fmt_output_arr.each { |line| puts "  #{line}" }
        else
          # no syntax error so we're looking at a lack of go formatting
          puts "[POLICY] Fail: You attempted to commit an unformatted go file."
          puts "[POLICY] Please check that this file is now formatted correctly"
          puts "[POLICY] and retry this commit:"
          puts "  #{file_path}"
        end
        err = true
      end
      if err
        exit 1
      end
    end
  end
end
