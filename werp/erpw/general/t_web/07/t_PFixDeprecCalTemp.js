/**************************************************************************/
/* 1. �� �� �� �� id : t_PFixDeprecCal.js(�����ڻ갨���󰡰�� )
/* 2. ����(�ó�����) : ��ũ��Ʈ�ҽ�
/* 3. ��  ��  ��  �� : �����ڻ갨���󰡰�� 
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-01-20)
/* 5. ����  ���α׷� : ���õ� ���α׷��� ���� �ּ�ó��
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
function Initialize()
{
	document.body.topMargin = 0;
	document.body.leftMargin = 0;

	lrArgs = window.dialogArguments;
	G_addDataSet(dsMAIN, null, gridMAIN, null, "�۾���� ��������");
	G_Load(dsDEPREC_FINISH, null);

	btnLoad_onClick();
}
function OnLoadBefore(dataset)
{
	if (dataset == dsMAIN)
	{
		var			strCOMP_CODE 		=  lrArgs.comp_code;
		var			strWORK_SEQ			=  lrArgs.work_seq;
		var			strWORK_TO_DT		=  lrArgs.work_to_dt;
		var			strDEPREC_FINISH		=  lrArgs.deprec_finish;
		
		
		dataset.DataID = sSelectPageName + D_P1("ACT","MAIN")
						 			 + D_P2("COMP_CODE", strCOMP_CODE)
						 			 + D_P2("ASSET_NAME", txtASSET_NAME.value)
						 			 + D_P2("DEPREC_FINISH", strDEPREC_FINISH) 
						 			 + D_P2("WORK_TO_DT", strWORK_TO_DT)
						 			 + D_P2("WORK_SEQ", strWORK_SEQ);														
																
	}
	else	if (dataset == dsDEPREC_FINISH)	//�󰢿Ϸᱸ��  ��������
	{
		dataset.DataID = sSelectPageName + D_P1("ACT","DEPREC_FINISH")
	}
	gridMAIN.focus();
}
function	SelectOrCancelAll(arTag)
{
	for(var i = 1 ; i <= dsMAIN.CountRow ; i ++)
	{
		dsMAIN.NameString(i,"CHKTAG") = arTag;
	}
}

// �̺�Ʈ����-------------------------------------------------------------------//
function	ConfirmSelected()
{
	for (i=1;i<=dsMAIN.CountRow;i++)
	{
		if(dsMAIN.NameValue(i,"CHKTAG") == "T")
		{
			lrArgs.dataset.AddRow();
			lrArgs.dataset.NameValue(lrArgs.dataset.RowPosition,"FIX_ASSET_SEQ")			=    dsMAIN.NameValue(i,"FIX_ASSET_SEQ");
			lrArgs.dataset.NameValue(lrArgs.dataset.RowPosition,"WORK_SEQ")				=    lrArgs.work_seq;
			lrArgs.dataset.NameValue(lrArgs.dataset.RowPosition,"BEFORE_ASSET_CNT")		=    dsMAIN.NameValue(i,"ASSET_CNT");
			lrArgs.dataset.NameValue(lrArgs.dataset.RowPosition,"DEPREC_RAT")				=    dsMAIN.NameValue(i,"DEPREC_RAT");
			lrArgs.dataset.NameValue(lrArgs.dataset.RowPosition,"BEFORE_WORK_SEQ")		=    dsMAIN.NameValue(i,"WORK_SEQ");
			lrArgs.dataset.NameValue(lrArgs.dataset.RowPosition,"BEFORE_BASE_AMT")		=    dsMAIN.NameValue(i,"BASE_AMT");
			lrArgs.dataset.NameValue(lrArgs.dataset.RowPosition,"BEFORE_OLD_DEPREC_AMT")	=    dsMAIN.NameValue(i,"OLD_DEPREC_AMT");
			lrArgs.dataset.NameValue(lrArgs.dataset.RowPosition,"BEFORE_DEPREC_FINISH")		=    dsMAIN.NameValue(i,"DEPREC_FINISH");
			lrArgs.dataset.NameValue(lrArgs.dataset.RowPosition,"BEFORE_INC_SUM_AMT")		=    dsMAIN.NameValue(i,"INC_SUM_AMT");
			lrArgs.dataset.NameValue(lrArgs.dataset.RowPosition,"BEFORE_SUB_SUM_AMT")		=    dsMAIN.NameValue(i,"SUB_SUM_AMT");
			lrArgs.dataset.NameValue(lrArgs.dataset.RowPosition,"ASSET_MNG_NO")			=    dsMAIN.NameValue(i,"ASSET_MNG_NO");
			lrArgs.dataset.NameValue(lrArgs.dataset.RowPosition,"ASSET_NAME")				=    dsMAIN.NameValue(i,"ASSET_NAME");
		}
	}
	window.close();
}
function imgOk_onClick()
{

	if(dsMAIN.CountRow < 1)
	{
		C_msgOk("����Ʈ���� �����͸� �����Ͻñ� �ٶ��ϴ�.","�˸�");
		return;
	}
	ConfirmSelected();
}

function imgCancel_onClick()
{
	window.returnValue = null;
	window.close();
}
function	btnLoad_onClick()			//��ȸ
{
	G_Load(dsMAIN, null);
	if(dsMAIN.CountRow == 0)
	{
		C_msgOk("�ش��ڷᰡ �����ϴ�." ,"�˸�");
		return;
	}
}

function	btnSelectAll_onClick()
{
	SelectOrCancelAll("T");
}
function	btnCancelAll_onClick()
{
	SelectOrCancelAll("F");
}