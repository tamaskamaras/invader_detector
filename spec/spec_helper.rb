# frozen_string_literal: true

require './config/application'
(Dir['./spec/**/*.rb'].sort - ['./spec/spec_helper.rb']).each { |file| require file }
