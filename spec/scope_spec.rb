require 'spec_helper'

describe "user's scope" do
  subject {
    User.create!(
      locale: 'ja',
      sign_in_count: 1,
      name: 'foobar',
      email: 'foobar@example.com',
      joined_at: Time.parse('2013-09-19 00:00:00'),
      specified_on: Date.parse('2013-09-19')
    )
  }
  specify { expect(subject).to be_ja }
  specify { expect(subject).not_to be_not_ja }
  specify { expect(subject).to be_ja_or_en }
  specify { expect(subject).not_to be_not_ja_or_en }
  specify { expect(subject).to be_rarely_signed_in }
  specify { expect(subject).not_to be_not_rarely_signed_in }
  specify { expect(subject).to be_recently_joined }
  specify { expect(subject).to be_specified_day_in_this_week }
  specify { expect(subject).not_to have_no_email }
  specify { expect(subject).to have_email }
  specify { expect(subject).to be_named('foo') }
  specify { expect(subject).not_to be_named('baz') }
  specify { expect(subject).not_to be_heavily_used }
  specify { expect(subject).to be_complex_logic }
end
