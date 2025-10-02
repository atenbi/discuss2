require "rails_helper"

RSpec.describe ApplicationHelper, type: :helper do
  describe "#flash_message_class" do
    context "when flash type is notice" do
      it "returns green styling classes" do
        result = helper.flash_message_class(:notice)

        expect(result).to eq("bg-green-100 border border-green-400 text-green-700")
      end

      it "handles string input" do
        result = helper.flash_message_class("notice")

        expect(result).to eq("bg-green-100 border border-green-400 text-green-700")
      end
    end

    context "when flash type is alert" do
      it "returns red styling classes" do
        result = helper.flash_message_class(:alert)

        expect(result).to eq("bg-red-100 border border-red-400 text-red-700")
      end
    end

    context "when flash type is unknown" do
      it "returns gray styling classes for unknown symbol" do
        result = helper.flash_message_class(:warning)

        expect(result).to eq("bg-gray-100 border border-gray-400 text-gray-700")
      end

      it "returns gray styling classes for unknown string" do
        result = helper.flash_message_class("info")

        expect(result).to eq("bg-gray-100 border border-gray-400 text-gray-700")
      end

      it "handles nil input" do
        result = helper.flash_message_class(nil)

        expect(result).to eq("bg-gray-100 border border-gray-400 text-gray-700")
      end

      it "handles empty string" do
        result = helper.flash_message_class("")

        expect(result).to eq("bg-gray-100 border border-gray-400 text-gray-700")
      end
    end
  end
end
