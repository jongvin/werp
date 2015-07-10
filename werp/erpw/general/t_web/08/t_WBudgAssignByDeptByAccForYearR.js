/**************************************************************************/
/* 1. 프 로 그 램 id : t_WBudgAssignByDeptByAccForYearR.js(부서별계정별월별현황(년))
/* 2. 유형(시나리오) : 스크립트소스
/* 3. 기  능  정  의 : 부서별계정별월별현황(년) 
/* 4. 변  경  이  력 : 한재원 작성(2005-12-29)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/
function Initialize()
{

	G_addDataSet(dsLIST00, null, null,  sSelectPageName+D_P1("ACT","LIST00"), "사업장별 부서목록");

	G_addDataSet(dsLIST02, null, gridLIST02, sSelectPageName+D_P1("ACT","LIST02")	, "부서별-월별 신청내역");
	
	G_addDataSet(dsLOV, null, null,  null, "LOV");

	txtCOMP_CODE.value = sCompCode;
	txtCOMPANY_NAME.value = sCompName;
	txtCLSE_ACC_ID.value = sClseAccId;
	txtACC_ID.value = sAccId;

	G_Load(dsLIST00, null);
	
	gridLIST02.focus();
}
function OnLoadBefore(dataset)
{
	
	 if (dataset == dsLIST00)
	{
		var vCOMP_CODE = txtCOMP_CODE.value;
		var vBudgYyyy = txtCLSE_ACC_ID.value;
		dataset.DataID = sSelectPageName + D_P1("ACT","LIST00")
									 + D_P2("COMP_CODE",vCOMP_CODE)
									 + D_P2("BUDG_YYYY",vBudgYyyy);
	}

	else if (dataset == dsLIST02)
	{
		var vCOMP_CODE = txtCOMP_CODE.value; 
		var vBudgYyyy    = txtCLSE_ACC_ID.value;
		var vDEPT_CODE = dsLIST00.NameString(dsLIST00.RowPosition,"DEPT_CODE");
		var vDeptFlag = selDeptFlag.value;
		
		dataset.DataID = sSelectPageName + D_P1("ACT","LIST02")
									 + D_P2("COMP_CODE",vCOMP_CODE)
									 + D_P2("BUDG_YYYY",vBudgYyyy)
									 + D_P2("DEPT_CODE",vDEPT_CODE)
									 + D_P2("DEPT_FLAG",vDeptFlag);
		
		makeGridTitle(gridLIST02);
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
function makeGridTitle(grid)
{	 
	var vBudgFlagName = "";
	var vDeptFlag = selDeptFlag.value;
	var vDeptFlagName = "";

	var gridTitle = "";

	if(vDeptFlag !="ALL"){
		gridTitle += "<FC> Name=팀  ID=chk_dept_name Sort=true Align=Left HeadAlign=Center     Width=80 suppress=3";
		gridTitle += "</FC>                                                                                                                               ";
	}
	if(vDeptFlag !="ALL" && vDeptFlag !="CHK_DEPT" ){
		gridTitle += "<FC> Name=부서  ID=DEPT_NAME Sort=true Align=Left HeadAlign=Center     Width=80 suppress=2";
		gridTitle += "</FC>                                                                                                                               ";
	}
	
	gridTitle += "<FC> Name=상위계정 ID=p_acc_name Sort=true Align=left HeadAlign=Center    Width=100    suppress=1           ";
	gridTitle += "</FC>                                                                                                                               ";
	gridTitle += "<FC> Name=계정 ID=ACC_NAME Sort=true Align=Left HeadAlign=Center   Width=200               ";
	gridTitle += "</FC>                                                                                                                               ";
	gridTitle += "<G>name={'1월'}    ID=MON_1                                                                                                                  ";
	gridTitle += "	<C> Name=예산 ID=pb1 Align=Right HeadAlign=Center  Width=80 SumText=@sum</C>                                                                   ";
	gridTitle += "	<C> Name=사용 ID=s1 Align=Right HeadAlign=Center  Width=80 SumText=@sum</C>                                                                   ";
	gridTitle += "	<C> Name=%    ID=r1 Align=Right HeadAlign=Center  Width=40</C>                                                                   ";
	gridTitle += "</G>                                                                                                                                ";
	gridTitle += "<G>name={'2월'}    ID=MON_2                                                                                                                ";
	gridTitle += "	<C> Name=예산 ID=pb2 Align=Right HeadAlign=Center  Width=80 SumText=@sum</C>                                                                   ";
	gridTitle += "	<C> Name=사용 ID=s2 Align=Right HeadAlign=Center  Width=80 SumText=@sum</C>                                                                   ";
	gridTitle += "	<C> Name=%    ID=r2 Align=Right HeadAlign=Center  Width=40</C>                                                                   ";
	gridTitle += "</G>                                                                                                                                ";
	gridTitle += "<G>name={'3월'}  ID=MON_3                                                                                                                    ";
	gridTitle += "	<C> Name=예산 ID=pb3 Align=Right HeadAlign=Center  Width=80 SumText=@sum</C>                                                                   ";
	gridTitle += "	<C> Name=사용 ID=s3 Align=Right HeadAlign=Center  Width=80 SumText=@sum</C>                                                                   ";
	gridTitle += "	<C> Name=%    ID=r3 Align=Right HeadAlign=Center  Width=40</C>                                                                   ";
	gridTitle += "</G>                                                                                                                                ";
	gridTitle += "<G>name={'1/4 분기'}   ID=MON_14                                                                                                              ";
	gridTitle += "	<C> Name=예산 ID=pb14 Align=Right HeadAlign=Center  Width=80 SumText=@sum</C>                                                                  ";
	gridTitle += "	<C> Name=사용 ID=s14 Align=Right HeadAlign=Center  Width=80 SumText=@sum</C>                                                                  ";
	gridTitle += "	<C> Name=%    ID=r14 Align=Right HeadAlign=Center  Width=40</C>                                                                  ";
	gridTitle += "</G>                                                                                                                                ";
	gridTitle += "<G>name={'4월'}  ID=MON_4                                                                                                                    ";
	gridTitle += "	<C> Name=예산 ID=pb4 Align=Right HeadAlign=Center  Width=80 SumText=@sum</C>                                                                   ";
	gridTitle += "	<C> Name=사용 ID=s4 Align=Right HeadAlign=Center  Width=80 SumText=@sum</C>                                                                   ";
	gridTitle += "	<C> Name=%    ID=r4 Align=Right HeadAlign=Center  Width=40</C>                                                                   ";
	gridTitle += "</G>                                                                                                                                ";
	gridTitle += "<G>name={'5월'}   ID=MON_5                                                                                                                   ";
	gridTitle += "	<C> Name=예산 ID=pb5 Align=Right HeadAlign=Center  Width=80 SumText=@sum</C>                                                                   ";
	gridTitle += "	<C> Name=사용 ID=s5 Align=Right HeadAlign=Center  Width=80 SumText=@sum</C>                                                                   ";
	gridTitle += "	<C> Name=%    ID=r5 Align=Right HeadAlign=Center  Width=40</C>                                                                   ";
	gridTitle += "</G>                                                                                                                                ";
	gridTitle += "<G>name={'6월'}   ID=MON_6                                                                                                                   ";
	gridTitle += "	<C> Name=예산 ID=pb6 Align=Right HeadAlign=Center  Width=80 SumText=@sum</C>                                                                   ";
	gridTitle += "	<C> Name=사용 ID=s6 Align=Right HeadAlign=Center  Width=80 SumText=@sum</C>                                                                   ";
	gridTitle += "	<C> Name=%    ID=r6 Align=Right HeadAlign=Center  Width=40</C>                                                                   ";
	gridTitle += "</G>                                                                                                                                ";
	gridTitle += "<G>name={'2/4 분기'}     ID=MON_24                                                                                                            ";
	gridTitle += "	<C> Name=예산 ID=pb24 Align=Right HeadAlign=Center  Width=80 SumText=@sum</C>                                                                  ";
	gridTitle += "	<C> Name=사용 ID=s24 Align=Right HeadAlign=Center  Width=80 SumText=@sum</C>                                                                  ";
	gridTitle += "	<C> Name=%    ID=r24 Align=Right HeadAlign=Center  Width=40</C>                                                                  ";
	gridTitle += "</G>                                                                                                                                ";
	gridTitle += "<G>name={'전반기'}     ID=MON_b                                                                                                              ";
	gridTitle += "	<C> Name=예산 ID=pb012 Align=Right HeadAlign=Center  Width=80 SumText=@sum</C>                                                                 ";
	gridTitle += "	<C> Name=사용 ID=s012 Align=Right HeadAlign=Center  Width=80 SumText=@sum</C>                                                                 ";
	gridTitle += "	<C> Name=%    ID=r012 Align=Right HeadAlign=Center  Width=40</C>                                                                 ";
	gridTitle += "</G>                                                                                                                                ";
	gridTitle += "<G>name={'7월'}       ID=MON_7                                                                                                              ";
	gridTitle += "	<C> Name=예산 ID=pb7 Align=Right HeadAlign=Center  Width=80 SumText=@sum</C>                                                                   ";
	gridTitle += "	<C> Name=사용 ID=s7 Align=Right HeadAlign=Center  Width=80 SumText=@sum</C>                                                                   ";
	gridTitle += "	<C> Name=%    ID=r7 Align=Right HeadAlign=Center  Width=40</C>                                                                   ";
	gridTitle += "</G>                                                                                                                                ";
	gridTitle += "<G>name={'8월'}       ID=MON_8                                                                                                               ";
	gridTitle += "	<C> Name=예산 ID=pb8 Align=Right HeadAlign=Center  Width=80 SumText=@sum</C>                                                                   ";
	gridTitle += "	<C> Name=사용 ID=s8 Align=Right HeadAlign=Center  Width=80 SumText=@sum</C>                                                                   ";
	gridTitle += "	<C> Name=%    ID=r8 Align=Right HeadAlign=Center  Width=40</C>                                                                   ";
	gridTitle += "</G>                                                                                                                                ";
	gridTitle += "<G>name={'9월'}        ID=MON_9                                                                                                              ";
	gridTitle += "	<C> Name=예산 ID=pb9 Align=Right HeadAlign=Center  Width=80 SumText=@sum</C>                                                                   ";
	gridTitle += "	<C> Name=사용 ID=s9 Align=Right HeadAlign=Center  Width=80 SumText=@sum</C>                                                                   ";
	gridTitle += "	<C> Name=%    ID=r9 Align=Right HeadAlign=Center  Width=40</C>                                                                   ";
	gridTitle += "</G>                                                                                                                                ";
	gridTitle += "<G>name={'3/4 분기'}     ID=MON_34                                                                                                            ";
	gridTitle += "	<C> Name=예산 ID=pb34 Align=Right HeadAlign=Center  Width=80 SumText=@sum</C>                                                                  ";
	gridTitle += "	<C> Name=사용 ID=s34 Align=Right HeadAlign=Center  Width=80 SumText=@sum</C>                                                                  ";
	gridTitle += "	<C> Name=%    ID=r34 Align=Right HeadAlign=Center  Width=40</C>                                                                  ";
	gridTitle += "</G>                                                                                                                                ";
	gridTitle += "<G>name={'10월'}          ID=MON_10                                                                                                           ";
	gridTitle += "	<C> Name=예산 ID=pb10 Align=Right HeadAlign=Center  Width=80 SumText=@sum</C>                                                                  ";
	gridTitle += "	<C> Name=사용 ID=s10 Align=Right HeadAlign=Center  Width=80 SumText=@sum</C>                                                                  ";
	gridTitle += "	<C> Name=%    ID=r10 Align=Right HeadAlign=Center  Width=40</C>                                                                  ";
	gridTitle += "</G>                                                                                                                                ";
	gridTitle += "<G>name={'11월'}     ID=MON_11                                                                                                                ";
	gridTitle += "	<C> Name=예산 ID=pb11 Align=Right HeadAlign=Center  Width=80 SumText=@sum</C>                                                                  ";
	gridTitle += "	<C> Name=사용 ID=s11 Align=Right HeadAlign=Center  Width=80 SumText=@sum</C>                                                                  ";
	gridTitle += "	<C> Name=%    ID=r11 Align=Right HeadAlign=Center  Width=40</C>                                                                  ";
	gridTitle += "</G>                                                                                                                                ";
	gridTitle += "<G>name={'12월'}             ID=MON_12                                                                                                       ";
	gridTitle += "	<C> Name=예산 ID=pb12 Align=Right HeadAlign=Center  Width=80 SumText=@sum</C>                                                                  ";
	gridTitle += "	<C> Name=사용 ID=s12 Align=Right HeadAlign=Center  Width=80 SumText=@sum</C>                                                                  ";
	gridTitle += "	<C> Name=%    ID=r12 Align=Right HeadAlign=Center  Width=40</C>                                                                  ";
	gridTitle += "</G>                                                                                                                                ";
	gridTitle += "<G>name={'4/4 분기'}       ID=MON_44                                                                                                          ";
	gridTitle += "	<C> Name=예산 ID=pb44 Align=Right HeadAlign=Center  Width=80 SumText=@sum</C>                                                                  ";
	gridTitle += "	<C> Name=사용 ID=s44 Align=Right HeadAlign=Center  Width=80 SumText=@sum</C>                                                                  ";
	gridTitle += "	<C> Name=%    ID=r44 Align=Right HeadAlign=Center  Width=40</C>                                                                  ";
	gridTitle += "</G>                                                                                                                                ";
	gridTitle += "<G>name={'후반기'}           ID=MON_p                                                                                                        ";
	gridTitle += "	<C> Name=예산 ID=pb022 Align=Right HeadAlign=Center  Width=80 SumText=@sum</C>                                                                 ";
	gridTitle += "	<C> Name=사용 ID=s022 Align=Right HeadAlign=Center  Width=80 SumText=@sum</C>                                                                 ";
	gridTitle += "	<C> Name=%    ID=r022 Align=Right HeadAlign=Center  Width=40</C>                                                                 ";
	gridTitle += "</G>                                                                                                                                ";
	grid.Format = gridTitle;
}
//검색조건체크
function print_condition_check()
{
	var vCompCode = txtCOMP_CODE.value;
   	var vClseAccId   = txtCLSE_ACC_ID.value;
   	
   	if ( C_isNull(vCompCode))
   	{
   		C_msgOk("사업장을 선택하세요");
   		return;
   	}
   	
   	if ( C_isNull(vClseAccId))
   	{
   		C_msgOk("회기를  선택하세요");
   		return;
   	}
}
// 공통 버튼 함수관련(상단에 공통 버튼을 누를 경우 호출되는 함수)---------------//

//인쇄
function btnquery_prt_onclick()                      
//------------------------------------------------------------------------
{
	print_condition_check();
	
	var vCompCode  = txtCOMP_CODE.value;
	var vCompName  = txtCOMPANY_NAME.value;
	var vClseAccId   = txtCLSE_ACC_ID.value;
	var vDeptCode   = dsLIST00.NameString(dsLIST00.RowPosition,"DEPT_CODE");
	var vDeptFlag = selDeptFlag.value;

	var strTemp = "";
   
  	if (sPrtDiv=='1')
  	{
  		if(vDeptFlag == "ALL")
  		{
	   		reportFile ="r_t_080000_a";  //상반기
			strTemp	+= "P_COMP_CODE__" + vCompCode;
			strTemp	+= "&&P_CLSE_ACC_ID__" + vClseAccId;
			strTemp	+= "&&P_COMP_NAME__" + vCompName;
  		}
  		else if(vDeptFlag == "CHK_DEPT")
  		{
	   		reportFile ="r_t_080000_b";  //상반기
			strTemp	+= "P_COMP_CODE__" + vCompCode;
			strTemp	+= "&&P_CLSE_ACC_ID__" + vClseAccId;
			strTemp	+= "&&P_DEPT_CODE__" + vDeptCode;
			strTemp	+= "&&P_COMP_NAME__" + vCompName;
  		}
  		else if(vDeptFlag == "DEPT")
  		{
	   		reportFile ="r_t_080000_c";  //상반기
			strTemp	+= "P_COMP_CODE__" + vCompCode;
			strTemp	+= "&&P_CLSE_ACC_ID__" + vClseAccId;
			strTemp	+= "&&P_DEPT_CODE__" + vDeptCode;
			strTemp	+= "&&P_COMP_NAME__" + vCompName;
  		}
   	}
   	else
   	{
  		if(vDeptFlag == "ALL")
  		{
	   		reportFile ="r_t_080000_2_a";  //하반기
			strTemp	+= "P_COMP_CODE__" + vCompCode;
			strTemp	+= "&&P_CLSE_ACC_ID__" + vClseAccId;
			strTemp	+= "&&P_COMP_NAME__" + vCompName;
	   	}
  		else if(vDeptFlag == "CHK_DEPT")
  		{
	   		reportFile ="r_t_080000_2_b";  //하반기
			strTemp	+= "P_COMP_CODE__" + vCompCode;
			strTemp	+= "&&P_CLSE_ACC_ID__" + vClseAccId;
			strTemp	+= "&&P_DEPT_CODE__" + vDeptCode;
			strTemp	+= "&&P_COMP_NAME__" + vCompName;
  		}
  		else if(vDeptFlag == "DEPT")
  		{
	   		reportFile ="r_t_080000_2_c";  //하반기
			strTemp	+= "P_COMP_CODE__" + vCompCode;
			strTemp	+= "&&P_CLSE_ACC_ID__" + vClseAccId;
			strTemp	+= "&&P_DEPT_CODE__" + vDeptCode;
			strTemp	+= "&&P_COMP_NAME__" + vCompName;
  		}
	}
   
   	
   	frmList.EXPORT_TAG.value ="P";
	frmList.RUN_TAG.value = "1";
	frmList.REQUEST_NAME.value = "부서별계정별월별현황";
	frmList.REPORT_NO.value = '00';
	frmList.REPORT_FILE_NAME.value = reportFile +'.rpt';
	
	

	
	
	//alert(frmList.REPORT_FILE_NAME.value);
	frmList.PARAMETERS.value = strTemp;
	
	if (!S_Submit(document.all)) return;
	frmList.submit();
	S_ObjectAllFormat(document.all);
	strTemp ="";
}
// 조회
function btnquery_onclick()
{
	D_defaultLoad();
}



// 취소
function btncancel_onclick()
{
	if (G_FocusObject != null) G_FocusObject.focus();
}

// 공통 재정의 이벤트관련-------------------------------------------------------//

function OnRowPosChanged(dataset, row)
{
	if(row==0) return;
	 if (dataset == dsLIST00)
	{
		//부서
		var vDeptCode = dsLIST00.NameString(dsLIST00.RowPosition,"DEPT_CODE");
		
		selDeptFlag.options.length = "0"; 
		var i = 0;
		if(vDeptCode == "%") selDeptFlag.options.options[i++] = new Option("전 체","ALL");
		if(vDeptCode == "%") selDeptFlag.options.options[i++] = new Option("팀별","CHK_DEPT");
		if(vDeptCode == "%") selDeptFlag.options.options[i++] = new Option("부서별","DEPT");
		if(vDeptCode != "%") selDeptFlag.options.options[i++] = new Option("팀별","CHK_DEPT");
		if(vDeptCode != "%") selDeptFlag.options.options[i++] = new Option("부서별","DEPT");
		
	}
	

}

// 이벤트관련-------------------------------------------------------------------//
function txtCOMP_CODE_onblur()
{
	if (C_isNull(txtCOMP_CODE.value))
	{
		txtCOMPANY_NAME.value = "";
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
}

function txtCLSE_ACC_ID_onblur()
{
	if(!CheckCompCode()) return;
	if (C_isNull(txtCLSE_ACC_ID.value))
	{
		txtACC_ID.value = "";
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
	
	
	D_defaultLoad();
	
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
}
function btnACC_ID_onClick()
{
	if(!CheckCompCode()) return;
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	lrArgs.set("CLSE_ACC_ID", "");
	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);

	lrRet = C_LOV("T_BUDG_YEAR", lrArgs,"T");
	
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

//출력
function btnPreView_onClick(div)
{
	sPrtDiv = div;
	btnquery_prt_onclick();
}