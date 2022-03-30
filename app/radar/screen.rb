# frozen_string_literal: true

class Radar
  class Screen < Radar

    private

    def each_frame(frame_width, frame_height)
      body.each_index do |row_index|
        row.each_index do |pixel_index|
          yeild()
        end
      end
    end
  end
end
