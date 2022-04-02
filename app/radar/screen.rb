# frozen_string_literal: true

class Radar
  class Screen < Radar
    def each_frame(frame_width, frame_height)
      body.each_with_index do |row, row_index|
        row.each_index do |pixel_index|
          yield(to_frame(row_index, pixel_index, frame_width, frame_height))
        end
      end
    end

    private

    def to_frame(row_index, pixel_index, frame_width, frame_height)
      body[row_index...(row_index + frame_height)].map do |row|
        row[pixel_index...(pixel_index + frame_width)]
      end
    end
  end
end
