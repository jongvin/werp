/**************************************************************************/
/* 1. �� �� �� �� id : t_WBudgAssignByDeptByAccForYearR.js(�μ���������������Ȳ(��))
/* 2. ����(�ó�����) : ��ũ��Ʈ�ҽ�
/* 3. ��  ��  ��  �� : �μ���������������Ȳ(��)
/* 4. ��  ��  ��  �� : ����� �ۼ�(2005-12-29)
/* 5. ����  ���α׷� : ���õ� ���α׷��� ���� �ּ�ó��
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
function Initialize()
{
	

	G_addDataSet(dsLOV, null, null,  null, "LOV");
	G_addDataSet(dsCOPY, transCopy, null,  null, "COPY");
	
	txtCOMP_CODE.value = sCompCode;
	txtCOMPANY_NAME.value = sCompName;
	//txtCLSE_ACC_ID.value = sClseAccId;
	//txtACC_ID.value = sAccId;
			
	txtYEAR_MONTH.value = sYearMonth;
	
	G_Load(dsCOPY, null);
}
function OnLoadBefore(dataset)
{
	if(dataset == dsCOPY)
	{
		dataset.DataID = sSelectPageName	+ D_P1("ACT","COPY");
	}
}

// ���ǰ��� �Լ�----------------------------------------------------------------//
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


//�˻�����üũ
function condition_check()
{
	var vCompCode = txtCOMP_CODE.value;
   	
   	if ( C_isNull(vCompCode))
   	{
   		C_msgOk("������� �����ϼ���");
   		return;
   	}
   	if ( C_isNull(txtYEAR_MONTH.value))
   	{
   		C_msgOk("���س�� �����ϼ���");
   		return;
   	}
   
   	
   	return true;
   	
}
// ���� ��ư �Լ�����(��ܿ� ���� ��ư�� ���� ��� ȣ��Ǵ� �Լ�)---------------//
//�μ�
function btnquery_prt_onclick()
{
	// ���α׷��� ��ȿ���˻� �߰�
				
	// ���� Check
	if (!condition_check()) return;
	
	 var vCompCode  = txtCOMP_CODE.value;
   	var vDeptName   = txtDEPT_NAME.value;

       var vDeptCode   = txtDEPT_CODE.value;
      
       var vYearMonth = txtYEAR_MONTH.value
   	var vYear      = vYearMonth.substr(0,4);
   	var vMonth   = vYearMonth.substr(5,2);
   	//alert(vYear);
   	//alert(vMonth);
  	//return;
  	
   	var reportFile ="";
	if (cboPROF_LOSS_TAG.value=='1')
	{
   		reportFile ="r_t_030012";  
	}
	else
	{     			
		reportFile ="r_t_030011";	
	}
	frmList.EXPORT_TAG.value =cboExportTag.value;
	frmList.RUN_TAG.value = cboRunTag.value;
	frmList.REQUEST_NAME.value = txtRequestName.value;
	frmList.REPORT_NO.value = '00';
	frmList.REPORT_FILE_NAME.value = reportFile +'.rpt';
	
	
	var strTemp = "";

	if(C_isNull(txtDEPT_CODE.value))
	{
		C_msgOk("������ �����ϼ���");
		return;
	}
	
	G_Load(dsCOPY, null);
	dsCOPY.NameString(dsCOPY.RowPosition,"EMP_NO") = sEmpNo;
	dsCOPY.NameString(dsCOPY.RowPosition,"DEPT_CODE") = txtDEPT_CODE.value;
	dsCOPY.NameString(dsCOPY.RowPosition,"YEAR") = vYear;
	dsCOPY.NameString(dsCOPY.RowPosition,"MONTH") =  vMonth;
	transCopy.Parameters = "ACT=COPY";
	//alert(transCopy.Parameters);
	//return;
	if(!G_saveData(dsCOPY))return;
	
	//alert(
	strTemp += "P_EMP_NO__" + sEmpNo;
	strTemp += "&&P_DEPT_CODE__" + vDeptCode;
	strTemp += "&&P_YEAR__" + vYear;
	strTemp += "&&P_MONTH__" + vMonth;
	strTemp += "&&P_DEPT_NAME__" + vDeptName;
	
	
	//alert(frmList.REPORT_FILE_NAME.value);
	//alert(strTemp);
	frmList.PARAMETERS.value = strTemp;
	
	if (!S_Submit(document.all)) return;
	frmList.submit();
	S_ObjectAllFormat(document.all);
	strTemp ="";
}


// ���� ������ �̺�Ʈ����-------------------------------------------------------//
function CalendarResult(asCalendarID, asDate, asYear, asMonth, asDay)
{
	if (asCalendarID == "YEAR_MONTH")
	{
		txtYEAR_MONTH.value = asDate;
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

}
function txtDEPT_CODE_onblur()
{
	
	
	if (C_isNull(txtDEPT_CODE.value))
	{
		txtDEPT_NAME.value = "";
		return;
	}
	
	if(!CheckCompCode()) return false;
	var lrArgs = new C_Dictionary();
	var lrRet = null;

	var vYearMonth = txtYEAR_MONTH.value
   	var vYear      = vYearMonth.substr(0,4); 
	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);
	lrArgs.set("SEARCH_CONDITION", txtDEPT_CODE.value);

	lrRet = C_AutoLov(dsLOV,"T_DEPT_CODE10", lrArgs,"T");

	if (lrRet == null) return;

	txtDEPT_CODE.value	= lrRet.get("DEPT_CODE");
	txtDEPT_NAME.value	= lrRet.get("DEPT_NAME");

}

 
function btnDEPT_CODE_onClick()
{     
	var lrArgs = new C_Dictionary();
	var lrRet = null;
	
	if(!CheckCompCode()) return false;
	var vYearMonth = txtYEAR_MONTH.value
   	var vYear      = vYearMonth.substr(0,4); 
	lrArgs.set("COMP_CODE", txtCOMP_CODE.value);
	lrArgs.set("SEARCH_CONDITION", "");

	lrRet = C_LOV("T_DEPT_CODE10", lrArgs,"F");

	if (lrRet == null) return;

	txtDEPT_CODE.value	= lrRet.get("DEPT_CODE");
	txtDEPT_NAME.value	= lrRet.get("DEPT_NAME");

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
function	CheckYearMonth()
{
	if (C_isNull(txtYEAR_MONTH.value))
	{
		C_msgOk("���� ���س���� �Է��ϼ���.", "Ȯ��");
		return false;
	}
	return true;
}

function btnYEAR_MONTH_onClick()
{
	C_Calendar("YEAR_MONTH", "M", txtYEAR_MONTH.value);
}


