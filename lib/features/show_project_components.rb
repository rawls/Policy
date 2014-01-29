# Encoding: utf-8
require 'util'

module Features
  # Author: Will Brown
  # Created: 2014/01/28
  # Description:
  #   Appends a list of project components included in the commit to the 
  #   commit message
  class ShowProjectComponents

    # Compares the staged files against the contents of a yaml file containing
    # patterns of project component types and their names
    def self.apply(msg_file)
      components = Util.match_commit_against 'project_components', Util.staged_files
      return if components.empty?
      File.open(msg_file, 'a') { |f| f.puts " (#{components.join('|')})" }
    end

  end
end
