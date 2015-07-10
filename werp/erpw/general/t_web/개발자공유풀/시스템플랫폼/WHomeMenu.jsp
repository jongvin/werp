<%@ page language="java" import="com.daebo.common.*, com.daebo.util.*, com.daebo.database.*" errorPage="Error.jsp" contentType="text/html;charset=euc-kr" %>
<%
   	CITData lrReturnData  = null;
   	CITData lrReturnData1 = null;
   	CITData lrReturnData2 = null;

   	String strOut = "";
   	String	strSql = "";
   	String strACCESS_YN = "";

    try
    {
      	CITCommon.initPage(request, response, session);
   	}
   	catch (Exception ex)
   	{
		     throw new Exception("페이지 초기화 오류 -> " + ex.getMessage());
	   }

 			try
 			{
     CITData lrArgData = new CITData();

  			strSql   = "SELECT A.SYS_ID SYS_ID,                \n";
  			strSql  += "       A.GROUP_ID GROUP_ID,            \n";
  			strSql  += "       A.GROUP_NM GROUP_NM,            \n";
  			strSql  += "       NVL(B.ACCESS_YN, 'N') ACCESS_YN \n";
  			strSql  += "  FROM TCC_SYS_GROUP A,                \n";
  			strSql  += "       TCC_GROUP_USER B                \n";
  			strSql  += " WHERE A.GROUP_ID = B.GROUP_ID(+)      \n";
  			strSql  += "   AND A.USE_FG = 'Y'                  \n";
  			strSql  += "   AND A.SYS_ID = ?                    \n";
  			strSql  += "   AND B.USER_NO(+) = ?                \n";
  			strSql  += " ORDER BY A.GROUP_SEQ                  \n";

  			lrArgData.addColumn("SYS_ID",CITData.VARCHAR2);
  			lrArgData.addColumn("USER_NO",CITData.VARCHAR2);
  			lrArgData.addRow();
  			lrArgData.setValue("SYS_ID",session.getAttribute("sys_id"));
  			lrArgData.setValue("USER_NO",session.getAttribute("user_no"));

 				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
 			}
 			catch (Exception ex)
 			{
 					throw new Exception("USER-900001:TCC_SYS_GROUP Select 오류 -> " + ex.getMessage());
 			}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>동일토건 - 통합정보시스템</title>
		<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
		<link href="../css/Style.css" rel="stylesheet" type="text/css">
		<script language="javascript" src="../script/Common.js"></script>
		<script language="javascript" src="../script/Standard.js"></script>
		<script language="javascript">
		<!--
			function js_div(divName, imgName, level, AccessFg)
			{
				// divName - 메뉴 Layer 명
				// imgName - (+)(-) 이미지 명
				// level   - depth

    if (AccessFg == 'N')
    {
       C_msgOk("귀하는 해당 메뉴에 접근 할 수 없습니다.","경고");
    }
				else if (eval(divName + ".style.display != 'none'"))
				{
					js_divhide(divName, imgName, level);
				}
				else
				{
					js_divshow(divName, imgName, level);
				}
			}

			// 하위 메뉴 보이기
			function js_divshow(divName, imgName, level)
			{
				if (level == 1)
				{
					// depth가 1인 경우의 (-) 이미지
					eval(imgName + ".src='../images/left_menubullet_main_m.gif'");
				}
				else
				{
					// depth가 1이 아닌 경우의 (-) 이미지
					eval(imgName + ".src='../images/left_menubullet_sub_m.gif'");
				}

				eval(divName + ".style.display = 'block'");
			}

			// 하위 메뉴 숨기기
			function js_divhide(divName, imgName, level)
			{
				if (level == 1)
				{
					// depth가 1인 경우의 (+) 이미지
					eval(imgName + ".src='../images/left_menubullet_main_p.gif'");
				}
				else
				{
					// depth가 1이 아닌 경우의 (+) 이미지
					eval(imgName + ".src='../images/left_menubullet_sub_p.gif'");
				}

				eval(divName + ".style.display = 'none'");
			}

		//-->
		</script>
	</head>

	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
		<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0" background="../images/z1_left_menubg.gif">
			<tr>
				<td valign="top">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
<%
 			try
 			{
     CITData lrArgData = new CITData();

  			strSql   = "SELECT SYS_LOGO_URL   \n";
  			strSql  += "  FROM TCC_SYS_SYSTEM \n";
  			strSql  += " WHERE SYS_ID = ?     \n";

  			lrArgData.addColumn("SYS_ID",CITData.VARCHAR2);
  			lrArgData.addRow();
  			lrArgData.setValue("SYS_ID",session.getAttribute("sys_id"));

 				lrReturnData2 = CITDatabase.selectQuery(strSql, lrArgData);
 			}
 			catch (Exception ex)
 			{
 					throw new Exception("USER-900001:TCC_SYS_SYSTEM Select 오류 -> " + ex.getMessage());
 			}
%>
  					<td width="100%"><img src="<%=lrReturnData2.toString(0, "SYS_LOGO_URL")%>" width="180" height="80" border="0"></td>
						</tr>
					</table>
					<!--Menu 1 : 1 depth-->
<%
     if (lrReturnData != null)
     {
         for (int i = 0; i < lrReturnData.getRowsCount(); i++)
         {
              strOut  = "<table width='100%' height='25' border='0' cellpadding='0' cellspacing='0' background='../images/z1_left_menuline.gif'>\n";
              strOut += "<tr>\n";
              strOut += "<td width='25' align='right'>\n";
              strOut += "<a href=javascript:js_div('menu"+i+"','btn_menu"+i+"',"+i+ ",'"+lrReturnData.toString(i, "ACCESS_YN")+"') onfocus='blur()'><img src='../images/left_menubullet_main_p.gif' name='btn_menu"+i+"' border='0'></a>";
              strOut += "</td>";
              strOut += "<td class='left_menu_1depth'>&nbsp;\n";
              strOut += "<a href=javascript:js_div('menu"+i+"','btn_menu"+i+"',"+i+ ",'"+lrReturnData.toString(i, "ACCESS_YN")+"') class='left_menu_1depth' onfocus='blur()'>";
              strOut += lrReturnData.toString(i, "GROUP_NM");
              strOut += "</a>";
              strOut += "</td>\n";
              strOut += "</tr>\n";
              strOut += "</table>\n";
              out.println(strOut);

           			strSql   = " SELECT A.GROUP_ID GROUP_ID, \n";
           			strSql  += "        A.MENU_ID MENU_ID,   \n";
           			strSql  += "        B.MENU_NM MENU_NM,   \n";
           			strSql  += "        B.MENU_URL MENU_URL, \n";
           			strSql  += "        A.MENU_SEQ MENU_SEQ  \n";
           			strSql  += "   FROM TCC_GROUP_MENU A,    \n";
           			strSql  += "        TCC_SYS_MENU B       \n";
           			strSql  += "  WHERE A.MENU_ID = B.MENU_ID\n";
           			strSql  += "    AND GROUP_ID = ?         \n";
           			strSql  += "    AND USE_FG =  'Y'        \n";
           			strSql  += " ORDER BY A.MENU_SEQ         \n";

              CITData lrArgData = new CITData();

           			lrArgData.addColumn("GROUP_ID",CITData.VARCHAR2);
           			lrArgData.addRow();
           			lrArgData.setValue("GROUP_ID",lrReturnData.toString(i, "GROUP_ID"));

           			try
           			{
           				lrReturnData1 = CITDatabase.selectQuery(strSql, lrArgData);
           			}
           			catch (Exception ex)
           			{
           					throw new Exception("USER-900001:MAIN Select 오류 -> " + ex.getMessage());
           			}

              if (lrReturnData1 != null)
              {

                 strOut  = "<div id='menu"+i+"'style='display:none'>\n";
                 for (int j = 0; j < lrReturnData1.getRowsCount(); j++)
                 {
                     strOut += "<table width='100%' height='25' border='0' cellpadding='0' cellspacing='0' background='../images/z1_left_menuline1.gif'>\n";
                     strOut += "<tr>\n";
                     strOut += "<td width='25'>&nbsp;</td>\n";
                     strOut += "<td width='14'><img src='../images/left_menubullet_sub_d.gif'></td>\n";
                     strOut += "<td class='left_menu'><a href='";
                     strOut += lrReturnData1.toString(j, "MENU_URL");
                     strOut += "' target='mainFrame' onfocus='blur()'>";
                     strOut += lrReturnData1.toString(j, "MENU_NM");
                     strOut += "</td>\n";
                     strOut += "</tr>\n";
                     strOut += "</table>\n";
                 }
                 strOut +=  "</div>\n";
                 out.println(strOut);
              }
         }
     }
%>
					<table width="100%" height="5" border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td width="100%" height="5"></td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
	</body>
</html>
