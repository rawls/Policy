# Encoding: utf-8
require 'util'

module Checks
  # Author: Will Brown
  # Created: 2014/01/28
  # Description:
  #   Checks the staged files for merge conflicts
  class MergeConflict
    MERGE_CONFLICT_PATTERN = /^\s?(<<<<<<<|=======|>>>>>>>).*/

    # Reads through each file staged for commit and matches against a merge
    # conflict regex
    def self.apply
      Util.staged_files.each do |file_path|
        file = File.read(file_path)
        if file.match MERGE_CONFLICT_PATTERN
          puts "[POLICY] Fail: You are committing a merge conflicted file: #{file_path}"
          exit 1
        end
      end
    end
  end
end
