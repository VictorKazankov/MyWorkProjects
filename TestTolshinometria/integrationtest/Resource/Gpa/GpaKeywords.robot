*** Keywords ***
session
     create ntlm session  urlTol   ${server}  ${domain}

login
    ${headers} =  Create Dictionary  Content-Type  application/x-www-form-urlencoded
    ${data} =   Create Dictionary  p_cpwd=NTQxNkQ3Q0Q2RUYxOTVBMEY3NjIyQTlDNTZCNTVFODQ=  p_nssid=29510699994  p_clogin=lena
    get  urlTol   /
    ${resp} =  Post  urlTol  /fl/auth  data=${data}  headers=${headers}
    Set global variable  ${resp}  ${resp}

Login is correct
    Should Not Contain	${resp.url}  /fl/main


HomePageThickness
    ${resp} =  get  urlTol  //TM/TM.jsp


GetListBendsGPA
    ${getListBendsObjects} =  get   urlTol  /orawci/v6/getxmlbysql?subsystem=${subsystemKey}&inType=2&isCompress=0&inSQL=gmt_mapd.TM_API.getBendListWithMeasurement(10506906539959,34,-1)
    ${bodyTextListBends} =  get body text  ${getListBendsObjects}
    Set global variable  ${bodyTextListBends}  ${bodyTextListBends}


Bend objects more null
    assert isObject  ${bodyTextListBends}



GetCountMeasurementInList
    ${getMeasurementListGpa} =  get   urlTol  /orawci/v6/getxmlbysql?inSQL=gmt_mapd.TM_API.getMeasurementList(10506906539959,34)&subsystem=${subsystemKey}&isCompress=0&inType=2
    ${bodyTextMeasurementList} =  get body text  ${getMeasurementListGpa}
    ${countMeasurementsInList} =  get count measurement  ${bodyTextMeasurementList}
    Set global variable  ${countMeasurementsInList}  ${countMeasurementsInList}
