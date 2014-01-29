# Encoding: utf-8
require 'util'

module Checks
  # Author: Will Brown
  # Created: 2014/01/28
  # Description:
  #   Makes sure the user isn't committing into the wrong branch
  class RestrictedBranches

    # Loads a yaml file containing a list of restricted branches and compares
    # against the current branch
    def self.apply
      restricted_branches = Util.load_config 'restricted_branches'
      current_branch = Util.current_branch
      return unless restricted_branches.is_a? Array
      if restricted_branches.include? current_branch
        puts "[POLICY] Fail: You are attempting to commit into restricted branch: #{current_branch}"
        exit 1
      end
    end
  end
end
