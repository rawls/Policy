# Encoding: utf-8
module Checks
  # Author: Will Brown
  # Created: 2014/01/28
  # Description:
  #   Enforces a standardized commit message structure
  class CommitMessage
    COMMIT_MSG_RULE = /^(\[((mantis: |HRB-)\d+|untracked)\]|Merge branch)/i
    MIN_MSG_LENGTH = 20

    # Compares the commit message against the regex and min length rules. Then
    # prints a description of the structure if the message fails
    def self.apply(commit_msg)
      unless COMMIT_MSG_RULE.match(commit_msg) && commit_msg.length > MIN_MSG_LENGTH
        puts '[POLICY] Fail: Your commit message is not formatted properly.'
        puts describe
        exit 1
      end
    end

    def self.describe_in(message_file)
      File.open(message_file, 'a') { |f| f.puts describe }
    end

    private

    def self.describe
      <<-eos
# The format for commit messages is as follows:
# * The message must start with a ticket ref, e.g. [mantis: 12345] [HRB-123] or [untracked]
# * The commit message must be at least 20 characters long
      eos
    end
  end
end
