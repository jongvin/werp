/**************************************************************************/
/* 1. �� ��	�� �� id : t_WBudgAssignByDeptByAccForYearR.js(�μ���������������Ȳ(��))
/* 2. ����(�ó�����) : ��ũ��Ʈ�ҽ�
/* 3. ��  ��  ��  �� : �μ���������������Ȳ(��)
/* 4. ��  ��  ��  �� : ����� �ۼ�(2005-12-29)
/* 5. ����	���α׷� : ���õ� ���α׷��� ���� �ּ�ó��
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
function Initialize()
{

	G_addDataSet(dsLIST00, null, null,	sSelectPageName+D_P1("ACT","LIST00"), "����庰	�μ����");

	G_addDataSet(dsLIST02, null, gridLIST02, sSelectPageName+D_P1("ACT","LIST02")	, "�μ���-���� ��û����");

	G_addDataSet(dsLOV,	null, null,	 null, "LOV");

	txtCOMP_CODE.value = sCompCode;
	txtCOMPANY_NAME.value =	sCompName;
	txtCLSE_ACC_ID.value = sClseAccId;
	txtACC_ID.value	= sAccId;

	G_Load(dsLIST00, null);

	gridLIST02.focus();
}
function OnLoadBefore(dataset)
{

	 if	(dataset ==	dsLIST00)
	{
		var	vCOMP_CODE = txtCOMP_CODE.value;

		dataset.DataID = sSelectPageName + D_P1("ACT","LIST00")
									 + D_P2("COMP_CODE",vCOMP_CODE);
	}

	else if	(dataset ==	dsLIST02)
	{
		var	vCOMP_CODE = txtCOMP_CODE.value;
		var	vMONTH = selMonth.value;
		var	vCLSE_ACC_ID = txtCLSE_ACC_ID.value;
		var	vDEPT_CODE = dsLIST00.NameString(dsLIST00.RowPosition,"DEPT_CODE");
		var	vDeptFlag =	selDeptFlag.value;

		dataset.DataID = sSelectPageName + D_P1("ACT", "LIST02")
									+ D_P2("COMP_CODE",vCOMP_CODE)
									+ D_P2("CLSE_ACC_ID",vCLSE_ACC_ID)
									+ D_P2("MONTH",vMONTH)
									+ D_P2("DEPT_CODE",vDEPT_CODE)
									+ D_P2("DEPT_FLAG",vDeptFlag);
		makeGridTitle(gridLIST02);
	}

}

// ���ǰ���	�Լ�----------------------------------------------------------------//
function SetSession()
{
}

function GetSession()
{
}

function ReportSession(asName, asValue)
{
}

// �Լ�����---------------------------------------------------------------------//

function makeGridTitle(grid)
{
	var	vBudgFlagName =	"";
	var	vDeptFlag =	selDeptFlag.value;
	var	vDeptFlagName =	"";


	var	gridTitle =	"";

	if(vDeptFlag !="ALL"){
		gridTitle += "<FC> Name=��	ID=chk_dept_name Sort=true Align=Left HeadAlign=Center	   Width=140 suppress=3";
		gridTitle += "</FC>																																  ";
	}
	if(vDeptFlag !="ALL" &&	vDeptFlag !="CHK_DEPT" ){
		gridTitle += "<FC> Name=�μ�  ID=DEPT_NAME Sort=true Align=Left	HeadAlign=Center	 Width=140 suppress=2";
		gridTitle += "</FC>																																  ";
	}

	gridTitle += "<FC> Name=�������� ID=p_acc_name Sort=true Align=left	HeadAlign=Center	Width=140	 suppress=1			  ";
	gridTitle += "</FC>																																  ";
	gridTitle += "<FC> Name=���� ID=ACC_NAME Sort=true Align=Left HeadAlign=Center	  Width=140				  ";
	gridTitle += "</FC>																																  ";
	gridTitle += "<G>name={'���'}	 ID=MON																																";
	gridTitle += "	<C>	Name=��ȹ	 ID=first_budg_amt Align=Right HeadAlign=Center	 Width=120 </C>																	  ";
	gridTitle += "	<C>	Name=����	 ID=sil_amt	Align=Right	HeadAlign=Center  Width=120</C>																	  ";
	gridTitle += "	<C>	Name=�ܾ�	 ID=sub_budg_amt Align=Right HeadAlign=Center  Width=120</C>																   ";
	gridTitle += "</G>																																 ";
	gridTitle += "<G>name={'����'}	 ID=SUM																																  ";
	gridTitle += "	<C>	Name=��ȹ	 ID=first_budg_amt_sum_sum Align=Right HeadAlign=Center	 Width=120 SumText=@sum</C>																	  ";
	gridTitle += "	<C>	Name=����	 ID=sil_amt_sum	Align=Right	HeadAlign=Center  Width=120</C>																	  ";
	gridTitle += "	<C>	Name=�ܾ�	 ID=sub_budg_amt_sum Align=Right HeadAlign=Center  Width=120</C>																   ";
	gridTitle += "</G>																																 ";
	grid.Format	= gridTitle;
}
//�˻�����üũ
function print_condition_check()
{
	var	vCompCode =	txtCOMP_CODE.value;


	if ( C_isNull(vCompCode))
	{
		C_msgOk("������� �����ϼ���");
		return;
	}

}
// ����	��ư �Լ�����(��ܿ� ���� ��ư�� ���� ��� ȣ��Ǵ�	�Լ�)---------------//
//�μ�
function btnquery_prt_onclick()
//------------------------------------------------------------------------
{
	print_condition_check();

	var	vCompName  = txtCOMPANY_NAME.value;
	var	vCompCode  = txtCOMP_CODE.value;
	var	vClseAccId	 = txtCLSE_ACC_ID.value;

	var	vDeptCode	= dsLIST00.NameString(dsLIST00.RowPosition,"DEPT_CODE");

	var	vDeptFlag =	selDeptFlag.value;
	var	vMonth	 = selMonth.value;

	var	reportFile ="";
	var	strTemp	= "";

	if(vDeptFlag == "ALL")
	{
		reportFile ="r_t_080010_a";
		strTemp	+=	"P_COMP_CODE__" + vCompCode;
		strTemp	+=	"&&P_CLSE_ACC_ID__"	+ vClseAccId;
		strTemp	+=	"&&P_MONTH__" + vMonth;
		strTemp	+=	"&&P_COMP_NAME__" +	vCompName;
	}
	else if(vDeptFlag == "CHK_DEPT")
	{
		reportFile ="r_t_080010_b";
		strTemp	+=	"P_COMP_CODE__" + vCompCode;
		strTemp	+=	"&&P_CLSE_ACC_ID__"	+ vClseAccId;
		strTemp	+=	"&&P_MONTH__" + vMonth;
		strTemp	+=	"&&P_DEPT_CODE__" + vDeptCode;
		strTemp	+=	"&&P_COMP_NAME__" +	vCompName;
	}
	else if(vDeptFlag == "DEPT")
	{
		reportFile ="r_t_080010_c";
		strTemp	+=	"P_COMP_CODE__" + vCompCode;
		strTemp	+=	"&&P_CLSE_ACC_ID__"	+ vClseAccId;
		strTemp	+=	"&&P_MONTH__" + vMonth;
		strTemp	+=	"&&P_DEPT_CODE__" + vDeptCode;
		strTemp	+=	"&&P_COMP_NAME__" +	vCompName;
	}



	frmList.EXPORT_TAG.value ="P";
	frmList.RUN_TAG.value =	"1";
	frmList.REQUEST_NAME.value = "�μ�����������Ȳ(��)";
	frmList.REPORT_NO.value	= '00';
	frmList.REPORT_FILE_NAME.value = reportFile	+'.rpt';





	//alert(frmList.REPORT_FILE_NAME.value);
	frmList.PARAMETERS.value = strTemp;

	if (!S_Submit(document.all)) return;
	frmList.submit();
	S_ObjectAllFormat(document.all);
	strTemp	="";
}
// ��ȸ
function btnquery_onclick()
{
	//CheckBudgYyyyMm();
	D_defaultLoad();
}



// ���
function btncancel_onclick()
{
	if (G_FocusObject != null) G_FocusObject.focus();
}

// ����	������ �̺�Ʈ����-------------------------------------------------------//
function CalendarResult(asCalendarID, asDate, asYear, asMonth, asDay)
{


}
function OnRowPosChanged(dataset, row)
{
	if(row==0) return;

	 if	(dataset ==	dsLIST00)
	{
		//�μ�
		var	vDeptCode =	dsLIST00.NameString(dsLIST00.RowPosition,"DEPT_CODE");

		selDeptFlag.options.length = "0";
		var	i =	0;
		if(vDeptCode ==	"%") selDeptFlag.options.options[i++] =	new	Option("�� ü","ALL");
		if(vDeptCode ==	"%") selDeptFlag.options.options[i++] =	new	Option("����","CHK_DEPT");
		if(vDeptCode ==	"%") selDeptFlag.options.options[i++] =	new	Option("�μ���","DEPT");
		if(vDeptCode !=	"%") selDeptFlag.options.options[i++] =	new	Option("����","CHK_DEPT");
		if(vDeptCode !=	"%") selDeptFlag.options.options[i++] =	new	Option("�μ���","DEPT");

		//G_Load(dsLIST02, null);
	}

}

// �̺�Ʈ����-------------------------------------------------------------------//
function deptFlag_onChange()
{
	//(dsLIST02,null);
}
function txtCOMP_CODE_onblur()
{
	if (C_isNull(txtCOMP_CODE.value))
	{
		txtCOMPANY_NAME.value =	"";
		return;
	}

	var	lrArgs = new C_Dictionary();
	var	lrRet =	null;

	lrArgs.set("SEARCH_CONDITION", txtCOMP_CODE.value);

	lrRet =	C_AutoLov(dsLOV,"T_COMP_CODE1",	lrArgs,"T");

	if (lrRet == null) return;

	txtCOMP_CODE.value	= lrRet.get("COMP_CODE");
	txtCOMPANY_NAME.value	= lrRet.get("COMPANY_NAME");

}


function btnCOMP_CODE_onClick()
{
	var	lrArgs = new C_Dictionary();
	var	lrRet =	null;

	lrArgs.set("SEARCH_CONDITION", "");

	lrRet =	C_LOV("T_COMP_CODE1", lrArgs,"T");

	if (lrRet == null) return;

	txtCOMP_CODE.value	= lrRet.get("COMP_CODE");
	txtCOMPANY_NAME.value	= lrRet.get("COMPANY_NAME");

}

function	CheckCompCode()
{
	if (C_isNull(txtCOMP_CODE.value))
	{
		C_msgOk("���� ������ڵ带 �����ϼ���.", "Ȯ��");
		return false;
	}
	return true;
}


//���
function btnPreView_onClick()
{
	btnquery_prt_onclick();
}

 function btnACC_ID_onClick()
{
	if(!CheckCompCode()) return;
	var	lrArgs = new C_Dictionary();
	var	lrRet =	null;

	lrArgs.set("CLSE_ACC_ID", "");
	lrArgs.set("COMP_CODE",	txtCOMP_CODE.value);

	lrRet =	C_LOV("T_BUDG_YEAR", lrArgs,"T");

	if (lrRet == null) return;

	txtCLSE_ACC_ID.value	= lrRet.get("CLSE_ACC_ID");
	txtACC_ID.value	= lrRet.get("ACC_ID");

}
function txtCLSE_ACC_ID_onblur()
{
	if(!CheckCompCode()) return;
	if (C_isNull(txtCLSE_ACC_ID.value))
	{
		txtACC_ID.value	= "";
		return;
	}

	var	lrArgs = new C_Dictionary();
	var	lrRet =	null;
	lrArgs.set("CLSE_ACC_ID", txtCLSE_ACC_ID.value);
	lrArgs.set("COMP_CODE",	txtCOMP_CODE.value);

	lrRet =	C_AutoLov(dsLOV,"T_BUDG_YEAR", lrArgs,"T");

	if (lrRet == null) return;

	txtCLSE_ACC_ID.value	= lrRet.get("CLSE_ACC_ID");
	txtACC_ID.value	= lrRet.get("ACC_ID");

}

