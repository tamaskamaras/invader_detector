# frozen_string_literal: true

class Radar
  class Frame < Radar
    attr_reader :screen

    def initialize(screen, width, hight)
      @screen = screen
      @width = width
      @hight = hight
    end

    def draw_from(pixel)
      set_coordinates(pixel)

      @body = screen.body[pixel.y...(pixel.y + hight)].map do |row|
        row[pixel.x...(pixel.x + width)]
      end
    end
  end
end
