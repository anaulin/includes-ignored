# frozen_string_literal: true

require "bundler/inline"

gemfile(true) do
  source "https://rubygems.org"

  gem "rails", "~> 7.2.2"
  # If you want to test against edge Rails replace the previous line with this:
  # gem "rails", github: "rails/rails", branch: "main"

  gem "sqlite3"
end

require "active_record/railtie"
require "minitest/autorun"

# This connection will do for database-independent bug reports.
ENV["DATABASE_URL"] = "sqlite3::memory:"

class TestApp < Rails::Application
  config.load_defaults Rails::VERSION::STRING.to_f
  config.eager_load = false
  config.logger = Logger.new($stdout)
  config.secret_key_base = "secret_key_base"

  config.active_record.encryption.primary_key = "primary_key"
  config.active_record.encryption.deterministic_key = "deterministic_key"
  config.active_record.encryption.key_derivation_salt = "key_derivation_salt"
end
Rails.application.initialize!

ActiveRecord::Schema.define do
  create_table :parents, force: true do |t|
    t.timestamps
  end

  create_table :children, force: true do |t|
    t.timestamps
  end

  create_table :children_parents, force: true do |t|
    t.integer :parent_id
    t.integer :child_id
    t.integer :ignored
  end
end

class ChildrenParent < ActiveRecord::Base
  self.ignored_columns = [:ignored]

  belongs_to :child
  belongs_to :parent
end

class Parent < ActiveRecord::Base
end

class Child < ActiveRecord::Base
  has_and_belongs_to_many :parents, -> { where.not(id: nil) }
end

class BugTest < ActiveSupport::TestCase
  def test_respects_ignored_columns
    child = Child.create!
    child.parents.create!

    puts Child.includes(:parents).to_sql
  end
end
