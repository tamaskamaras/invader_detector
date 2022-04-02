# frozen_string_literal: true

class Radar
  class Frame
    attr_reader :screen, :width, :hight, :body

    def initialize(screen, width, hight)
      @screen = screen
      @width = width
      @hight = hight
    end

    def draw(x, y)
      @body = screen.body[y...(y + hight)].map do |row|
        row[x...(x + width)]
      end
    end

    def valid?
      return false unless body

      body.size == hight && body.all? { |row| row.size == width }
    end
  end
end
