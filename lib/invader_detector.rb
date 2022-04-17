# frozen_string_literal: true

root_path = File.expand_path(File.dirname(__FILE__))

Dir["#{root_path}/app/**/*.rb"].sort.each { |file| require file }
