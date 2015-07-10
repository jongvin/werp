<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id :
/* 2. 유형(시나리오) : Select Page
/* 3. 기  능  정  의 :
/* 4. 변  경  이  력 : 한재원 작성(2005-12-18)
/* 5. 관련  프로그램 :
/* 6. 특  기  사  항 :
/**************************************************************************/

	CITGauceInfo GauceInfo = null;

	CITData lrReturnData = null;
	GauceDataSet lrDataset = null;
	String	strSql = "";
	String	strAct = "";
	String	strUserNo = "";
	String      ssCompCode = "";
	String      ssDeptCode = "";
	String      ssDeptName = "";
	String     ssPrivLevel ="";
	String     ssDeptShortName ="";
	try
	{
		GauceInfo = CITCommon.initServerPage(request, response, session);
		strUserNo = CITCommon.toKOR((String)session.getAttribute("emp_no"));
		ssCompCode = CITCommon.toKOR((String)session.getAttribute("comp_code"));
		ssDeptCode = CITCommon.toKOR((String)session.getAttribute("dept_code"));
		ssDeptName = CITCommon.toKOR((String)session.getAttribute("long_name"));

		CITData lrArgData = new CITData();

		strAct = CITCommon.toKOR(request.getParameter("ACT"));

		if (strAct.equals("LIST00"))
		{
				String vCompCode = CITCommon.toKOR(request.getParameter("COMP_CODE"));
				String vBudgYyyy = CITCommon.toKOR(request.getParameter("BUDG_YYYY"));

				
				strSql  = "select '"+vCompCode+"' COMP_CODE, '%' DEPT_CODE, '전  체' DEPT_NAME, '전  체' DEPT_SHORT_NAME \n";
				strSql += "from dual a \n";
				strSql += "union all \n";
				strSql += "select a.COMP_CODE, a.DEPT_CODE, a.DEPT_NAME, a.DEPT_SHORT_NAME \n";
				strSql += "from T_DEPT_CODE a, \n";
				strSql += "	 ( \n";
				strSql += "	  SELECT DEPT_CODE \n";
				strSql += "	  FROM T_BUDG_DEPT \n";
				strSql += "	  group by DEPT_CODE \n";
				strSql += "	 ) b \n";
				strSql  += "WHERE \n";
				strSql  += "     a.COMP_CODE = '"+vCompCode+"' \n";
				strSql += "	and a.DEPT_CODE = b.DEPT_CODE \n";

			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);

				lrReturnData.setKey("COMP_CODE",true);
				lrReturnData.setKey("DEPT_CODE",true);

				lrReturnData.setColumnDisplaySize("DEPT_NAME", 100);
				lrReturnData.setColumnDisplaySize("DEPT_SHORT_NAME", 200);


				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo != null)
				{
					GauceInfo.response.writeException("USER", "900001","MAIN Select 오류-> "+ ex.getMessage());
				}
				else
				{
					throw new Exception("USER-900001:MAIN Select 오류 -> " + ex.getMessage());
				}
			}
		}

		//전체
		else if (strAct.equals("LIST02"))
		{
			String strCOMP_CODE = CITCommon.toKOR(request.getParameter("COMP_CODE"));
			String strDEPT_CODE = CITCommon.toKOR(request.getParameter("DEPT_CODE"));
			String strCLSE_ACC_ID = CITCommon.toKOR(request.getParameter("BUDG_YYYY"));
			String strCLSE_ACC_ID_B4 = CITCommon.toKOR(request.getParameter("BUDG_YYYY_B4"));
			String strDEPT_FLAG = CITCommon.toKOR(request.getParameter("DEPT_FLAG"));
			
			if(strDEPT_FLAG.equals("ALL"))
			{
				strSql  = " Select \n";
				strSql += " 	a.COMP_CODE, \n";
				strSql += " 	a.BUDG_CODE_NO, \n";
				strSql += " 	a.BUDG_CODE_NAME acc_name, \n";
				strSql += " 	a.P_BUDG_CODE_NO, \n";
				strSql += " 	a.RN, \n";
				strSql += " 	a.P_RN, \n";
				strSql += " 	a.P_BUDG_CODE_NAME p_acc_name, \n";
				strSql += " 	a.b_cb1, \n";
				strSql += " 	a.b_cb2, \n";
				strSql += " 	a.b_cb3, \n";
				strSql += " 	a.b_cb4, \n";
				strSql += " 	a.b_cb5, \n";
				strSql += " 	a.b_cb6, \n";
				strSql += " 	a.b_cb7, \n";
				strSql += " 	a.b_cb8, \n";
				strSql += " 	a.b_cb9, \n";
				strSql += " 	a.b_cb10, \n";
				strSql += " 	a.b_cb11, \n";
				strSql += " 	a.b_cb12, \n";
				strSql += " 	a.cb1, \n";
				strSql += " 	a.cb2, \n";
				strSql += " 	a.cb3, \n";
				strSql += " 	a.cb4, \n";
				strSql += " 	a.cb5, \n";
				strSql += " 	a.cb6, \n";
				strSql += " 	a.cb7, \n";
				strSql += " 	a.cb8, \n";
				strSql += " 	a.cb9, \n";
				strSql += " 	a.cb10, \n";
				strSql += " 	a.cb11, \n";
				strSql += " 	a.cb12, \n";
				strSql += " 	Nvl(a.cb1,0) 	- Nvl(a.b_cb1,0) 	sub_cb1, \n";
				strSql += " 	Nvl(a.cb2,0) 	- Nvl(a.b_cb2,0) 	sub_cb2, \n";
				strSql += " 	Nvl(a.cb3,0) 	- Nvl(a.b_cb3,0) 	sub_cb3, \n";
				strSql += " 	Nvl(a.cb4,0) 	- Nvl(a.b_cb4,0) 	sub_cb4, \n";
				strSql += " 	Nvl(a.cb5,0) 	- Nvl(a.b_cb5,0) 	sub_cb5, \n";
				strSql += " 	Nvl(a.cb6,0) 	- Nvl(a.b_cb6,0) 	sub_cb6, \n";
				strSql += " 	Nvl(a.cb7,0) 	- Nvl(a.b_cb7,0) 	sub_cb7, \n";
				strSql += " 	Nvl(a.cb8,0) 	- Nvl(a.b_cb8,0) 	sub_cb8, \n";
				strSql += " 	Nvl(a.cb9,0) 	- Nvl(a.b_cb9,0) 	sub_cb9, \n";
				strSql += " 	Nvl(a.cb10,0) 	- Nvl(a.b_cb10,0) 	sub_cb10, \n";
				strSql += " 	Nvl(a.cb11,0) 	- Nvl(a.b_cb11,0) 	sub_cb11, \n";
				strSql += " 	Nvl(a.cb12,0) 	- Nvl(a.b_cb12,0) 	sub_cb12, \n";
				strSql += " 	To_Char(100* Nvl(a.b_cb1,0)   /  NullIf(Nvl(a.cb1,0) ,0),'fm999,999,999,999,999,990.00')	r_cb1, \n";
				strSql += " 	To_Char(100* Nvl(a.b_cb2,0)   /  NullIf(Nvl(a.cb2,0) ,0),'fm999,999,999,999,999,990.00')	r_cb2, \n";
				strSql += " 	To_Char(100* Nvl(a.b_cb3,0)   /  NullIf(Nvl(a.cb3,0) ,0),'fm999,999,999,999,999,990.00')	r_cb3, \n";
				strSql += " 	To_Char(100* Nvl(a.b_cb4,0)   /  NullIf(Nvl(a.cb4,0) ,0),'fm999,999,999,999,999,990.00')	r_cb4, \n";
				strSql += " 	To_Char(100* Nvl(a.b_cb5,0)   /  NullIf(Nvl(a.cb5,0) ,0),'fm999,999,999,999,999,990.00')	r_cb5, \n";
				strSql += " 	To_Char(100* Nvl(a.b_cb6,0)   /  NullIf(Nvl(a.cb6,0) ,0),'fm999,999,999,999,999,990.00')	r_cb6, \n";
				strSql += " 	To_Char(100* Nvl(a.b_cb7,0)   /  NullIf(Nvl(a.cb7,0) ,0),'fm999,999,999,999,999,990.00')	r_cb7, \n";
				strSql += " 	To_Char(100* Nvl(a.b_cb8,0)   /  NullIf(Nvl(a.cb8,0) ,0),'fm999,999,999,999,999,990.00')	r_cb8, \n";
				strSql += " 	To_Char(100* Nvl(a.b_cb9,0)   /  NullIf(Nvl(a.cb9,0) ,0),'fm999,999,999,999,999,990.00')	r_cb9, \n";
				strSql += " 	To_Char(100* Nvl(a.b_cb10,0)  /  NullIf(Nvl(a.cb10,0),0),'fm999,999,999,999,999,990.00') 	r_cb10, \n";
				strSql += " 	To_Char(100* Nvl(a.b_cb11,0)  /  NullIf(Nvl(a.cb11,0),0),'fm999,999,999,999,999,990.00') 	r_cb11, \n";
				strSql += " 	To_Char(100* Nvl(a.b_cb12,0)  /  NullIf(Nvl(a.cb12,0),0),'fm999,999,999,999,999,990.00') 	r_cb12 \n";
				strSql += " From \n";
				strSql += " 	( \n";
				strSql += " 		Select \n";
				strSql += " 			b.COMP_CODE, \n";
				strSql += " 			C.BUDG_CODE_NO, \n";
				strSql += " 			C.BUDG_CODE_NAME, \n";
				strSql += " 			C.P_BUDG_CODE_NO, \n";
				strSql += " 			C.RN, \n";
				strSql += " 			D.RN P_RN, \n";
				strSql += " 			Case When Grouping(d.RN) = 1 Then '총  계' When Grouping(c.RN) = 1 Then d.BUDG_CODE_NAME ||' 계' Else d.BUDG_CODE_NAME End P_BUDG_CODE_NAME, \n";
				strSql += " 			Sum(Case When To_Char(b.MAKE_DT,'YYYY') =  ?  And To_Char(b.MAKE_DT,'MM') = '01' Then nvl(b.DB_AMT,0) + nvl(b.CR_AMT,0) Else 0 End) b_cb1, \n";
				strSql += " 			Sum(Case When To_Char(b.MAKE_DT,'YYYY') =  ?  And To_Char(b.MAKE_DT,'MM') = '02' Then nvl(b.DB_AMT,0) + nvl(b.CR_AMT,0) Else 0 End) b_cb2, \n";
				strSql += " 			Sum(Case When To_Char(b.MAKE_DT,'YYYY') =  ?  And To_Char(b.MAKE_DT,'MM') = '03' Then nvl(b.DB_AMT,0) + nvl(b.CR_AMT,0) Else 0 End) b_cb3, \n";
				strSql += " 			Sum(Case When To_Char(b.MAKE_DT,'YYYY') =  ?  And To_Char(b.MAKE_DT,'MM') = '04' Then nvl(b.DB_AMT,0) + nvl(b.CR_AMT,0) Else 0 End) b_cb4, \n";
				strSql += " 			Sum(Case When To_Char(b.MAKE_DT,'YYYY') =  ?  And To_Char(b.MAKE_DT,'MM') = '05' Then nvl(b.DB_AMT,0) + nvl(b.CR_AMT,0) Else 0 End) b_cb5, \n";
				strSql += " 			Sum(Case When To_Char(b.MAKE_DT,'YYYY') =  ?  And To_Char(b.MAKE_DT,'MM') = '06' Then nvl(b.DB_AMT,0) + nvl(b.CR_AMT,0) Else 0 End) b_cb6, \n";
				strSql += " 			Sum(Case When To_Char(b.MAKE_DT,'YYYY') =  ?  And To_Char(b.MAKE_DT,'MM') = '07' Then nvl(b.DB_AMT,0) + nvl(b.CR_AMT,0) Else 0 End) b_cb7, \n";
				strSql += " 			Sum(Case When To_Char(b.MAKE_DT,'YYYY') =  ?  And To_Char(b.MAKE_DT,'MM') = '08' Then nvl(b.DB_AMT,0) + nvl(b.CR_AMT,0) Else 0 End) b_cb8, \n";
				strSql += " 			Sum(Case When To_Char(b.MAKE_DT,'YYYY') =  ?  And To_Char(b.MAKE_DT,'MM') = '09' Then nvl(b.DB_AMT,0) + nvl(b.CR_AMT,0) Else 0 End) b_cb9, \n";
				strSql += " 			Sum(Case When To_Char(b.MAKE_DT,'YYYY') =  ?  And To_Char(b.MAKE_DT,'MM') = '10' Then nvl(b.DB_AMT,0) + nvl(b.CR_AMT,0) Else 0 End) b_cb10, \n";
				strSql += " 			Sum(Case When To_Char(b.MAKE_DT,'YYYY') =  ?  And To_Char(b.MAKE_DT,'MM') = '11' Then nvl(b.DB_AMT,0) + nvl(b.CR_AMT,0) Else 0 End) b_cb11, \n";
				strSql += " 			Sum(Case When To_Char(b.MAKE_DT,'YYYY') =  ?  And To_Char(b.MAKE_DT,'MM') = '12' Then nvl(b.DB_AMT,0) + nvl(b.CR_AMT,0) Else 0 End) b_cb12, \n";
				strSql += " 			Sum(Case When To_Char(b.MAKE_DT,'YYYY') =  ?  And To_Char(b.MAKE_DT,'MM') = '01' Then nvl(b.DB_AMT,0) + nvl(b.CR_AMT,0) Else 0 End) cb1, \n";
				strSql += " 			Sum(Case When To_Char(b.MAKE_DT,'YYYY') =  ?  And To_Char(b.MAKE_DT,'MM') = '02' Then nvl(b.DB_AMT,0) + nvl(b.CR_AMT,0) Else 0 End) cb2, \n";
				strSql += " 			Sum(Case When To_Char(b.MAKE_DT,'YYYY') =  ?  And To_Char(b.MAKE_DT,'MM') = '03' Then nvl(b.DB_AMT,0) + nvl(b.CR_AMT,0) Else 0 End) cb3, \n";
				strSql += " 			Sum(Case When To_Char(b.MAKE_DT,'YYYY') =  ?  And To_Char(b.MAKE_DT,'MM') = '04' Then nvl(b.DB_AMT,0) + nvl(b.CR_AMT,0) Else 0 End) cb4, \n";
				strSql += " 			Sum(Case When To_Char(b.MAKE_DT,'YYYY') =  ?  And To_Char(b.MAKE_DT,'MM') = '05' Then nvl(b.DB_AMT,0) + nvl(b.CR_AMT,0) Else 0 End) cb5, \n";
				strSql += " 			Sum(Case When To_Char(b.MAKE_DT,'YYYY') =  ?  And To_Char(b.MAKE_DT,'MM') = '06' Then nvl(b.DB_AMT,0) + nvl(b.CR_AMT,0) Else 0 End) cb6, \n";
				strSql += " 			Sum(Case When To_Char(b.MAKE_DT,'YYYY') =  ?  And To_Char(b.MAKE_DT,'MM') = '07' Then nvl(b.DB_AMT,0) + nvl(b.CR_AMT,0) Else 0 End) cb7, \n";
				strSql += " 			Sum(Case When To_Char(b.MAKE_DT,'YYYY') =  ?  And To_Char(b.MAKE_DT,'MM') = '08' Then nvl(b.DB_AMT,0) + nvl(b.CR_AMT,0) Else 0 End) cb8, \n";
				strSql += " 			Sum(Case When To_Char(b.MAKE_DT,'YYYY') =  ?  And To_Char(b.MAKE_DT,'MM') = '09' Then nvl(b.DB_AMT,0) + nvl(b.CR_AMT,0) Else 0 End) cb9, \n";
				strSql += " 			Sum(Case When To_Char(b.MAKE_DT,'YYYY') =  ?  And To_Char(b.MAKE_DT,'MM') = '10' Then nvl(b.DB_AMT,0) + nvl(b.CR_AMT,0) Else 0 End) cb10, \n";
				strSql += " 			Sum(Case When To_Char(b.MAKE_DT,'YYYY') =  ?  And To_Char(b.MAKE_DT,'MM') = '11' Then nvl(b.DB_AMT,0) + nvl(b.CR_AMT,0) Else 0 End) cb11, \n";
				strSql += " 			Sum(Case When To_Char(b.MAKE_DT,'YYYY') =  ?  And To_Char(b.MAKE_DT,'MM') = '12' Then nvl(b.DB_AMT,0) + nvl(b.CR_AMT,0) Else 0 End) cb12 \n";
				strSql += " 		From	T_ACC_SLIP_BODY1 b, \n";
				strSql += " 				( \n";
				strSql += " 					Select  \n";
				strSql += " 						c.BUDG_CODE_NO , \n";
				strSql += " 						c.CRTUSERNO , \n";
				strSql += " 						c.CRTDATE , \n";
				strSql += " 						c.MODUSERNO , \n";
				strSql += " 						c.MODDATE , \n";
				strSql += " 						c.P_BUDG_CODE_NO , \n";
				strSql += " 						c.LEVEL_SEQ , \n";
				strSql += " 						c.LEGACY_BUDG_CODE , \n";
				strSql += " 						c.BUDG_CODE_NAME , \n";
				strSql += " 						c.ACC_CODE , \n";
				strSql += " 						c.USE_CLS , \n";
				strSql += " 						c.CONTROL_LEVEL_TAG , \n";
				strSql += " 						c.BUDG_ITEM_CODE , \n";
				strSql += " 						c.MAKE_DEPT , \n";
				strSql += " 						c.ASSIGN_TAG , \n";
				strSql += " 						c.COMP_CODE, \n";
				strSql += " 						RowNum Rn \n";
				strSql += " 					From T_BUDG_CODE C \n";
				strSql += " 					Start With \n";
				strSql += " 							COMP_CODE =  ?  \n";
				strSql += " 					And		Not Exists \n";
				strSql += " 							( \n";
				strSql += " 								Select \n";
				strSql += " 									Null \n";
				strSql += " 								From	t_budg_code x \n";
				strSql += " 								Where	x.COMP_CODE = c.COMP_CODE \n";
				strSql += " 								And		x.BUDG_CODE_NO = c.P_BUDG_CODE_NO \n";
				strSql += " 							) \n";
				strSql += " 					Connect By \n";
				strSql += " 						Prior	c.BUDG_CODE_NO = c.P_BUDG_CODE_NO \n";
				strSql += " 					Order Siblings By \n";
				strSql += " 						c.LEVEL_SEQ \n";
				strSql += " 				) C, \n";
				strSql += " 				( \n";
				strSql += " 					Select  \n";
				strSql += " 						c.BUDG_CODE_NO , \n";
				strSql += " 						c.CRTUSERNO , \n";
				strSql += " 						c.CRTDATE , \n";
				strSql += " 						c.MODUSERNO , \n";
				strSql += " 						c.MODDATE , \n";
				strSql += " 						c.P_BUDG_CODE_NO , \n";
				strSql += " 						c.LEVEL_SEQ , \n";
				strSql += " 						c.LEGACY_BUDG_CODE , \n";
				strSql += " 						c.BUDG_CODE_NAME , \n";
				strSql += " 						c.ACC_CODE , \n";
				strSql += " 						c.USE_CLS , \n";
				strSql += " 						c.CONTROL_LEVEL_TAG , \n";
				strSql += " 						c.BUDG_ITEM_CODE , \n";
				strSql += " 						c.MAKE_DEPT , \n";
				strSql += " 						c.ASSIGN_TAG , \n";
				strSql += " 						c.COMP_CODE, \n";
				strSql += " 						RowNum Rn \n";
				strSql += " 					From T_BUDG_CODE C \n";
				strSql += " 					Start With \n";
				strSql += " 							COMP_CODE =  ?  \n";
				strSql += " 					And		Not Exists \n";
				strSql += " 							( \n";
				strSql += " 								Select \n";
				strSql += " 									Null \n";
				strSql += " 								From	t_budg_code x \n";
				strSql += " 								Where	x.COMP_CODE = c.COMP_CODE \n";
				strSql += " 								And		x.BUDG_CODE_NO = c.P_BUDG_CODE_NO \n";
				strSql += " 							) \n";
				strSql += " 					Connect By \n";
				strSql += " 						Prior	c.BUDG_CODE_NO = c.P_BUDG_CODE_NO \n";
				strSql += " 					Order Siblings By \n";
				strSql += " 						c.LEVEL_SEQ \n";
				strSql += " 				) D \n";
				strSql += " 		Where	b.KEEP_DT is not null \n";
				strSql += " 		And		b.TRANSFER_TAG = 'F' \n";
				strSql += " 		And		b.MAKE_DT Between To_Date(  ?  ||'-01-01','YYYY-MM-DD') And To_Date(  ?  ||'-12-31','YYYY-MM-DD') \n";
				strSql += " 		And		b.COMP_CODE =  ?  \n";
				strSql += " 		And		b.ACC_CODE  = c.ACC_CODE \n";
				strSql += " 		And		b.COMP_CODE = c.COMP_CODE \n";
				strSql += " 		And		c.P_BUDG_CODE_NO = d.BUDG_CODE_NO (+) \n";
				strSql += " 		Group By Grouping Sets \n";
				strSql += " 		( \n";
				strSql += " 			( \n";
				strSql += " 				b.COMP_CODE, \n";
				strSql += " 				C.BUDG_CODE_NO, \n";
				strSql += " 				C.BUDG_CODE_NAME, \n";
				strSql += " 				C.P_BUDG_CODE_NO, \n";
				strSql += " 				D.BUDG_CODE_NAME, \n";
				strSql += " 				C.RN, \n";
				strSql += " 				D.RN \n";
				strSql += " 			), \n";
				strSql += " 			( \n";
				strSql += " 				b.COMP_CODE, \n";
				strSql += " 				C.P_BUDG_CODE_NO, \n";
				strSql += " 				D.BUDG_CODE_NAME, \n";
				strSql += " 				D.RN \n";
				strSql += " 			), \n";
				strSql += " 			( \n";
				strSql += " 			) \n";
				strSql += " 		) \n";
				strSql += " 	) a \n";
				strSql += " Order By \n";
				strSql += " 	a.P_RN, \n";
				strSql += " 	a.RN \n";
				strSql += "  ";
				
				lrArgData.addColumn("1CLSE_ACC_ID_B4", CITData.VARCHAR2);
				lrArgData.addColumn("2CLSE_ACC_ID_B4", CITData.VARCHAR2);
				lrArgData.addColumn("3CLSE_ACC_ID_B4", CITData.VARCHAR2);
				lrArgData.addColumn("4CLSE_ACC_ID_B4", CITData.VARCHAR2);
				lrArgData.addColumn("5CLSE_ACC_ID_B4", CITData.VARCHAR2);
				lrArgData.addColumn("6CLSE_ACC_ID_B4", CITData.VARCHAR2);
				lrArgData.addColumn("7CLSE_ACC_ID_B4", CITData.VARCHAR2);
				lrArgData.addColumn("8CLSE_ACC_ID_B4", CITData.VARCHAR2);
				lrArgData.addColumn("9CLSE_ACC_ID_B4", CITData.VARCHAR2);
				lrArgData.addColumn("10CLSE_ACC_ID_B4", CITData.VARCHAR2);
				lrArgData.addColumn("11CLSE_ACC_ID_B4", CITData.VARCHAR2);
				lrArgData.addColumn("12CLSE_ACC_ID_B4", CITData.VARCHAR2);
				lrArgData.addColumn("13CLSE_ACC_ID", CITData.VARCHAR2);
				lrArgData.addColumn("14CLSE_ACC_ID", CITData.VARCHAR2);
				lrArgData.addColumn("15CLSE_ACC_ID", CITData.VARCHAR2);
				lrArgData.addColumn("16CLSE_ACC_ID", CITData.VARCHAR2);
				lrArgData.addColumn("17CLSE_ACC_ID", CITData.VARCHAR2);
				lrArgData.addColumn("18CLSE_ACC_ID", CITData.VARCHAR2);
				lrArgData.addColumn("19CLSE_ACC_ID", CITData.VARCHAR2);
				lrArgData.addColumn("20CLSE_ACC_ID", CITData.VARCHAR2);
				lrArgData.addColumn("21CLSE_ACC_ID", CITData.VARCHAR2);
				lrArgData.addColumn("22CLSE_ACC_ID", CITData.VARCHAR2);
				lrArgData.addColumn("23CLSE_ACC_ID", CITData.VARCHAR2);
				lrArgData.addColumn("24CLSE_ACC_ID", CITData.VARCHAR2);
				lrArgData.addColumn("25COMP_CODE", CITData.VARCHAR2);
				lrArgData.addColumn("26COMP_CODE", CITData.VARCHAR2);
				lrArgData.addColumn("27CLSE_ACC_ID_B4", CITData.VARCHAR2);
				lrArgData.addColumn("28CLSE_ACC_ID", CITData.VARCHAR2);
				lrArgData.addColumn("29COMP_CODE", CITData.VARCHAR2);
				lrArgData.addRow();
				lrArgData.setValue("1CLSE_ACC_ID_B4", strCLSE_ACC_ID_B4);
				lrArgData.setValue("2CLSE_ACC_ID_B4", strCLSE_ACC_ID_B4);
				lrArgData.setValue("3CLSE_ACC_ID_B4", strCLSE_ACC_ID_B4);
				lrArgData.setValue("4CLSE_ACC_ID_B4", strCLSE_ACC_ID_B4);
				lrArgData.setValue("5CLSE_ACC_ID_B4", strCLSE_ACC_ID_B4);
				lrArgData.setValue("6CLSE_ACC_ID_B4", strCLSE_ACC_ID_B4);
				lrArgData.setValue("7CLSE_ACC_ID_B4", strCLSE_ACC_ID_B4);
				lrArgData.setValue("8CLSE_ACC_ID_B4", strCLSE_ACC_ID_B4);
				lrArgData.setValue("9CLSE_ACC_ID_B4", strCLSE_ACC_ID_B4);
				lrArgData.setValue("10CLSE_ACC_ID_B4", strCLSE_ACC_ID_B4);
				lrArgData.setValue("11CLSE_ACC_ID_B4", strCLSE_ACC_ID_B4);
				lrArgData.setValue("12CLSE_ACC_ID_B4", strCLSE_ACC_ID_B4);
				lrArgData.setValue("13CLSE_ACC_ID", strCLSE_ACC_ID);
				lrArgData.setValue("14CLSE_ACC_ID", strCLSE_ACC_ID);
				lrArgData.setValue("15CLSE_ACC_ID", strCLSE_ACC_ID);
				lrArgData.setValue("16CLSE_ACC_ID", strCLSE_ACC_ID);
				lrArgData.setValue("17CLSE_ACC_ID", strCLSE_ACC_ID);
				lrArgData.setValue("18CLSE_ACC_ID", strCLSE_ACC_ID);
				lrArgData.setValue("19CLSE_ACC_ID", strCLSE_ACC_ID);
				lrArgData.setValue("20CLSE_ACC_ID", strCLSE_ACC_ID);
				lrArgData.setValue("21CLSE_ACC_ID", strCLSE_ACC_ID);
				lrArgData.setValue("22CLSE_ACC_ID", strCLSE_ACC_ID);
				lrArgData.setValue("23CLSE_ACC_ID", strCLSE_ACC_ID);
				lrArgData.setValue("24CLSE_ACC_ID", strCLSE_ACC_ID);
				lrArgData.setValue("25COMP_CODE", strCOMP_CODE);
				lrArgData.setValue("26COMP_CODE", strCOMP_CODE);
				lrArgData.setValue("27CLSE_ACC_ID_B4", strCLSE_ACC_ID_B4);
				lrArgData.setValue("28CLSE_ACC_ID", strCLSE_ACC_ID);
				lrArgData.setValue("29COMP_CODE", strCOMP_CODE);
			}
			else if(strDEPT_FLAG.equals("CHK_DEPT"))
			{
				strSql  = " Select \n";
				strSql += " 	a.COMP_CODE, \n";
				strSql += " 	a.BUDG_CODE_NO, \n";
				strSql += " 	a.CHK_DEPT_CODE, \n";
				strSql += " 	a.CHK_DEPT_NAME, \n";
				strSql += " 	a.BUDG_CODE_NAME acc_name, \n";
				strSql += " 	a.P_BUDG_CODE_NO, \n";
				strSql += " 	a.RN, \n";
				strSql += " 	a.P_RN, \n";
				strSql += " 	a.P_BUDG_CODE_NAME p_acc_name, \n";
				strSql += " 	a.b_cb1, \n";
				strSql += " 	a.b_cb2, \n";
				strSql += " 	a.b_cb3, \n";
				strSql += " 	a.b_cb4, \n";
				strSql += " 	a.b_cb5, \n";
				strSql += " 	a.b_cb6, \n";
				strSql += " 	a.b_cb7, \n";
				strSql += " 	a.b_cb8, \n";
				strSql += " 	a.b_cb9, \n";
				strSql += " 	a.b_cb10, \n";
				strSql += " 	a.b_cb11, \n";
				strSql += " 	a.b_cb12, \n";
				strSql += " 	a.cb1, \n";
				strSql += " 	a.cb2, \n";
				strSql += " 	a.cb3, \n";
				strSql += " 	a.cb4, \n";
				strSql += " 	a.cb5, \n";
				strSql += " 	a.cb6, \n";
				strSql += " 	a.cb7, \n";
				strSql += " 	a.cb8, \n";
				strSql += " 	a.cb9, \n";
				strSql += " 	a.cb10, \n";
				strSql += " 	a.cb11, \n";
				strSql += " 	a.cb12, \n";
				strSql += " 	Nvl(a.cb1,0) 	- Nvl(a.b_cb1,0) 	sub_cb1, \n";
				strSql += " 	Nvl(a.cb2,0) 	- Nvl(a.b_cb2,0) 	sub_cb2, \n";
				strSql += " 	Nvl(a.cb3,0) 	- Nvl(a.b_cb3,0) 	sub_cb3, \n";
				strSql += " 	Nvl(a.cb4,0) 	- Nvl(a.b_cb4,0) 	sub_cb4, \n";
				strSql += " 	Nvl(a.cb5,0) 	- Nvl(a.b_cb5,0) 	sub_cb5, \n";
				strSql += " 	Nvl(a.cb6,0) 	- Nvl(a.b_cb6,0) 	sub_cb6, \n";
				strSql += " 	Nvl(a.cb7,0) 	- Nvl(a.b_cb7,0) 	sub_cb7, \n";
				strSql += " 	Nvl(a.cb8,0) 	- Nvl(a.b_cb8,0) 	sub_cb8, \n";
				strSql += " 	Nvl(a.cb9,0) 	- Nvl(a.b_cb9,0) 	sub_cb9, \n";
				strSql += " 	Nvl(a.cb10,0) 	- Nvl(a.b_cb10,0) 	sub_cb10, \n";
				strSql += " 	Nvl(a.cb11,0) 	- Nvl(a.b_cb11,0) 	sub_cb11, \n";
				strSql += " 	Nvl(a.cb12,0) 	- Nvl(a.b_cb12,0) 	sub_cb12, \n";
				strSql += " 	To_Char(100* Nvl(a.b_cb1,0)   /  NullIf(Nvl(a.cb1,0) ,0),'fm999,999,999,999,999,990.00')	r_cb1, \n";
				strSql += " 	To_Char(100* Nvl(a.b_cb2,0)   /  NullIf(Nvl(a.cb2,0) ,0),'fm999,999,999,999,999,990.00')	r_cb2, \n";
				strSql += " 	To_Char(100* Nvl(a.b_cb3,0)   /  NullIf(Nvl(a.cb3,0) ,0),'fm999,999,999,999,999,990.00')	r_cb3, \n";
				strSql += " 	To_Char(100* Nvl(a.b_cb4,0)   /  NullIf(Nvl(a.cb4,0) ,0),'fm999,999,999,999,999,990.00')	r_cb4, \n";
				strSql += " 	To_Char(100* Nvl(a.b_cb5,0)   /  NullIf(Nvl(a.cb5,0) ,0),'fm999,999,999,999,999,990.00')	r_cb5, \n";
				strSql += " 	To_Char(100* Nvl(a.b_cb6,0)   /  NullIf(Nvl(a.cb6,0) ,0),'fm999,999,999,999,999,990.00')	r_cb6, \n";
				strSql += " 	To_Char(100* Nvl(a.b_cb7,0)   /  NullIf(Nvl(a.cb7,0) ,0),'fm999,999,999,999,999,990.00')	r_cb7, \n";
				strSql += " 	To_Char(100* Nvl(a.b_cb8,0)   /  NullIf(Nvl(a.cb8,0) ,0),'fm999,999,999,999,999,990.00')	r_cb8, \n";
				strSql += " 	To_Char(100* Nvl(a.b_cb9,0)   /  NullIf(Nvl(a.cb9,0) ,0),'fm999,999,999,999,999,990.00')	r_cb9, \n";
				strSql += " 	To_Char(100* Nvl(a.b_cb10,0)  /  NullIf(Nvl(a.cb10,0),0),'fm999,999,999,999,999,990.00') 	r_cb10, \n";
				strSql += " 	To_Char(100* Nvl(a.b_cb11,0)  /  NullIf(Nvl(a.cb11,0),0),'fm999,999,999,999,999,990.00') 	r_cb11, \n";
				strSql += " 	To_Char(100* Nvl(a.b_cb12,0)  /  NullIf(Nvl(a.cb12,0),0),'fm999,999,999,999,999,990.00') 	r_cb12 \n";
				strSql += " From \n";
				strSql += " 	( \n";
				strSql += " 		Select \n";
				strSql += " 			b.COMP_CODE, \n";
				strSql += " 			C.BUDG_CODE_NO, \n";
				strSql += " 			C.BUDG_CODE_NAME, \n";
				strSql += " 			C.P_BUDG_CODE_NO, \n";
				strSql += " 			F.DEPT_CODE CHK_DEPT_CODE, \n";
				strSql += " 			C.RN, \n";
				strSql += " 			D.RN P_RN, \n";
				strSql += " 			Case When Grouping(F.DEPT_CODE) = 1 Then '총  계' When Grouping(d.RN) = 1 Then F.DEPT_NAME||' 계' Else f.DEPT_NAME End CHK_DEPT_NAME, \n";
				strSql += " 			Case When Grouping(d.RN) = 1 Then ' ' When Grouping(c.RN) = 1 Then d.BUDG_CODE_NAME ||' 계' Else d.BUDG_CODE_NAME End P_BUDG_CODE_NAME, \n";
				strSql += " 			Sum(Case When To_Char(b.MAKE_DT,'YYYY') =  ?  And To_Char(b.MAKE_DT,'MM') = '01' Then nvl(b.DB_AMT,0) + nvl(b.CR_AMT,0) Else 0 End) b_cb1, \n";
				strSql += " 			Sum(Case When To_Char(b.MAKE_DT,'YYYY') =  ?  And To_Char(b.MAKE_DT,'MM') = '02' Then nvl(b.DB_AMT,0) + nvl(b.CR_AMT,0) Else 0 End) b_cb2, \n";
				strSql += " 			Sum(Case When To_Char(b.MAKE_DT,'YYYY') =  ?  And To_Char(b.MAKE_DT,'MM') = '03' Then nvl(b.DB_AMT,0) + nvl(b.CR_AMT,0) Else 0 End) b_cb3, \n";
				strSql += " 			Sum(Case When To_Char(b.MAKE_DT,'YYYY') =  ?  And To_Char(b.MAKE_DT,'MM') = '04' Then nvl(b.DB_AMT,0) + nvl(b.CR_AMT,0) Else 0 End) b_cb4, \n";
				strSql += " 			Sum(Case When To_Char(b.MAKE_DT,'YYYY') =  ?  And To_Char(b.MAKE_DT,'MM') = '05' Then nvl(b.DB_AMT,0) + nvl(b.CR_AMT,0) Else 0 End) b_cb5, \n";
				strSql += " 			Sum(Case When To_Char(b.MAKE_DT,'YYYY') =  ?  And To_Char(b.MAKE_DT,'MM') = '06' Then nvl(b.DB_AMT,0) + nvl(b.CR_AMT,0) Else 0 End) b_cb6, \n";
				strSql += " 			Sum(Case When To_Char(b.MAKE_DT,'YYYY') =  ?  And To_Char(b.MAKE_DT,'MM') = '07' Then nvl(b.DB_AMT,0) + nvl(b.CR_AMT,0) Else 0 End) b_cb7, \n";
				strSql += " 			Sum(Case When To_Char(b.MAKE_DT,'YYYY') =  ?  And To_Char(b.MAKE_DT,'MM') = '08' Then nvl(b.DB_AMT,0) + nvl(b.CR_AMT,0) Else 0 End) b_cb8, \n";
				strSql += " 			Sum(Case When To_Char(b.MAKE_DT,'YYYY') =  ?  And To_Char(b.MAKE_DT,'MM') = '09' Then nvl(b.DB_AMT,0) + nvl(b.CR_AMT,0) Else 0 End) b_cb9, \n";
				strSql += " 			Sum(Case When To_Char(b.MAKE_DT,'YYYY') =  ?  And To_Char(b.MAKE_DT,'MM') = '10' Then nvl(b.DB_AMT,0) + nvl(b.CR_AMT,0) Else 0 End) b_cb10, \n";
				strSql += " 			Sum(Case When To_Char(b.MAKE_DT,'YYYY') =  ?  And To_Char(b.MAKE_DT,'MM') = '11' Then nvl(b.DB_AMT,0) + nvl(b.CR_AMT,0) Else 0 End) b_cb11, \n";
				strSql += " 			Sum(Case When To_Char(b.MAKE_DT,'YYYY') =  ?  And To_Char(b.MAKE_DT,'MM') = '12' Then nvl(b.DB_AMT,0) + nvl(b.CR_AMT,0) Else 0 End) b_cb12, \n";
				strSql += " 			Sum(Case When To_Char(b.MAKE_DT,'YYYY') =  ?  And To_Char(b.MAKE_DT,'MM') = '01' Then nvl(b.DB_AMT,0) + nvl(b.CR_AMT,0) Else 0 End) cb1, \n";
				strSql += " 			Sum(Case When To_Char(b.MAKE_DT,'YYYY') =  ?  And To_Char(b.MAKE_DT,'MM') = '02' Then nvl(b.DB_AMT,0) + nvl(b.CR_AMT,0) Else 0 End) cb2, \n";
				strSql += " 			Sum(Case When To_Char(b.MAKE_DT,'YYYY') =  ?  And To_Char(b.MAKE_DT,'MM') = '03' Then nvl(b.DB_AMT,0) + nvl(b.CR_AMT,0) Else 0 End) cb3, \n";
				strSql += " 			Sum(Case When To_Char(b.MAKE_DT,'YYYY') =  ?  And To_Char(b.MAKE_DT,'MM') = '04' Then nvl(b.DB_AMT,0) + nvl(b.CR_AMT,0) Else 0 End) cb4, \n";
				strSql += " 			Sum(Case When To_Char(b.MAKE_DT,'YYYY') =  ?  And To_Char(b.MAKE_DT,'MM') = '05' Then nvl(b.DB_AMT,0) + nvl(b.CR_AMT,0) Else 0 End) cb5, \n";
				strSql += " 			Sum(Case When To_Char(b.MAKE_DT,'YYYY') =  ?  And To_Char(b.MAKE_DT,'MM') = '06' Then nvl(b.DB_AMT,0) + nvl(b.CR_AMT,0) Else 0 End) cb6, \n";
				strSql += " 			Sum(Case When To_Char(b.MAKE_DT,'YYYY') =  ?  And To_Char(b.MAKE_DT,'MM') = '07' Then nvl(b.DB_AMT,0) + nvl(b.CR_AMT,0) Else 0 End) cb7, \n";
				strSql += " 			Sum(Case When To_Char(b.MAKE_DT,'YYYY') =  ?  And To_Char(b.MAKE_DT,'MM') = '08' Then nvl(b.DB_AMT,0) + nvl(b.CR_AMT,0) Else 0 End) cb8, \n";
				strSql += " 			Sum(Case When To_Char(b.MAKE_DT,'YYYY') =  ?  And To_Char(b.MAKE_DT,'MM') = '09' Then nvl(b.DB_AMT,0) + nvl(b.CR_AMT,0) Else 0 End) cb9, \n";
				strSql += " 			Sum(Case When To_Char(b.MAKE_DT,'YYYY') =  ?  And To_Char(b.MAKE_DT,'MM') = '10' Then nvl(b.DB_AMT,0) + nvl(b.CR_AMT,0) Else 0 End) cb10, \n";
				strSql += " 			Sum(Case When To_Char(b.MAKE_DT,'YYYY') =  ?  And To_Char(b.MAKE_DT,'MM') = '11' Then nvl(b.DB_AMT,0) + nvl(b.CR_AMT,0) Else 0 End) cb11, \n";
				strSql += " 			Sum(Case When To_Char(b.MAKE_DT,'YYYY') =  ?  And To_Char(b.MAKE_DT,'MM') = '12' Then nvl(b.DB_AMT,0) + nvl(b.CR_AMT,0) Else 0 End) cb12 \n";
				strSql += " 		From	T_ACC_SLIP_BODY1 b, \n";
				strSql += " 				( \n";
				strSql += " 					Select  \n";
				strSql += " 						c.BUDG_CODE_NO , \n";
				strSql += " 						c.CRTUSERNO , \n";
				strSql += " 						c.CRTDATE , \n";
				strSql += " 						c.MODUSERNO , \n";
				strSql += " 						c.MODDATE , \n";
				strSql += " 						c.P_BUDG_CODE_NO , \n";
				strSql += " 						c.LEVEL_SEQ , \n";
				strSql += " 						c.LEGACY_BUDG_CODE , \n";
				strSql += " 						c.BUDG_CODE_NAME , \n";
				strSql += " 						c.ACC_CODE , \n";
				strSql += " 						c.USE_CLS , \n";
				strSql += " 						c.CONTROL_LEVEL_TAG , \n";
				strSql += " 						c.BUDG_ITEM_CODE , \n";
				strSql += " 						c.MAKE_DEPT , \n";
				strSql += " 						c.ASSIGN_TAG , \n";
				strSql += " 						c.COMP_CODE, \n";
				strSql += " 						RowNum Rn \n";
				strSql += " 					From T_BUDG_CODE C \n";
				strSql += " 					Start With \n";
				strSql += " 							COMP_CODE =  ?  \n";
				strSql += " 					And		Not Exists \n";
				strSql += " 							( \n";
				strSql += " 								Select \n";
				strSql += " 									Null \n";
				strSql += " 								From	t_budg_code x \n";
				strSql += " 								Where	x.COMP_CODE = c.COMP_CODE \n";
				strSql += " 								And		x.BUDG_CODE_NO = c.P_BUDG_CODE_NO \n";
				strSql += " 							) \n";
				strSql += " 					Connect By \n";
				strSql += " 						Prior	c.BUDG_CODE_NO = c.P_BUDG_CODE_NO \n";
				strSql += " 					Order Siblings By \n";
				strSql += " 						c.LEVEL_SEQ \n";
				strSql += " 				) C, \n";
				strSql += " 				( \n";
				strSql += " 					Select  \n";
				strSql += " 						c.BUDG_CODE_NO , \n";
				strSql += " 						c.CRTUSERNO , \n";
				strSql += " 						c.CRTDATE , \n";
				strSql += " 						c.MODUSERNO , \n";
				strSql += " 						c.MODDATE , \n";
				strSql += " 						c.P_BUDG_CODE_NO , \n";
				strSql += " 						c.LEVEL_SEQ , \n";
				strSql += " 						c.LEGACY_BUDG_CODE , \n";
				strSql += " 						c.BUDG_CODE_NAME , \n";
				strSql += " 						c.ACC_CODE , \n";
				strSql += " 						c.USE_CLS , \n";
				strSql += " 						c.CONTROL_LEVEL_TAG , \n";
				strSql += " 						c.BUDG_ITEM_CODE , \n";
				strSql += " 						c.MAKE_DEPT , \n";
				strSql += " 						c.ASSIGN_TAG , \n";
				strSql += " 						c.COMP_CODE, \n";
				strSql += " 						RowNum Rn \n";
				strSql += " 					From T_BUDG_CODE C \n";
				strSql += " 					Start With \n";
				strSql += " 							COMP_CODE =  ?  \n";
				strSql += " 					And		Not Exists \n";
				strSql += " 							( \n";
				strSql += " 								Select \n";
				strSql += " 									Null \n";
				strSql += " 								From	t_budg_code x \n";
				strSql += " 								Where	x.COMP_CODE = c.COMP_CODE \n";
				strSql += " 								And		x.BUDG_CODE_NO = c.P_BUDG_CODE_NO \n";
				strSql += " 							) \n";
				strSql += " 					Connect By \n";
				strSql += " 						Prior	c.BUDG_CODE_NO = c.P_BUDG_CODE_NO \n";
				strSql += " 					Order Siblings By \n";
				strSql += " 						c.LEVEL_SEQ \n";
				strSql += " 				) D, \n";
				strSql += " 				T_BUDG_DEPT_MAP E, \n";
				strSql += " 				T_DEPT_CODE_ORG F \n";
				strSql += " 		Where	b.KEEP_DT is not null \n";
				strSql += " 		And		b.TRANSFER_TAG = 'F' \n";
				strSql += " 		And		b.MAKE_DT Between To_Date(  ?  ||'-01-01','YYYY-MM-DD') And To_Date(  ?  ||'-12-31','YYYY-MM-DD') \n";
				strSql += " 		And		b.COMP_CODE =  ?  \n";
				strSql += " 		And		b.ACC_CODE  = c.ACC_CODE \n";
				strSql += " 		And		b.COMP_CODE = c.COMP_CODE \n";
				strSql += " 		And		c.P_BUDG_CODE_NO = d.BUDG_CODE_NO (+) \n";
				strSql += " 		And		b.DEPT_CODE = e.DEPT_CODE  \n";
				strSql += " 		And		e.CHK_DEPT_CODE Like  ?  || '%' \n";
				strSql += " 		And		e.CHK_DEPT_CODE = F.DEPT_CODE  \n";
				strSql += " 		Group By Grouping Sets \n";
				strSql += " 		( \n";
				strSql += " 			( \n";
				strSql += " 				b.COMP_CODE, \n";
				strSql += " 				F.DEPT_CODE, \n";
				strSql += " 				F.DEPT_NAME, \n";
				strSql += " 				C.BUDG_CODE_NO, \n";
				strSql += " 				C.BUDG_CODE_NAME, \n";
				strSql += " 				C.P_BUDG_CODE_NO, \n";
				strSql += " 				D.BUDG_CODE_NAME, \n";
				strSql += " 				C.RN, \n";
				strSql += " 				D.RN \n";
				strSql += " 			), \n";
				strSql += " 			( \n";
				strSql += " 				b.COMP_CODE, \n";
				strSql += " 				F.DEPT_CODE, \n";
				strSql += " 				F.DEPT_NAME, \n";
				strSql += " 				C.P_BUDG_CODE_NO, \n";
				strSql += " 				D.BUDG_CODE_NAME, \n";
				strSql += " 				D.RN \n";
				strSql += " 			), \n";
				strSql += " 			( \n";
				strSql += " 				b.COMP_CODE, \n";
				strSql += " 				F.DEPT_CODE, \n";
				strSql += " 				F.DEPT_NAME \n";
				strSql += " 			), \n";
				strSql += " 			( \n";
				strSql += " 			) \n";
				strSql += " 		) \n";
				strSql += " 	) a \n";
				strSql += " Order By \n";
				strSql += " 	a.CHK_DEPT_CODE, \n";
				strSql += " 	a.P_RN, \n";
				strSql += " 	a.RN \n";
				strSql += "  ";
				
				lrArgData.addColumn("1CLSE_ACC_ID_B4", CITData.VARCHAR2);
				lrArgData.addColumn("2CLSE_ACC_ID_B4", CITData.VARCHAR2);
				lrArgData.addColumn("3CLSE_ACC_ID_B4", CITData.VARCHAR2);
				lrArgData.addColumn("4CLSE_ACC_ID_B4", CITData.VARCHAR2);
				lrArgData.addColumn("5CLSE_ACC_ID_B4", CITData.VARCHAR2);
				lrArgData.addColumn("6CLSE_ACC_ID_B4", CITData.VARCHAR2);
				lrArgData.addColumn("7CLSE_ACC_ID_B4", CITData.VARCHAR2);
				lrArgData.addColumn("8CLSE_ACC_ID_B4", CITData.VARCHAR2);
				lrArgData.addColumn("9CLSE_ACC_ID_B4", CITData.VARCHAR2);
				lrArgData.addColumn("10CLSE_ACC_ID_B4", CITData.VARCHAR2);
				lrArgData.addColumn("11CLSE_ACC_ID_B4", CITData.VARCHAR2);
				lrArgData.addColumn("12CLSE_ACC_ID_B4", CITData.VARCHAR2);
				lrArgData.addColumn("13CLSE_ACC_ID", CITData.VARCHAR2);
				lrArgData.addColumn("14CLSE_ACC_ID", CITData.VARCHAR2);
				lrArgData.addColumn("15CLSE_ACC_ID", CITData.VARCHAR2);
				lrArgData.addColumn("16CLSE_ACC_ID", CITData.VARCHAR2);
				lrArgData.addColumn("17CLSE_ACC_ID", CITData.VARCHAR2);
				lrArgData.addColumn("18CLSE_ACC_ID", CITData.VARCHAR2);
				lrArgData.addColumn("19CLSE_ACC_ID", CITData.VARCHAR2);
				lrArgData.addColumn("20CLSE_ACC_ID", CITData.VARCHAR2);
				lrArgData.addColumn("21CLSE_ACC_ID", CITData.VARCHAR2);
				lrArgData.addColumn("22CLSE_ACC_ID", CITData.VARCHAR2);
				lrArgData.addColumn("23CLSE_ACC_ID", CITData.VARCHAR2);
				lrArgData.addColumn("24CLSE_ACC_ID", CITData.VARCHAR2);
				lrArgData.addColumn("25COMP_CODE", CITData.VARCHAR2);
				lrArgData.addColumn("26COMP_CODE", CITData.VARCHAR2);
				lrArgData.addColumn("27CLSE_ACC_ID_B4", CITData.VARCHAR2);
				lrArgData.addColumn("28CLSE_ACC_ID", CITData.VARCHAR2);
				lrArgData.addColumn("29COMP_CODE", CITData.VARCHAR2);
				lrArgData.addColumn("30DEPT_CODE", CITData.VARCHAR2);
				lrArgData.addRow();
				lrArgData.setValue("1CLSE_ACC_ID_B4", strCLSE_ACC_ID_B4);
				lrArgData.setValue("2CLSE_ACC_ID_B4", strCLSE_ACC_ID_B4);
				lrArgData.setValue("3CLSE_ACC_ID_B4", strCLSE_ACC_ID_B4);
				lrArgData.setValue("4CLSE_ACC_ID_B4", strCLSE_ACC_ID_B4);
				lrArgData.setValue("5CLSE_ACC_ID_B4", strCLSE_ACC_ID_B4);
				lrArgData.setValue("6CLSE_ACC_ID_B4", strCLSE_ACC_ID_B4);
				lrArgData.setValue("7CLSE_ACC_ID_B4", strCLSE_ACC_ID_B4);
				lrArgData.setValue("8CLSE_ACC_ID_B4", strCLSE_ACC_ID_B4);
				lrArgData.setValue("9CLSE_ACC_ID_B4", strCLSE_ACC_ID_B4);
				lrArgData.setValue("10CLSE_ACC_ID_B4", strCLSE_ACC_ID_B4);
				lrArgData.setValue("11CLSE_ACC_ID_B4", strCLSE_ACC_ID_B4);
				lrArgData.setValue("12CLSE_ACC_ID_B4", strCLSE_ACC_ID_B4);
				lrArgData.setValue("13CLSE_ACC_ID", strCLSE_ACC_ID);
				lrArgData.setValue("14CLSE_ACC_ID", strCLSE_ACC_ID);
				lrArgData.setValue("15CLSE_ACC_ID", strCLSE_ACC_ID);
				lrArgData.setValue("16CLSE_ACC_ID", strCLSE_ACC_ID);
				lrArgData.setValue("17CLSE_ACC_ID", strCLSE_ACC_ID);
				lrArgData.setValue("18CLSE_ACC_ID", strCLSE_ACC_ID);
				lrArgData.setValue("19CLSE_ACC_ID", strCLSE_ACC_ID);
				lrArgData.setValue("20CLSE_ACC_ID", strCLSE_ACC_ID);
				lrArgData.setValue("21CLSE_ACC_ID", strCLSE_ACC_ID);
				lrArgData.setValue("22CLSE_ACC_ID", strCLSE_ACC_ID);
				lrArgData.setValue("23CLSE_ACC_ID", strCLSE_ACC_ID);
				lrArgData.setValue("24CLSE_ACC_ID", strCLSE_ACC_ID);
				lrArgData.setValue("25COMP_CODE", strCOMP_CODE);
				lrArgData.setValue("26COMP_CODE", strCOMP_CODE);
				lrArgData.setValue("27CLSE_ACC_ID_B4", strCLSE_ACC_ID_B4);
				lrArgData.setValue("28CLSE_ACC_ID", strCLSE_ACC_ID);
				lrArgData.setValue("29COMP_CODE", strCOMP_CODE);
				lrArgData.setValue("30DEPT_CODE", strDEPT_CODE);
			}
			else if(strDEPT_FLAG.equals("DEPT"))
			{
				strSql  = " Select \n";
				strSql += " 	a.COMP_CODE, \n";
				strSql += " 	a.BUDG_CODE_NO, \n";
				strSql += " 	a.CHK_DEPT_CODE, \n";
				strSql += " 	a.CHK_DEPT_NAME, \n";
				strSql += " 	a.DEPT_CODE, \n";
				strSql += " 	a.DEPT_NAME, \n";
				strSql += " 	a.BUDG_CODE_NAME acc_name, \n";
				strSql += " 	a.P_BUDG_CODE_NO, \n";
				strSql += " 	a.RN, \n";
				strSql += " 	a.P_RN, \n";
				strSql += " 	a.P_BUDG_CODE_NAME p_acc_name, \n";
				strSql += " 	a.b_cb1, \n";
				strSql += " 	a.b_cb2, \n";
				strSql += " 	a.b_cb3, \n";
				strSql += " 	a.b_cb4, \n";
				strSql += " 	a.b_cb5, \n";
				strSql += " 	a.b_cb6, \n";
				strSql += " 	a.b_cb7, \n";
				strSql += " 	a.b_cb8, \n";
				strSql += " 	a.b_cb9, \n";
				strSql += " 	a.b_cb10, \n";
				strSql += " 	a.b_cb11, \n";
				strSql += " 	a.b_cb12, \n";
				strSql += " 	a.cb1, \n";
				strSql += " 	a.cb2, \n";
				strSql += " 	a.cb3, \n";
				strSql += " 	a.cb4, \n";
				strSql += " 	a.cb5, \n";
				strSql += " 	a.cb6, \n";
				strSql += " 	a.cb7, \n";
				strSql += " 	a.cb8, \n";
				strSql += " 	a.cb9, \n";
				strSql += " 	a.cb10, \n";
				strSql += " 	a.cb11, \n";
				strSql += " 	a.cb12, \n";
				strSql += " 	Nvl(a.cb1,0) 	- Nvl(a.b_cb1,0) 	sub_cb1, \n";
				strSql += " 	Nvl(a.cb2,0) 	- Nvl(a.b_cb2,0) 	sub_cb2, \n";
				strSql += " 	Nvl(a.cb3,0) 	- Nvl(a.b_cb3,0) 	sub_cb3, \n";
				strSql += " 	Nvl(a.cb4,0) 	- Nvl(a.b_cb4,0) 	sub_cb4, \n";
				strSql += " 	Nvl(a.cb5,0) 	- Nvl(a.b_cb5,0) 	sub_cb5, \n";
				strSql += " 	Nvl(a.cb6,0) 	- Nvl(a.b_cb6,0) 	sub_cb6, \n";
				strSql += " 	Nvl(a.cb7,0) 	- Nvl(a.b_cb7,0) 	sub_cb7, \n";
				strSql += " 	Nvl(a.cb8,0) 	- Nvl(a.b_cb8,0) 	sub_cb8, \n";
				strSql += " 	Nvl(a.cb9,0) 	- Nvl(a.b_cb9,0) 	sub_cb9, \n";
				strSql += " 	Nvl(a.cb10,0) 	- Nvl(a.b_cb10,0) 	sub_cb10, \n";
				strSql += " 	Nvl(a.cb11,0) 	- Nvl(a.b_cb11,0) 	sub_cb11, \n";
				strSql += " 	Nvl(a.cb12,0) 	- Nvl(a.b_cb12,0) 	sub_cb12, \n";
				strSql += " 	To_Char(100* Nvl(a.b_cb1,0)   /  NullIf(Nvl(a.cb1,0) ,0),'fm999,999,999,999,999,990.00')	r_cb1, \n";
				strSql += " 	To_Char(100* Nvl(a.b_cb2,0)   /  NullIf(Nvl(a.cb2,0) ,0),'fm999,999,999,999,999,990.00')	r_cb2, \n";
				strSql += " 	To_Char(100* Nvl(a.b_cb3,0)   /  NullIf(Nvl(a.cb3,0) ,0),'fm999,999,999,999,999,990.00')	r_cb3, \n";
				strSql += " 	To_Char(100* Nvl(a.b_cb4,0)   /  NullIf(Nvl(a.cb4,0) ,0),'fm999,999,999,999,999,990.00')	r_cb4, \n";
				strSql += " 	To_Char(100* Nvl(a.b_cb5,0)   /  NullIf(Nvl(a.cb5,0) ,0),'fm999,999,999,999,999,990.00')	r_cb5, \n";
				strSql += " 	To_Char(100* Nvl(a.b_cb6,0)   /  NullIf(Nvl(a.cb6,0) ,0),'fm999,999,999,999,999,990.00')	r_cb6, \n";
				strSql += " 	To_Char(100* Nvl(a.b_cb7,0)   /  NullIf(Nvl(a.cb7,0) ,0),'fm999,999,999,999,999,990.00')	r_cb7, \n";
				strSql += " 	To_Char(100* Nvl(a.b_cb8,0)   /  NullIf(Nvl(a.cb8,0) ,0),'fm999,999,999,999,999,990.00')	r_cb8, \n";
				strSql += " 	To_Char(100* Nvl(a.b_cb9,0)   /  NullIf(Nvl(a.cb9,0) ,0),'fm999,999,999,999,999,990.00')	r_cb9, \n";
				strSql += " 	To_Char(100* Nvl(a.b_cb10,0)  /  NullIf(Nvl(a.cb10,0),0),'fm999,999,999,999,999,990.00') 	r_cb10, \n";
				strSql += " 	To_Char(100* Nvl(a.b_cb11,0)  /  NullIf(Nvl(a.cb11,0),0),'fm999,999,999,999,999,990.00') 	r_cb11, \n";
				strSql += " 	To_Char(100* Nvl(a.b_cb12,0)  /  NullIf(Nvl(a.cb12,0),0),'fm999,999,999,999,999,990.00') 	r_cb12 \n";
				strSql += " From \n";
				strSql += " 	( \n";
				strSql += " 		Select \n";
				strSql += " 			b.COMP_CODE, \n";
				strSql += " 			C.BUDG_CODE_NO, \n";
				strSql += " 			C.BUDG_CODE_NAME, \n";
				strSql += " 			C.P_BUDG_CODE_NO, \n";
				strSql += " 			F.DEPT_CODE CHK_DEPT_CODE, \n";
				strSql += " 			G.DEPT_CODE, \n";
				strSql += " 			C.RN, \n";
				strSql += " 			D.RN P_RN, \n";
				strSql += " 			Case When Grouping(F.DEPT_CODE) = 1 Then '총  계' When Grouping(G.DEPT_CODE) = 1 Then F.DEPT_NAME||' 계' Else f.DEPT_NAME End CHK_DEPT_NAME, \n";
				strSql += " 			Case When Grouping(G.DEPT_CODE) = 1 Then ' ' When Grouping(d.RN) = 1 Then G.DEPT_NAME||' 계' Else g.DEPT_NAME End DEPT_NAME, \n";
				strSql += " 			Case When Grouping(d.RN) = 1 Then ' ' When Grouping(c.RN) = 1 Then d.BUDG_CODE_NAME ||' 계' Else d.BUDG_CODE_NAME End P_BUDG_CODE_NAME, \n";
				strSql += " 			Sum(Case When To_Char(b.MAKE_DT,'YYYY') =  ?  And To_Char(b.MAKE_DT,'MM') = '01' Then nvl(b.DB_AMT,0) + nvl(b.CR_AMT,0) Else 0 End) b_cb1, \n";
				strSql += " 			Sum(Case When To_Char(b.MAKE_DT,'YYYY') =  ?  And To_Char(b.MAKE_DT,'MM') = '02' Then nvl(b.DB_AMT,0) + nvl(b.CR_AMT,0) Else 0 End) b_cb2, \n";
				strSql += " 			Sum(Case When To_Char(b.MAKE_DT,'YYYY') =  ?  And To_Char(b.MAKE_DT,'MM') = '03' Then nvl(b.DB_AMT,0) + nvl(b.CR_AMT,0) Else 0 End) b_cb3, \n";
				strSql += " 			Sum(Case When To_Char(b.MAKE_DT,'YYYY') =  ?  And To_Char(b.MAKE_DT,'MM') = '04' Then nvl(b.DB_AMT,0) + nvl(b.CR_AMT,0) Else 0 End) b_cb4, \n";
				strSql += " 			Sum(Case When To_Char(b.MAKE_DT,'YYYY') =  ?  And To_Char(b.MAKE_DT,'MM') = '05' Then nvl(b.DB_AMT,0) + nvl(b.CR_AMT,0) Else 0 End) b_cb5, \n";
				strSql += " 			Sum(Case When To_Char(b.MAKE_DT,'YYYY') =  ?  And To_Char(b.MAKE_DT,'MM') = '06' Then nvl(b.DB_AMT,0) + nvl(b.CR_AMT,0) Else 0 End) b_cb6, \n";
				strSql += " 			Sum(Case When To_Char(b.MAKE_DT,'YYYY') =  ?  And To_Char(b.MAKE_DT,'MM') = '07' Then nvl(b.DB_AMT,0) + nvl(b.CR_AMT,0) Else 0 End) b_cb7, \n";
				strSql += " 			Sum(Case When To_Char(b.MAKE_DT,'YYYY') =  ?  And To_Char(b.MAKE_DT,'MM') = '08' Then nvl(b.DB_AMT,0) + nvl(b.CR_AMT,0) Else 0 End) b_cb8, \n";
				strSql += " 			Sum(Case When To_Char(b.MAKE_DT,'YYYY') =  ?  And To_Char(b.MAKE_DT,'MM') = '09' Then nvl(b.DB_AMT,0) + nvl(b.CR_AMT,0) Else 0 End) b_cb9, \n";
				strSql += " 			Sum(Case When To_Char(b.MAKE_DT,'YYYY') =  ?  And To_Char(b.MAKE_DT,'MM') = '10' Then nvl(b.DB_AMT,0) + nvl(b.CR_AMT,0) Else 0 End) b_cb10, \n";
				strSql += " 			Sum(Case When To_Char(b.MAKE_DT,'YYYY') =  ?  And To_Char(b.MAKE_DT,'MM') = '11' Then nvl(b.DB_AMT,0) + nvl(b.CR_AMT,0) Else 0 End) b_cb11, \n";
				strSql += " 			Sum(Case When To_Char(b.MAKE_DT,'YYYY') =  ?  And To_Char(b.MAKE_DT,'MM') = '12' Then nvl(b.DB_AMT,0) + nvl(b.CR_AMT,0) Else 0 End) b_cb12, \n";
				strSql += " 			Sum(Case When To_Char(b.MAKE_DT,'YYYY') =  ?  And To_Char(b.MAKE_DT,'MM') = '01' Then nvl(b.DB_AMT,0) + nvl(b.CR_AMT,0) Else 0 End) cb1, \n";
				strSql += " 			Sum(Case When To_Char(b.MAKE_DT,'YYYY') =  ?  And To_Char(b.MAKE_DT,'MM') = '02' Then nvl(b.DB_AMT,0) + nvl(b.CR_AMT,0) Else 0 End) cb2, \n";
				strSql += " 			Sum(Case When To_Char(b.MAKE_DT,'YYYY') =  ?  And To_Char(b.MAKE_DT,'MM') = '03' Then nvl(b.DB_AMT,0) + nvl(b.CR_AMT,0) Else 0 End) cb3, \n";
				strSql += " 			Sum(Case When To_Char(b.MAKE_DT,'YYYY') =  ?  And To_Char(b.MAKE_DT,'MM') = '04' Then nvl(b.DB_AMT,0) + nvl(b.CR_AMT,0) Else 0 End) cb4, \n";
				strSql += " 			Sum(Case When To_Char(b.MAKE_DT,'YYYY') =  ?  And To_Char(b.MAKE_DT,'MM') = '05' Then nvl(b.DB_AMT,0) + nvl(b.CR_AMT,0) Else 0 End) cb5, \n";
				strSql += " 			Sum(Case When To_Char(b.MAKE_DT,'YYYY') =  ?  And To_Char(b.MAKE_DT,'MM') = '06' Then nvl(b.DB_AMT,0) + nvl(b.CR_AMT,0) Else 0 End) cb6, \n";
				strSql += " 			Sum(Case When To_Char(b.MAKE_DT,'YYYY') =  ?  And To_Char(b.MAKE_DT,'MM') = '07' Then nvl(b.DB_AMT,0) + nvl(b.CR_AMT,0) Else 0 End) cb7, \n";
				strSql += " 			Sum(Case When To_Char(b.MAKE_DT,'YYYY') =  ?  And To_Char(b.MAKE_DT,'MM') = '08' Then nvl(b.DB_AMT,0) + nvl(b.CR_AMT,0) Else 0 End) cb8, \n";
				strSql += " 			Sum(Case When To_Char(b.MAKE_DT,'YYYY') =  ?  And To_Char(b.MAKE_DT,'MM') = '09' Then nvl(b.DB_AMT,0) + nvl(b.CR_AMT,0) Else 0 End) cb9, \n";
				strSql += " 			Sum(Case When To_Char(b.MAKE_DT,'YYYY') =  ?  And To_Char(b.MAKE_DT,'MM') = '10' Then nvl(b.DB_AMT,0) + nvl(b.CR_AMT,0) Else 0 End) cb10, \n";
				strSql += " 			Sum(Case When To_Char(b.MAKE_DT,'YYYY') =  ?  And To_Char(b.MAKE_DT,'MM') = '11' Then nvl(b.DB_AMT,0) + nvl(b.CR_AMT,0) Else 0 End) cb11, \n";
				strSql += " 			Sum(Case When To_Char(b.MAKE_DT,'YYYY') =  ?  And To_Char(b.MAKE_DT,'MM') = '12' Then nvl(b.DB_AMT,0) + nvl(b.CR_AMT,0) Else 0 End) cb12 \n";
				strSql += " 		From	T_ACC_SLIP_BODY1 b, \n";
				strSql += " 				( \n";
				strSql += " 					Select  \n";
				strSql += " 						c.BUDG_CODE_NO , \n";
				strSql += " 						c.CRTUSERNO , \n";
				strSql += " 						c.CRTDATE , \n";
				strSql += " 						c.MODUSERNO , \n";
				strSql += " 						c.MODDATE , \n";
				strSql += " 						c.P_BUDG_CODE_NO , \n";
				strSql += " 						c.LEVEL_SEQ , \n";
				strSql += " 						c.LEGACY_BUDG_CODE , \n";
				strSql += " 						c.BUDG_CODE_NAME , \n";
				strSql += " 						c.ACC_CODE , \n";
				strSql += " 						c.USE_CLS , \n";
				strSql += " 						c.CONTROL_LEVEL_TAG , \n";
				strSql += " 						c.BUDG_ITEM_CODE , \n";
				strSql += " 						c.MAKE_DEPT , \n";
				strSql += " 						c.ASSIGN_TAG , \n";
				strSql += " 						c.COMP_CODE, \n";
				strSql += " 						RowNum Rn \n";
				strSql += " 					From T_BUDG_CODE C \n";
				strSql += " 					Start With \n";
				strSql += " 							COMP_CODE =  ?  \n";
				strSql += " 					And		Not Exists \n";
				strSql += " 							( \n";
				strSql += " 								Select \n";
				strSql += " 									Null \n";
				strSql += " 								From	t_budg_code x \n";
				strSql += " 								Where	x.COMP_CODE = c.COMP_CODE \n";
				strSql += " 								And		x.BUDG_CODE_NO = c.P_BUDG_CODE_NO \n";
				strSql += " 							) \n";
				strSql += " 					Connect By \n";
				strSql += " 						Prior	c.BUDG_CODE_NO = c.P_BUDG_CODE_NO \n";
				strSql += " 					Order Siblings By \n";
				strSql += " 						c.LEVEL_SEQ \n";
				strSql += " 				) C, \n";
				strSql += " 				( \n";
				strSql += " 					Select  \n";
				strSql += " 						c.BUDG_CODE_NO , \n";
				strSql += " 						c.CRTUSERNO , \n";
				strSql += " 						c.CRTDATE , \n";
				strSql += " 						c.MODUSERNO , \n";
				strSql += " 						c.MODDATE , \n";
				strSql += " 						c.P_BUDG_CODE_NO , \n";
				strSql += " 						c.LEVEL_SEQ , \n";
				strSql += " 						c.LEGACY_BUDG_CODE , \n";
				strSql += " 						c.BUDG_CODE_NAME , \n";
				strSql += " 						c.ACC_CODE , \n";
				strSql += " 						c.USE_CLS , \n";
				strSql += " 						c.CONTROL_LEVEL_TAG , \n";
				strSql += " 						c.BUDG_ITEM_CODE , \n";
				strSql += " 						c.MAKE_DEPT , \n";
				strSql += " 						c.ASSIGN_TAG , \n";
				strSql += " 						c.COMP_CODE, \n";
				strSql += " 						RowNum Rn \n";
				strSql += " 					From T_BUDG_CODE C \n";
				strSql += " 					Start With \n";
				strSql += " 							COMP_CODE =  ?  \n";
				strSql += " 					And		Not Exists \n";
				strSql += " 							( \n";
				strSql += " 								Select \n";
				strSql += " 									Null \n";
				strSql += " 								From	t_budg_code x \n";
				strSql += " 								Where	x.COMP_CODE = c.COMP_CODE \n";
				strSql += " 								And		x.BUDG_CODE_NO = c.P_BUDG_CODE_NO \n";
				strSql += " 							) \n";
				strSql += " 					Connect By \n";
				strSql += " 						Prior	c.BUDG_CODE_NO = c.P_BUDG_CODE_NO \n";
				strSql += " 					Order Siblings By \n";
				strSql += " 						c.LEVEL_SEQ \n";
				strSql += " 				) D, \n";
				strSql += " 				T_BUDG_DEPT_MAP E, \n";
				strSql += " 				T_DEPT_CODE_ORG F, \n";
				strSql += " 				T_DEPT_CODE_ORG G \n";
				strSql += " 		Where	b.KEEP_DT is not null \n";
				strSql += " 		And		b.TRANSFER_TAG = 'F' \n";
				strSql += " 		And		b.MAKE_DT Between To_Date(  ?  ||'-01-01','YYYY-MM-DD') And To_Date(  ?  ||'-12-31','YYYY-MM-DD') \n";
				strSql += " 		And		b.COMP_CODE =  ?  \n";
				strSql += " 		And		b.ACC_CODE  = c.ACC_CODE \n";
				strSql += " 		And		b.COMP_CODE = c.COMP_CODE \n";
				strSql += " 		And		c.P_BUDG_CODE_NO = d.BUDG_CODE_NO (+) \n";
				strSql += " 		And		b.DEPT_CODE = e.DEPT_CODE  \n";
				strSql += " 		And		b.DEPT_CODE Like  ?  || '%' \n";
				strSql += " 		And		e.CHK_DEPT_CODE = F.DEPT_CODE \n";
				strSql += " 		And		b.DEPT_CODE = g.DEPT_CODE \n";
				strSql += " 		Group By Grouping Sets \n";
				strSql += " 		( \n";
				strSql += " 			( \n";
				strSql += " 				b.COMP_CODE, \n";
				strSql += " 				F.DEPT_CODE, \n";
				strSql += " 				F.DEPT_NAME, \n";
				strSql += " 				G.DEPT_CODE, \n";
				strSql += " 				G.DEPT_NAME, \n";
				strSql += " 				C.BUDG_CODE_NO, \n";
				strSql += " 				C.BUDG_CODE_NAME, \n";
				strSql += " 				C.P_BUDG_CODE_NO, \n";
				strSql += " 				D.BUDG_CODE_NAME, \n";
				strSql += " 				C.RN, \n";
				strSql += " 				D.RN \n";
				strSql += " 			), \n";
				strSql += " 			( \n";
				strSql += " 				b.COMP_CODE, \n";
				strSql += " 				F.DEPT_CODE, \n";
				strSql += " 				F.DEPT_NAME, \n";
				strSql += " 				G.DEPT_CODE, \n";
				strSql += " 				G.DEPT_NAME, \n";
				strSql += " 				C.P_BUDG_CODE_NO, \n";
				strSql += " 				D.BUDG_CODE_NAME, \n";
				strSql += " 				D.RN \n";
				strSql += " 			), \n";
				strSql += " 			( \n";
				strSql += " 				b.COMP_CODE, \n";
				strSql += " 				F.DEPT_CODE, \n";
				strSql += " 				F.DEPT_NAME, \n";
				strSql += " 				G.DEPT_CODE, \n";
				strSql += " 				G.DEPT_NAME \n";
				strSql += " 			), \n";
				strSql += " 			( \n";
				strSql += " 				b.COMP_CODE, \n";
				strSql += " 				F.DEPT_CODE, \n";
				strSql += " 				F.DEPT_NAME \n";
				strSql += " 			), \n";
				strSql += " 			( \n";
				strSql += " 			) \n";
				strSql += " 		) \n";
				strSql += " 	) a \n";
				strSql += " Order By \n";
				strSql += " 	a.CHK_DEPT_CODE, \n";
				strSql += " 	a.DEPT_CODE, \n";
				strSql += " 	a.P_RN, \n";
				strSql += " 	a.RN \n";
				strSql += "  ";
				
				lrArgData.addColumn("1CLSE_ACC_ID_B4", CITData.VARCHAR2);
				lrArgData.addColumn("2CLSE_ACC_ID_B4", CITData.VARCHAR2);
				lrArgData.addColumn("3CLSE_ACC_ID_B4", CITData.VARCHAR2);
				lrArgData.addColumn("4CLSE_ACC_ID_B4", CITData.VARCHAR2);
				lrArgData.addColumn("5CLSE_ACC_ID_B4", CITData.VARCHAR2);
				lrArgData.addColumn("6CLSE_ACC_ID_B4", CITData.VARCHAR2);
				lrArgData.addColumn("7CLSE_ACC_ID_B4", CITData.VARCHAR2);
				lrArgData.addColumn("8CLSE_ACC_ID_B4", CITData.VARCHAR2);
				lrArgData.addColumn("9CLSE_ACC_ID_B4", CITData.VARCHAR2);
				lrArgData.addColumn("10CLSE_ACC_ID_B4", CITData.VARCHAR2);
				lrArgData.addColumn("11CLSE_ACC_ID_B4", CITData.VARCHAR2);
				lrArgData.addColumn("12CLSE_ACC_ID_B4", CITData.VARCHAR2);
				lrArgData.addColumn("13CLSE_ACC_ID", CITData.VARCHAR2);
				lrArgData.addColumn("14CLSE_ACC_ID", CITData.VARCHAR2);
				lrArgData.addColumn("15CLSE_ACC_ID", CITData.VARCHAR2);
				lrArgData.addColumn("16CLSE_ACC_ID", CITData.VARCHAR2);
				lrArgData.addColumn("17CLSE_ACC_ID", CITData.VARCHAR2);
				lrArgData.addColumn("18CLSE_ACC_ID", CITData.VARCHAR2);
				lrArgData.addColumn("19CLSE_ACC_ID", CITData.VARCHAR2);
				lrArgData.addColumn("20CLSE_ACC_ID", CITData.VARCHAR2);
				lrArgData.addColumn("21CLSE_ACC_ID", CITData.VARCHAR2);
				lrArgData.addColumn("22CLSE_ACC_ID", CITData.VARCHAR2);
				lrArgData.addColumn("23CLSE_ACC_ID", CITData.VARCHAR2);
				lrArgData.addColumn("24CLSE_ACC_ID", CITData.VARCHAR2);
				lrArgData.addColumn("25COMP_CODE", CITData.VARCHAR2);
				lrArgData.addColumn("26COMP_CODE", CITData.VARCHAR2);
				lrArgData.addColumn("27CLSE_ACC_ID_B4", CITData.VARCHAR2);
				lrArgData.addColumn("28CLSE_ACC_ID", CITData.VARCHAR2);
				lrArgData.addColumn("29COMP_CODE", CITData.VARCHAR2);
				lrArgData.addColumn("30DEPT_CODE", CITData.VARCHAR2);
				lrArgData.addRow();
				lrArgData.setValue("1CLSE_ACC_ID_B4", strCLSE_ACC_ID_B4);
				lrArgData.setValue("2CLSE_ACC_ID_B4", strCLSE_ACC_ID_B4);
				lrArgData.setValue("3CLSE_ACC_ID_B4", strCLSE_ACC_ID_B4);
				lrArgData.setValue("4CLSE_ACC_ID_B4", strCLSE_ACC_ID_B4);
				lrArgData.setValue("5CLSE_ACC_ID_B4", strCLSE_ACC_ID_B4);
				lrArgData.setValue("6CLSE_ACC_ID_B4", strCLSE_ACC_ID_B4);
				lrArgData.setValue("7CLSE_ACC_ID_B4", strCLSE_ACC_ID_B4);
				lrArgData.setValue("8CLSE_ACC_ID_B4", strCLSE_ACC_ID_B4);
				lrArgData.setValue("9CLSE_ACC_ID_B4", strCLSE_ACC_ID_B4);
				lrArgData.setValue("10CLSE_ACC_ID_B4", strCLSE_ACC_ID_B4);
				lrArgData.setValue("11CLSE_ACC_ID_B4", strCLSE_ACC_ID_B4);
				lrArgData.setValue("12CLSE_ACC_ID_B4", strCLSE_ACC_ID_B4);
				lrArgData.setValue("13CLSE_ACC_ID", strCLSE_ACC_ID);
				lrArgData.setValue("14CLSE_ACC_ID", strCLSE_ACC_ID);
				lrArgData.setValue("15CLSE_ACC_ID", strCLSE_ACC_ID);
				lrArgData.setValue("16CLSE_ACC_ID", strCLSE_ACC_ID);
				lrArgData.setValue("17CLSE_ACC_ID", strCLSE_ACC_ID);
				lrArgData.setValue("18CLSE_ACC_ID", strCLSE_ACC_ID);
				lrArgData.setValue("19CLSE_ACC_ID", strCLSE_ACC_ID);
				lrArgData.setValue("20CLSE_ACC_ID", strCLSE_ACC_ID);
				lrArgData.setValue("21CLSE_ACC_ID", strCLSE_ACC_ID);
				lrArgData.setValue("22CLSE_ACC_ID", strCLSE_ACC_ID);
				lrArgData.setValue("23CLSE_ACC_ID", strCLSE_ACC_ID);
				lrArgData.setValue("24CLSE_ACC_ID", strCLSE_ACC_ID);
				lrArgData.setValue("25COMP_CODE", strCOMP_CODE);
				lrArgData.setValue("26COMP_CODE", strCOMP_CODE);
				lrArgData.setValue("27CLSE_ACC_ID_B4", strCLSE_ACC_ID_B4);
				lrArgData.setValue("28CLSE_ACC_ID", strCLSE_ACC_ID);
				lrArgData.setValue("29COMP_CODE", strCOMP_CODE);
				lrArgData.setValue("30DEPT_CODE", strDEPT_CODE);
			}
			try                                                                       
			{                                                                         
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);



				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo != null)
				{
					GauceInfo.response.writeException("USER", "900001","MAIN Select 오류-> "+ ex.getMessage());
				}
				else
				{
					throw new Exception("USER-900001:MAIN Select 오류 -> " + ex.getMessage());
				}
			}
		}

	}
	catch (Exception ex)
	{
		if (GauceInfo != null)
		{
			GauceInfo.response.writeException("SYS", "100001", "페이지 초기화 오류 -> " + ex.getMessage());
		}
		else
		{
			throw new Exception("SYS-100001:페이지 초기화 오류 -> " + ex.getMessage());
		}
	}
	finally
	{
		try
		{
			CITCommon.finalServerPage(GauceInfo);
		}
		catch (Exception ex)
		{
			if (GauceInfo != null)
			{
				GauceInfo.response.writeException("SYS", "100002", "페이지 종료 오류 -> " + ex.getMessage());
			}
			else
			{
				throw new Exception("SYS-100002:페이지 종료 오류 -> " + ex.getMessage());
			}
		}
	}
%>
