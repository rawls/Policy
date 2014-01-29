# Encoding: utf-8
require 'util'

module Features
  # Author: Will Brown
  # Created: 2014/01/28
  # Description:
  #   Appends a list of file types included in the commit to the commit message
  class ShowFileTypes

    # Compares the staged files against the contents of a yaml file containing
    # patterns of file types and their names
    def self.apply(msg_file)
      staged_types = Util.match_commit_against 'file_types', Util.staged_files
      return if staged_types.empty?
      File.open(msg_file, 'a') { |f| f.puts " (#{staged_types.join('|')})" }
    end
  end
end
