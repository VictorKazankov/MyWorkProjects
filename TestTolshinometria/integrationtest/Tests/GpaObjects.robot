*** Settings ***
Documentation    Suite testing add, edit and delete measurement in GPA list

Suite Setup  session

Library  RequestsLibrary
Library  BuiltIn
Library  Collections
Library  ../Libs/TestMethodList.py

Resource  ../Resource/Gpa/GpaKeywords.robot
Resource  ../Resource/Gpa/GpaVariables.robot

*** Test Cases ***
Authorization
    [Documentation]   Loging of user to system
    [Tags]   Smoke
    Given session
    When Login
    Then login is correct


GetBendListWithMeasuresForGPA
    [Documentation]  Verify that bends > 0 when create new measurement AVO type
    Given HomePageThickness
    When GetListBendsGPA
    Then Bend objects more null


AddMeasurementToMeasurementListForGPA
    [Documentation]  Add measurement
    Given HomePageThickness
    When GetCountMeasurementInList
    ${oldList} =  Get variable value  ${countMeasurementsInList}
    And SendDataNewMeasurement
    And GetCountMeasurementInList
    ${newList} =  Get variable value  ${countMeasurementsInList}
    Then New measurement added to list
