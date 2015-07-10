/**************************************************************************/
/* 1. 프 로 그 램 id : t_WETaxSale2R(세금계산서대량등록)
/* 2. 유형(시나리오) : 사업장의 조회 및 입력
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 배민정 작성(2005-11-11)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 :
/**************************************************************************/
var p;
var ph;
var peer;
var del_status;
var vError_Flag = null;
var vOBJ = null;
var doc_yymm;
function Initialize()
{
	G_addDataSet(dsMAIN, trans, gridMAIN, null, "세금계산서");
	G_addDataSet(dsSUB01,trans, gridSUB01, null, "거래명세서");	
	G_addDataSet(dsSERIAL, null, null, null, "일련번호");	
	G_addDataSet(dsITEM, null, null, null, "upload");	
	G_addDataSet(dsREGNUM, null, null, null, "사업자번호");	
	G_addDataSet(dsUSER, null, null, null, "사용자");	
	G_addDataSet(dsLOV, null, null, null, "LOV");

	//G_addRel(dsMAIN,dsSUB01);
	//G_addRelCol(dsSUB01,"DOC_NUMBER","DOC_NUMBER");	
	G_setLovCol(gridMAIN,"BUY_REGNUM");
	G_setLovCol(gridMAIN,"BUY_EMPID");
	G_setLovCol(gridMAIN,"GEN_TM");
	G_setLovCol(gridSUB01,"TAX_GENDATE");
	G_setLovCol(gridSUB01,"ITEM_CODE");
	
	G_Load(dsMAIN);
	G_Load(dsSUB01);

}
function OnLoadBefore(dataset)
{
	if(dataset == dsMAIN)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","MAIN")
											+ D_P2("DOC_NUMBER"," ")	;
	}
  else if(dataset == dsSUB01)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","SUB01")
											+ D_P2("DOC_NUMBER" ," ");
	}											
  else if(dataset == dsSERIAL)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","SERIAL")
											+ D_P2("DOC_COM_ID" ,sComid)
											+ D_P2("DOC_YYMM" ,doc_yymm);

	}
  else if(dataset == dsITEM)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","ITEM");
	}	
  else if(dataset == dsREGNUM)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","REGNUM")
											+ D_P2("REG_NUM" ,dsMAIN.NameString(dsMAIN.CountRow,"BUY_REGNUM").substr(0,10));
	}	
  else if(dataset == dsUSER)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","USER")
											+ D_P2("COM_ID" ,dsMAIN.NameString(dsMAIN.CountRow,"BUY_COM_ID"))
											+ D_P2("USER" ,dsMAIN.NameString(dsMAIN.CountRow,"BUY_EMPID"));
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
	G_Load(dsMAIN, null);
	G_Load(dsSUB01, null);
	fileUploadForm.fileCMS.value = "";
}

// 추가
function btnadd_onclick()
{

}

// 삽입
function btninsert_onclick()
{

}

// 삭제
function btndelete_onclick()
{

}

// 저장
function btnsave_onclick()
{
	var v_all_doc_number = "";
		  
	if (dsSUB01.CountRow == 0)
	{
		C_msgOk("저장할 계산서내역이 없습니다.", "확인");
		return false;
	}  
	
	for (i=1;i<=dsMAIN.CountRow;i++) {

	  // 문서번호 : 회사ID(4) + 년월(6) + 일련번호 (10)
	  var com_id = txtDOC_COM_ID.value ;
	  doc_yymm = dsMAIN.NameString(i,"DOC_YYMM") ;	  
	  var buy_regnum = C_Trim(dsMAIN.NameString(i,"BUY_REGNUM")) ;

 		// 일련번호(10자리)
 		if ( i==1 )
 		{
	  	G_Load(dsSERIAL); 
	  	var serial = dsSERIAL.NameString(1,"REF_SERIAL"); 	
		}
		else
		{
			serial = Number(serial) + 1
			serial = C_LPad( serial.toString() ,10,'0');
	  }	

		dsMAIN.NameString(i,"DOC_NUMBER")	= com_id + doc_yymm + serial;
	  dsMAIN.NameString(i,"REF_SERIAL")	= serial;
	  
	  v_all_doc_number = v_all_doc_number + dsMAIN.NameString(i,"DOC_NUMBER") + " " 
	  
	  var seq = 0;
	  var tax_supprice = 0;
	  var tax_taxprice = 0;
		//거래명세 항목 SET
		for (j=1;j<=dsSUB01.CountRow;j++) {
			if ( C_Trim(dsSUB01.NameString(j,"BUY_REGNUM")) == buy_regnum )
			{
				dsSUB01.NameString(j,"DOC_NUMBER") = dsMAIN.NameString(i,"DOC_NUMBER") ;
				seq = seq + 1
				dsSUB01.NameString(j,"ITEM_SEQ")   = seq  ;
				tax_supprice = tax_supprice + C_convSafeFloat( dsSUB01.NameString(j,"TAX_SUPPRICE"),false);
				tax_taxprice = tax_taxprice + C_convSafeFloat( dsSUB01.NameString(j,"TAX_TAXPRICE"),false);
			}
			dsSUB01.NameString(j,"TAX_GENDATE") = dsSUB01.NameString(j,"TAX_GENDATE").replace(/-/g,'');
		}	
		
		dsMAIN.NameString(i,"GEN_TM") 				= dsMAIN.NameString(i,"GEN_TM").replace(/-/g,'');
		dsMAIN.NameString(i,"TAX_SUPPRICE")		= tax_supprice; 
		dsMAIN.NameString(i,"TAX_TAXPRICE")		= tax_taxprice;
		dsMAIN.NameString(i,"PAY_TOTALPRICE")	= tax_supprice + tax_taxprice;
		dsMAIN.NameString(i,"ITEM_NUM")				= seq;		
		if ( seq > 8 )
		{
			dsMAIN.NameString(i,"TX_REQ") = "T" ;
		}

		/* 필수항목체크 */
		Input_Error_Check(i);
		
		if (vError_Flag == 'T')
		{
			vError_Flag = "F";
			return false;
		}		
	}  

	trans.Parameters = "ACT=MAIN";
	if(!G_saveData(dsMAIN)) {
		return;
	}

	C_msgOk("작업이 저장되었습니다." + "<BR>" + v_all_doc_number , "확인");

}

// 취소
function btncancel_onclick()
{
	if (G_FocusObject != null) G_FocusObject.focus();
	G_Load(dsMAIN, null);
	G_Load(dsSUB01, null);
	fileUploadForm.fileCMS.value = "";	
}

// 공통 재정의 이벤트관련-------------------------------------------------------//
function CalendarResult(asCalendarID, asDate, asYear, asMonth, asDay)
{
	if (asCalendarID == "GEN_TM")
	{
		dsMAIN.NameString(dsMAIN.RowPosition,"GEN_TM") = asDate;
	}
	else if (asCalendarID == "TAXGENDATE")
	{
		dsSUB01.NameString(dsSUB01.RowPosition,"TAX_GENDATE") = asDate;
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
}

function OnExit(dataset, grid, row, colid, olddata)
{
		if(colid == "TAX_GENDATE" )
		{
			D_defaultDateProcessInGrid(dataset, row, colid, olddata,dataset.NameString(row,"TAX_GENDATE"));
			 
		}
		else if(colid == "GEN_TM" )
		{
			D_defaultDateProcessInGrid(dataset, row, colid, olddata,dataset.NameString(row,"GEN_TM"));
			 
		}			
		else if(colid == "ITEM_CODE" )
		{		
			//제품검색
			var lrArgs = new C_Dictionary();
			var lrRet = null;
			
			lrArgs.set("COM_ID", dataset.NameString(row,"COM_ID"));
			lrArgs.set("SEARCH_CONDITION", dataset.NameString(row,colid));
			
			lrRet = C_AutoLov(dsLOV,"TB_WT_ITEM", lrArgs,"T");
			
			if (lrRet == null)
			{
				dataset.NameString(row,"ITEM_CODE") = "";
				dataset.NameString(row,"ITEM_NAME") = "";
				dataset.NameString(row,"ITEM_UNIT") = "";
			}				
			else
			{
				dataset.NameString(row,"ITEM_CODE") = lrRet.get("ITEM_CODE");
				dataset.NameString(row,"ITEM_NAME") = lrRet.get("ITEM_NAME");
				dataset.NameString(row,"ITEM_UNIT") = lrRet.get("ITEM_SIZE");
			}			

		}
		else if(colid == "BUY_REGNUM" )
		{		
			//공급받는자사업자번호
			var	lsNewData = dataset.NameString(row,colid);
			if(lsNewData == olddata) return;
			if(C_isNull(lsNewData))
			{
				dataset.NameString(row,"BUY_COM_ID") 	 = "";
				dataset.NameString(row,"BUY_ID")			 = "";
				dataset.NameString(row,"BUY_REGNUM") 	 = "";
				dataset.NameString(row,"BUY_COMPANY")  = "";
				dataset.NameString(row,"BUY_EMPLOYER") = "";
				dataset.NameString(row,"BUY_ADDRESS")  = "";
				dataset.NameString(row,"BUY_BIZCOND")  = "";
				dataset.NameString(row,"BUY_BIZITEM")  = "";
				dataset.NameString(row,"RECEIVER") 		 = "";
				dataset.NameString(row,"BUY_EMPID") 	 = "";
				return;
			}			
			var lrArgs = new C_Dictionary();
			var lrRet = null;
			
			lrArgs.set("AS_SB_GB1", "BUY");
			lrArgs.set("COM_ID1", sComid);
			lrArgs.set("AS_SB_GB2", "BUY");
			lrArgs.set("COM_ID2", sComid);	
			lrArgs.set("SET_CONDITION1", dataset.NameString(row,"BUY_COM_ID"));
			lrArgs.set("SET_CONDITION2", dataset.NameString(row,colid));
		
			lrRet = C_AutoLov(dsLOV,"TB_WT_PLANT_COMPANY", lrArgs,"T");

			if (lrRet == null)
			{
				dataset.NameString(row,"BUY_COM_ID") 	 = "";
				dataset.NameString(row,"BUY_ID")			 = "";
				dataset.NameString(row,"BUY_REGNUM") 	 = "";
				dataset.NameString(row,"BUY_COMPANY")  = "";
				dataset.NameString(row,"BUY_EMPLOYER") = "";
				dataset.NameString(row,"BUY_ADDRESS")  = "";
				dataset.NameString(row,"BUY_BIZCOND")  = "";
				dataset.NameString(row,"BUY_BIZITEM")  = "";
				dataset.NameString(row,"RECEIVER") 		 = "";
				dataset.NameString(row,"BUY_EMPID") 	 = "";
			}				
			else
			{
				dataset.NameString(row,"BUY_COM_ID") 	 = lrRet.get("COM_ID");
				dataset.NameString(row,"BUY_ID")			 = lrRet.get("WEBTAX21_ID");
				dataset.NameString(row,"BUY_REGNUM") 	 = lrRet.get("REG_NUM");
				dataset.NameString(row,"BUY_COMPANY")  = lrRet.get("COMPANY");
				dataset.NameString(row,"BUY_EMPLOYER") = lrRet.get("EMPLOYER");
				dataset.NameString(row,"BUY_ADDRESS")  = lrRet.get("ADDRESS");
				dataset.NameString(row,"BUY_BIZCOND")  = lrRet.get("BIZ_COND");
				dataset.NameString(row,"BUY_BIZITEM")  = lrRet.get("BIZ_ITEM");
				dataset.NameString(row,"RECEIVER") 		 = lrRet.get("WEBTAX21_ID");
				dataset.NameString(row,"BUY_EMPID") 	 = "";
			}
			
			for (i=1;i<=dsSUB01.CountRow;i++) {
				if (dsSUB01.NameString(i,"BUY_REGNUM") == olddata )
				{
					dsSUB01.NameString(i,"BUY_REGNUM") = dataset.NameString(row,"BUY_REGNUM"); 
				}
			}			
		}		
		else if(colid == "BUY_EMPID" )
		{		
			//공급받는자부서/성명찾기
			var	lsNewData = dataset.NameString(row,colid);
			if(lsNewData == olddata) return;
			if(C_isNull(lsNewData))
			{
				dataset.NameString(row,"BUY_SECTOR") 	 = "";
				dataset.NameString(row,"BUY_EMPLOYEE") = "";
				dataset.NameString(row,"BUY_EMPID") 	 = "";
				dataset.NameString(row,"BUY_EMPEMAIL") = "";
				dataset.NameString(row,"BUY_EMPMOBILE")= "";
				return;
			}						
			var lrArgs = new C_Dictionary();
			var lrRet = null;

			if (C_isNull(dataset.NameString(row,"BUY_REGNUM")))
			{
					C_msgOk("공급받는자 등록번호를 입력하세요.","알림");
					return;
			}			
			
			lrArgs.set("COM_ID", dataset.NameString(row,"BUY_COM_ID"));
			lrArgs.set("REG_NUM", C_Trim(dataset.NameString(row,"BUY_REGNUM")));
			lrArgs.set("SET_CONDITION", dataset.NameString(row,colid));
		
			lrRet = C_AutoLov(dsLOV,"TB_WT_SECT_USER", lrArgs,"T");
			if (lrRet == null)
			{
				dataset.NameString(row,"BUY_SECTOR") 	 = "";
				dataset.NameString(row,"BUY_EMPLOYEE") = "";
				dataset.NameString(row,"BUY_EMPID") 	 = "";
				dataset.NameString(row,"BUY_EMPEMAIL") = "";
				dataset.NameString(row,"BUY_EMPMOBILE")= "";
			}				
			else
			{
				dataset.NameString(row,"BUY_SECTOR") 	 = lrRet.get("SECT_NAME");
				dataset.NameString(row,"BUY_EMPLOYEE") = lrRet.get("EMP_NAME");
				dataset.NameString(row,"BUY_EMPID") 	 = lrRet.get("EMP_NO");
				dataset.NameString(row,"BUY_EMPEMAIL") = lrRet.get("EMAIL");
				dataset.NameString(row,"BUY_EMPMOBILE")= lrRet.get("EMPLOYER");
			}
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
		else if(colid == "GEN_TM" )
		{
			var lrArgs = new C_Dictionary();
			var lrRet = null;
			
		  C_Calendar("GEN_TM", "D", dataset.NameString(row,"GEN_TM"));
		}		  		
		else if(colid == "ITEM_CODE"  )
		{
			var lrArgs = new C_Dictionary();
			var lrRet = null;
			
			lrArgs.set("COM_ID", dataset.NameString(row,"COM_ID"));
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
		else if(colid == "BUY_REGNUM"  )
		{
			var olddata = dataset.NameString(row,"BUY_REGNUM");
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
		
			dataset.NameString(row,"BUY_COM_ID") 	 = lrRet.get("COM_ID");
			dataset.NameString(row,"BUY_ID")			 = lrRet.get("WEBTAX21_ID");
			dataset.NameString(row,"BUY_REGNUM") 	 = lrRet.get("REG_NUM");
			dataset.NameString(row,"BUY_COMPANY")  = lrRet.get("COMPANY");
			dataset.NameString(row,"BUY_EMPLOYER") = lrRet.get("EMPLOYER");
			dataset.NameString(row,"BUY_ADDRESS")  = lrRet.get("ADDRESS");
			dataset.NameString(row,"BUY_BIZCOND")  = lrRet.get("BIZ_COND");
			dataset.NameString(row,"BUY_BIZITEM")  = lrRet.get("BIZ_ITEM");
			dataset.NameString(row,"RECEIVER") 		 = lrRet.get("WEBTAX21_ID");
			dataset.NameString(row,"BUY_EMPID") 	 = "";
			
			for (i=1;i<=dsSUB01.CountRow;i++) {
				if (dsSUB01.NameString(i,"BUY_REGNUM") == olddata )
				{
					dsSUB01.NameString(i,"BUY_REGNUM") = dataset.NameString(row,"BUY_REGNUM"); 
				}
			}
		}
		else if(colid == "BUY_EMPID"  )
		{
			var lrArgs = new C_Dictionary();
			var lrRet = null;
		
			if (C_isNull(dataset.NameString(row,"BUY_REGNUM")))
			{
					C_msgOk("공급받는자 등록번호를 입력하세요.","알림");
					return;
			}			

			lrArgs.set("COM_ID", dataset.NameString(row,"BUY_COM_ID"));
			lrArgs.set("REG_NUM", C_Trim(dataset.NameString(row,"BUY_REGNUM")));
			lrArgs.set("SET_CONDITION", "");
		
			lrRet = C_LOV("TB_WT_SECT_USER", lrArgs,"F");
			
			if (lrRet == null) return;
			
			dataset.NameString(row,"BUY_SECTOR") 	 	= lrRet.get("SECT_NAME");
			dataset.NameString(row,"BUY_EMPLOYEE") 	= lrRet.get("EMP_NAME");
			dataset.NameString(row,"BUY_EMPID") 	 	= lrRet.get("EMP_NO");
			dataset.NameString(row,"BUY_EMPEMAIL") 	= lrRet.get("EMAIL");
			dataset.NameString(row,"BUY_EMPMOBILE")	= lrRet.get("EMPLOYER");
			dataset.NameString(row,"RECEIVER") 			= lrRet.get("EMP_NO"); 
		}	
}

// 이벤트관련-------------------------------------------------------------------//
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
function Input_Error_Check(row)
{
	if (C_isNull(dsMAIN.NameString(row,"REF_TYPE")))
	{
		C_msgOk("[청구영수구분]은 필수입력 항목입니다.", "확인");
		vError_Flag = "T";
		return;
	}
	if (C_isNull(dsMAIN.NameString(row,"TAX_TYPE")))
	{
		C_msgOk("[세무구분]은 필수입력 항목입니다.", "확인");
		vError_Flag = "T";
		return;
	}	
	if (C_isNull(dsMAIN.NameString(row,"MSG_TYPE")))
	{
		C_msgOk("[발행방향]은 필수입력 항목입니다.", "확인");
		vError_Flag = "T";
		return;
	}		
	if (C_isNull(dsMAIN.NameString(row,"SUP_REGNUM")))
	{
		C_msgOk("[공급자사업번호]는 필수입력 항목입니다.", "확인");
		vError_Flag = "T";
		return;
	}
	if (C_isNull(dsMAIN.NameString(row,"SUP_COMPANY")))
	{
		C_msgOk("[공급자회사명]은 필수입력 항목입니다.", "확인");
		vError_Flag = "T";
		return;
	}
	
	if (C_isNull(dsMAIN.NameString(row,"SUP_EMPLOYER")))
	{
		C_msgOk("[공급자대표자]는 필수입력 항목입니다.", "확인");
		vError_Flag = "T";
		return;
	}
	if (C_isNull(dsMAIN.NameString(row,"SUP_ADDRESS")))
	{
		C_msgOk("[공급자주소]는 필수입력 항목입니다.", "확인");
		vError_Flag = "T";
		return;
	}	
	if (C_isNull(dsMAIN.NameString(row,"SUP_BIZCOND")))
	{
		C_msgOk("[공급자업종]은 필수입력 항목입니다.", "확인");
		vError_Flag = "T";
		return;
	}		
	if (C_isNull(dsMAIN.NameString(row,"SUP_BIZITEM")))
	{
		C_msgOk("[공급자업태]은 필수입력 항목입니다.", "확인");
		vError_Flag = "T";
		return;
	}
	if (C_isNull(dsMAIN.NameString(row,"SUP_SECTOR")))
	{
		C_msgOk("[공급자담당부서]는 필수입력 항목입니다.", "확인");
		vError_Flag = "T";
		return;
	}	
	
	if (C_isNull(dsMAIN.NameString(row,"BUY_REGNUM")))
	{
		C_msgOk("[공급받는자사업번호]는 필수입력 항목입니다.", "확인");
		vError_Flag = "T";
		return;
	}
	if (C_isNull(dsMAIN.NameString(row,"BUY_COMPANY")))
	{
		C_msgOk("[공급받는자회사명]은 필수입력 항목입니다.", "확인");
		vError_Flag = "T";
		return;
	}	
	if (C_isNull(dsMAIN.NameString(row,"BUY_EMPLOYER")))
	{
		C_msgOk("[공급받는자대표자]는 필수입력 항목입니다.", "확인");
		vError_Flag = "T";
		return;
	}		
	if (C_isNull(dsMAIN.NameString(row,"BUY_ADDRESS")))
	{
		C_msgOk("[공급받는자주소]는 필수입력 항목입니다.", "확인");
		vError_Flag = "T";
		return;
	}
	if (C_isNull(dsMAIN.NameString(row,"BUY_BIZCOND")))
	{
		C_msgOk("[공급받는자업종]은 필수입력 항목입니다.", "확인");
		vError_Flag = "T";
		return;
	}		

  if ( dsMAIN.NameString(row,"BUY_COM_ID") != 'Z999')
  {
		if (C_isNull(dsMAIN.NameString(row,"BUY_EMPID")))
		{
			C_msgOk("[공급받는자담당자]는 필수입력 항목입니다.", "확인");
			vError_Flag = "T";
			return;
		}  	
  	
		if (C_isNull(dsMAIN.NameString(row,"BUY_SECTOR")))
		{
			C_msgOk("[공급받는자담당부서]는 필수입력 항목입니다.", "확인");
			vError_Flag = "T";
			return;
		}
		if (C_isNull(dsMAIN.NameString(row,"BUY_EMPLOYEE")))
		{
			C_msgOk("[공급받는자담당자명]은 필수입력 항목입니다.", "확인");
			vError_Flag = "T";
			return;
		}	
	}		
	if (C_isNull(dsMAIN.NameString(row,"GEN_TM")))
	{
		C_msgOk("[작성일]는 필수입력 항목입니다.", "확인");
		vError_Flag = "T";
		return;
	}		
	//공급자사업번호와 공급받는자 사업번호 Check
	if ( dsMAIN.NameString(row,"SUP_REGNUM") == dsMAIN.NameString(row,"BUY_REGNUM"))
	{
		C_msgOk("[공급자사업번호]와 [공급받는자사업번호]가 동일합니다.", "확인");
		vError_Flag = "T";
		return;
	}
	//거래명세 필수항목 Check
	for (j=1;j<=dsSUB01.CountRow;j++) {
		if (C_isNull(dsSUB01.NameString(j,"TAX_GENDATE")))
		{
			C_msgOk("[거래일]은 필수입력 항목입니다." + "[" + j + "]번째", "확인");
			vError_Flag = "T";
			return;
		}
		if (C_isNull(dsSUB01.NameString(j,"ITEM_NAME")))
		{
			C_msgOk("[상품명]은 필수입력 항목입니다." + "[" + j + "]번째", "확인");
			vError_Flag = "T";
			return;
		}
		if (C_isNull(dsSUB01.NameString(j,"TAX_SUPPRICE")) || dsSUB01.NameString(j,"TAX_SUPPRICE") == 0 )
		{
			C_msgOk("[공급가액]은 필수입력 항목입니다." + "[" + j + "]번째", "확인");
			vError_Flag = "T";
			return;
		}
	}			
}	
function btnFileLoad_onClick()
{
	if (C_isNull(txtSUP_REGNUM.value) )
	{
		C_msgOk("공급자 사업번호를 확인하세요.!!", "확인");
		return;
	}	
	
	if(fileUploadForm.fileCMS.value == '')
	{
			C_msgOk("파일을 입력하십시오.","확인");
			return;
	} 
		
	fileUploadForm.action =	"./t_WETaxSale2R_u.jsp?ACT=FILE";
	fileUploadForm.submit();

	G_Load(dsITEM);

	//거래명세 
	for (i=1;i<=dsITEM.CountRow;i++) {
		var findrow = dsMAIN.NameValueRow("BUY_REGNUM",dsITEM.NameString(i,"BUY_REGNUM"));
		if ( findrow == 0 )
		{
			G_addRow(dsMAIN);
			dsMAIN.NameString(dsMAIN.CountRow,"DOC_NUMBER") 	= "" ;
			dsMAIN.NameString(dsMAIN.CountRow,"REF_SERIAL") 	= "" ;
			dsMAIN.NameString(dsMAIN.CountRow,"DOC_COM_ID") 	= sComid ;		
			dsMAIN.NameString(dsMAIN.CountRow,"DOC_YYMM") 		= sDate.replace(/-/g,'').substr(0,6); 
			dsMAIN.NameString(dsMAIN.CountRow,"STATUS") 			= "INS"; 
			dsMAIN.NameString(dsMAIN.CountRow,"TX_REQ") 			= "F"; 
			dsMAIN.NameString(dsMAIN.CountRow,"DEL_STATUS") 	= "0"; 
			dsMAIN.NameString(dsMAIN.CountRow,"SENDER") 			= sEmpid; 
			dsMAIN.NameString(dsMAIN.CountRow,"RECEIVER") 		= dsITEM.NameString(i,"BUY_EMPID"); 
			dsMAIN.NameString(dsMAIN.CountRow,"REF_TYPE") 		= "REQ"; 
			dsMAIN.NameString(dsMAIN.CountRow,"TAX_TYPE") 		= "VAT"; 
			dsMAIN.NameString(dsMAIN.CountRow,"MSG_TYPE") 		= "380"; 
			dsMAIN.NameString(dsMAIN.CountRow,"RES_FLAG") 		= "1"; 
			dsMAIN.NameString(dsMAIN.CountRow,"SUP_ID") 			= txtSUP_ID.value; 
			dsMAIN.NameString(dsMAIN.CountRow,"SUP_REGNUM") 	= txtSUP_REGNUM.value; 
			dsMAIN.NameString(dsMAIN.CountRow,"SUP_COMPANY") 	= txtSUP_COMPANY.value; 
			dsMAIN.NameString(dsMAIN.CountRow,"SUP_EMPLOYER") = txtSUP_EMPLOYER.value;
			dsMAIN.NameString(dsMAIN.CountRow,"SUP_ADDRESS")  = txtSUP_ADDRESS.value;
			dsMAIN.NameString(dsMAIN.CountRow,"SUP_BIZCOND")  = txtSUP_BIZCOND.value;
			dsMAIN.NameString(dsMAIN.CountRow,"SUP_BIZITEM")  = txtSUP_BIZITEM.value;
			dsMAIN.NameString(dsMAIN.CountRow,"SUP_SECTOR") 	= sSectname;
			dsMAIN.NameString(dsMAIN.CountRow,"SUP_EMPID") 		= sEmpid; 
			dsMAIN.NameString(dsMAIN.CountRow,"SUP_EMPEMAIL") = sEmail; 
			dsMAIN.NameString(dsMAIN.CountRow,"SUP_EMPMOBILE")= sMobile; 
			dsMAIN.NameString(dsMAIN.CountRow,"BUY_REGNUM") 	= dsITEM.NameString(i,"BUY_REGNUM"); 
			G_Load(dsREGNUM);
			dsMAIN.NameString(dsMAIN.CountRow,"BUY_COM_ID") 	= dsREGNUM.NameString(1,"COM_ID"); 
			dsMAIN.NameString(dsMAIN.CountRow,"BUY_ID") 			= dsREGNUM.NameString(1,"WEBTAX21_ID"); 		
			dsMAIN.NameString(dsMAIN.CountRow,"BUY_COMPANY") 	= dsREGNUM.NameString(1,"COMPANY"); 
			dsMAIN.NameString(dsMAIN.CountRow,"BUY_EMPLOYER") = dsREGNUM.NameString(1,"EMPLOYER");
			dsMAIN.NameString(dsMAIN.CountRow,"BUY_ADDRESS") 	= dsREGNUM.NameString(1,"ADDRESS"); 
			dsMAIN.NameString(dsMAIN.CountRow,"BUY_BIZCOND") 	= dsREGNUM.NameString(1,"BIZ_COND");		
			dsMAIN.NameString(dsMAIN.CountRow,"BUY_BIZITEM") 	= dsREGNUM.NameString(1,"BIZ_ITEM");
			dsMAIN.NameString(dsMAIN.CountRow,"BUY_EMPID") 		= dsITEM.NameString(i,"BUY_EMPID");
			G_Load(dsUSER);
			dsMAIN.NameString(dsMAIN.CountRow,"BUY_SECTOR") 	= dsUSER.NameString(1,"SECT_NAME"); 
			dsMAIN.NameString(dsMAIN.CountRow,"BUY_EMPLOYEE") = dsUSER.NameString(1,"EMP_NAME");		
			dsMAIN.NameString(dsMAIN.CountRow,"BUY_EMPEMAIL") = dsUSER.NameString(1,"EMAIL");
			dsMAIN.NameString(dsMAIN.CountRow,"BUY_EMPMOBILE")= dsUSER.NameString(1,"MOBILE");
			dsMAIN.NameString(dsMAIN.CountRow,"SBM_TM")				= "";
			dsMAIN.NameString(dsMAIN.CountRow,"GEN_TM")				= dsITEM.NameString(i,"GEN_TM"); 
			dsMAIN.NameString(dsMAIN.CountRow,"TAX_SUPPRICE")	= 0;
			dsMAIN.NameString(dsMAIN.CountRow,"TAX_TAXPRICE")	= 0;
			dsMAIN.NameString(dsMAIN.CountRow,"PAY_TOTALPRICE")	= 0;
			dsMAIN.NameString(dsMAIN.CountRow,"TAX_BIGO")				= dsITEM.NameString(i,"TAX_BIGO"); ;
			dsMAIN.NameString(dsMAIN.CountRow,"ITEM_NUM")				= 0;
		}			
		G_addRow(dsSUB01);
		dsSUB01.NameString(dsSUB01.CountRow,"ITEM_SEQ") 		= dsSUB01.CountRow ;		
		dsSUB01.NameString(dsSUB01.CountRow,"TAX_GENDATE") 	= dsITEM.NameString(i,"TAX_GENDATE"); 
		dsSUB01.NameString(dsSUB01.CountRow,"ITEM_CODE") 		= dsITEM.NameString(i,"ITEM_CODE"); 
		dsSUB01.NameString(dsSUB01.CountRow,"ITEM_NAME") 		= dsITEM.NameString(i,"ITEM_NAME"); 
		dsSUB01.NameString(dsSUB01.CountRow,"ITEM_UNIT") 		= dsITEM.NameString(i,"ITEM_UNIT"); 
		dsSUB01.NameString(dsSUB01.CountRow,"ITEM_NUM") 		= dsITEM.NameString(i,"ITEM_NUM"); 
		dsSUB01.NameString(dsSUB01.CountRow,"ITEM_DANGA") 	= dsITEM.NameString(i,"ITEM_DANGA"); 
		dsSUB01.NameString(dsSUB01.CountRow,"TAX_SUPPRICE")	= dsITEM.NameString(i,"TAX_SUPPRICE"); 
		dsSUB01.NameString(dsSUB01.CountRow,"TAX_TAXPRICE") = dsITEM.NameString(i,"TAX_TAXPRICE"); 
		dsSUB01.NameString(dsSUB01.CountRow,"ITEM_BIGO") 		= dsITEM.NameString(i,"ITEM_BIGO"); 
		dsSUB01.NameString(dsSUB01.CountRow,"BUY_REGNUM") 	= dsITEM.NameString(i,"BUY_REGNUM");  
		dsSUB01.NameString(dsSUB01.CountRow,"COM_ID") 			= sComid; 
		dsSUB01.NameString(dsSUB01.CountRow,"MTSID")      	= " ";
		
	}			

	txtCOUNT_master.value = dsMAIN.CountRow.toString();
	txtCOUNT_detail.value = dsSUB01.CountRow.toString();

}
