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

//==========  엑셀로 저장시
function ln_Excel(obj,title){
//	var tbgd_Excel=

        obj.SetExcelTitle(0, "");
	TitleText = "value:" + title + ";font-face:굴림체;font-size:30pt;font-color:black;font-bold;font-underline;bgcolor:#CCFFCC;align: center;line-color:#C0C0C0;line-width:0.5pt;skiprow:1;";
	obj.SetExcelTitle(1, TitleText);
	var today = new Date();
	var day = today.getDay();
	var week;
	if (day==0) {week="일요일";}
	else if (day==1) {week="월요일";}
	else if (day==2) {week="화요일";}
	else if (day==3) {week="수요일";}
	else if (day==4) {week="목요일";}
	else if (day==5) {week="금요일";}
	else if (day==6) {week="토요일";}
	var hour = today.getHours();
	if (hour>12) {hour="오후 "+(hour-12);}
  else {hour="오전 "+hour;}
  var minute = today.getMinutes();
  var second = today.getSeconds();
	
	var ymd = today.getYear() +"년 "+ (today.getMonth() + 1) +"월 "+ today.getDate() + "일"
  var hms = hour + "시 " + minute + "분 " +  second + "초";
  TitleText = "value : 출력일자 : " + ymd + " ("+ week + ")";
  TitleText+= "\n" + hms;
	TitleText+= "; font-face: '굴림체';font-size: 12pt;font-color:#336600;font-italic;bgcolor:#ffffff;align:right;line-color: #C0C0C0;line-width:0.5pt;skiprow: 1;";
	obj.SetExcelTitle(1, TitleText);
	
	var g_Excelfile_type ="0";
	g_Excelfile_type = ln_Excel_file();

	if (g_Excelfile_type =="1"){//파일로 받기
			//obj.ExportFile(title,'true');
		obj.GridtoExcel(title,title,29);
	}else if (g_Excelfile_type =="2"){//엑셀로 받기
			obj.GridtoExcel(title,"",1);
	}else if (g_Excelfile_type =="3"){//텍스트 파일 저장시 사용함
			obj.ExportFileEx(title+'.txt', true, 1, false);
	}else{
		return;
	}
}

// 정의된 메세지 CALL
function gs_CallMsg(l_iMsgCode, l_sWork)
{
	var l_sMsg;
    if ( l_sWork == '-' || l_sWork == '-"' || l_sWork == '"-' || l_sWork == '"-"') l_sWork = "";
	switch(l_iMsgCode) {
		case "M001": l_sMsg = l_sWork +"자료 등록이 완료 되었습니다.";
			break;
		case "M002": l_sMsg = l_sWork +"자료 삭제가 완료 되었습니다.";
			break;
		case "M003": l_sMsg = l_sWork +"건이 조회 되었습니다.";
			break;
		case "M005": l_sMsg = l_sWork +"처리가 완료 되었습니다.";
			break;
		case "M006": l_sMsg = l_sWork +"삭제하시겠습니까?";
			break;
		case "M007": l_sMsg = l_sWork +"저장하시겠습니까?";
			break;
		case "M008": l_sMsg = l_sWork +"파일을 다운로드하시겠습니까?";
			break;
		case "M009": l_sMsg = l_sWork +"조회 후 작업하십시오.";
			break;
		case "M010": l_sMsg = l_sWork + "검색조건을 입력하십시오.";
			break;
		case "M011": l_sMsg = "기간 선택이 잘못되었습니다.";
			break;
		case "M012": l_sMsg = l_sWork + "일자 입력이 잘못되었습니다.";
			break;
		case "M013": l_sMsg = "해당자료가 없습니다.";
			break;
		case "M014": l_sMsg = "사용자를 검색해주세요.";
			break;
		case "M015": l_sMsg = "해당" + l_sWork + "의 세부내역이 있어 삭제할 수 없습니다.";
			break;
		case "M016": l_sMsg = l_sWork +"권한이 없습니다.";
			break;
		case "M017": l_sMsg = "해당 사용자가 없습니다.";
			break;
		case "M019": l_sMsg = l_sWork +"세션 정보가 없습니다. 다시 로그인하세요.";
			break;
		case "M020": l_sMsg = "삭제중입니다.....";
			break;
		case "M021": l_sMsg = "조회중입니다.....";
			break;
		case "M022": l_sMsg = "저장중입니다.....";
			break;
		case "M041": l_sMsg = "선택된 자료를 삭제하시겠습니까?";
			break;
		case "M042": l_sMsg = "등록된 자료에 대해서만 삭제가 가능합니다.";
			break;
		case "M043": l_sMsg = "※ 필수 입력 항목을 확인하세요\n\n  항목 : "+l_sWork;
			break;
		case "M044": l_sMsg = "검색 조건항목이 없습니다. ";
			break;
		case "M045": l_sMsg = "첨부파일이 있습니다. \n\n모든 자료를 삭제하시겠습니까?";
			break;
		case "M060": l_sMsg = l_sWork +"부서코드 오류 입니다.";
			break;
		case "M061": l_sMsg = l_sWork +"삭제하고자 하는 데이터를 선택해 주세요.";
			break;
		case "M062": l_sMsg = l_sWork +"저장하고자 하는 데이터가 없습니다.";
			break;
		case "M063": l_sMsg = l_sWork +"출력하고자 하는 데이터를 선택해 주세요.";
			break;
		case "M064": l_sMsg = l_sWork +"출력하고자 하는 데이터가 없습니다..";
			break;
		case "M065": l_sMsg = l_sWork +"취소하고자 하는 데이터를 선택해 주세요.";
			break;
		case "M066": l_sMsg = l_sWork +"변경된 자료가 없습니다";
			break;
		case "M070": l_sMsg ="결재 신청을 하시겠습니까?";
			break;
		case "M071": l_sMsg = "선택된 파일이 존재하지 않습니다.";
			break;
		case "M072": l_sMsg = "첨부할 파일을 선택하세요.";
			break;
		default :    l_sMsg = l_sWork +" 자료의 default 입니다.";
			break;
	}

	return l_sMsg;
}


