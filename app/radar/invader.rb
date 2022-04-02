# frozen_string_literal: true

class Radar
  class Invader < Radar
    def radar_data
      {
        size: size,
        # coordinates: invader.coordinates
        coordinates: {
          x: 0,
          y: 0
        }
      }
    end
  end
end
