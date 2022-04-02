# frozen_string_literal: true

class Radar
  class Invader < Radar
    def radar_data
      {
        size: size,
        coordinates: {
          x: x,
          y: y
        }
      }
    end
  end
end
