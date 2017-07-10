require 'spec_helper'
require 'state'

RSpec.describe 'state' do
  describe '#next' do
    subject(:next) { State.new(initial_state).next }

    context 'dead cells do not become alive' do
      let(:initial_state) {
        [
          [0, 0, 0, 0, 0],
          [0, 0, 0, 0, 0],
          [0, 0, 0, 0, 0],
          [0, 0, 0, 0, 0],
          [0, 0, 0, 0, 0],
        ]
      }

      it { is_expected.to eq(initial_state) }
    end

    context 'a cell with fewer than 2 neighbors dies' do
      let(:initial_state) {
        [
          [0, 0, 0, 0, 0],
          [0, 0, 0, 0, 0],
          [0, 0, 1, 0, 0],
          [0, 0, 0, 0, 0],
          [0, 0, 0, 0, 0],
        ]
      }

      it {
        is_expected.to eq(
          [
            [0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0],
          ]
        )
      }
    end

    context 'a cell with 2-3 live neighbors survives' do
      let(:initial_state) {
        [
          [0, 0, 0, 0, 0],
          [0, 1, 0, 0, 0],
          [0, 0, 1, 1, 0],
          [0, 0, 0, 0, 0],
          [0, 0, 0, 0, 0],
        ]
      }

      it {
        is_expected.to eq(
          [
            [0, 0, 0, 0, 0],
            [0, 0, 1, 0, 0],
            [0, 0, 1, 0, 0],
            [0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0],
          ]
        )
      }
    end

    context 'a cell with more than 3 live neighbors dies' do
      let(:initial_state) {
        [
          [0, 0, 0, 0, 0],
          [0, 0, 1, 0, 0],
          [0, 1, 1, 1, 0],
          [0, 0, 1, 0, 0],
          [0, 0, 0, 0, 0],
        ]
      }

      it {
        is_expected.to eq(
          [
            [0, 0, 0, 0, 0],
            [0, 1, 1, 1, 0],
            [0, 1, 0, 1, 0],
            [0, 1, 1, 1, 0],
            [0, 0, 0, 0, 0],
          ]
        )
      }
    end

    context 'a dead cell with exact 3 live neighbors reproduces' do
      let(:initial_state) {
        [
          [0, 0, 0, 0, 0],
          [0, 1, 0, 1, 0],
          [0, 0, 0, 0, 0],
          [0, 1, 0, 0, 0],
          [0, 0, 0, 0, 0],
        ]
      }

      it {
        is_expected.to eq(
          [
            [0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0],
            [0, 0, 1, 0, 0],
            [0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0],
          ]
        )
      }
    end
  end
end
