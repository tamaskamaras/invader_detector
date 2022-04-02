# frozen_string_literal: true

class Radar
  class Screen < Radar
    def each_frame(width, hight)
      body.each_with_index do |row, y|
        row.each_index do |x|
          frame = Frame.new(self, width, hight)
          frame.draw(x, y)
          yield(frame) if frame.valid?
        end
      end
    end
  end
end
