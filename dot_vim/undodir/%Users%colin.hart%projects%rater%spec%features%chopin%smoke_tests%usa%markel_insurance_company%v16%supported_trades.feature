Vim�UnDo� ��I��Ɔ�f�ƅ�'��~���ÚEk���   5                                  a;Y&    _�                     *   4    ����                                                                                                                                                                                                                                                                                                                                                             a;Xe     �   )   +   w      \      | Primary trade                     | General Contractor                             |5�_�                    -   6    ����                                                                                                                                                                                                                                                                                                                                                             a;Xg     �   ,   .   w      \      | Trade ratio                       | {"General Contractor" => 50, "Roofing" => 50 } |5�_�                    9        ����                                                                                                                                                                                                                                                                                                                            9   7       A   7       V   7    a;Xk     �   8   9       	   U  Scenario Outline: Markel Insurance Company quotes Contractors - subcontracted - noc   =    Given I provide a valid Usa 'General liability' RFQ with:   @      | Primary trade                     | General contractor |   @      | General contractor classification | yes                |   @      | Use subcontractors                | yes                |   �    Then the reasons for referral <include_do_not_include> the message "This insurer does not support this trade: <trade>" from "Markel Insurance Company"       Examples:   D      | trade                             | include_do_not_include |   D      | Contractors - subcontracted - noc | do_not_include         |5�_�                    9        ����                                                                                                                                                                                                                                                                                                                            9   7       9   7       V   7    a;Xl     �   8   9           5�_�                    O       ����                                                                                                                                                                                                                                                                                                                            S          O          V       a;Xq     �   N   O          P      | Appliance and accessories installation and repair - commercial         |   P      | Appliance and accessories installation and repair - household          |   P      | Carpet, rug, furniture or upholstery cleaning - on customers' premises |   P      | Carpet, rug or upholstery cleaning - shop only                         |   P      | Combined heating and air conditioning installation and repair (HVAC)   |5�_�                    d   p    ����                                                                                                                                                                                                                                                                                                                            O          O          V       a;X�     �   c   e   h      �    Then the reasons for referral include the message "This insurer does not support this trade: <primary_trade>" from "Markel Insurance Company"5�_�                    g       ����                                                                                                                                                                                                                                                                                                                            O          O          V       a;X�     �   f   g          P      | Carpet, rug, furniture or upholstery cleaning - on customers' premises |5�_�      	              g       ����                                                                                                                                                                                                                                                                                                                            O          O          V       a;X�     �   f              P      | Carpet, rug or upholstery cleaning - shop only                         |5�_�      
           	   g       ����                                                                                                                                                                                                                                                                                                                            g          g   5          5    a;X�     �   f              P      | jjhjhhj rug or upholstery cleaning - shop only                         |�   g            5�_�   	              
   g        ����                                                                                                                                                                                                                                                                                                                            g          g   )          5    a;X�    �   f   h          D      | Trucking & transportation services                         |�   e   g          P      | primary_trade                                                          |5�_�   
                 T   )    ����                                                                                                                                                                                                                                                                                                                            b   )       T   )       V   )    a;X�     �   S   T          g      | Sale of general items                                                      | no               |   g      | Pool law                                                                   | yes              |   g      | Warranty                                                                   | no               |   g      | Diving board                                                               | no               |   g      | General contractor classification                                          | yes              |   g      | Window cleaning ineligible operations                                      | no               |   g      | Heating and air conditioning installation and repair ineligible operations | no               |   g      | Residential or commercial work                                             | Residential work |   g      | Appliance installation classification                                      | Your shop        |   g      | Furniture manufacturing                                                    | no               |   g      | Interior or exterior                                                       | no               |   g      | Carpet rug furniture or upholstery cleaning on premises                    | no               |   g      | Residential cleaning                                                       | no               |   g      | Spray painting                                                             | no               |   g      | Auto snow removal                                                          | no               |5�_�                    S       ����                                                                                                                                                                                                                                                                                                                            T   )       T   )       V   )    a;X�     �   R   S          g      | Primary trade                                                              | <primary_trade>  |   ;    And the feature flag "markel_appetite_expansion" is off5�_�                    <       ����                                                                                                                                                                                                                                                                                                                            J          <          V       a;X�     �   ;   <          g      | Sale of general items                                                      | no               |   g      | Pool law                                                                   | yes              |   g      | Warranty                                                                   | no               |   g      | Diving board                                                               | no               |   g      | General contractor classification                                          | yes              |   g      | Window cleaning ineligible operations                                      | no               |   g      | Heating and air conditioning installation and repair ineligible operations | no               |   g      | Residential or commercial work                                             | Residential work |   g      | Appliance installation classification                                      | Your shop        |   g      | Furniture manufacturing                                                    | no               |   g      | Interior or exterior                                                       | no               |   g      | Carpet rug furniture or upholstery cleaning on premises                    | no               |   g      | Residential cleaning                                                       | no               |   g      | Spray painting                                                             | no               |   g      | Auto snow removal                                                          | no               |5�_�                    ;        ����                                                                                                                                                                                                                                                                                                                            <          <          V       a;X�     �   :   <          g      | Primary trade                                                              | <primary_trade>  |5�_�                    @        ����                                                                                                                                                                                                                                                                                                                            <          <          V       a;X�    �   ?   A          P      | Masonry work                                                           |�   >   @          P      | primary_trade                                                          |5�_�                    C        ����                                                                                                                                                                                                                                                                                                                            ;          ;          V       a;X�    �   C   E   G    �   C   D   G    5�_�                            ����                                                                                                                                                                                                                                                                                                                                      %          V       a;X�     �                v      | Combined heating and air conditioning installation and repair (HVAC)                | do_not_include         |   v      | Carpentry - interior                                                                | do_not_include         |   v      | Cleaning - outside surfaces of buildings and other exterior surfaces                | do_not_include         |   v      | Electrical work - within buildings                                                  | do_not_include         |   v      | Electrical apparatus - installation, servicing or repair                            | do_not_include         |   v      | Handyperson                                                                         | do_not_include         |   v      | General contractor                                                                  | do_not_include         |   v      | Masonry work                                                                        | do_not_include         |   v      | Metal erection - decorative or artistic                                             | do_not_include         |   v      | Metal erection - in the construction of dwellings not exceeding 2 stories in height | do_not_include         |   v      | Metal erection - frame structures, iron work on outside of buildings                | do_not_include         |   v      | Online retailers                                                                    | do_not_include         |   v      | Painting and wall covering contractors                                              | do_not_include         |   v      | Residential building construction                                                   | do_not_include         |   v      | Remodeling                                                                          | do_not_include         |   v      | Nonresidential building construction                                                | do_not_include         |   v      | Plastering or stucco work                                                           | do_not_include         |   v      | Sheet metal work - outside                                                          | do_not_include         |   v      | Siding installation                                                                 | do_not_include         |5�_�                           ����                                                                                                                                                                                                                                                                                                                                                V       a;X�    �                f      | Interior or exterior                                                       | Interior        |5�_�                     0       ����                                                                                                                                                                                                                                                                                                                                                V       a;Y%    �   0   2   4    �   0   1   4    5��