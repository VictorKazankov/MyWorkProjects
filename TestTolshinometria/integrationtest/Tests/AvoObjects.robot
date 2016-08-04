*** Settings ***
Documentation    Suite testing add, edit and delete measurement in AVO list

Suite Setup  session

Library  RequestsLibrary
Library  BuiltIn
Library  Collections
Library  ../Libs/TestMethodList.py

Resource  ../Resource/Avo/AvoKeywords.robot
Resource  ../Resource/Avo/AvoVariables.robot


*** Test Cases ***

Authorization
    [Documentation]   Loging of user to system
    [Tags]   Smoke
    Given session
    When Login
    Then login is correct

GetFullTree
    [Documentation]   Verify that object count is correct in tree
    Given HomePageThickness
    When TakeBody
    Then CountElementsTrue more


GetDeviceMeasurement
    [Documentation]  Verify that measuring device > 0 when create new measurement
    Given HomePageThickness
    When GetMeasuring device
    Then Measuring devices more null


GetBendListWithMeasuresForAVO
    [Documentation]  Verify that bends > 0 when create new measurement AVO type
    Given HomePageThickness
    When GetListBendsAVO
    Then Bend objects more null


SaveNewMeasurementToMeasurementListForAVO
    [Documentation]  Add measurement
    Given HomePageThickness
    When GetCountMeasurementInList
    ${oldList} =  Get variable value  ${countMeasurementsInList}
    And SendDataNewMeasurement
    And GetCountMeasurementInList
    ${newList} =  Get variable value  ${countMeasurementsInList}
    Then New measurement added to list


EditMeasurementInAvoList
    [Documentation]  Update measurement
    Given HomePageThickness
    When EditNewDataForMeasurement
    Then MeasurementIsUpdate


DeleteMeasurementInAvoList
    [Documentation]  Deleted measurement
    Given HomePageThickness
    When GetCountMeasurementInList
    ${oldList} =  Get variable value  ${countMeasurementsInList}
    And DeleteMeasurement
    And GetCountMeasurementInList
    ${newList} =  Get variable value  ${countMeasurementsInList}
    Then MeasurementDeletedFromList



#GetBendListWithMeasuresForGPA
 #   [Documentation]  Verify that bends > 0 when create new measurement PGA type
  #  Given HomePageThickness
   # When GetListBendsPGA
    #Then Bend objects more null