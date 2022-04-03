# frozen_string_literal: true

require 'spec_helper'

RSpec.shared_examples 'a radar scanner' do
  it 'returns expected invader data', :aggregate_failures do
    expect(monitor.detect(invader1)).to eq(expected_invader1_data)
    expect(monitor.detect(invader2)).to eq(expected_invader2_data)
    expect(monitor.detect([invader1, invader2])).to eq(expected_invader1_data + expected_invader2_data)
  end
end

RSpec.describe Monitor do
  let(:invader1) { Radar::Invader.new('spec/fixtures/radar/invaders/invader_1') }
  let(:invader2) { Radar::Invader.new('spec/fixtures/radar/invaders/invader_2') }
  let(:expected_invader1_data) { [] }
  let(:expected_invader2_data) { [] }
  let(:tolerance) { 0 }

  subject(:monitor) do
    described_class.new(screen, tolerance: tolerance)
  end

  context 'when screen is empty' do
    let(:screen) { Radar::Screen.new('spec/fixtures/radar/screens/empty') }

    it_behaves_like 'a radar scanner'
  end

  context 'when screen clearly displays 1 invader' do
    let(:screen) { Radar::Screen.new('spec/fixtures/radar/screens/with_invader_1') }
    let(:expected_invader1_data) do
      [
        {
          size: invader1.size,
          coordinates: { x: 21, y: 12 }
        }
      ]
    end

    it_behaves_like 'a radar scanner'
  end

  context 'when screen clearly displays 4 invaders with_multiple_invaders' do
    let(:screen) { Radar::Screen.new('spec/fixtures/radar/screens/with_multiple_invaders') }
    let(:expected_invader1_data) do
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
    let(:expected_invader2_data) do
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

    it_behaves_like 'a radar scanner'
  end

  context 'when screen displays invaders with noise' do
    let(:screen) { Radar::Screen.new('spec/fixtures/radar/screens/with_noise_and_invaders') }

    context 'when tolerance is 0' do
      it_behaves_like 'a radar scanner'
    end

    context 'when tolerance is 10' do
      let(:tolerance) { 10 }
      let(:expected_invader2_data) do
        [
          {
            size: invader2.size,
            coordinates: { x: 16, y: 28 }
          }
        ]
      end

      it_behaves_like 'a radar scanner'
    end

    context 'when tolerance is 20' do
      let(:tolerance) { 20 }
      let(:expected_invader1_data) do
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
      let(:expected_invader2_data) do
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

      it_behaves_like 'a radar scanner'
    end
  end
end
