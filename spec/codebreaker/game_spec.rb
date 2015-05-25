require 'spec_helper'

module Codebreaker

  describe Game do

    context "#initialize" do

      it "saves 4 numbers secret code" do
        expect(subject.instance_variable_get(:@secret_code).size).to eq 4
      end

      it "saves secret code with numbers from 1 to 6" do
        expect(subject.instance_variable_get(:@secret_code)).to match /^[1-6]{4}$/
      end

      it "should respond_to @attempt" do
        expect(subject).to respond_to(:attempt)
      end

      it "should respond_to @hint" do
        expect(subject).to respond_to(:hint)
      end

      it "attempt set to 5" do
        expect(subject.attempt).to eq(5)
      end

    end

    context "#attempt=" do

      it "attempt set to 10" do
        subject.instance_variable_set(:@attempt, 10)
        expect(subject.instance_variable_get(:@attempt)).to eq(10)
      end
    end

    context "#compare" do

      before do
        subject.instance_variable_set(:@secret_code, '1134')
      end

      it "should return if code not a number" do
        expect(subject.compare 'f123').to eq('You entered is not a number, or a length of less than 4 or greater is present number 6')
      end
      it "should return if code present number > 6" do
        expect(subject.compare '1713').to eq('You entered is not a number, or a length of less than 4 or greater is present number 6')
      end
      it "should return if code length  < 4" do
        expect(subject.compare '1713').to eq('You entered is not a number, or a length of less than 4 or greater is present number 6')
      end

      it "should return ++++" do
        expect(subject.compare '1134').to eq('++++')
      end

      it "should return +++" do
        expect(subject.compare '1131').to eq('+++')
      end

      it "should return ++--" do
        expect(subject.compare '4131').to eq('++--')
      end

      it "should return +-" do
        expect(subject.compare '5112').to eq('+-')
      end

      it "should return ----" do
        expect(subject.compare '3411').to eq('----')
      end

      it "should return -" do
        expect(subject.compare '6455').to eq('-')
      end

      it "should return +" do
        expect(subject.compare '5554').to eq('+')
      end

      it "should return empty string" do
        expect(subject.compare '5566').to eq('')
      end

    end

    context "#get_hint" do

      before do
        subject.instance_variable_set(:@secret_code, '1234')
      end

      it "hint should be true" do
        expect(subject.hint).to eq(true)
      end

      it "should set instance to false" do
        expect { subject.get_hint }.to change{ subject.hint }.to(false)
      end

      it "should return a hint" do
        expect(subject.get_hint).to include('*')
      end

      it "hint has 4 items" do
        expect(subject.get_hint.size).to eq(4)
      end


      it "should return **3*" do
        allow(subject).to receive(:rand).and_return(2)
        expect(subject.get_hint).to eq('**3*')
      end

      it "should return 1***" do
        allow(subject).to receive(:rand).and_return(0)
        expect(subject.get_hint).to eq('1***')
      end

    end

  end
end

