Vim�UnDo� P����e8$S��4I׋K�"?$�1�#�  �                                   a	�9    _�                     �        ����                                                                                                                                                                                                                                                                                                                           �         �          V       a	�8    �  �  �          >  Scenario Outline: Elements will not offer portable equipment   .    Given I provide a valid business RFQ with:   A      | key                                  | value            |   A      | Portable equipment sum insured       | <limit>          |   A      | Have secondary trade                 | no               |   A      | UK postcode                          | EC2A 1AE         |   A      | Years trading                        | Less than 1 year |   A      | Business type                        | Partnership      |   A      | Partners EL                          | no               |   A      | Have employees                       | no               |   A      | Total partners                       | 2                |   A      | Include contents                     | yes              |   A      | Contents sum insured                 | 5000             |   A      | Equipment away from risk address     | yes              |   A      | Clerical partners                    | 1                |   A      | Total employees                      | 1                |   A      | Clerical employees                   | 0                |   A      | Primary trade                        | Photographer     |   A      | SoF underwater or aerial photography | no               |   '    When I receive the insurer response   5    Then I will be quoted the following tech premiums   (      | cover              | premium   |   (      | Portable equipment | <premium> |           Examples:         | limit | premium   |         | 1000  | £5,000.00 |         | 2000  | £5,000.00 |5��