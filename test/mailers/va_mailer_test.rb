require 'test_helper'

class VaMailerTest < ActionMailer::TestCase
  test "va" do
    mail = VaMailer.va
    assert_equal "Va", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
