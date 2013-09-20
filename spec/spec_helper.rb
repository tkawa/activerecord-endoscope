$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'active_record'
require 'arel_ruby'
require 'activerecord-endoscope'
require 'squeel'

# database
ActiveRecord::Base.configurations = {'test' => {:adapter => 'sqlite3', :database => ':memory:'}}
ActiveRecord::Base.establish_connection('test')

# models
class User < ActiveRecord::Base
  extend ActiveRecord::Endoscope
  scope :ja, -> {
    where(locale: 'ja')
  }
  scope :not_ja, -> {
    where.not(locale: 'ja')
  }
  scope :ja_or_en, -> {
    where(locale: ['ja', 'en'])
    #where{ (locale == 'ja') | (locale == 'en') }
  }
  scope :not_ja_or_en, -> {
    where.not(locale: ['ja', 'en'])
  }
  scope :rarely_signed_in, -> {
    where(sign_in_count: 0..3)
  }
  scope :not_rarely_signed_in, -> {
    where.not(sign_in_count: 0..3)
  }
  scope :recently_joined, -> {
    now = Time.parse('2013-09-20 00:00:00')
    where(joined_at: now.ago(1.week)..now)
  }
  scope :specified_day_in_this_week, -> {
    now = Date.parse('2013-09-20')
    where(specified_on: now.beginning_of_week..now.end_of_week)
  }
  scope :have_no_email, -> {
    where(email: nil)
  }
  scope :have_email, -> {
    where.not(email: nil).where.not(email: '')
  }
  # using squeel
  scope :named, ->(param) {
    where{ name.like "%#{param}%" }
  }
  scope :not_named, ->(param) {
    where{ name.not_like "%#{param}%" }
  }
  scope :heavily_used, -> {
    where{ sign_in_count >= 4 }
  }
  scope :complex_logic, -> {
    where{ ((locale == 'ja') & (email != nil)) | ((locale == 'en') & (email == nil)) }
  }
end

# migrations
class CreateAllTables < ActiveRecord::Migration
  def self.up
    create_table(:users) {|t| t.string :locale; t.integer :sign_in_count; t.string :name; t.string :email; t.datetime :joined_at; t.date :specified_on}
  end
end

RSpec.configure do |config|
  config.before :all do
    CreateAllTables.up unless ActiveRecord::Base.connection.table_exists?('users')
  end
end
