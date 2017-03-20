Feature: Create New Property

  As a register user of the system
  I want to be able to create a new property
  So that the property records are up to date.

  # CREATE NEW PROPERTY SCREEN #

  @Sanity @PropertyTax
  Scenario Outline: Registered user creating a new property in the system

    Given juniorAssistant logs in
    And user will select the required screen as "Create New Property"
    And he enters property header details as <propertyHeaderDetails>
    And he enters owner details for the first owner as <ownerDetails>
    And he enters property address details as <propertyAddressDetails>
    And he enters assessment details as <assessmentDetails>

    And he enters amenities as <amenitiesDetails>
    And he enters construction type details as <constructionTypeDetails>
    And he enters floor details as <floorDetails>
    And he click on floors Details entered
    And he enters document type details as <documentDetails>
    And he forwards for approval to billCollector
    And he will copy the acknowledgement message with assessment number createProperty-create
    Then user will be notified by "Successfully"
    And current user logs out

    When billCollector logs in
    And he chooses to act upon above assessment number
    And he forwards for approval to revenueInspector
    And current user closes acknowledgement
    And current user logs out

    When revenueInspector logs in
    And he chooses to act upon above assessment number
    And he forwards for approval to revenueOfficer
    And current user closes acknowledgement
    And current user logs out

    When revenueOfficer logs in
    And he chooses to act upon above assessment number
    And he forwards for approval to commissioner
    And current user closes acknowledgement
    And current user logs out

    When commissioner logs in
    And he chooses to act upon above assessment number
    And he approved the property with remarks "property approved"
    Then create property details get saved successfully by generating assesssment number
    And he will copy the acknowledgement message with assessment number createProperty-forward
    Then user will be notified by "Successfully"

    And he chooses to act upon above assessment number
    And he does a digital signature
    When commissioner closes acknowledgement
    And current user logs out

    And juniorAssistant logs in
    And he chooses to act upon above assessment number
    And he generates a notice
    And current user logs out

    Examples:
      | propertyHeaderDetails | ownerDetails | propertyAddressDetails | assessmentDetails     | amenitiesDetails | constructionTypeDetails | floorDetails | documentDetails |
      | residentialPrivate    | bimal        | addressOne             | assessmentNewProperty | all              | defaultConstructionType | firstFloor   | documentSelect  |

   # DATA ENTRY SCREEN #

  @Sanity @PropertyTax
  Scenario: Registered user create property through data entry screen

    Given commissioner logs in
    And user will select the required screen as "Data entry screen" with condition as "ptis"
    And he creates a new assessment for a private residential property
    Then dataEntry Details saved successfully
    And he choose to add edit DCB
    And he choose to close the dataentry acknowledgement screen
    And current user logs out

   # ADDITION ALTERATION SCREEN #

  @Sanity @PropertyTax
  Scenario Outline: Registered user Update existing property

    Given commissioner logs in
    And user will select the required screen as "Data entry screen" with condition as "ptis"
    And he creates a new assessment for a private residential property
    Then dataEntry Details saved successfully
    And he choose to add edit DCB
    And he choose to close the dataentry acknowledgement screen
    And current user logs out

    Given juniorAssistant logs in
    And user will select the required screen as "Addition/Alteration of Assessment"
    And he searches for assessment with number
    And he updates assessment details as <editAssessmentDetails>
    And he enters amenities as <amenitiesDetails>
    And he enters Floor Details as <editFloorDetails>
    And he forwards for approval to billCollector
    And he will copy the acknowledgement message with assessment number modifyProperty-forward
    Then user will be notified by "successfully"
    And current user logs out

    When billCollector logs in
    And he chooses to act upon above assessment number
    And he forwards for approval to revenueInspector
    And current user closes acknowledgement
    And current user logs out

    When revenueInspector logs in
    And he chooses to act upon above assessment number
    And he forwards for approval to revenueOfficer
    And current user closes acknowledgement
    And current user logs out

    When revenueOfficer logs in
    And he chooses to act upon above assessment number
    And he forwards for approval to commissioner
    And current user closes acknowledgement
    And current user logs out

    When commissioner logs in
    And he chooses to act upon above assessment number
    And he approved the property with remarks addition "property approved"
    And current user closes acknowledgement

    And he chooses to act upon above assessment number
    And he does a digital signature

    When commissioner closes acknowledgement
    And current user logs out

    And juniorAssistant logs in
    And he chooses to act upon above assessment number
    And he generates a notice
    And current user logs out

    Examples:
      | editAssessmentDetails      | amenitiesDetails | editFloorDetails             |
      | assessmentAdditionProperty | all              | firstFloorAdditionaltaration |

  # TRANSFER OF OWNERSHIP SCREEN #

  @Sanity @PropertyTax
  Scenario Outline: Register Choose to do title Transfer

    Given commissioner logs in
    And user will select the required screen as "data entry screen" with condition as "ptis"
    And he creates a new assessment for a private residential property
    Then dataEntry Details saved successfully
    And he choose to add edit DCB
    And he choose to close the dataentry acknowledgement screen
    And current user logs out

    Given juniorAssistant logs in
    And user will select the required screen as "collect tax"
    And he searches for assessment with number
    And he chooses to pay tax
    And he pay tax using Cash

    And user will select the required screen as "Transfer Ownership"
    And he searches for assessment with number
    And he chooses Registration already done button
    And he enters registration details for the property <registrationDetails>
    And he enters enclosure details

    And he forwards for approval to billCollector
    And he will copy the acknowledgement message with assessment number title
    And user will be notified by "successfully"
    And current user logs out

    When billCollector logs in
    And he chooses to act upon above assessment number
    And he forwards for approval to revenueInspector
    And current user closes acknowledgement
    And current user logs out

    When revenueInspector logs in
    And he chooses to act upon above assessment number
    And he forwards for approval to revenueOfficer
    And current user closes acknowledgement
    And current user logs out

    Given juniorAssistant logs in
    And user will select the required screen as "Property Mutation Fee"
    And he searches for the assessment with mutation assessment number
    And he pay tax using Cash
    And current user logs out

    When revenueOfficer logs in
    And he chooses to act upon above assessment number
    And he forwards for approval to commissioner
    And current user closes acknowledgement
    And current user logs out

    When commissioner logs in
    And he chooses to act upon above assessment number
    And he approved the property with remarks "property approved" for transfer of ownership
    And current user closes acknowledgement

    And he chooses to act upon above assessment number
    And he does a digital signature

    When commissioner closes acknowledgement
    And current user logs out

    And juniorAssistant logs in
    And he chooses to act upon above assessment number
    And he generate title transfer notice
    And current user logs out

    Examples:
      | registrationDetails |
      | register            |

  # CREATE REVISION PETITION SCREEN #

  @Sanity @PropertyTax
  Scenario Outline: Register user choose to do revision petition of property

    Given juniorAssistant logs in
    And user will select the required screen as "Create new property" with condition as "ptis"
    And he enters property header details as <propertyHeaderDetails>
    And he enters owner details for the first owner as <ownerDetails>
    And he enters property address details as <propertyAddressDetails>
    And he enters assessment details as <assessmentDetails>

    And he enters amenities as <amenitiesDetails>
    And he enters construction type details as <constructionTypeDetails>
    And he enters floor details as <floorDetails>
    And he click on floors Details entered
    And he enters document type details as <documentDetails>
    And he forwards for approval to billCollector
    And he will copy the acknowledgement message with assessment number createProperty-create
    And user will be notified by "Successfully"
    And current user logs out

    When billCollector logs in
    And he chooses to act upon above assessment number
    And he forwards for approval to revenueInspector
    And current user closes acknowledgement
    And current user logs out

    When revenueInspector logs in
    And he chooses to act upon above assessment number
    And he forwards for approval to revenueOfficer
    And current user closes acknowledgement
    And current user logs out

    When revenueOfficer logs in
    And he chooses to act upon above assessment number
    And he forwards for approval to commissioner
    And current user closes acknowledgement
    And current user logs out

    When commissioner logs in
    And he chooses to act upon above assessment number
    And he approved the property with remarks "property approved"
    And he will copy the acknowledgement message with assessment number createProperty-forward
    Then user will be notified by "Successfully"

    And he chooses to act upon above assessment number
    And he does a digital signature
    When commissioner closes acknowledgement
    And current user logs out

    And juniorAssistant logs in
    And he chooses to act upon above assessment number
    And he generates a notice

    And user will select the required screen as "Create Revision Petition"
    And he search for assessment from commissioner screen
    And he choose revision petition header
    And he enters revision petition details<revisionPetitionDetails>
    And he forwards for approval to commissioner
    And current user closes acknowledgement
    And current user logs out

    When commissioner logs in
    And he chooses to act upon above assessment number
    And he choose revision petition header
    And he enters hearing details<hearingDetails>
    And current user closes acknowledgement
    And current user logs out

    And juniorAssistant logs in
    And he chooses to act upon above assessment number
    And he choose revision petition header
    And he enters approver remark
    And he forwards for approval to revenueInspector
    And current user closes acknowledgement
    And current user logs out

    When revenueInspector logs in
    And he chooses to act upon above assessment number
    And he enters reason for modification
    And he choose revision petition header
    And he enters inspection details

    And he forwards for approval to revenueOfficer
    And current user closes acknowledgement
    And current user logs out

    When revenueOfficer logs in
    And he chooses to act upon above assessment number
    And he choose revision petition header
    And he enters approver remark
    And he forwards for approval to commissioner
    And current user closes acknowledgement
    And current user logs out

    When commissioner logs in
    And he chooses to act upon above assessment number
    And he choose to approve for revision petition
    And current user closes acknowledgement

    And he chooses to act upon above assessment number
    And he prints endoresement notice

    And he chooses to act upon above assessment number
    And he does a digital signature

    When commissioner closes acknowledgement
    And current user logs out

    And juniorAssistant logs in
    And he chooses to act upon above assessment number
    And he generates a print special notice
    And current user logs out

    Examples:
      | propertyHeaderDetails | ownerDetails | propertyAddressDetails | assessmentDetails     | amenitiesDetails | constructionTypeDetails | floorDetails | revisionPetitionDetails | hearingDetails | documentDetails |
      | residentialPrivate    | bimal        | addressOne             | assessmentNewProperty | all              | defaultConstructionType | firstFloor   | revisionpetitionBlock   | hearingBlock   | documentSelect  |


    # GENERAL REVISION PETITION SCREEN #

  @Sanity @PropertyTax
  Scenario Outline: Register user choose to do general revision petition of property

    Given commissioner logs in
    And user will select the required screen as "Data entry screen" with condition as "ptis"
    And he creates a new assessment for a private residential property
    Then dataEntry Details saved successfully
    And he choose to add edit DCB
    And he choose to close the dataentry acknowledgement screen
    And current user logs out

    Given juniorAssistant logs in
    And user will select the required screen as "collect tax"
    And he searches for assessment with number
    And he chooses to pay tax
    And he pay tax using Cash

    And user will select the required screen as "General Revision Petition"
    And he searches for assessment with number

    And he choose revision petition header
    And he enters revision petition details<revisionPetitionDetails>
    And he forwards for approval to commissioner
    And current user closes acknowledgement
    And current user logs out

    When commissioner logs in
    And he chooses to act upon above assessment number
    And he choose revision petition header
    And he enters hearing details<hearingDetails>
    And current user closes acknowledgement
    And current user logs out

    And juniorAssistant logs in
    And he chooses to act upon above assessment number
    And he choose revision petition header
    And he enters approver remark
    And he forwards for approval to revenueInspector
    And current user closes acknowledgement
    And current user logs out

    When revenueInspector logs in
    And he chooses to act upon above assessment number
    And he enters reason for modification
    And he choose revision petition header
    And he enters inspection details

    And he forwards for approval to revenueOfficer
    And current user closes acknowledgement
    And current user logs out

    When revenueOfficer logs in
    And he chooses to act upon above assessment number
    And he choose revision petition header
    And he enters approver remark
    And he forwards for approval to commissioner
    And current user closes acknowledgement
    And current user logs out

    When commissioner logs in
    And he chooses to act upon above assessment number
    And he choose to approve for revision petition
    And current user closes acknowledgement

    And he chooses to act upon above assessment number
    And he prints endoresement notice

    And he chooses to act upon above assessment number
    And he does a digital signature

    When commissioner closes acknowledgement
    And current user logs out

    And juniorAssistant logs in
    And he chooses to act upon above assessment number
    And he generates a print special notice
    And current user logs out

    Examples:
      | revisionPetitionDetails | hearingDetails |
      | revisionpetitionBlock   | hearingBlock   |


    # DEMOLITION OF PROPERTY SCREEN #

  @Sanity @PropertyTax
  Scenario Outline: Register user choose to do demolition of property

    Given commissioner logs in
    And user will select the required screen as "Data entry screen" with condition as "ptis"
    And he creates a new assessment for a private residential property
    Then dataEntry Details saved successfully
    And he choose to add edit DCB
    And he choose to close the dataentry acknowledgement screen
    And current user logs out

    Given juniorAssistant logs in
    And user will select the required screen as "collect tax"
    And he searches for assessment with number
    And he chooses to pay tax
    And he pay tax using Cash

    And user will select the required screen as "Demolition"
    And he searches for assessment with number
    And he enters demolition details as <demolition Details>

    And he forwarding for approval to bill_Collector
    And he will copy the acknowledgement message with application number propertyAckForm
    Then user will be notified by "successfully"
    And current user logs out

    When bill_Collector logs in
    And he chooses to act upon above application number
    And he forwarding for approval to revenue_Inspector
    And current user closes tax exemption acknowledgement
    And current user logs out

    When revenue_Inspector logs in
    And he chooses to act upon above application number
    And he forwarding for approval to revenue_Officer
    And current user closes tax exemption acknowledgement
    And current user logs out

    When revenue_Officer logs in
    And he chooses to act upon above application number
    And he forwarding for approval to commissioner1
    And current user closes tax exemption acknowledgement
    And current user logs out

    When commissioner logs in
    And he chooses to act upon above assessment number
    And he approved the property with remarks "property approved"
    And current user closes tax exemption acknowledgement
#    Then user will be notified by "Successfully"
    And he chooses to act upon above assessment number
    And he does a digital signature
    When commissioner closes acknowledgement
    And current user logs out

    And juniorAssistant logs in
    And he chooses to act upon above assessment number
    And he generates a notice
    And current user logs out

    Examples:
      |demolition Details|
      | demolitionBlock  |

    # TAX EXEMPTION OF PROPERTY #

  @Sanity @PropertyTax
  Scenario: Registered user choose to do tax exemption of property

  Given commissioner logs in
  And user will select the required screen as "Data entry screen" with condition as "ptis"
  And he creates a new assessment for a private residential property
  Then dataEntry Details saved successfully
  And he choose to add edit DCB
  And he choose to close the dataentry acknowledgement screen
  And current user logs out

  Given juniorAssistant logs in
  And user will select the required screen as "collect tax"
  And he searches for assessment with number
  And he chooses to pay tax
  And he pay tax using Cash

  And user will select the required screen as "Tax Exemption"
  And he searches for assessment with number
  And he selects the exemption reason from drop down
  And he forwarding for approval to bill_Collector
  And he will copy the acknowledgement message with application number propertyAckForm
  Then user will be notified by "successfully"
  And current user logs out

  When bill_Collector logs in
  And he chooses to act upon above application number
  And he forwarding for approval to revenue_Inspector
  And current user closes tax exemption acknowledgement
  And current user logs out

  When revenue_Inspector logs in
  And he chooses to act upon above application number
  And he forwarding for approval to revenue_Officer
  And current user closes tax exemption acknowledgement
  And current user logs out

  When revenue_Officer logs in
  And he chooses to act upon above application number
  And he forwarding for approval to commissioner1
  And current user closes tax exemption acknowledgement
  And current user logs out

   When commissioner logs in
   And he chooses to act upon above assessment number
   And he approved the property with remarks "property approved"
   And current user closes tax exemption acknowledgement
#  Then user will be notified by "Successfully"
   And he chooses to act upon above assessment number
   And he does a digital signature
   When commissioner closes acknowledgement
   And current user logs out

   And juniorAssistant logs in
   And he chooses to act upon above assessment number
   And he generates a notice
   And current user logs out


  # AMALGAMATION OF PROPERTY #

  @Sanity @PropertyTax
  Scenario: Registered user choose to do amalgamation of property

  Given commissioner logs in
  And user will select the required screen as "Data entry screen" with condition as "ptis"
  And he creates a new assessment for a private residential property
  Then dataEntry Details saved successfully
  And he choose to add edit DCB
  And he choose to close the dataentry acknowledgement screen
  And current user logs out

  Given juniorAssistant logs in
  And user will select the required screen as "collect tax"
  And he searches for assessment with number
  And he chooses to pay tax
  And he pay tax using Cash
  And user will select the required screen as "Amalgamation of Property"
  And he searches for assessment with number
  And he search for the Amalgamated Properties
  And he forwards for approval to billCollector
  And current user closes tax exemption acknowledgement
  And current user logs out

  When billCollector logs in
  And he chooses to act upon above assessment number
  And he forwards for approval to revenueInspector
  And current user closes tax exemption acknowledgement
  And current user logs out

  When revenueInspector logs in
  And he chooses to act upon above assessment number
  And he forwards for approval to revenueOfficer
  And current user closes tax exemption acknowledgement
  And current user logs out

  When revenueOfficer logs in
  And he chooses to act upon above assessment number
  And he forwards for approval to commissioner
  And current user closes tax exemption acknowledgement
  And current user logs out

  When commissioner logs in
  And he chooses to act upon above assessment number
  And he approved the property with remarks "amalgamation-approve"
  And current user closes tax exemption acknowledgement
  And he chooses to act upon above assessment number
  And he does a digital signature
  When commissioner closes acknowledgement
  And current user logs out

  And juniorAssistant logs in
  And he chooses to act upon above assessment number
  Then he generates a notice
  And current user logs out


  # BIFURCATION OF PROPERTY #

  @Sanity @PropertyTax
  Scenario Outline: Register user choose to do bifurcation of property

    Given juniorAssistant logs in
    And user will select the required screen as "Create new property" with condition as "ptis"
    And he enters property header details as <propertyHeaderDetails>
    And he enters owner details for the first owner as <ownerDetails>
    And he enters property address details as <propertyAddressDetails>
    And he enters bifurcation assessment details as <bifurcationDetails>

    And he enters amenities as <amenitiesDetails>
    And he enters construction type details as <constructionTypeDetails>
    And he enters floor details as <floorDetails>
    And he click on floors Details entered
    And he enters document type details as <documentDetails>
    And he forwards for approval to billCollector
    And he will copy the acknowledgement message with assessment number createProperty-create
    And user will be notified by "Successfully"
    And user will select the required screen as "Bifurcation of Assessment"
    And he enters parent bifurcated assessment number as <bifurcationDetails>

    And he forwards for approval to billCollector
    And he will copy the acknowledgement message with assessment number modifyProperty-forward
    Then user will be notified by "Successfully"
    And current user logs out

    When billCollector logs in
    And he chooses to act upon above assessment number
    And he forwards for approval to revenueInspector
    And current user closes acknowledgement
    And current user logs out

    When revenueInspector logs in
    And he chooses to act upon above assessment number
    And he forwards for approval to revenueOfficer
    And current user closes acknowledgement
    And current user logs out

    When revenueOfficer logs in
    And he chooses to act upon above assessment number
    And he forwards for approval to commissioner
    And current user closes acknowledgement
    And current user logs out

    When commissioner logs in
    And he chooses to act upon above assessment number
    And he approved the property with remarks addition "property approved"
    And current user closes acknowledgement

    And he chooses to act upon above assessment number
    And he does a digital signature

    When commissioner closes acknowledgement
    And current user logs out

    And juniorAssistant logs in
    And he chooses to act upon above assessment number
    And he generates a notice
    And current user logs out

    Examples:
      | propertyHeaderDetails | ownerDetails | propertyAddressDetails | bifurcationDetails    | amenitiesDetails | constructionTypeDetails | floorDetails |    documentDetails |
      | residentialPrivate    | bimal        | addressOne             | bifurcationProperty   | all              | defaultConstructionType | firstFloor   |    documentSelect  |


   # VACANCY REMISSION OF PROPERTY SCREEN #

  @Sanity @PropertyTax
  Scenario: Registered user create property through data entry screen and do Vacancy Remission

    Given commissioner logs in
    And user will select the required screen as "Data entry screen" with condition as "ptis"
    And he creates a new assessment for a private residential property
    Then dataEntry Details saved successfully
    And he choose to add edit DCB
    And he choose to close the dataentry acknowledgement screen
    And current user logs out

    Given juniorAssistant logs in
    And user will select the required screen as "collect tax"
    And he searches for assessment with number
    And he chooses to pay tax
    And he pay tax using Cash

    And user will select the required screen as "Vacancy Remission"
    And he searches for assessment with number
    And he enters the Vacancy Remission Details
    And he forwarding for approval to commissioner1
    And he will copy the acknowledgement message with application number vacancyRemissionAckForm
    And current user logs out

    When commissioner logs in
    And he chooses to act upon above assessment number
    And he forward application to the junior assistant and closes acknowledgement
    And current user logs out

    When juniorAssistant logs in
    And he chooses to act upon above assessment number
    And he forwarding for approval to bill_Collector
    And current user closes tax exemption acknowledgement
    And current user logs out

    When bill_Collector logs in
    And he chooses to act upon above application number
    And he forwarding for approval to revenue_Inspector
    And current user closes tax exemption acknowledgement
    And current user logs out

    When revenue_Inspector logs in
    And he chooses to act upon above application number
    And he approved the property with remarks "vacancy remission approved"
    And current user closes tax exemption acknowledgement
    Then user will be notified by "Successfully"
    And current user logs out

