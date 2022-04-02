# frozen_string_literal: true

class Radar
  attr_reader :body, :width, :hight, :x, :y

  def initialize(source_path)
    @body = to_a(source_path)
    @width = body.first.length
    @hight = body.size
  end

  def valid?
    return false unless body

    body.size == hight && body.all? { |row| row.size == width }
  end

  def pixel_count
    @pixel_count ||= body.inject(0) do |result, row|
      result + row.size
    end
  end
  alias size pixel_count

  def filled_pixel_count
    @filled_pixel_count ||= body.inject(0) do |result, row|
      result + row.count { |pixel| pixel == 'o' }
    end
  end

  def each_pixel
    body.each_with_index do |row, y|
      row.each_index do |x|
        yield(Pixel.new(body, x, y))
      end
    end
  end

  def find_pixel_by(other_pixel)
    return unless body.is_a?(Array)
    return unless other_pixel.is_a?(Pixel)

    Pixel.new(body, other_pixel.x, other_pixel.y)
  end

  def set_coordinates(top_left_corner)
    @x ||= top_left_corner.x
    @y ||= top_left_corner.y
  end

  def radar_data
    {
      size: size,
      coordinates: {
        x: x,
        y: y
      }
    }
  end

  private

  def to_a(path)
    File.read(path).split("\n").map { |row| row.split('') }
  end
end
