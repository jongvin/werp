/**************************************************************************/
/* 1. 프 로 그 램 id : t_WCompanyR(사업장 등록)
/* 2. 유형(시나리오) : 사업장의 조회 및 입력
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 강덕율 작성(2005-11-11)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 :
/**************************************************************************/
var p;
var ph;
var peer;
var del_status;
var vError_Flag = null;
var vOBJ = null;
var vRDY_Flag = null;

function Initialize()
{
	G_addDataSet(dsSLIP_H, trans, gridMAIN, null, "세금계산서");
	G_addDataSet(dsSLIP_D, trans, gridSUB, null, "거래명세서");	
	G_addDataSet(dsSERIAL, null, null, null, "일련번호");	
	G_addDataSet(dsITEM, null, null, null, "거래명세upload");	
	G_addDataSet(dsLOV, null, null, null, "LOV");

	G_setLovCol(gridSUB,"TAX_GENDATE");
	G_setLovCol(gridSUB,"ITEM_CODE");
	
	document.all.btnSUP_REGNUM.disabled			= true;
	document.all.btnBUY_REGNUM.disabled			= true;
	document.all.btnBUY_EMPLOYEE.disabled		= true;

	G_Load(dsSLIP_H);
	G_Load(dsSLIP_D);
}
function OnLoadBefore(dataset)
{
	if(dataset == dsSLIP_H)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","MAIN")
											+ D_P2("DOC_COM_ID",sComid)
											+ D_P2("DOC_NUMBER",C_Trim(txtDOC_NUMBER.value));
	}
  else if(dataset == dsSLIP_D)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","SUB01")
											+ D_P2("DOC_NUMBER" ,C_Trim(txtDOC_NUMBER.value));
	}	
  else if(dataset == dsSERIAL)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","SERIAL")
											+ D_P2("DOC_COM_ID" ,txtDOC_COM_ID.value)
											+ D_P2("DOC_YYMM" ,txtDOC_YYMM.value);

	}		
  else if(dataset == dsITEM)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","ITEM");
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

// 공통 버튼 함수관련(상단에 공통 버튼을 누를 경우 호출되는 함수)---------------//
// 조회
function btnquery_onclick()
{
	if (dsSLIP_H.IsUpdated || G_isChanged(dsSLIP_H.id))
	{
		var	vRet	= C_msgYesNo("계산서 작성중입니다. 작성을 취소하고 진행하시겠습니까?", "확인");
		if (vRet != "Y") return;
	}
	
	if (C_isNull(txtDOC_NUMBER.value))
	{
			C_msgOk("문서번호를 입력하세요.","알림");
			return;
	}
	if (del_status == 'd')
	{
			C_msgOk("이미 삭제된 자료입니다.","알림");
			return;
	}	
	
	G_Load(dsSLIP_H, null);
	G_Load(dsSLIP_D, null);
	
	if (dsSLIP_H.CountRow != 1) {
  		button_onClick( "F");
  		return;
	}  		

	button_onClick( "T");
}

// 추가
function btnadd_onclick()
{
	if (dsSLIP_H.IsUpdated || G_isChanged(dsSLIP_H.id))
	{
		var	vRet	= C_msgYesNo("계산서 작성중입니다. 작성을 취소하고 진행하시겠습니까?", "확인");
		if (vRet != "Y") return;
	}

	txtDOC_NUMBER.value = "" ;
	
	dsSLIP_D.ClearData();

	dsSLIP_H.ClearData();	
	dsSLIP_H.AddRow()

	txtDOC_COM_ID.value = sComid ;
	txtDOC_YYMM.value = sDate.replace(/-/g,'').substr(0,6) ;
	txtDEL_STATUS.value = '0' ;
	txtSENDER.value = sEmpid ;
	cboREF_TYPE.value = "REQ" ;
	cboTAX_TYPE.value = "VAT" ;
	cboMSG_TYPE.value = "380" ;
	cboRES_FLAG.value = "1" ;	
	txtSUP_ID.value = sEmpid ;
	txtSUP_REGNUM.value = sRegnum ;
	txtSUP_COMPANY.value = sCompany ;
	txtSUP_EMPLOYER.value = sEmployer ;
	txtSUP_ADDRESS.value = sAddress ;
	txtSUP_BIZCOND.value = sBizcond ;
	txtSUP_BIZITEM.value = sBizitem ;
	txtSUP_SECTOR.value = sSectname ;
	txtSUP_EMPLOYEE.value = sEmpname ;
	txtSUP_EMPID.value = sEmpno ;
	txtSUP_EMPEMAIL.value = sEmail ;
	txtSUP_EMPMOBILE.value = sMobile ;
	
	dsSLIP_H.Namestring(1,"TX_REQ") = "F" ;
	//txtTX_REQ.value = "F" ;
	txtSTATUS.value = "INS" ;
	txtGEN_TM.value = sDate.replace(/-/g,'') ;
	
  button_onClick( "T");

}

// 삽입
function btninsert_onclick()
{

}

// 삭제
function btndelete_onclick()
{
	if (dsSLIP_H.CountRow != 1) return;
	
	/* 처리상태가 작성중('INS')일 경우에만 삭제할수 있다.*/
	/* 삭제시 STATUS= 'DEL'로 마킹.DEL_TM 삭제일자 set   */
	if (C_Trim(txtSTATUS.value) != 'INS')
	{
			C_msgOk("삭제할수 없는 자료입니다.","알림");
			return;
	}

	if (C_keyCode == "68")
	{
		btnDELETEROW_onClick();
		C_keyCode = "";
		return;
	}

	if (C_cmdCode == "3040")
	{
		btnDELETEROW_onClick();
		C_cmdCode = "";
		return;
	}

	if(C_msgYesNo("정말 삭제하시겠습니까?","확인") == "N")
	{
		return;
	}

	dsSLIP_D.ClearData();
	G_deleteRow(dsSLIP_H);
	
	trans.Parameters = "ACT=SLIP_H";
	if(!G_saveData(dsSLIP_H)) {
		dsSLIP_H.ResetStatus();
		dsSLIP_D.ResetStatus();
		btnquery_onclick();
		return;
	}

	txtDOC_NUMBER.value = "";
	button_onClick( "F");
}

// 저장
function btnsave_onclick()
{
	if (dsSLIP_H.CountRow != 1) return false;
	
	if (dsSLIP_D.CountRow == 0)
	{
		C_msgOk("저장할 계산서내역이 없습니다.", "확인");
		return false;
	}  
	
  /* 처리상태가 'INS : 작성중' 인 상태가 아닐경우 수정불가.*/
	if ( (C_Trim(txtSTATUS.value) != 'INS') && (C_Trim(txtSTATUS.value) != '000'))
	{
			C_msgOk("수정할수 없는 자료입니다.","알림");
			return;
	}

	/* 필수항목체크 */
	Input_Error_Check();
	
	if (vError_Flag == 'T')
	{
		gridSUB.focus();
		vError_Flag = "F";
		return false;
	}

  if( dsSLIP_H.RowStatus(1) == 1 ) { // 0 : 조회, 1 : 추가, 2 : 삭제, 3 : 수정
		// 일련번호 (10)
	  G_Load(dsSERIAL);  	
	  // 문서번호 : 회사ID(4) + 년월(6) + 일련번호 (10)
		dsSLIP_H.NameString(1,"DOC_NUMBER")	= txtDOC_COM_ID.value + txtDOC_YYMM.value + dsSERIAL.NameString(1,"REF_SERIAL");
	  dsSLIP_H.NameString(1,"REF_SERIAL")	= dsSERIAL.NameString(1,"REF_SERIAL");
	  
		//거래명세 항목 SET
		for (i=1;i<=dsSLIP_D.CountRow;i++) {
			dsSLIP_D.NameString(i,"DOC_NUMBER") = dsSLIP_H.NameString(1,"DOC_NUMBER") ;
			dsSLIP_D.NameString(i,"COM_ID")     = dsSLIP_H.NameString(1,"DOC_COM_ID") ;
			dsSLIP_D.NameString(i,"MTSID")     	= " ";
			dsSLIP_D.NameString(i,"ITEM_SEQ")   = i ;
		}	  
	}  

	dsSLIP_H.NameString(1,"GEN_TM")					= txtGEN_TM.value.replace(/-/g,''); 
	dsSLIP_H.NameString(1,"TAX_SUPPRICE")		= dsSLIP_D.NameSum("TAX_SUPPRICE",0,0); 
	dsSLIP_H.NameString(1,"TAX_TAXPRICE")		= dsSLIP_D.NameSum("TAX_TAXPRICE",0,0);
	dsSLIP_H.NameString(1,"PAY_TOTALPRICE")	= dsSLIP_D.NameSum("TAX_SUPPRICE",0,0) + dsSLIP_D.NameSum("TAX_TAXPRICE",0,0);
	dsSLIP_H.NameString(1,"ITEM_NUM")				= dsSLIP_D.CountRow;

	if ( vRDY_Flag == "RDY" ) txtSTATUS.value = "RDY";

	trans.Parameters = "ACT=SLIP_H";
	if(!G_saveData(dsSLIP_H)) {
		dsSLIP_H.ResetStatus();
		dsSLIP_D.ResetStatus();
		btnquery_onclick();
		return;
	}
	/*trans.Parameters = "ACT=SLIP_D";
	if(!G_saveData(dsSLIP_D)) {
		return;
	}*/

	C_msgOk("전표내역이 저장되었습니다." + "<BR>" + "문서번호" + "<BR>" + "[ " + dsSLIP_H.NameString(1,"DOC_NUMBER") + " ]", "확인");

	// 문서번호을 가져와 다시 조회한다.
	txtDOC_NUMBER.value = dsSLIP_H.NameString(1,"DOC_NUMBER");
	dsSLIP_H.ResetStatus();
	dsSLIP_D.ResetStatus();
	vRDY_Flag = null;	
	btnquery_onclick();
	return true;
}

// 취소
function btncancel_onclick()
{
	if (G_FocusObject != null) G_FocusObject.focus();
}

// 공통 재정의 이벤트관련-------------------------------------------------------//
function CalendarResult(asCalendarID, asDate, asYear, asMonth, asDay)
{
	if (asCalendarID == "GEN_TM")
	{
		txtGEN_TM.value = asDate;
	}
	else if (asCalendarID == "TAXGENDATE")
	{
		dsSLIP_D.NameString(dsSLIP_D.RowPosition,"TAX_GENDATE") = asDate;
	}		
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
	if (dataset == dsSLIP_D)
	{
		if ((colid == "ITEM_NUM") || (colid == "ITEM_DANGA"))
		{
			dsSLIP_D.NameString(row,"TAX_SUPPRICE") = C_Round( dsSLIP_D.NameString(row,"ITEM_NUM") * dsSLIP_D.NameString(row,"ITEM_DANGA") ,0);			
			if ( cboTAX_TYPE.value == "VAT")
			{
				dsSLIP_D.NameString(row,"TAX_TAXPRICE") = C_Round( dsSLIP_D.NameString(row,"TAX_SUPPRICE") * 0.1 ,0);							
			}
			else	
			{
				dsSLIP_D.NameString(row,"TAX_TAXPRICE") = 0;
			}
			
			txtTAX_TAXPRICE.value = C_toNumberFormatString( dsSLIP_D.NameSum("TAX_TAXPRICE",0,0) ,false);
			txtTAX_SUPPRICE.value = C_toNumberFormatString( dsSLIP_D.NameSum("TAX_SUPPRICE",0,0) ,false);
	 	}
		else if ((colid == "TAX_SUPPRICE"))
		{	
			if ( cboTAX_TYPE.value == "VAT")
			{
				dsSLIP_D.NameString(row,"TAX_TAXPRICE") = C_Round( dsSLIP_D.NameString(row,"TAX_SUPPRICE") * 0.1 ,0);							
			}
			else	
			{
				dsSLIP_D.NameString(row,"TAX_TAXPRICE") = 0;
			}				
		}	 	
	}

}

function OnExit(dataset, grid, row, colid, olddata)
{
		if(colid == "TAX_GENDATE" )
		{
			D_defaultDateProcessInGrid(dataset, row, colid, olddata,dataset.NameString(row,"TAX_GENDATE"));
			 
		}			 
		else if(colid == "ITEM_CODE" )
		{		
			//제품검색
			var lrArgs = new C_Dictionary();
			var lrRet = null;
			
			lrArgs.set("COM_ID", txtDOC_COM_ID.value);
			lrArgs.set("SEARCH_CONDITION", dataset.NameString(row,colid));
			
			lrRet = C_AutoLov(dsLOV,"TB_WT_ITEM", lrArgs,"T");
			
			if (lrRet == null) return;
			
			dataset.NameString(row,"ITEM_CODE") = lrRet.get("ITEM_CODE");
			dataset.NameString(row,"ITEM_NAME") = lrRet.get("ITEM_NAME");
			dataset.NameString(row,"ITEM_UNIT") = lrRet.get("ITEM_SIZE");
		}
}

function OnPopup(dataset, grid, row, colid, data)
{
		if(colid == "TAX_GENDATE" )
		{
			var lrArgs = new C_Dictionary();
			var lrRet = null;
			
		  C_Calendar("TAXGENDATE", "D", dataset.NameString(row,"TAX_GENDATE"));
		}		  
		else if(colid == "ITEM_CODE"  )
		{
			var lrArgs = new C_Dictionary();
			var lrRet = null;
			
			lrArgs.set("COM_ID", txtDOC_COM_ID.value);
			lrArgs.set("SEARCH_CONDITION", "");
		
			lrRet = C_LOV("TB_WT_ITEM", lrArgs,"F");
			
			if (lrRet != null)
			{
				if(row > 0)
				{
					dataset.NameString(row,"ITEM_CODE") = lrRet.get("ITEM_CODE");
					dataset.NameString(row,"ITEM_NAME") = lrRet.get("ITEM_NAME");
					dataset.NameString(row,"ITEM_UNIT") = lrRet.get("ITEM_SIZE");
				}
			}
		}
}

// 이벤트관련-------------------------------------------------------------------//
//문서번호찾기
function	btnDOCU_NO_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;
	del_status = null;
	
	lrArgs.set("DOC_COM_ID", sComid);
	lrArgs.set("GEN_TM", sDate.substr(0,7));
	lrArgs.set("BUY_COMPANY", "");

	lrRet = C_LOV("TB_WT_SALE", lrArgs,"F");
	
	if (lrRet == null) return;

	txtDOC_NUMBER.value	= lrRet.get("DOC_NUMBER");
	del_status = lrRet.get("DEL_STATUS");
	btnquery_onclick();
	
}
function	btnDOCU_NO_onblur()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;
	del_status = null;
	
	// 입력값이 ''이면 리턴	
	if (C_isNull(C_Trim(txtDOC_NUMBER.value)))	return;

	lrArgs.set("DOC_COM_ID", sComid);
	lrArgs.set("GEN_TM", sDate.substr(0,7));
	lrArgs.set("BUY_COMPANY", "");
	lrArgs.set("DOC_NUMBER", txtDOC_NUMBER.value);

	lrRet = C_AutoLov(dsLOV,"TB_WT_SALE", lrArgs,"T");
	
	if (lrRet == null) return;

	txtDOC_NUMBER.value	= lrRet.get("DOC_NUMBER");
	del_status = lrRet.get("DEL_STATUS");

}
//공급자등록번호찾기
function	btnSUP_REGNUM_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;
	
	lrArgs.set("AS_SB_GB1", "SUP");
	lrArgs.set("COM_ID1", sComid);
	lrArgs.set("AS_SB_GB2", "SUP");
	lrArgs.set("COM_ID2", sComid);	
	lrArgs.set("SET_CONDITION1", "");
	lrArgs.set("SET_CONDITION2", "");

	lrRet = C_LOV("TB_WT_PLANT_COMPANY", lrArgs,"F");
	
	if (lrRet == null) return;

	txtSUP_REGNUM.value	  = lrRet.get("REG_NUM");
	txtSUP_COMPANY.value	= lrRet.get("COMPANY");
	txtSUP_EMPLOYER.value	= lrRet.get("EMPLOYER");
	txtSUP_ADDRESS.value	= lrRet.get("ADDRESS");
	txtSUP_BIZCOND.value	= lrRet.get("BIZ_COND");
	txtSUP_BIZITEM.value	= lrRet.get("BIZ_ITEM");			
	txtSUP_ID.value	      = lrRet.get("WEBTAX21_ID");
	txtDOC_COM_ID.value	  = lrRet.get("COM_ID");
	
}
//공급받는자등록번호찾기
function	btnBUY_REGNUM_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;
	
	lrArgs.set("AS_SB_GB1", "BUY");
	lrArgs.set("COM_ID1", sComid);
	lrArgs.set("AS_SB_GB2", "BUY");
	lrArgs.set("COM_ID2", sComid);	
	lrArgs.set("SET_CONDITION1", "");
	lrArgs.set("SET_CONDITION2", "");

	lrRet = C_LOV("TB_WT_PLANT_COMPANY", lrArgs,"F");
	
	if (lrRet == null) return;

	txtBUYCOM_ID.value	  = lrRet.get("COM_ID");
	txtBUY_ID.value	      = lrRet.get("WEBTAX21_ID");
	txtBUY_REGNUM.value	  = lrRet.get("REG_NUM");
	txtBUY_COMPANY.value	= lrRet.get("COMPANY");
	txtBUY_EMPLOYER.value	= lrRet.get("EMPLOYER");
	txtBUY_ADDRESS.value	= lrRet.get("ADDRESS");
	txtBUY_BIZCOND.value	= lrRet.get("BIZ_COND");
	txtBUY_BIZITEM.value	= lrRet.get("BIZ_ITEM");	
	txtRECEIVER.value 		= lrRet.get("WEBTAX21_ID");
	
}
//공급받는자부서/성명찾기
function	btnBUY_EMPLOYEE_onClick()
{
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	if (C_isNull(txtBUY_REGNUM.value))
	{
			C_msgOk("공급받는자 등록번호를 입력하세요.","알림");
			return;
	}			
	
	lrArgs.set("COM_ID", txtBUYCOM_ID.value);
	lrArgs.set("REG_NUM", C_Trim(txtBUY_REGNUM.value).replace(/-/g,''));
	lrArgs.set("SET_CONDITION", "");

	lrRet = C_LOV("TB_WT_SECT_USER", lrArgs,"F");
	
	if (lrRet == null) return;
	
	txtBUY_SECTOR.value	= lrRet.get("SECT_NAME");
	txtBUY_EMPLOYEE.value	  = lrRet.get("EMP_NAME");
	txtBUY_EMPID.value	= lrRet.get("EMP_NO");
	txtBUY_EMPEMAIL.value	= lrRet.get("EMAIL");
	txtBUY_EMPMOBILe.value	= lrRet.get("MOBILE");
	
}
function btnGEN_TM_onClick()
{
	C_Calendar("GEN_TM", "D", txtGEN_TM.value);
}
function Input_Error_Check()
{
	if (C_isNull(cboREF_TYPE.value))
	{
		C_msgOk("[청구영수구분]은 필수입력 항목입니다.", "확인");
		cboREF_TYPE.focus();
		vError_Flag = "T";
		return;
	}
	if (C_isNull(cboTAX_TYPE.value))
	{
		C_msgOk("[세무구분]은 필수입력 항목입니다.", "확인");
		cboTAX_TYPE.focus();
		vError_Flag = "T";
		return;
	}	
	if (C_isNull(cboMSG_TYPE.value))
	{
		C_msgOk("[발행방향]은 필수입력 항목입니다.", "확인");
		cboMSG_TYPE.focus();
		vError_Flag = "T";
		return;
	}		
	if (C_isNull(txtSUP_REGNUM.value))
	{
		C_msgOk("[공급자사업번호]는 필수입력 항목입니다.", "확인");
		txtSUP_REGNUM.focus();
		vError_Flag = "T";
		return;
	}
	if (C_isNull(txtSUP_COMPANY.value))
	{
		C_msgOk("[공급자회사명]은 필수입력 항목입니다.", "확인");
		txtSUP_COMPANY.focus();
		vError_Flag = "T";
		return;
	}
	
	if (C_isNull(txtSUP_EMPLOYER.value))
	{
		C_msgOk("[공급자대표자]는 필수입력 항목입니다.", "확인");
		txtSUP_EMPLOYER.focus();
		vError_Flag = "T";
		return;
	}
	if (C_isNull(txtSUP_ADDRESS.value))
	{
		C_msgOk("[공급자주소]는 필수입력 항목입니다.", "확인");
		txtSUP_ADDRESS.focus();
		vError_Flag = "T";
		return;
	}	
	if (C_isNull(txtSUP_BIZCOND.value))
	{
		C_msgOk("[공급자업종]은 필수입력 항목입니다.", "확인");
		txtSUP_BIZCOND.focus();
		vError_Flag = "T";
		return;
	}		
	if (C_isNull(txtSUP_BIZITEM.value))
	{
		C_msgOk("[공급자업태]은 필수입력 항목입니다.", "확인");
		txtSUP_BIZITEM.focus();
		vError_Flag = "T";
		return;
	}
	if (C_isNull(txtSUP_SECTOR.value))
	{
		C_msgOk("[공급자담당부서]는 필수입력 항목입니다.", "확인");
		txtSUP_SECTOR.focus();
		vError_Flag = "T";
		return;
	}	
	
	if (C_isNull(txtBUY_REGNUM.value))
	{
		C_msgOk("[공급받는자사업번호]는 필수입력 항목입니다.", "확인");
		txtBUY_REGNUM.focus();
		vError_Flag = "T";
		return;
	}
	if (C_isNull(txtBUY_COMPANY.value))
	{
		C_msgOk("[공급받는자회사명]은 필수입력 항목입니다.", "확인");
		txtBUY_COMPANY.focus();
		vError_Flag = "T";
		return;
	}	
	if (C_isNull(txtBUY_EMPLOYER.value))
	{
		C_msgOk("[공급받는자대표자]는 필수입력 항목입니다.", "확인");
		txtBUY_EMPLOYER.focus();
		vError_Flag = "T";
		return;
	}		
	if (C_isNull(txtBUY_ADDRESS.value))
	{
		C_msgOk("[공급받는자주소]는 필수입력 항목입니다.", "확인");
		txtBUY_ADDRESS.focus();
		vError_Flag = "T";
		return;
	}
	if (C_isNull(txtBUY_BIZCOND.value))
	{
		C_msgOk("[공급받는자업종]은 필수입력 항목입니다.", "확인");
		txtBUY_BIZCOND.focus();
		vError_Flag = "T";
		return;
	}		

  if ( txtBUYCOM_ID.value != 'Z999')
  {
		if (C_isNull(txtBUY_SECTOR.value))
		{
			C_msgOk("[공급받는자담당부서]는 필수입력 항목입니다.", "확인");
			txtBUY_SECTOR.focus();
			vError_Flag = "T";
			return;
		}
		if (C_isNull(txtBUY_EMPLOYEE.value))
		{
			C_msgOk("[공급받는자담당자명]은 필수입력 항목입니다.", "확인");
			txtBUY_EMPLOYEE.focus();
			vError_Flag = "T";
			return;
		}	
	}		
	if (C_isNull(txtGEN_TM.value))
	{
		C_msgOk("[작성일]는 필수입력 항목입니다.", "확인");
		txtGEN_TM.focus();
		vError_Flag = "T";
		return;
	}		
	//공급자사업번호와 공급받는자 사업번호 Check
	if ( txtSUP_REGNUM.value == txtBUY_REGNUM.value )
	{
		C_msgOk("[공급자사업번호]와 [공급받는자사업번호]가 동일합니다.", "확인");
		txtBUY_REGNUM.focus();
		vError_Flag = "T";
		return;
	}
	//거래명세 필수항목 Check
	for (j=1;j<=dsSLIP_D.CountRow;j++) {
		if (C_isNull(dsSLIP_D.NameString(j,"TAX_GENDATE")))
		{
			C_msgOk("[거래일]은 필수입력 항목입니다.", "확인");
			vError_Flag = "T";
			return;
		}
		if (C_isNull(dsSLIP_D.NameString(j,"ITEM_NAME")))
		{
			C_msgOk("[상품명]은 필수입력 항목입니다.", "확인");
			vError_Flag = "T";
			return;
		}
		if (C_isNull(dsSLIP_D.NameString(j,"TAX_SUPPRICE")) || dsSLIP_D.NameString(j,"TAX_SUPPRICE") == 0 )
		{
			C_msgOk("[공급가액]은 필수입력 항목입니다.", "확인");
			vError_Flag = "T";
			return;
		}
	}			

	if ( dsSLIP_D.CountRow > 8 )
	{
		dsSLIP_H.Namestring(1,"TX_REQ") = "T" ;
		//txtTX_REQ.value = "T" ;
	}			
}	
function btnADDROW_onclick()
{
	if (dsSLIP_H.CountRow == 0 )
	{
		C_msgOk("조회를 먼저하세요", "확인");
		return;
	}

	G_addRow(dsSLIP_D);
	dsSLIP_D.NameString(dsSLIP_D.CountRow,"TAX_GENDATE") 	= sDate.replace(/-/g,'') ;
	dsSLIP_D.NameString(dsSLIP_D.CountRow,"ITEM_SEQ") 		= dsSLIP_D.CountRow ;
	dsSLIP_D.NameString(dsSLIP_D.CountRow,"DOC_NUMBER") 	= dsSLIP_H.NameString(1,"DOC_NUMBER") ;
	dsSLIP_D.NameString(dsSLIP_D.CountRow,"COM_ID")     	= dsSLIP_H.NameString(1,"DOC_COM_ID") ;
	dsSLIP_D.NameString(dsSLIP_D.CountRow,"MTSID")     		= " ";
	
}
function btnDELETEROW_onClick()
{
	if (dsSLIP_H.CountRow == 0 )
	{
		C_msgOk("조회를 먼저하세요", "확인");
		return;
	}
	G_deleteRow(dsSLIP_D);
	
}
function button_onClick( status )
{
	if ( status == "T" )
	{
		document.all.btnSUP_REGNUM.disabled			= false;
		document.all.btnBUY_REGNUM.disabled			= false;
		document.all.btnBUY_EMPLOYEE.disabled		= false;
	}
	else if ( status == "F" )
	{
		document.all.btnSUP_REGNUM.disabled			= true;
		document.all.btnBUY_REGNUM.disabled			= true;
		document.all.btnBUY_EMPLOYEE.disabled		= true;
	}	
}
function cboTAX_TYPE_onChange()
{
	if ( cboTAX_TYPE.value == "VAT")
	{ 
		var supprice = C_convSafeFloat(C_removeComma(txtTAX_SUPPRICE.value,false),false)
		var taxprice = C_Round( C_convSafeFloat(C_removeComma(txtTAX_SUPPRICE.value,false),false) * 0.1 , 0) ;
		
		txtTAX_TAXPRICE.value = C_toNumberFormatString( taxprice ,false)
		txtPAY_TOTALPRICE.value = supprice + taxprice ;
		//거래명세 
		for (i=1;i<=dsSLIP_D.CountRow;i++) {
			dsSLIP_D.NameString(i,"TAX_TAXPRICE") = C_Round( dsSLIP_D.NameString(i,"TAX_SUPPRICE") * 0.1 , 0); 
		}
	}
	else
	{
		var supprice = C_convSafeFloat(C_removeComma(txtTAX_SUPPRICE.value,false),false)
				
		txtTAX_TAXPRICE.value 	= 0;
		txtPAY_TOTALPRICE.value = supprice ;
		//거래명세 
		for (i=1;i<=dsSLIP_D.CountRow;i++) {
			dsSLIP_D.NameString(i,"TAX_TAXPRICE") = 0 ;
		}		
	}	
}
function btnCANCEL_onclick()
{
		if(dsSLIP_D.CountRow==0) return;
	  if( ( dsSLIP_H.RowStatus(1) != 0 ) && ( dsSLIP_H.RowStatus(1) != 3 ) ) { 
	  		return;
		}
		if  ( C_msgYesNo("전자세금계산서 발행취소처리를 하시겠습니까?", "발행취소확인") != "Y" ) return;
		if  ( C_msgYesNo("정말로 전자세금계산서 발행취소처리를 하시겠습니까?", "발행취소재확인") != "Y" ) return;
		
		var vstatus = C_Trim(txtSTATUS.value) ;
    if ( vstatus != "ACK")
    {
    	C_msgOk("처리상태가 승인된 내역만 발행취소할 수 있습니다.","처리상태 확인");
    	return;
    }	
    
    txtSTATUS.value = "RDY";
    var doc_number = dsSLIP_H.NameString(1,"DOC_NUMBER").substr(0,20)
    if ( doc_number.substr(21,1) != "R" )
    {
    		dsSLIP_H.NameString(1,"DOC_NUMBER")= doc_number + 'R' ; 
    }     		
		dsSLIP_H.NameString(1,"RES_FLAG")= "0" ; 
 	
		//거래명세 
		for (i=1;i<=dsSLIP_D.CountRow;i++) {
			dsSLIP_D.NameString(i,"DOC_NUMBER") 	= dsSLIP_H.NameString(1,"DOC_NUMBER"); 
			dsSLIP_D.NameString(i,"ITEM_DANGA") 	= dsSLIP_D.NameString(i,"ITEM_DANGA") * -1; 
			if ( dsSLIP_D.NameString(i,"ITEM_DANGA") == 0 )
			{
				dsSLIP_D.NameString(i,"TAX_SUPPRICE") 	= dsSLIP_D.NameString(i,"TAX_SUPPRICE") * -1; 
				dsSLIP_D.NameString(i,"TAX_TAXPRICE") 	= dsSLIP_D.NameString(i,"TAX_TAXPRICE") * -1; 
			}				
			dsSLIP_D.UserStatus(i) = 1;
		}	

		dsSLIP_H.NameString(1,"GEN_TM")					= txtGEN_TM.value.replace(/-/g,''); 
		dsSLIP_H.NameString(1,"TAX_SUPPRICE")		= dsSLIP_D.NameSum("TAX_SUPPRICE",0,0); 
		dsSLIP_H.NameString(1,"TAX_TAXPRICE")		= dsSLIP_D.NameSum("TAX_TAXPRICE",0,0);
		dsSLIP_H.NameString(1,"PAY_TOTALPRICE")	= dsSLIP_D.NameSum("TAX_SUPPRICE",0,0) + dsSLIP_D.NameSum("TAX_TAXPRICE",0,0);
		dsSLIP_H.NameString(1,"ITEM_NUM")				= dsSLIP_D.CountRow;
		dsSLIP_H.UserStatus(1) = 1;

		trans.Parameters = "ACT=SLIP_H";
		if(!G_saveData(dsSLIP_H)) {
			txtDOC_NUMBER.value = dsSLIP_H.NameString(1,"DOC_NUMBER").substr(0,20);			
			dsSLIP_H.ResetStatus();
			dsSLIP_D.ResetStatus();
			btnquery_onclick();
			return;
		}
//		trans.Parameters = "ACT=SLIP_D";
//		if(!G_saveData(dsSLIP_D)) {
//			txtDOC_NUMBER.value = dsSLIP_H.NameString(1,"DOC_NUMBER").substr(0,20);			
//			dsSLIP_H.ResetStatus();
//			dsSLIP_D.ResetStatus();
//			btnquery_onclick();
//			return;
//		}

		C_msgOk("발행취소가 완료되었습니다.", "확인");
		
		// 문서번호을 가져와 다시 조회한다.
		txtDOC_NUMBER.value = dsSLIP_H.NameString(1,"DOC_NUMBER");
		dsSLIP_H.ResetStatus();
		dsSLIP_D.ResetStatus();
		btnquery_onclick();    
		
}
function btnCREATE_onclick()
{
		if(dsSLIP_D.CountRow==0) return;
	  if( ( dsSLIP_H.RowStatus(1) != 0 ) && ( dsSLIP_H.RowStatus(1) != 3 ) ) { 
	  		return;
		}		
		if  ( C_msgYesNo("전자세금계산서 발행처리를 하시겠습니까?", "발행확인") != "Y" ) return;
		
		var vstatus = C_Trim(txtSTATUS.value) ;
    if ( vstatus == "INS")
    {
    	//txtSTATUS.value = "RDY";
    	vRDY_Flag = "RDY"; 
    }
  	else if ( vstatus == "RDY")
    {
    	C_msgOk("이미 세금계산서 발행처리가 완료되었습니다. !","확인");
    	return;
    }
  	else
    {
    	C_msgOk("처리상태가 작업중인 것만 발행처리할수 있습니다. !","확인");
    	return;
    }
	
		btnsave_onclick();    
}
function btnFileLoad_onClick()
{
	if (dsSLIP_H.CountRow == 0 )
	{
		C_msgOk("세금계산서 내역을 먼저 입력하세요.", "확인");
		return;
	}	
	
	if(fileUploadForm.fileCMS.value == '')
	{
			C_msgOk("파일을 선택하십시오.","확인");
			return;
	} 
		
	fileUploadForm.action =	"./t_WETaxSaleR_u.jsp?ACT=FILE";
	fileUploadForm.submit();
	
	G_Load(dsITEM);
	
	//거래명세 
	for (i=1;i<=dsITEM.CountRow;i++) {
		G_addRow(dsSLIP_D);
		dsSLIP_D.NameString(dsSLIP_D.CountRow,"ITEM_SEQ") 		= dsSLIP_D.CountRow ;		
		dsSLIP_D.NameString(dsSLIP_D.CountRow,"TAX_GENDATE") 	= dsITEM.NameString(i,"TAX_GENDATE"); 
		dsSLIP_D.NameString(dsSLIP_D.CountRow,"ITEM_CODE") 		= dsITEM.NameString(i,"ITEM_CODE"); 
		dsSLIP_D.NameString(dsSLIP_D.CountRow,"ITEM_NAME") 		= dsITEM.NameString(i,"ITEM_NAME"); 
		dsSLIP_D.NameString(dsSLIP_D.CountRow,"ITEM_UNIT") 		= dsITEM.NameString(i,"ITEM_UNIT"); 
		dsSLIP_D.NameString(dsSLIP_D.CountRow,"ITEM_NUM") 		= dsITEM.NameString(i,"ITEM_NUM"); 
		dsSLIP_D.NameString(dsSLIP_D.CountRow,"ITEM_DANGA") 	= dsITEM.NameString(i,"ITEM_DANGA"); 
		dsSLIP_D.NameString(dsSLIP_D.CountRow,"TAX_SUPPRICE") = dsITEM.NameString(i,"TAX_SUPPRICE"); 
		dsSLIP_D.NameString(dsSLIP_D.CountRow,"TAX_TAXPRICE") = dsITEM.NameString(i,"TAX_TAXPRICE"); 
		dsSLIP_D.NameString(dsSLIP_D.CountRow,"ITEM_BIGO") 		= dsITEM.NameString(i,"ITEM_BIGO"); 

		dsSLIP_D.NameString(dsSLIP_D.CountRow,"DOC_NUMBER") 	= dsSLIP_H.NameString(1,"DOC_NUMBER") ;
		dsSLIP_D.NameString(dsSLIP_D.CountRow,"COM_ID")     	= dsSLIP_H.NameString(1,"DOC_COM_ID") ;
		dsSLIP_D.NameString(dsSLIP_D.CountRow,"MTSID")     		= " ";
	}		
	
}
//인쇄
function btnquery_prt_onclick()
{
	if (dsSLIP_H.CountRow == 0 )	return;
  if( ( dsSLIP_H.RowStatus(1) != 0 ) && ( dsSLIP_H.RowStatus(1) != 3 ) ) { // 0 : 조회, 1 : 추가, 2 : 삭제, 3 : 수정
  		return;
	}	
	// 프로그래머 유효성검사 추가
	// 보고서 디렉토리
  var reportFile = "r_t_140001";
   	
	frmList.EXPORT_TAG.value = 'P';//cboExportTag.value;
	frmList.RUN_TAG.value = '1';//cboRunTag.value;
	frmList.REQUEST_NAME.value = '';//txtRequestName.value;
	frmList.REPORT_NO.value = '--';
	frmList.REPORT_FILE_NAME.value = reportFile +'.rpt';
	
	
	var strTemp = "";
	var strdoc_number = C_Trim(txtDOC_NUMBER.value) ;
	var strdoc_com_id = txtDOC_COM_ID.value ;
	// 프로그래머 파라메터 추가
	// 파라메터1__값1&&파라메터2__값2&&....
	// 예제
	strTemp += "DOC_NUMBER__" + strdoc_number + "&&";
	strTemp += "DOC_COM_ID__" + strdoc_com_id;
	
	//alert(frmList.REPORT_FILE_NAME.value);
	frmList.PARAMETERS.value = strTemp;
	
	if (!S_Submit(document.all)) return;
	frmList.submit();
	S_ObjectAllFormat(document.all);
	strTemp ="";
}
