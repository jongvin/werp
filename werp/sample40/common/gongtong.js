 function ln_Excel_file()
 {
       var g_RetVal;
       var g_PrmVal;
       var g_PrmVal = "" + "|" + "";

    	g_RetVal = window.showModalDialog("p_Excel.html",
		                               g_PrmVal,
	                              "unadorned:off;help:off; dialogHide:off;resizable:off;status:off;dialogWidth:302px; dialogHeight:150px;");
		return g_RetVal;
 }

function ln_Report_MakeData(f_name)
{
	RMapper1.MakeData("c:\\"+f_name, "^");

}


//function ln_Report_Popup(f_name,f_mrd)
function ln_Report_Popup(f_mrd,obj_RMaper)
{
	var args = new Array();
	args["f_mrd"] = f_mrd;
	args["RMapper"] = obj_RMaper;
	//showModalDialog(f_name, args, "dialogWidth:800px; dialogHeight:600px");
	showModalDialog("ReportViewer.htm", args, "dialogWidth:900px; dialogHeight:700px");
//	showModelessDialog("ReportViewer.htm", args, "dialogWidth:900px; dialogHeight:700px");

}

//function ln_Report_Popup(f_name,f_mrd)
function ln_Report_Popup_1(f_mrd)
{
	var args = new Array();
	args["f_mrd"] = f_mrd;
	//showModalDialog(f_name, args, "dialogWidth:800px; dialogHeight:600px");
	showModelessDialog("ReportViewer_NoMapper.htm", args, "dialogWidth:900px; dialogHeight:700px");

}
//function ln_Report_Popup(f_name,f_mrd)
function ln_Report_Popup_2(f_mrd,obj_RMaper)
{
	var args = new Array();
	args["f_mrd"] = f_mrd;
	args["RMapper"] = obj_RMaper;
	//showModalDialog(f_name, args, "dialogWidth:800px; dialogHeight:600px");
	showModalDialog("ReportViewer2.htm", args, "dialogWidth:900px; dialogHeight:700px");
//	showModelessDialog("ReportViewer.htm", args, "dialogWidth:900px; dialogHeight:700px");

}

//==========  ������ �����
function ln_Excel(obj,title){
//	var tbgd_Excel=

        obj.SetExcelTitle(0, "");
	TitleText = "value:" + title + ";font-face:����ü;font-size:30pt;font-color:black;font-bold;font-underline;bgcolor:#CCFFCC;align: center;line-color:#C0C0C0;line-width:0.5pt;skiprow:1;";
	obj.SetExcelTitle(1, TitleText);
	var today = new Date();
	var day = today.getDay();
	var week;
	if (day==0) {week="�Ͽ���";}
	else if (day==1) {week="������";}
	else if (day==2) {week="ȭ����";}
	else if (day==3) {week="������";}
	else if (day==4) {week="�����";}
	else if (day==5) {week="�ݿ���";}
	else if (day==6) {week="�����";}
	var hour = today.getHours();
	if (hour>12) {hour="���� "+(hour-12);}
  else {hour="���� "+hour;}
  var minute = today.getMinutes();
  var second = today.getSeconds();
	
	var ymd = today.getYear() +"�� "+ (today.getMonth() + 1) +"�� "+ today.getDate() + "��"
  var hms = hour + "�� " + minute + "�� " +  second + "��";
  TitleText = "value : ������� : " + ymd + " ("+ week + ")";
  TitleText+= "\n" + hms;
	TitleText+= "; font-face: '����ü';font-size: 12pt;font-color:#336600;font-italic;bgcolor:#ffffff;align:right;line-color: #C0C0C0;line-width:0.5pt;skiprow: 1;";
	obj.SetExcelTitle(1, TitleText);
	
	var g_Excelfile_type ="0";
	g_Excelfile_type = ln_Excel_file();

	if (g_Excelfile_type =="1"){//���Ϸ� �ޱ�
			//obj.ExportFile(title,'true');
		obj.GridtoExcel(title,title,29);
	}else if (g_Excelfile_type =="2"){//������ �ޱ�
			obj.GridtoExcel(title,"",1);
	}else if (g_Excelfile_type =="3"){//�ؽ�Ʈ ���� ����� �����
			obj.ExportFileEx(title+'.txt', true, 1, false);
	}else{
		return;
	}
}

// ���ǵ� �޼��� CALL
function gs_CallMsg(l_iMsgCode, l_sWork)
{
	var l_sMsg;
    if ( l_sWork == '-' || l_sWork == '-"' || l_sWork == '"-' || l_sWork == '"-"') l_sWork = "";
	switch(l_iMsgCode) {
		case "M001": l_sMsg = l_sWork +"�ڷ� ����� �Ϸ� �Ǿ����ϴ�.";
			break;
		case "M002": l_sMsg = l_sWork +"�ڷ� ������ �Ϸ� �Ǿ����ϴ�.";
			break;
		case "M003": l_sMsg = l_sWork +"���� ��ȸ �Ǿ����ϴ�.";
			break;
		case "M005": l_sMsg = l_sWork +"ó���� �Ϸ� �Ǿ����ϴ�.";
			break;
		case "M006": l_sMsg = l_sWork +"�����Ͻðڽ��ϱ�?";
			break;
		case "M007": l_sMsg = l_sWork +"�����Ͻðڽ��ϱ�?";
			break;
		case "M008": l_sMsg = l_sWork +"������ �ٿ�ε��Ͻðڽ��ϱ�?";
			break;
		case "M009": l_sMsg = l_sWork +"��ȸ �� �۾��Ͻʽÿ�.";
			break;
		case "M010": l_sMsg = l_sWork + "�˻������� �Է��Ͻʽÿ�.";
			break;
		case "M011": l_sMsg = "�Ⱓ ������ �߸��Ǿ����ϴ�.";
			break;
		case "M012": l_sMsg = l_sWork + "���� �Է��� �߸��Ǿ����ϴ�.";
			break;
		case "M013": l_sMsg = "�ش��ڷᰡ �����ϴ�.";
			break;
		case "M014": l_sMsg = "����ڸ� �˻����ּ���.";
			break;
		case "M015": l_sMsg = "�ش�" + l_sWork + "�� ���γ����� �־� ������ �� �����ϴ�.";
			break;
		case "M016": l_sMsg = l_sWork +"������ �����ϴ�.";
			break;
		case "M017": l_sMsg = "�ش� ����ڰ� �����ϴ�.";
			break;
		case "M019": l_sMsg = l_sWork +"���� ������ �����ϴ�. �ٽ� �α����ϼ���.";
			break;
		case "M020": l_sMsg = "�������Դϴ�.....";
			break;
		case "M021": l_sMsg = "��ȸ���Դϴ�.....";
			break;
		case "M022": l_sMsg = "�������Դϴ�.....";
			break;
		case "M041": l_sMsg = "���õ� �ڷḦ �����Ͻðڽ��ϱ�?";
			break;
		case "M042": l_sMsg = "��ϵ� �ڷῡ ���ؼ��� ������ �����մϴ�.";
			break;
		case "M043": l_sMsg = "�� �ʼ� �Է� �׸��� Ȯ���ϼ���\n\n  �׸� : "+l_sWork;
			break;
		case "M044": l_sMsg = "�˻� �����׸��� �����ϴ�. ";
			break;
		case "M045": l_sMsg = "÷�������� �ֽ��ϴ�. \n\n��� �ڷḦ �����Ͻðڽ��ϱ�?";
			break;
		case "M060": l_sMsg = l_sWork +"�μ��ڵ� ���� �Դϴ�.";
			break;
		case "M061": l_sMsg = l_sWork +"�����ϰ��� �ϴ� �����͸� ������ �ּ���.";
			break;
		case "M062": l_sMsg = l_sWork +"�����ϰ��� �ϴ� �����Ͱ� �����ϴ�.";
			break;
		case "M063": l_sMsg = l_sWork +"����ϰ��� �ϴ� �����͸� ������ �ּ���.";
			break;
		case "M064": l_sMsg = l_sWork +"����ϰ��� �ϴ� �����Ͱ� �����ϴ�..";
			break;
		case "M065": l_sMsg = l_sWork +"����ϰ��� �ϴ� �����͸� ������ �ּ���.";
			break;
		case "M066": l_sMsg = l_sWork +"����� �ڷᰡ �����ϴ�";
			break;
		case "M070": l_sMsg ="���� ��û�� �Ͻðڽ��ϱ�?";
			break;
		case "M071": l_sMsg = "���õ� ������ �������� �ʽ��ϴ�.";
			break;
		case "M072": l_sMsg = "÷���� ������ �����ϼ���.";
			break;
		default :    l_sMsg = l_sWork +" �ڷ��� default �Դϴ�.";
			break;
	}

	return l_sMsg;
}


