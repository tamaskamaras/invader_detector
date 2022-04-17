# frozen_string_literal: true

class Radar
  class Screen < Radar
    def each_frame(width, hight)
      each_pixel do |pixel|
        frame = Frame.new(self, width, hight)
        frame.draw_from(pixel)
        yield(frame) if frame.valid?
      end
    end
  end
end
