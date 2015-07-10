/**************************************************************************/
/* 1. 프 로 그 램 id : t_WFLDeptForeR(현장별경영계획전망수립)
/* 2. 유형(시나리오) : 
/* 3. 기  능  정  의 : 프로그램 설명 
/* 4. 변  경  이  력 : 김흥수 작성(2006-01-16)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/
var			bEnter = false;
var			s1 = 
"	<FG> Name='기본사항' id='G1' \n" +
"	<C> Name=현장명 ID=DEPT_NAME Width=120 suppress=1\n" +
"	</C>\n" +
"	<C> Name=항목명 ID=LEVELED_NAME Width=120 suppress=2 \n" +
"	</C> \n" +
"	<C> Name=구분 ID=SUBTITLE_NAME Align=Center Width=40   \n" +
"	</C> \n" +
"	</FG> \n" +
"	<G> Name='전월실적' id='G2' \n" +
"		<C> Name='누    계' ID=EXEC_AMT	Width=95  \n" +
"		</C> \n" +
"	</G> \n" +
"	<G> Name='1월' id='G3' \n" +
"		<C> Name='계획금액' ID=PLAN_AMT_01	Width=95  \n" +
"		</C> \n" +
"		<C> Name='전망금액' ID=FORECAST_AMT_01	Width=95 BgColor={decode(LV,1,'#DCDCDC',2,decode(IS_LEAF_TAG,'T','white','F','#EFEFEF'),3,'#87CEEB')} \n" +
"		</C> \n" +
"		<C> Name='실적+전망' ID=EXEC_AMT_01	Width=95 Value={EXEC_AMT+FORECAST_AMT_01} \n" +
"		</C> \n" +
"	</G> \n" +
"	<G> Name='2월' id='G4'  \n" +
"		<C> Name='계획금액' ID=PLAN_AMT_02	Width=95  \n" +
"		</C> \n" +
"		<C> Name='전망금액' ID=FORECAST_AMT_02	Width=95 BgColor={decode(LV,1,'#DCDCDC',2,decode(IS_LEAF_TAG,'T','white','F','#EFEFEF'),3,'#87CEEB')} \n" +
"		</C> \n" +
"		<C> Name='실적+전망' ID=EXEC_AMT_02	Width=95 Value={EXEC_AMT+FORECAST_AMT_01+FORECAST_AMT_02} \n" +
"		</C> \n" +
"	</G> \n" +
"	<G> Name='3월'  id='G5' \n" +
"		<C> Name='계획금액' ID=PLAN_AMT_03	Width=95  \n" +
"		</C> \n" +
"		<C> Name='전망금액' ID=FORECAST_AMT_03	Width=95 BgColor={decode(LV,1,'#DCDCDC',2,decode(IS_LEAF_TAG,'T','white','F','#EFEFEF'),3,'#87CEEB')} \n" +
"		</C> \n" +
"		<C> Name='실적+전망' ID=EXEC_AMT_03	Width=95 Value={EXEC_AMT+FORECAST_AMT_01+FORECAST_AMT_02+FORECAST_AMT_03} \n" +
"		</C> \n" +
"	</G> \n";

var			s2 = 
"	<FG> Name='기본사항' id='G1' \n" +
"	<C> Name=현장명 ID=DEPT_NAME Width=120 suppress=1\n" +
"	</C>\n" +
"	<C> Name=항목명 ID=LEVELED_NAME Width=120 suppress=2 \n" +
"	</C> \n" +
"	<C> Name=구분 ID=SUBTITLE_NAME Align=Center Width=40   \n" +
"	</C> \n" +
"	</FG> \n" +
"	<G> Name='전월실적' id='G2' \n" +
"		<C> Name='누    계' ID=EXEC_AMT	Width=95  \n" +
"		</C> \n" +
"	</G> \n" +
"	<G> Name='4월'  id='G3' \n" +
"		<C> Name='계획금액' ID=PLAN_AMT_01	Width=95  \n" +
"		</C> \n" +
"		<C> Name='전망금액' ID=FORECAST_AMT_01	Width=95 BgColor={decode(LV,1,'#DCDCDC',2,decode(IS_LEAF_TAG,'T','white','F','#EFEFEF'),3,'#87CEEB')} \n" +
"		</C> \n" +
"		<C> Name='실적+전망' ID=EXEC_AMT_01	Width=95 Value={EXEC_AMT+FORECAST_AMT_01} \n" +
"		</C> \n" +
"	</G> \n" +
"	<G> Name='5월'  id='G4' \n" +
"		<C> Name='계획금액' ID=PLAN_AMT_02	Width=95  \n" +
"		</C> \n" +
"		<C> Name='전망금액' ID=FORECAST_AMT_02	Width=95 BgColor={decode(LV,1,'#DCDCDC',2,decode(IS_LEAF_TAG,'T','white','F','#EFEFEF'),3,'#87CEEB')} \n" +
"		</C> \n" +
"		<C> Name='실적+전망' ID=EXEC_AMT_02	Width=95 Value={EXEC_AMT+FORECAST_AMT_01+FORECAST_AMT_02} \n" +
"		</C> \n" +
"	</G> \n" +
"	<G> Name='6월'  id='G5' \n" +
"		<C> Name='계획금액' ID=PLAN_AMT_03	Width=95  \n" +
"		</C> \n" +
"		<C> Name='전망금액' ID=FORECAST_AMT_03	Width=95 BgColor={decode(LV,1,'#DCDCDC',2,decode(IS_LEAF_TAG,'T','white','F','#EFEFEF'),3,'#87CEEB')} \n" +
"		</C> \n" +
"		<C> Name='실적+전망' ID=EXEC_AMT_03	Width=95 Value={EXEC_AMT+FORECAST_AMT_01+FORECAST_AMT_02+FORECAST_AMT_03} \n" +
"		</C> \n" +
"	</G> \n";

var			s3 = 
"	<FG> Name='기본사항' id='G1' \n" +
"	<C> Name=현장명 ID=DEPT_NAME Width=120 suppress=1\n" +
"	</C>\n" +
"	<C> Name=항목명 ID=LEVELED_NAME Width=120 suppress=2 \n" +
"	</C> \n" +
"	<C> Name=구분 ID=SUBTITLE_NAME Align=Center Width=40   \n" +
"	</C> \n" +
"	</FG> \n" +
"	<G> Name='전월실적' id='G2' \n" +
"		<C> Name='누    계' ID=EXEC_AMT	Width=95  \n" +
"		</C> \n" +
"	</G> \n" +
"	<G> Name='7월'  id='G3' \n" +
"		<C> Name='계획금액' ID=PLAN_AMT_01	Width=95  \n" +
"		</C> \n" +
"		<C> Name='전망금액' ID=FORECAST_AMT_01	Width=95 BgColor={decode(LV,1,'#DCDCDC',2,decode(IS_LEAF_TAG,'T','white','F','#EFEFEF'),3,'#87CEEB')} \n" +
"		</C> \n" +
"		<C> Name='실적+전망' ID=EXEC_AMT_01	Width=95 Value={EXEC_AMT+FORECAST_AMT_01} \n" +
"		</C> \n" +
"	</G> \n" +
"	<G> Name='8월'  id='G4' \n" +
"		<C> Name='계획금액' ID=PLAN_AMT_02	Width=95  \n" +
"		</C> \n" +
"		<C> Name='전망금액' ID=FORECAST_AMT_02	Width=95 BgColor={decode(LV,1,'#DCDCDC',2,decode(IS_LEAF_TAG,'T','white','F','#EFEFEF'),3,'#87CEEB')} \n" +
"		</C> \n" +
"		<C> Name='실적+전망' ID=EXEC_AMT_02	Width=95 Value={EXEC_AMT+FORECAST_AMT_01+FORECAST_AMT_02} \n" +
"		</C> \n" +
"	</G> \n" +
"	<G> Name='9월'  id='G5' \n" +
"		<C> Name='계획금액' ID=PLAN_AMT_03	Width=95  \n" +
"		</C> \n" +
"		<C> Name='전망금액' ID=FORECAST_AMT_03	Width=95 BgColor={decode(LV,1,'#DCDCDC',2,decode(IS_LEAF_TAG,'T','white','F','#EFEFEF'),3,'#87CEEB')} \n" +
"		</C> \n" +
"		<C> Name='실적+전망' ID=EXEC_AMT_03	Width=95 Value={EXEC_AMT+FORECAST_AMT_01+FORECAST_AMT_02+FORECAST_AMT_03} \n" +
"		</C> \n" +
"	</G> \n";

var			s4 = 
"	<FG> Name='기본사항' id='G1' \n" +
"	<C> Name=현장명 ID=DEPT_NAME Width=120 suppress=1\n" +
"	</C>\n" +
"	<C> Name=항목명 ID=LEVELED_NAME Width=120 suppress=2 \n" +
"	</C> \n" +
"	<C> Name=구분 ID=SUBTITLE_NAME Align=Center Width=40   \n" +
"	</C> \n" +
"	</FG> \n" +
"	<G> Name='전월실적' id='G2' \n" +
"		<C> Name='누    계' ID=EXEC_AMT	Width=95  \n" +
"		</C> \n" +
"	</G> \n" +
"	<G> Name='10월'  id='G3' \n" +
"		<C> Name='계획금액' ID=PLAN_AMT_01	Width=95  \n" +
"		</C> \n" +
"		<C> Name='전망금액' ID=FORECAST_AMT_01	Width=95 BgColor={decode(LV,1,'#DCDCDC',2,decode(IS_LEAF_TAG,'T','white','F','#EFEFEF'),3,'#87CEEB')} \n" +
"		</C> \n" +
"		<C> Name='실적+전망' ID=EXEC_AMT_01	Width=95 Value={EXEC_AMT+FORECAST_AMT_01} \n" +
"		</C> \n" +
"	</G> \n" +
"	<G> Name='11월'  id='G4' \n" +
"		<C> Name='계획금액' ID=PLAN_AMT_02	Width=95  \n" +
"		</C> \n" +
"		<C> Name='전망금액' ID=FORECAST_AMT_02	Width=95 BgColor={decode(LV,1,'#DCDCDC',2,decode(IS_LEAF_TAG,'T','white','F','#EFEFEF'),3,'#87CEEB')} \n" +
"		</C> \n" +
"		<C> Name='실적+전망' ID=EXEC_AMT_02	Width=95 Value={EXEC_AMT+FORECAST_AMT_01+FORECAST_AMT_02} \n" +
"		</C> \n" +
"	</G> \n" +
"	<G> Name='12월'  id='G5' \n" +
"		<C> Name='계획금액' ID=PLAN_AMT_03	Width=95  \n" +
"		</C> \n" +
"		<C> Name='전망금액' ID=FORECAST_AMT_03	Width=95 BgColor={decode(LV,1,'#DCDCDC',2,decode(IS_LEAF_TAG,'T','white','F','#EFEFEF'),3,'#87CEEB')} \n" +
"		</C> \n" +
"		<C> Name='실적+전망' ID=EXEC_AMT_03	Width=95 Value={EXEC_AMT+FORECAST_AMT_01+FORECAST_AMT_02+FORECAST_AMT_03} \n" +
"		</C> \n" +
"	</G> \n";

function Initialize()
{
	G_addDataSet(dsMAIN, trans, gridMAIN, null, "현장별경영계획전망",null,null,true);
	
	G_addDataSet(dsCOPY,transCopy,null,null,"복사");
	G_addDataSet(dsREMOVE,transRemove,null,null,"삭제");
	
	G_addDataSet(dsLOV, null, null, null, "LOV");
	G_addDataSet(dsCLOSE, null, null, null, "CLOSE");
	
	
	cboQUARTER_YEAR.value = sQUARTER_YEAR;
	txtCOMP_CODE.value = sCompCode;
	txtCOMPANY_NAME.value = sCompName;
	txtCLSE_ACC_ID.value = sClseAccId;
	txtACC_ID.value = sAccId;

	processGridTitle();
	
	
	gridMAIN.RejectEnterkeyOnPopupStyle = true;
	gridMAIN.focus();

}
function OnLoadBefore(dataset)
{
	if (dataset == dsMAIN)	//시스템명 가져오기
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","MAIN")
											+ D_P2("COMP_CODE",txtCOMP_CODE.value)
											+ D_P2("CLSE_ACC_ID",txtCLSE_ACC_ID.value)
											+ D_P2("QUARTER_YEAR",cboQUARTER_YEAR.value)
											+ D_P2("DEPT_NAME",txtDEPT_NAME.value);
	}
	else if(dataset == dsCOPY)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","COPY");
	}
	else if(dataset == dsREMOVE)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","REMOVE");
	}
	else if (dataset == dsCLOSE)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","CLOSE")
											+ D_P2("COMP_CODE",txtCOMP_CODE.value)
											+ D_P2("CLSE_ACC_ID",txtCLSE_ACC_ID.value)
											+ D_P2("QUARTER_YEAR",cboQUARTER_YEAR.value);
	}
}

// 세션관련 함수----------------------------------------------------------------//
function SetSession()
{
}

function GetSession()
{
}

function ReportSession(asName, asValue)
{
}

// 함수관련---------------------------------------------------------------------//
function	processGridTitle()
{
	if(cboQUARTER_YEAR.value == "1")
	{
		gridMAIN.Format = s1;
	}
	else if(cboQUARTER_YEAR.value == "2")
	{
		gridMAIN.Format = s2;
	}
	else if(cboQUARTER_YEAR.value == "3")
	{
		gridMAIN.Format = s3;
	}
	else if(cboQUARTER_YEAR.value == "4")
	{
		gridMAIN.Format = s4;
	}
	G_setReadOnlyCol(gridMAIN,"DEPT_NAME");
	G_setReadOnlyCol(gridMAIN,"LEVELED_NAME");
	G_setReadOnlyCol(gridMAIN,"SUBTITLE_NAME");
	G_setReadOnlyCol(gridMAIN,"EXEC_AMT");
	G_setReadOnlyCol(gridMAIN,"PLAN_AMT_01");
	G_setReadOnlyCol(gridMAIN,"PLAN_AMT_02");
	G_setReadOnlyCol(gridMAIN,"PLAN_AMT_03");
	G_setReadOnlyCol(gridMAIN,"EXEC_AMT_01");
	G_setReadOnlyCol(gridMAIN,"EXEC_AMT_02");
	G_setReadOnlyCol(gridMAIN,"EXEC_AMT_03");
}
function	CalcSum(row,colid)
{
	if(dsMAIN.NameString(row,"LV") != "2") return;
	if(dsMAIN.NameString(row,"IS_LEAF_TAG") != "T") return;
	dsMAIN.NameString(row + 1,colid) = C_convSafeFloat(dsMAIN.NameString(row - 1,colid)) + C_convSafeFloat(dsMAIN.NameString(row ,colid));
}
function	checkConditions()
{
	if (C_isNull(txtCOMP_CODE.value))
	{
		C_msgOk("먼저 사업장코드를 선택하세요.", "확인");
		return false;
	}

	if(C_isNull(txtCLSE_ACC_ID.value))
	{
		C_msgOk("먼저 회기를 선택하세요.", "확인");
		return false;
	}
	return true;
}
function	isClose()
{
	return false;
}
function	checkClose()
{
	if(isClose())
	{
		C_msgOk("이미 마감되었습니다.");
		return true;
	}
	else
	{
		return false;
	}
}
// 공통 버튼 함수관련(상단에 공통 버튼을 누를 경우 호출되는 함수)---------------//
// 조회
function btnquery_onclick()
{
	if(!checkConditions()) return;
	D_defaultLoad();
}

// 추가
function btnadd_onclick()
{
}

// 삽입
function btninsert_onclick()
{
	btnadd_onclick();
}

// 삭제
function btndelete_onclick()
{
}

// 저장
function btnsave_onclick()
{
	var			lbRet = D_defaultSave(dsMAIN);
}

// 취소
function btncancel_onclick()
{
	if (G_FocusObject != null) G_FocusObject.focus();
}

// 공통 재정의 이벤트관련-------------------------------------------------------//
function CalendarResult(asCalendarID, asDate, asYear, asMonth, asDay)
{
}

function OnLoadCompleted(dataset, rowcnt)
{
	if(dataset == dsMAIN)
	{
		G_Load(dsCLOSE);
		if(checkClose())
		{
			gridMAIN.Editable = false;
		}
		else
		{
			gridMAIN.Editable = true;
		}
	}
}
function OnRowInsertBefore(dataset)
{
	return true;
}

function OnRowInserted(dataset, row)
{
}

function OnRowDeleteBefore(dataset)
{
	return false;
}

function OnRowDeleted(dataset, row)
{
}
function OnColumnPosChanged(dataset, grid, row, colid)
{
	if(colid != 'LEVELED_NAME' && colid != 'SUBTITLE_NAME' && colid != 'EXEC_AMT' && colid != 'PLAN_AMT_01' && colid != 'PLAN_AMT_02' && colid != 'PLAN_AMT_03')
	{
		if(dataset.NameString(row,"IS_LEAF_TAG") == "T" && dataset.NameString(row,"LV") == "2")
		{
			grid.ColumnProp(colid,'Edit') = 'Numeric';
		}
		else
		{
			grid.ColumnProp(colid,'Edit') = 'None';
		}
	}
}
function OnColumnChanged(dataset, row, colid)
{
	if(bEnter) return;
	bEnter = true;
	if(dataset == dsMAIN)
	{
		try
		{
			CalcSum(row,colid);
		}
		catch(e)
		{
		}
	}
	bEnter = false;
}

function OnExit(dataset, grid, row, colid, olddata)
{
}
function OnClick(dataset, grid, row, colid)
{
}
	
function OnPopup(dataset, grid, row, colid, data)
{
}
function OnPostBefore(dataset, trans)
{
	return true;
}
function	OnSuccess(dataset,trans)
{
}

// 이벤트관련-------------------------------------------------------------------//

function txtCOMP_CODE_onblur()
{
	if (C_isNull(txtCOMP_CODE.value))
	{
		txtCOMPANY_NAME.value = "";
		dsMAIN.ClearData();
		return;
	}
	
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", txtCOMP_CODE.value);

	lrRet = C_AutoLov(dsLOV,"T_COMP_CODE1", lrArgs,"T");
	
	if (lrRet == null) return;
	
	txtCOMP_CODE.value	= lrRet.get("COMP_CODE");
	txtCOMPANY_NAME.value	= lrRet.get("COMPANY_NAME");
	txtCLSE_ACC_ID.value = "";
	txtACC_ID.value = "";
	dsMAIN.ClearData();
}
function txtCLSE_ACC_ID_onblur()
{
	if(!CheckCompCode()) return;
	if (C_isNull(txtCLSE_ACC_ID.value))
	{
		txtACC_ID.value = "";
		dsMAIN.ClearData();
		return;
	}
	
	var lrArgs = new C_Dictionary();
	var lrRet = null;
	lrArgs.set("CLSE_ACC_ID", txtCLSE_ACC_ID.value);
	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);

	lrRet = C_AutoLov(dsLOV,"T_BUDG_YEAR", lrArgs,"T");
	
	if (lrRet == null) return;
	
	txtCLSE_ACC_ID.value	= lrRet.get("CLSE_ACC_ID");
	txtACC_ID.value	= lrRet.get("ACC_ID");
	
}
function btnCOMP_CODE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("SEARCH_CONDITION", "");

	lrRet = C_LOV("T_COMP_CODE1", lrArgs,"T");
	
	if (lrRet == null) return;

	txtCOMP_CODE.value	= lrRet.get("COMP_CODE");
	txtCOMPANY_NAME.value	= lrRet.get("COMPANY_NAME");
	txtCLSE_ACC_ID.value = "";
	txtACC_ID.value = "";
	dsMAIN.ClearData();
}
function btnACC_ID_onClick()
{
	if(!CheckCompCode()) return;
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("CLSE_ACC_ID", "");
	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);

	lrRet = C_LOV("T_YEAR", lrArgs,"T");
	
	if (lrRet == null) return;
	
	txtCLSE_ACC_ID.value	= lrRet.get("CLSE_ACC_ID");
	txtACC_ID.value	= lrRet.get("ACC_ID");
	
}
function	CheckCompCode()
{
	if (C_isNull(txtCOMP_CODE.value))
	{
		C_msgOk("먼저 사업장코드를 선택하세요.", "확인");
		return false;
	}
	return true;
}
function	btnGetConsInfo_onClick()
{
	if(!checkConditions()) return;
	if(checkClose()) return;
	if (dsMAIN.IsUpdated || G_isChanged(dsMAIN.id))
	{
		var ret = C_msgYesNo("이 작업을 위해서는 먼저 저장을 하셔야 합니다.<br>변경된 내용을 저장하시겠습니까?" , "저장");

		if (ret == "Y")
		{
			if(!G_saveAllData(dsMAIN)) return ;
		}
		else if(ret == "N")
		{
			return ;
		}
	}
	G_Load(dsCOPY);
	var			lsDeptCode = "";
	for(var i = 1 ; i <= dsMAIN.CountRow ; ++i)
	{
		if(dsMAIN.NameString(i,"DEPT_CODE") == lsDeptCode)
		{
		}
		else
		{
			lsDeptCode = dsMAIN.NameString(i,"DEPT_CODE");
			G_addRow(dsCOPY);
			dsCOPY.NameString(dsCOPY.RowPosition,"COMP_CODE") = txtCOMP_CODE.value;
			dsCOPY.NameString(dsCOPY.RowPosition,"CLSE_ACC_ID") = txtCLSE_ACC_ID.value;
			dsCOPY.NameString(dsCOPY.RowPosition,"DEPT_CODE") = lsDeptCode;
		}
	}
	transCopy.Parameters = "ACT=COPY";
	if(!G_saveData(dsCOPY))return;
	C_msgOk("집계하여 가져오기가 정상적으로 수행되었습니다.");
	G_Load(dsMAIN);
}
function	btnRemoveAll()
{
	if(!checkConditions()) return;
	if(checkClose()) return;
	var	ret = C_msgYesNo("이 작업을 수행하시면 현재 선택된 현장의 경영계획 전망이 완전히 삭제됩니다.<br> 정말 작업을 수행하시겠습니까?","경고");
	if(ret == "N") return;
	G_Load(dsREMOVE);
	var			lsDeptCode = "";
	for(var i = 1 ; i <= dsMAIN.CountRow ; ++i)
	{
		if(dsMAIN.NameString(i,"DEPT_CODE") == lsDeptCode)
		{
		}
		else
		{
			lsDeptCode = dsMAIN.NameString(i,"DEPT_CODE");
			G_addRow(dsREMOVE);
			dsREMOVE.NameString(dsREMOVE.RowPosition,"COMP_CODE") = txtCOMP_CODE.value;
			dsREMOVE.NameString(dsREMOVE.RowPosition,"CLSE_ACC_ID") = txtCLSE_ACC_ID.value;
			dsREMOVE.NameString(dsREMOVE.RowPosition,"DEPT_CODE") = lsDeptCode;
		}
	}
	transRemove.Parameters = "ACT=REMOVE";
	if(!G_saveData(dsREMOVE))return;
	C_msgOk("경영계획전망삭제가 정상적으로 수행되었습니다.");
	G_Load(dsMAIN);
}
function	cboQUARTER_YEAR_onChange()
{
	processGridTitle();
	if(C_isNull(txtCLSE_ACC_ID.value))
	{
		dsMAIN.ClearData();
	}
	else
	{
		D_defaultLoad();
	}
}
