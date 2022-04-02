# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Monitor do
  let(:invader1) { Radar::Invader.new('spec/fixtures/radar/invaders/invader_1') }
  let(:invader2) { Radar::Invader.new('spec/fixtures/radar/invaders/invader_2') }

  subject(:monitor) do
    described_class.new(screen)
  end

  context 'when screen is empty' do
    let(:screen) { Radar::Screen.new('spec/fixtures/radar/screens/empty') }

    it 'returns an empty Array', :aggregate_failures do
      expect(monitor.detect(invader1)).to eq([])
      expect(monitor.detect(invader2)).to eq([])
      expect(monitor.detect([invader1, invader2])).to eq([])
    end
  end

  context 'when screen clearly displays 1 invader' do
    let(:screen) { Radar::Screen.new('spec/fixtures/radar/screens/with_invader_1') }
    let(:invader1_data) do
      [
        {
          size: invader1.size,
          coordinates: { x: 21, y: 12 }
        }
      ]
    end

    it 'returns the size and location of invader1', :aggregate_failures do
      expect(monitor.detect(invader1)).to match_array(invader1_data)
      expect(monitor.detect(invader2)).to eq([])
      expect(monitor.detect([invader1, invader2])).to match_array(invader1_data)
    end
  end

  context 'when screen clearly displays 4 invaders with_multiple_invaders' do
    let(:screen) { Radar::Screen.new('spec/fixtures/radar/screens/with_multiple_invaders') }
    let(:invader1_data) do
      [
        {
          size: invader1.size,
          coordinates: { x: 34, y: 3 }
        },
        {
          size: invader1.size,
          coordinates: { x: 21, y: 16 }
        }
      ]
    end
    let(:invader2_data) do
      [
        {
          size: invader2.size,
          coordinates: { x: 44, y: 21 }
        },
        {
          size: invader2.size,
          coordinates: { x: 66, y: 33 }
        }
      ]
    end

    it 'returns the size and location of the invaders', :aggregate_failures do
      expect(monitor.detect(invader1)).to match_array(invader1_data)
      expect(monitor.detect(invader2)).to match_array(invader2_data)
      expect(monitor.detect([invader1, invader2])).to match_array(invader1_data + invader2_data)
    end
  end

  context 'when screen displays invaders with noise' do
    let(:screen) { Radar::Screen.new('spec/fixtures/radar/screens/with_noise_and_invaders') }

    context 'when tolerance is 0' do
      it 'returns the size and location of the invaders', :aggregate_failures do
        expect(monitor.detect(invader1)).to eq([])
        expect(monitor.detect(invader2)).to eq([])
        expect(monitor.detect([invader1, invader2])).to eq([])
      end
    end

    context 'when tolerance is 10' do
      let(:invader2_data) do
        [
          {
            size: invader2.size,
            coordinates: { x: 16, y: 28 }
          }
        ]
      end

      subject(:monitor) do
        described_class.new(screen, tolerance: 10)
      end

      it 'returns the size and location of the invaders', :aggregate_failures do
        expect(monitor.detect(invader1)).to eq([])
        expect(monitor.detect(invader2)).to eq(invader2_data)
        expect(monitor.detect([invader1, invader2])).to eq(invader2_data)
      end
    end

    context 'when tolerance is 20' do
      let(:invader1_data) do
        [
          {
            size: invader1.size,
            coordinates: { x: 74, y: 1 }
          },
          {
            size: invader1.size,
            coordinates: { x: 85, y: 12 }
          },
          {
            size: invader1.size,
            coordinates: { x: 60, y: 13 }
          }
        ]
      end
      let(:invader2_data) do
        [
          {
            size: invader2.size,
            coordinates: { x: 42, y: 0 }
          },
          {
            size: invader2.size,
            coordinates: { x: 35, y: 15 }
          },
          {
            size: invader2.size,
            coordinates: { x: 16, y: 28 }
          },
          {
            size: invader2.size,
            coordinates: { x: 82, y: 41 }
          }
        ]
      end

      subject(:monitor) do
        described_class.new(screen, tolerance: 20)
      end

      it 'returns the size and location of the invaders', :aggregate_failures do
        expect(monitor.detect(invader1)).to eq(invader1_data)
        expect(monitor.detect(invader2)).to eq(invader2_data)
        expect(monitor.detect([invader1, invader2])).to eq(invader1_data + invader2_data)
      end
    end
  end
end
