require 'spec_helper'

module Datacite
  module Mapping
    describe Title do
      describe '#initialize' do
        it 'sets the value' do
          value = 'An Account of a Very Odd Monstrous Calf'
          title = Title.new(value: value)
          expect(title.value).to eq(value)
        end

        it 'sets the language' do
          lang = 'en-emodeng'
          title = Title.new(lang: lang, value: 'Observables upon a Monstrous Head')
          expect(title.lang).to eq(lang)
        end

        it 'sets the type' do
          type = Types::TitleType::SUBTITLE
          title = Title.new(type: type, value: 'And a Contest between Two Artists about Optick Glasses, &c')
          expect(title.type).to eq(type)
        end

        it 'defaults to a nil language' do
          title = Title.new(value: 'A Relation of an Accident by Thunder and Lightning, at Oxford')
          expect(title.lang).to be_nil
        end

        it 'defaults to a nil type' do
          title = Title.new(value: "Of Some Books Lately Publish't")
          expect(title.type).to be_nil
        end
      end

      describe '#load_from_xml' do
        it 'parses XML' do
          xml_text = '<title xml:lang="en-emodeng" titleType="Subtitle">Together with an Appendix of the Same, Containing an Answer to Some Objections, Made by Severall Persons against That Hypothesis</title>'
          xml = REXML::Document.new(xml_text).root
          title = Title.load_from_xml(xml)

          expected_lang = 'en-emodeng'
          expected_type = Types::TitleType::SUBTITLE
          expected_value = 'Together with an Appendix of the Same, Containing an Answer to Some Objections, Made by Severall Persons against That Hypothesis'

          expect(title.lang).to eq(expected_lang)
          expect(title.type).to eq(expected_type)
          expect(title.value).to eq(expected_value)
        end
      end

      describe '#save_to_xml' do
        it 'writes XML' do
          title = Title.new(
            lang: 'en-emodeng',
            type: Types::TitleType::SUBTITLE,
            value: 'Together with an Appendix of the Same, Containing an Answer to Some Objections, Made by Severall Persons against That Hypothesis'
          )
          expected_xml = '<title xml:lang="en-emodeng" titleType="Subtitle">Together with an Appendix of the Same, Containing an Answer to Some Objections, Made by Severall Persons against That Hypothesis</title>'
          expect(title.save_to_xml).to be_xml(expected_xml)
        end
      end

    end
  end
end
