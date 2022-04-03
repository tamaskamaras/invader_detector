# frozen_string_literal: true

class Radar
  class Pixel
    attr_reader :x, :y, :body

    def initialize(window, x, y)
      @x = x
      @y = y
      @body = window.is_a?(Array) ? window[y][x] : window
    end

    def valid?
      %w[o -].includes?(body) &&
        x.is_a?(Integer) &&
        y.is_a?(Integer)
    end

    def filled?
      body == 'o'
    end
  end
end
