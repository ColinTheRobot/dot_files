Vim�UnDo� �N:^��<��ք�x�9��rd��荵�DRG�   Q   %end # cover(name: 'Public liability')   R                           a0��    _�                     /       ����                                                                                                                                                                                                                                                                                                                            /          2                 a0��    �   .   3   R      .    given("1-2 years")        { 0.9349593496 }   .    given("2-3 years")        { 0.9391304348 }   .    given("3-4 years")        { 0.9444444444 }   .    given("4-5 years")        { 0.9509803922 }5�_�                     /       ����                                                                                                                                                                                                                                                                                                                            /          2                 a0��    �   Q              %end # cover(name: 'Public liability')�   P   R          �  insurer_specific_name "Liabilities Insurance - Section 2 Property Owners' Liability (See separate Limit of Indemnity endorsement)"�   O   Q          "  load_factor 'Years owned factor'�   N   P          "  load_factor 'No-claims discount'�   M   O          &  load_factor 'Renewals load Sep 2021'�   L   N          1cover(name: 'Public liability', type: 'Choco') do�   K   M           �   J   L          end # cover(name: 'Contents')�   I   K          I  insurer_specific_name "Property Damage Insurance - Landlord's Contents"�   H   J          "  load_factor 'Years owned factor'�   G   I          "  load_factor 'No-claims discount'�   F   H          &  load_factor 'Renewals load Sep 2021'�   E   G          )cover(name: 'Contents', type: 'Choco') do�   D   F           �   C   E          (end # cover(name: 'Fixtures & fittings')�   B   D          V  insurer_specific_name "Property Damage Insurance - Landlord's Fixtures and Fittings"�   A   C          "  load_factor 'Years owned factor'�   @   B          "  load_factor 'No-claims discount'�   ?   A          &  load_factor 'Renewals load Sep 2021'�   >   @          4cover(name: 'Fixtures & fittings', type: 'Choco') do�   =   ?           �   <   >          "end # cover(name: 'Main building')�   ;   =          ?  insurer_specific_name "Property Damage Insurance - Buildings"�   :   <          "  load_factor 'Years owned factor'�   9   ;          "  load_factor 'No-claims discount'�   8   :          &  load_factor 'Renewals load Sep 2021'�   7   9          .cover(name: 'Main building', type: 'Choco') do�   6   8           �   5   7          end�   4   6            end�   3   5          .    given("6+ years")         { 1.00         }�   2   4          .    given("Over 5 years")     { 0.9587628866 }�   1   3          .    given("4-5 years")        { 0.9509803922 }�   0   2          .    given("3-4 years")        { 0.9444444444 }�   /   1          .    given("2-3 years")        { 0.9391304348 }�   .   0          .    given("1-2 years")        { 0.9349593496 }�   -   /          .    given("Less than 1 year") { 1.00         }�   ,   .          !  lookup(basis: 'Years owned') do�   +   -          <load_factor(name: 'Years owned factor', cumulative: true) do�   *   ,           �   )   +          -end # load_factor(name: 'No-claims discount')�   (   *            end�   '   )          .    given("6+ years")          { 1.000000000 }�   &   (          .    given("5-6 years")         { 0.958762887 }�   %   '          .    given("4-5 years")         { 0.950980392 }�   $   &          .    given("3-4 years")         { 0.944444444 }�   #   %          .    given("2-3 years")         { 0.939130435 }�   "   $          .    given("1-2 years")         { 0.934959350 }�   !   #          )    given("Less than 1 year")  { :refer }�       "          /  lookup(basis: 'Renewal years claims free') do�      !          <load_factor(name: 'No-claims discount', cumulative: true) do�                  �                1end # load_factor(name: 'Renewals load Sep 2021')�                  end�                    given(:anything) { 1.05 }�                6  lookup(basis: 'UK postcode', default_value: 1.05) do�                Xload_factor(name: 'Renewals load Sep 2021', cumulative: true, end_date: '2022-01-28') do�                 �                 �                Bprice_factor name: :buildings_blanket_limit,        value: 600_000�                Xprice_factor name: :max_commission_rate,            value: 1.5000 # 60% of gross premium�                Xprice_factor name: :commission_rate,                value: 1.0000 # 50% of gross premium�                end�                  end�                    end�                "      of('no')          { 92.40  }�                "      of('yes')         { 114.00 }�                F    given('Fixtures and fittings', with: 'Contents cover selected') do�                    end�                "      of('no')          { 114.00 }�                "      of('yes')         { 114.00 }�   
             >    given('Main building', with: 'Contents cover selected') do�   	                 end�      
          "      of('yes')         { 84.00  }�      	          5    given('None', with: 'Contents cover selected') do�                b  lookup(basis: 'Fixtures and fittings or main building cover selected', default_value: 114.00) do�                &price_factor name: :minimum_premium do�                 �                0source_from_project 'direct_debit_price_factors'�                -source_from_project 'uk_shared_price_factors'�                "source_from_insurer 'filter_rules'�                 )source_from_insurer_shared 'endorsements'5��