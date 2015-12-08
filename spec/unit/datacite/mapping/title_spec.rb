require 'spec_helper'

module Datacite
  module Mapping
    describe Title do
      describe '#initialize' do
        it 'sets the value' do
          value = 'An Account of a Very Odd Monstrous Calf'
          title = Title.new(value: value, language: 'en-emodeng')
          expect(title.value).to eq(value)
        end

        it 'sets the language' do
          lang = 'en-emodeng'
          title = Title.new(language: lang, value: 'Observables upon a Monstrous Head')
          expect(title.language).to eq(lang)
        end

        it 'requires a language' do
          expect { Title.new(value: 'A Relation of an Accident by Thunder and Lightning, at Oxford') }.to raise_error(ArgumentError)
        end

        it 'sets the type' do
          type = TitleType::SUBTITLE
          title = Title.new(type: type, value: 'And a Contest between Two Artists about Optick Glasses, &c', language: 'en-emodeng')
          expect(title.type).to eq(type)
        end

        it 'defaults to a nil type' do
          title = Title.new(value: "Of Some Books Lately Publish't", language: 'en-emodeng')
          expect(title.type).to be_nil
        end
      end

      describe 'value=' do
        it 'sets the value' do
          title = Title.allocate
          title.value = "Of Some Books Lately Publish't"
          expect(title.value).to eq("Of Some Books Lately Publish't")
        end
        it 'requires a value' do
          title = Title.new(value: "Of Some Books Lately Publish't", language: 'en-emodeng')
          expect { title.value = nil }.to raise_error(ArgumentError)
          expect(title.value).to eq("Of Some Books Lately Publish't")
        end
        it 'requires a non-empty value' do
          title = Title.new(value: "Of Some Books Lately Publish't", language: 'en-emodeng')
          expect { title.value = '' }.to raise_error(ArgumentError)
          expect(title.value).to eq("Of Some Books Lately Publish't")
        end
      end

      describe 'lang=' do
        it 'sets the language' do
          title = Title.new(value: "Of Some Books Lately Publish't", language: 'en-emodeng')
          new_lang = 'en-gb'
          title.language = new_lang
          expect(title.language).to eq(new_lang)
        end
        it 'ignores nil' do
          title = Title.new(value: "Of Some Books Lately Publish't", language: 'en-emodeng')
          title.language = nil
          expect(title.language).to eq('en-emodeng')
        end
      end

      describe '#load_from_xml' do
        it 'parses XML' do
          xml_text = '<title xml:lang="en-emodeng" titleType="Subtitle">Together with an Appendix of the Same, Containing an Answer to Some Objections, Made by Severall Persons against That Hypothesis</title>'
          xml = REXML::Document.new(xml_text).root
          title = Title.load_from_xml(xml)

          expected_lang = 'en-emodeng'
          expected_type = TitleType::SUBTITLE
          expected_value = 'Together with an Appendix of the Same, Containing an Answer to Some Objections, Made by Severall Persons against That Hypothesis'

          expect(title.language).to eq(expected_lang)
          expect(title.type).to eq(expected_type)
          expect(title.value).to eq(expected_value)
        end

        it 'treats missing language as en' do
          xml_text = '<title>Physical oceanography from BT during cruise U99XX00542B_1979</title>'
          xml = REXML::Document.new(xml_text).root
          title = Title.load_from_xml(xml)
          expect(title.language).to eq('en')
        end

        it 'trims the value' do
          xml_text = '<title>
                         Physical oceanography from BT during cruise U99XX00542B_1979
                      </title>'
          xml = REXML::Document.new(xml_text).root
          title = Title.load_from_xml(xml)
          expect(title.value).to eq('Physical oceanography from BT during cruise U99XX00542B_1979')
        end
      end

      describe '#save_to_xml' do
        it 'writes XML' do
          title = Title.new(
            language: 'en-emodeng',
            type: TitleType::SUBTITLE,
            value: 'Together with an Appendix of the Same, Containing an Answer to Some Objections, Made by Severall Persons against That Hypothesis'
          )
          expected_xml = '<title xml:lang="en-emodeng" titleType="Subtitle">Together with an Appendix of the Same, Containing an Answer to Some Objections, Made by Severall Persons against That Hypothesis</title>'
          expect(title.save_to_xml).to be_xml(expected_xml)
        end
      end
    end
  end
end
