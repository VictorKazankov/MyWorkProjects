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


TakeBody
    ${getRequestFullTree} =  get   urlTol   /orawci/v6/getxmlbysql?inType=2&subsystem=${subsystemKey}&isCompress=0&inSQL=gmt_mapd.TM_API.getFullTree
    ${body_text} =  get body text  ${getRequestFullTree}
    Set global variable  ${body_text}  ${body_text}


CountElementsTrue more
    assert elements count  ${body_text}


GetMeasuring device
    ${getListDeviseMeasurement} =  get  urlTol  /orawci/v6/getxmlbysql?subsystem=${subsystemKey}&inType=2&isCompress=0&inSQL=gmt_mapd.TM_API.getDeviceMeasurement()
    ${bodyTextListDevise} =  get body text  ${getListDeviseMeasurement}
    Set global variable  ${bodyTextListDevise}  ${bodyTextListDevise}


Measuring devices more null
    assert isObject  ${bodyTextListDevise}


GetListBendsAVO
    ${getListBendsObjects} =  get   urlTol  /orawci/v6/getxmlbysql?subsystem=${subsystemKey}&inType=2&isCompress=0&inSQL=gmt_mapd.TM_API.getBendListWithMeasurement(10511120139959,6,-1)
    ${bodyTextListBends} =  get body text  ${getListBendsObjects}
    Set global variable  ${bodyTextListBends}  ${bodyTextListBends}

Bend objects more null
    assert isObject  ${bodyTextListBends}


GetCountMeasurementInList
    ${getMeasurementListAvo} =  get   urlTol  /orawci/v6/getxmlbysql?inSQL=gmt_mapd.TM_API.getMeasurementList(10511120139959,6)&subsystem=${subsystemKey}&isCompress=0&inType=2
    ${bodyTextMeasurementList} =  get body text  ${getMeasurementListAvo}
    ${countMeasurementsInList} =  get count measurement  ${bodyTextMeasurementList}
    Set global variable  ${countMeasurementsInList}  ${countMeasurementsInList}

SendDataNewMeasurement
    ${saveDataMeasurement} =  Create Dictionary   inSQL=gmt_mapd.TM_API.modifyMeasurement(${nMeasurementKeyNew},${nObjectKey},${nTypeKey},${nControlData},'${cWorkCarriedOut}',${nMeasureDeviceKey},'${cParametersNew}')  isCompress=0  inType=2  subsystem=${subsystemKey}
    ${resultSaveMeasurement} =  Post  urlTol  /orawci/v6/getxmlbysql  data=${saveDataMeasurement}
    ${textResponseHTML} =  get body text  ${resultSaveMeasurement}
    ${numberNewMeasurement} =  get number measurement  ${textResponseHTML}
    Set global variable  ${numberNewMeasurement}  ${numberNewMeasurement}
    #Set global variable  ${resultSaveMeasurement}  ${resultSaveMeasurement}

New measurement added to list
    Run Keyword If   '${newList}' > '${oldList}'   log to console  \nNew measurement added to list


EditNewDataForMeasurement
    ${updateDataMeasurement} =  Create Dictionary  	inSQL=gmt_mapd.TM_API.modifyMeasurement(${numberNewMeasurement},${nObjectKey},${nTypeKey},${nControlData},'${cWorkCarriedOutEdit}',${nMeasureDeviceKey},'${cParametersEdit}')  isCompress=0  inType=2  subsystem=${subsystemKey}
    ${resultUpdateMeasurement} =  Post  urlTol  /orawci/v6/getxmlbysql  data=${updateDataMeasurement}
    ${textResponseHTML} =  get body text  ${resultUpdateMeasurement}
    ${numberUpdateMeasurement} =  get number measurement  ${textResponseHTML}
    Set global variable  ${numberUpdateMeasurement}  ${numberUpdateMeasurement}


MeasurementIsUpdate
    Should Not Be Empty   ${numberUpdateMeasurement}


DeleteMeasurement
    ${numberDeletedMeasurement} =  get   urlTol   /orawci/v6/getxmlbysql?inSQL=gmt_mapd.TM_API.dropMeasurement(${numberUpdateMeasurement})&inType=2&subsystem=${subsystemKey}&isCompress=0
    Log  ${numberDeletedMeasurement}


MeasurementDeletedFromList
    Run Keyword If   '${newList}' < '${oldList}'   log to console  \nMeasurement deleted from list