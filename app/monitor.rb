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
    result = []

    screen.each_frame(invader.width, invader.hight) do |frame|
      next if frame.filled_pixel_count == 0
      next unless invader_found?(invader, frame)

      result << frame.radar_data
    end

    result
  end

  def invader_found?(invader, frame)
    return false if invader.pixel_count != frame.pixel_count

    probability(invader, frame) >= (100 - tolerance)
  end

  def probability(invader, frame)
    (matching_pixel_count(invader, frame) / invader.filled_pixel_count) * 100
  end

  def matching_pixel_count(invader, frame)
    result = 0

    invader.each_pixel do |invader_pixel|
      next unless invader_pixel.filled?
      next unless frame.find_pixel_by(invader_pixel).filled?

      result += 1
    end

    result.to_f
  end
end
