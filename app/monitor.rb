# frozen_string_literal: true

class Monitor
  attr_reader :screen, :tolerance

  def initialize(screen, tolerance: 0)
    @screen = screen
    @tolerance = tolerance
  end

  def detect(invaders)
    if invaders.is_a?(Array)
      invaders.flat_map { |invader| detect(invader) }
    else
      detected_invaders(invaders)
    end
  end

  private

  def detected_invaders(invader)
    matches = []
    screen.each_frame(invader.width, invader.hight) do |frame|
      next if frame.filled_pixel_count == 0

      matches << check(invader, frame)
    end
    matches.compact
  end

  def check(invader, frame)
    return if probability(invader, frame) < (100 - tolerance)

    {
      size: invader.size,
      coordinates: {
        x: frame.x,
        y: frame.y
      }
    }
  end

  def probability(invader, frame)
    return 0 if invader.pixel_count != frame.pixel_count

    (match_count(invader, frame) / invader.filled_pixel_count) * 100
  end

  def match_count(invader, frame)
    result = 0

    invader.each_pixel do |invader_pixel|
      next unless invader_pixel.filled?

      if invader_pixel.body == frame.find_pixel_by(invader_pixel).body
        result += 1
      end
    end

    result.to_f
  end
end
