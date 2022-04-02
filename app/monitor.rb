# frozen_string_literal: true

class Monitor
  attr_reader :screen, :tolerance

  def initialize(screen, tolerance: 0)
    @screen = screen
    @tolerance = tolerance
  end

  def detect(invaders)
    if invaders.is_an?(Array)
      invaders.map { |invader| detect(invader) }
    else
      detected_invaders(invaders)
    end
  end

  private

  def detected_invaders(invader)
    matches = []
    screen.each_frame do |frame|
      matches << check(invader, frame)
    end
    matches.compact
  end

  def check(invader, frame)
    {
      size: [],
      coordinates: {
        x: '',
        y: ''
      }
    }

    nil
  end
end
