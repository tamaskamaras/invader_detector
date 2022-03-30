# frozen_string_literal: true

class Radar
  attr_reader :body, :width, :hight

  def initialize(source_path)
    @body = to_a(source_path)
    @width = body.first.length
    @hight = body.size
  end

  private

  def to_a(path)
    File.read(path).split("\n").map { |row| row.split('') }
  end
end
