/**************************************************************************/
/* 1. 프 로 그 램 id : t_WBrainSlipBodyR.js(표준전표적요소코드등록)
/* 2. 유형(시나리오) : 스크립트소스
/* 3. 기  능  정  의 : 표준전표적요소코드등록 
/* 4. 변  경  이  력 : 한재원 작성(2005-12-06)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/
function Initialize()
{
	G_addDataSet(dsMAIN, trans, gridMAIN, sSelectPageName+D_P1("ACT","MAIN"), "표준전표적요소코드등록");
	G_addDataSet(dsBRAIN_SLIP_SEQ1, null, null, null, "표준전표적요코드대분류등록");
	G_addDataSet(dsBRAIN_SLIP_SEQ2, null, null, null, "표준전표적요소코드중분류등록");
	G_addDataSet(dsSEQ, null, null, null, "SEQ");
	G_addDataSet(dsLOV, null, null, null, "LOV");

	G_addRel(dsBRAIN_SLIP_SEQ1, dsBRAIN_SLIP_SEQ2);
	G_addRelCol(dsBRAIN_SLIP_SEQ2, "BRAIN_SLIP_SEQ1", "BRAIN_SLIP_SEQ1");
	G_Load(dsBRAIN_SLIP_SEQ1, null);
	
	G_setLovCol(gridMAIN,"ACC_CODE");
	//G_setLovCol(gridMAIN,"VAT_CODE");
	G_setReadOnlyCol(gridMAIN,"ACC_NAME");
	//G_setReadOnlyCol(gridMAIN,"SUMMARY1");
	G_setReadOnlyCol(gridMAIN,"VAT_NAME");
	gridMAIN.RejectEnterkeyOnPopupStyle = true;	//그리드에서 enter 키 입력시 popup을 뜨지 않게한다.
	gridMAIN.TabToss = false;
	
	gridMAIN.focus();
}
function OnLoadBefore(dataset)
{
	if(dataset == dsMAIN)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","MAIN")
										 + D_P2("BRAIN_SLIP_SEQ1",dsBRAIN_SLIP_SEQ1.NameString(dsBRAIN_SLIP_SEQ1.RowPosition,"BRAIN_SLIP_SEQ1"))
										 + D_P2("BRAIN_SLIP_SEQ2",dsBRAIN_SLIP_SEQ2.NameString(dsBRAIN_SLIP_SEQ2.RowPosition,"BRAIN_SLIP_SEQ2"));
	}
	else if(dataset == dsBRAIN_SLIP_SEQ1)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","BRAIN_SLIP_SEQ1");
	}
	else if(dataset == dsBRAIN_SLIP_SEQ2)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","BRAIN_SLIP_SEQ2")
										 + D_P2("BRAIN_SLIP_SEQ1",dsBRAIN_SLIP_SEQ1.NameString(dsBRAIN_SLIP_SEQ1.RowPosition,"BRAIN_SLIP_SEQ1"));
	}
	else if(dataset == dsSEQ)
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","SEQ");
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
function chkAccCode()
{
	if(C_isNull( dsMAIN.NameValue(dsMAIN.RowPosition,"ACC_CODE")))
	{
		C_msgOK("계정코드를 먼저 선택하세요", "확인");
		return false;	
	}
	return true;
}
// 공통 버튼 함수관련(상단에 공통 버튼을 누를 경우 호출되는 함수)---------------//
// 조회
function btnquery_onclick()
{
	D_defaultLoad();
}

// 추가
function btnadd_onclick()
{
	D_defaultAdd();
}

// 삽입
function btninsert_onclick()
{
	D_defaultInsert();
}

// 삭제
function btndelete_onclick()
{
	D_defaultDelete();
}

// 저장
function btnsave_onclick()
{
	D_defaultSave(dsMAIN);
}

// 취소
function btncancel_onclick()
{
	if (G_FocusObject != null) G_FocusObject.focus();
}

//인쇄
function btnquery_prt_onclick()
{
	// 프로그래머 유효성검사 추가
				
	// 공통 Check
	
      
   	var reportFile ="";
	
   	reportFile ="r_t_000003";  

	frmList.EXPORT_TAG.value =cboExportTag.value;
	frmList.RUN_TAG.value = cboRunTag.value;
	frmList.REQUEST_NAME.value = txtRequestName.value;
	frmList.REPORT_NO.value = '--';
	frmList.REPORT_FILE_NAME.value = reportFile +'.rpt';
	
	
	var strTemp = "";
	
	strTemp += "P_BRAIN_SLIP_SEQ1__" + dsBRAIN_SLIP_SEQ1.NameValue(dsBRAIN_SLIP_SEQ1.RowPosition, "BRAIN_SLIP_SEQ1");
	strTemp += "&&P_BRAIN_SLIP_SEQ2__" + dsBRAIN_SLIP_SEQ2.NameValue(dsBRAIN_SLIP_SEQ2.RowPosition, "BRAIN_SLIP_SEQ2");
	strTemp += "&&P_BRAIN_SLIP_NAME1__" + dsBRAIN_SLIP_SEQ1.NameValue(dsBRAIN_SLIP_SEQ1.RowPosition, "BRAIN_SLIP_NAME1");
	strTemp += "&&P_BRAIN_SLIP_NAME2__" + dsBRAIN_SLIP_SEQ2.NameValue(dsBRAIN_SLIP_SEQ2.RowPosition, "BRAIN_SLIP_NAME2");

	frmList.PARAMETERS.value = strTemp;
	
	if (!S_Submit(document.all)) return;
	frmList.submit();
	S_ObjectAllFormat(document.all);
	strTemp ="";
}
// 공통 재정의 이벤트관련-------------------------------------------------------//
function CalendarResult(asCalendarID, asDate, asYear, asMonth, asDay)
{
}


function OnLoadCompleted(dataset, rowcnt)
{
}

function OnRowInsertBefore(dataset)
{
	return true;
}

function OnRowInserted(dataset, row)
{
	if (dataset == dsMAIN)
	{
		G_Load(dsSEQ, null);
		dsMAIN.NameValue(row,"BRAIN_SLIP_SEQ1") = dsBRAIN_SLIP_SEQ1.NameValue(dsBRAIN_SLIP_SEQ1.RowPosition,"BRAIN_SLIP_SEQ1");
		dsMAIN.NameValue(row,"BRAIN_SLIP_SEQ2") = dsBRAIN_SLIP_SEQ2.NameValue(dsBRAIN_SLIP_SEQ2.RowPosition,"BRAIN_SLIP_SEQ2");
		dsMAIN.NameValue(row,"BRAIN_SLIP_LINE") = dsSEQ.NameValue(dsSEQ.RowPosition,"SEQ");
		dsMAIN.NameValue(row,"ACC_POSITION") = "D";
	}
}

function OnRowDeleteBefore(dataset)
{
	return true;
}

function OnRowDeleted(dataset, row)
{
}

function OnColumnChanged(dataset, row, colid)
{
}

function OnExit(dataset, grid, row, colid, olddata)
{
	if (dataset == dsMAIN)
	{
		var		COL_DATA;
		COL_DATA = dataset.NameString(row,colid);
		if(colid == "ACC_CODE")
		{
			if(C_isNull(COL_DATA))
			{
				dataset.NameString(row,"ACC_CODE") = "";
				dataset.NameString(row,"ACC_NAME") = "";
				dataset.NameValue(row,"SUMMARY_CODE")	= "";
			    dataset.NameValue(row,"SUMMARY1") = "";
				return ;
			}
			else
			{
				var lrArgs = new C_Dictionary();

				var		strACC_CODE = dsMAIN.NameString(row,"ACC_CODE");

				lrArgs.set("SEARCH_CONDITION", strACC_CODE);

				var		lrRet = C_AutoLov(dsLOV,"T_ACC_CODE1",lrArgs,"T");


				if (lrRet != null)
				{
					dsMAIN.NameString(row,"ACC_CODE")	= lrRet.get("ACC_CODE");
					dsMAIN.NameString(row,"ACC_NAME")	= lrRet.get("ACC_NAME");
					dataset.NameValue(row,"SUMMARY_CODE")	= "";
			   		dataset.NameValue(row,"SUMMARY1") = "";
				}
				else
				{
					dsMAIN.NameString(row,"ACC_CODE")	= olddata;

				}
			}
		}
		
		else if(colid == "SUMMARY_CODE")
		{
			if(C_isNull(COL_DATA))
			{
				dataset.NameString(row,"SUMMARY_CODE") = "";
				dataset.NameString(row,"SUMMARY1") = "";
				return ;
			}
			else
			{
				//if(!chkAccCode()) return ;
				var lrArgs = new C_Dictionary();

				var		strACC_CODE = dsMAIN.NameString(row,"SUMMARY_CODE");

				lrArgs.set("ACC_CODE", dsMAIN.NameValue(row,"ACC_CODE"));
				lrArgs.set("SEARCH_CONDITION", strACC_CODE);

				var		lrRet = C_AutoLov(dsLOV,"T_SUMMARY_CODE",lrArgs,"T");


				if (lrRet != null)
				{
					dsMAIN.NameString(row,"SUMMARY_CODE")	= lrRet.get("SUMMARY_CODE");
					dsMAIN.NameString(row,"SUMMARY1")		= lrRet.get("SUMMARY_NAME");
				}
				else
				{
					dsMAIN.NameString(row,"SUMMARY_CODE")	= olddata;

				}
			}
		}
		else if(colid == "VAT_ACC_NAME")
		{
			if(C_isNull(COL_DATA))
			{
				dataset.NameString(row,"VAT_ACC_CODE") = "";
				dataset.NameString(row,"VAT_ACC_NAME") = "";
				return ;
			}
			else
			{
				var lrArgs = new C_Dictionary();

				var		strVAT_ACC_CODE = dsMAIN.NameString(row,"VAT_ACC_CODE");

				lrArgs.set("SEARCH_CONDITION", strVAT_ACC_CODE);

				var		lrRet = C_AutoLov(dsLOV, "T_ACC_CODE10", lrArgs, "T");


				if (lrRet != null)
				{
					dsMAIN.NameString(row,"VAT_ACC_CODE")	= lrRet.get("ACC_CODE");
					dsMAIN.NameString(row,"VAT_ACC_NAME")	= lrRet.get("ACC_NAME");
				}
				else
				{
					dsMAIN.NameString(row,"VAT_ACC_CODE")	= olddata;

				}
			}
		}	
	}
}

function OnPopup(dataset, grid, row, colid, data)
{
	if (dataset == dsMAIN)
	{
		if (colid == "ACC_CODE")
		{
			var lrArgs = new C_Dictionary();
			var lrRet = null;
		
			lrArgs.set("SEARCH_CONDITION", "");
		
			lrRet = C_LOV("T_ACC_CODE1", lrArgs,"F");
			
			if (lrRet == null) return;
		
			dsMAIN.NameValue(row,"ACC_CODE")	= lrRet.get("ACC_CODE");
			dsMAIN.NameValue(row,"ACC_NAME")	= lrRet.get("ACC_NAME");
			dataset.NameValue(row,"SUMMARY_CODE")	= "";
			dataset.NameValue(row,"SUMMARY1") = "";
		}
		
		else if (colid == "SUMMARY_CODE")
		{
			//if(!chkAccCode()) return false;
			var lrArgs = new C_Dictionary();
			var lrRet = null;
		
			lrArgs.set("ACC_CODE", dsMAIN.NameValue(row,"ACC_CODE"));
			lrArgs.set("SEARCH_CONDITION", "");
		
			lrRet = C_LOV("T_SUMMARY_CODE", lrArgs,"F");
			
			if (lrRet == null) return;
		
			dsMAIN.NameValue(row,"SUMMARY_CODE")	= lrRet.get("SUMMARY_CODE");
			dsMAIN.NameValue(row,"SUMMARY1")	= lrRet.get("SUMMARY_NAME");
		}
		
		else if (colid == "VAT_ACC_NAME")
		{
			var lrArgs = new C_Dictionary();
			var lrRet = null;
		
			lrArgs.set("SEARCH_CONDITION", "");
		
			lrRet = C_LOV("T_ACC_CODE10", lrArgs,"F");
			
			if (lrRet == null) return;
		
			dsMAIN.NameString(row,"VAT_ACC_CODE")	= lrRet.get("ACC_CODE");
			dsMAIN.NameString(row,"VAT_ACC_NAME")	= lrRet.get("ACC_NAME");
		}	
	}
}

// 이벤트관련-------------------------------------------------------------------//
//출력
function btnPreView_onClick()
{
	btnquery_prt_onclick();
}