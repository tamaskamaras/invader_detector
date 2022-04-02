# frozen_string_literal: true

class Radar
  class Screen < Radar
    def each_frame(frame_width, frame_height)
      body.each_with_index do |row, y|
        row.each_index do |x|
          frame = to_frame(x, y, frame_width, frame_height)
          yield(frame) if complete_frame?(frame)
        end
      end
    end

    private

    # TODO: create Radar::Frame
    def to_frame(x, y, frame_width, frame_height)
      body[y...(y + frame_height)].map do |row|
        row[x...(x + frame_width)]
      end
    end

    def complete_frame?(frame)
      # TODO
      true
    end
  end
end
