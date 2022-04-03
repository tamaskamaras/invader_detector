# frozen_string_literal: true

class Radar
  class Pixel
    attr_reader :x, :y, :body

    def initialize(char, x, y)
      @body = char
      @x = x
      @y = y
    end

    def valid?
      return false unless %w[o -].includes?(body)
      return false unless x.is_a?(Integer)
      return false unless y.is_a?(Integer)

      true
    end

    def filled?
      body == 'o'
    end
  end
end
