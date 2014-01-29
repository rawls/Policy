# Encoding: utf-8
require 'pathname'
require 'yaml'
BASE = Pathname.new(__FILE__).realpath.parent.parent.parent unless defined? BASE
CONFIG_DIR = Pathname.new(__FILE__).realpath.parent.parent + 'config' unless defined? CONFIG_DIR

# Author: Will Brown
# Created: 2014/01/28
# Description:
#   Simple utilities for working with git hooks
class Util

  # Parse the specified config file or return nil if the file doesn't exist
  def self.load_config(name)
    YAML.load_file(CONFIG_DIR + "#{name}.yml")
  rescue
    return nil
  end

  # Returns the name of the branch which is currently in use
  def self.current_branch
    `git rev-parse --abbrev-ref HEAD`.chomp
  end

  # Returns a list of absolute paths to files which have been staged for this
  # commit
  def self.staged_files
    file_list = `git diff --cached --name-only --diff-filter=ACM`.split
    file_list.inject([]) do |results, f|
      results << Pathname.new(BASE + f) if File.size(f) < 1_000_000
      results
    end
  end

  # Grabs a yaml config file (a list of names and regexes) and matches the
  # patterns against the files that have been staged for commit
  def self.match_commit_against(config_name, files)
    results = []
    pattern_list = load_config config_name
    return results unless pattern_list.is_a? Hash
    files.each do |real_path|
      rel_path = real_path.relative_path_from(BASE).to_s
      pattern_list.each do |name, pattern|
        results << name if rel_path.match(pattern) && !results.include?(name)
      end
    end
    results
  end
end
