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
	
			
	txtYMD.value = sYMD;
	
	
}
function OnLoadBefore(dataset)
{

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
	
   	if ( C_isNull(txtYMD.value))
   	{
   		C_msgOk("�۾����� �����ϼ���");
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
	
	
      
       var vYMD = txtYMD.value

   	//alert(vYear);
   	//alert(vMonth);
  	//return;
  	
   	var reportFile ="";

   	reportFile ="r_t_040047";  

	frmList.EXPORT_TAG.value =cboExportTag.value;
	frmList.RUN_TAG.value = cboRunTag.value;
	frmList.REQUEST_NAME.value = txtRequestName.value;
	frmList.REPORT_NO.value = '00';
	frmList.REPORT_FILE_NAME.value = reportFile +'.rpt';
		
	var strTemp = "";

	strTemp = "P_WORK_DT__" + vYMD;
	//strTemp += "&&P_WORK_DT2__" + vYMD;
	//strTemp += "&&P_WORK_DT3__" + vYMD;


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
	if (asCalendarID == "YMD")
	{
		txtYMD.value = asDate;
	}
}


// �̺�Ʈ����-------------------------------------------------------------------//



function btnYMD_onClick()
{
	C_Calendar("YMD", "D", txtYMD.value);
}


