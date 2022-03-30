# frozen_string_literal: true

Dir[Rails.root.join('{app,spec}/**/*.rb')].sort.each { |file| require file }
