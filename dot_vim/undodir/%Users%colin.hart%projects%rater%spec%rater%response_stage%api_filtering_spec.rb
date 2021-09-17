Vim�UnDo� !|��C�:��f�LQ�#ѯ��f�,�E�)nü   P   n      rfq = Rater::Factories::Chopin::Usa::Usa.quoting_rfq(product: "General liability", insurer: "Travelers")   I   B                       a'��   	 _�                     *   =    ����                                                                                                                                                                                                                                                                                                                                                             a��    �   )   +   P      R        rfq = Rater::Factories::Chopin::Usa::Usa.quoting_rfq(insurer: "Travelers")5�_�                    *   N    ����                                                                                                                                                                                                                                                                                                                                                             a��     �   )   +   P      q        rfq = Rater::Factories::Chopin::Usa::Usa.quoting_rfq(product: "Generali liability", insurer: "Travelers")5�_�                    *   N    ����                                                                                                                                                                                                                                                                                                                                                             a��    �   )   +   P      q        rfq = Rater::Factories::Chopin::Usa::Usa.quoting_rfq(product: "Generaly liability", insurer: "Travelers")5�_�                    7        ����                                                                                                                                                                                                                                                                                                                            7          7          V       a��     �   6   8   O    �   7   8   O    �   6   7          P      rfq = Rater::Factories::Chopin::Usa::Usa.quoting_rfq(insurer: "Travelers")5�_�                   I        ����                                                                                                                                                                                                                                                                                                                            I   +       I   +       V   +    a��    �   H   J   O    �   I   J   O    �   H   I          P      rfq = Rater::Factories::Chopin::Usa::Usa.quoting_rfq(insurer: "Travelers")5�_�                    I       ����                                                                                                                                                                                                                                                                                                                            I           I   o       V   +    a��    �   O   Q          end�   N   P            end�   M   O              end�   L   N          L      expect(response.reasons_for_referral).to include("pretty good reason")�   K   M          0      expect(response.decision).to eq(:declined)�   J   L           �   I   K                 response = call_stage(rfq)�   H   J          p        rfq = Rater::Factories::Chopin::Usa::Usa.quoting_rfq(product: "General liability", insurer: "Travelers")�   G   I           �   F   H                }�   E   G          	        )�   D   F          6          reasons_for_referral: ["pretty good reason"]�   C   E                    referred?: true,�   B   D          #          Rater::Filtering::Result,�   A   C                  instance_double(�   @   B          <      allow(Rater::Filtering::Base).to receive(:filtering) {�   ?   A          .    it "sets the quote decision to decline" do�   >   @          /  context "when selected trades not matches" do�   =   ?           �   <   >            end�   ;   =              end�   :   <          Y      expect(response.reasons_for_referral).to include("#{insurer} API is not available")�   9   ;          0      expect(response.decision).to eq(:referred)�   8   :           �   7   9                 response = call_stage(rfq)�   6   8          p        rfq = Rater::Factories::Chopin::Usa::Usa.quoting_rfq(product: "General liability", insurer: "Travelers")�   5   7           �   4   6          e        .and_return(instance_double('Rater::Availability::ScheduledAvailability', available?: false))�   3   5                  .with(insurer)�   2   4          P      allow(Rater::Availability::ScheduledAvailability).to receive(:for_insurer)�   1   3          /    it "sets the quote decision to referred" do�   0   2          ,  context "when insurer is not available" do�   /   1           �   .   0            end�   -   /              end�   ,   .          	      end�   +   -          4        expect(response.decision).to eq(:indication)�   *   ,          "        response = call_stage(rfq)�   )   +          p        rfq = Rater::Factories::Chopin::Usa::Usa.quoting_rfq(product: "General liability", insurer: "Travelers")�   (   *          f          .and_return(instance_double('Rater::Availability::ScheduledAvailability', available?: true))�   '   )                    .with(insurer)�   &   (          R        allow(Rater::Availability::ScheduledAvailability).to receive(:for_insurer)�   %   '          2      it "sets the quote decision to indicated" do�   $   &          .    context "when the rfq is a quoting rfq" do�   #   %          (  context "when insurer is available" do�   "   $           �   !   #            end�       "              end�      !          /      expect(response.decision).to eq(:unrated)�                        response = call_stage(rfq)�                :      rfq = Rater::Factories::Chopin::Usa::Usa.unrated_rfq�                .    it "sets the quote decision to unrated" do�                7  context "when the rfq is missing some rating info" do�                 �                  end�                    response�                L    described_class.call(response: response, model: model, context: context)�                q    context = PipelineTestHelper.build_pipeline_context(questionnaire: questionnaire, risk_profile: risk_profile)�                3    risk_profile = Rater::RiskProfile.new(rfq: rfq)�                    )�                .      question_customiser: question_customiser�                      project: "Chopin",�                      rfq: rfq,�                H    questionnaire = Rater::Form::QuestionnaireFactory.questionnaire_for(�                    )�                      decision: nil�                      vertical: "Usa",�                      project: "Chopin",�                      product: "Usa",�   
                   insurer: insurer,�   	                   :response,�      
               response = FactoryBot.build(�      	            def call_stage(rfq)�                 �                U  let(:question_customiser) { Rater::QuestionTextCategory::Questionnaire.new("Usa") }�                V  let(:model) { Rater::Rating::Repository.model_for("Chopin", "Usa", "Usa", insurer) }�                  let(:insurer) { 'Travelers' }�                .describe Rater::ResponseStage::ApiFiltering do�                 �                 require 'spec_helper'5�_�      	              *   D    ����                                                                                                                                                                                                                                                                                                                                                             a'��     �   )   +   P      p        rfq = Rater::Factories::Chopin::Usa::Usa.quoting_rfq(product: "General liability", insurer: "Travelers")5�_�      
           	   *   G    ����                                                                                                                                                                                                                                                                                                                                                             a'��     �   )   +   P      q        rfq = Rater::Factories::Chopin::Usa::Usa.quoting_rfq(products: "General liability", insurer: "Travelers")5�_�   	              
   *   [    ����                                                                                                                                                                                                                                                                                                                                                             a'��    �   )   +   P      r        rfq = Rater::Factories::Chopin::Usa::Usa.quoting_rfq(products: ["General liability", insurer: "Travelers")5�_�   
                 7   B    ����                                                                                                                                                                                                                                                                                                                                                             a'��     �   6   8   P      n      rfq = Rater::Factories::Chopin::Usa::Usa.quoting_rfq(product: "General liability", insurer: "Travelers")5�_�                    7   E    ����                                                                                                                                                                                                                                                                                                                                                             a'��     �   6   8   P      o      rfq = Rater::Factories::Chopin::Usa::Usa.quoting_rfq(products: "General liability", insurer: "Travelers")5�_�                    7   Y    ����                                                                                                                                                                                                                                                                                                                                                             a'��    �   6   8   P      p      rfq = Rater::Factories::Chopin::Usa::Usa.quoting_rfq(products: ["General liability", insurer: "Travelers")5�_�                    I   B    ����                                                                                                                                                                                                                                                                                                                                                             a'��     �   H   J   P      n      rfq = Rater::Factories::Chopin::Usa::Usa.quoting_rfq(product: "General liability", insurer: "Travelers")5�_�                    I   E    ����                                                                                                                                                                                                                                                                                                                                                             a'��     �   H   J   P      o      rfq = Rater::Factories::Chopin::Usa::Usa.quoting_rfq(products: "General liability", insurer: "Travelers")5�_�                     I   Y    ����                                                                                                                                                                                                                                                                                                                                                             a'��   	 �   H   J   P      p      rfq = Rater::Factories::Chopin::Usa::Usa.quoting_rfq(products: ["General liability", insurer: "Travelers")5�_�                    I        ����                                                                                                                                                                                                                                                                                                                            I           I   O       V   +    a��     �   H   J        �   I   J   O    �   H   I   O      P      rfq = Rater::Factories::Chopin::Usa::Usa.quoting_rfq(insurer: "Travelers")5��