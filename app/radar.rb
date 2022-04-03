# frozen_string_literal: true

class Radar
  attr_reader :body, :width, :hight, :x, :y

  def initialize(source_path)
    @body = to_a(source_path)
    @width = pixels.first.length
    @hight = pixels.size
  end

  def valid?
    return false unless pixels
    return false if pixels.size != hight
    return false if pixels.all? { |row| row.size != width }

    true
  end

  def pixel_count
    @pixel_count ||= pixels.inject(0) do |result, row|
      result + row.size
    end
  end
  alias size pixel_count

  def filled_pixel_count
    @filled_pixel_count ||= pixels.inject(0) do |result, row|
      result + row.count { |pixel| pixel.body == 'o' }
    end
  end

  def each_pixel
    pixels.each do |row|
      row.each do |pixel|
        yield(pixel)
      end
    end
  end

  def find_pixel_by(other_pixel)
    return unless pixels.is_a?(Array)
    return unless other_pixel.is_a?(Pixel)

    result = nil

    each_pixel do |own_pixel|
      next if own_pixel.x != other_pixel.x
      next if own_pixel.y != other_pixel.y

      result = own_pixel
      break
    end

    result
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

  def pixels
    @pixels ||= begin
      result = []

      body.each_with_index do |row, y|
        new_row = []

        row.each_with_index do |char, x|
          new_row << Pixel.new(char, x, y)
        end

        result << new_row
      end

      result
    end
  end

  private

  def to_a(path)
    File.read(path).split("\n").map { |row| row.split('') }
  end
end
