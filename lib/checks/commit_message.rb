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
        puts '[POLICY] Fail: Your commit message is not formatted correctly.'
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
#
# The format for commit messages is as follows:
# * The msg must start with a ticket reference
#     e.g. [mantis: 12345] [HRB-123] or [untracked]
# * The commit message must be at least 20 characters long
# * The regex that's matched is /^(\[((mantis: |HRB-)\d+|untracked)\]|Merge branch)/i
#
# Here are some examples:
#   [mantis: 12345] Added a regex to validate password structures to the
#     web registration page
#   [HRB-123] Moved every button on the mobile wagerpad one pixel to the left
#   [untracked] Found and fixed a possible race condition in the payout
#     handling code.
      eos
    end
  end
end
