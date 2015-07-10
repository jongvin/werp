<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Select Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 김흥수 작성(2006-04-04)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
 
	CITGauceInfo GauceInfo = null;
	
	CITData lrReturnData = null;
	GauceDataSet lrDataset = null;

	String	strSql = "";
	String	strAct = "";
	
	try
	{
		GauceInfo = CITCommon.initServerPage(request, response, session);
		
		CITData lrArgData = new CITData();
		
		strAct = CITCommon.toKOR(request.getParameter("ACT"));
		
		if (strAct.equals("MAIN"))
		{
			String strCompCode   		= CITCommon.toKOR(request.getParameter("CompCode"));
			String strYEARMONTH    	= CITCommon.toKOR(request.getParameter("ADJUSTYEARMONTH"));
			String strCARDNUMBER   	= CITCommon.toKOR(request.getParameter("CARDNUMBER"));

strSql  = "select a.CARDNUMBER,																									\n";
strSql += "      a.ADJUSTYEARMONTH,                                            	\n";
strSql += "      f.NAME EMPNAME,                                               	\n";
strSql += "      e.AccNo ,                                                     	\n";
strSql += "      e.Bank_Main_Code,                                             	\n";
strSql += "      g.Bank_Main_Name,                                             	\n";
strSql +=	"		 max(b.Slip_id) Slip_id,                                        	\n";
strSql +=	"		 max(c.MAKE_SLIPNO)  Slip ,                                     	\n";
strSql +=	"		 max(TO_CHAR(c.MAKE_DT ,'YYYYMMDD')) MAKE_DT ,                  	\n";
strSql +=	"		 max(c.MAKE_SEQ) MAKE_SEQ,                                      	\n";
strSql +=	"		 max(c.SLIP_KIND_TAG) SLIP_KIND_TAG,                            	\n";
strSql +=	"		 max(TO_CHAR(c.MAKE_DT ,'YYYY-MM-DD')) ADJUSTFinishDateTime ,   	\n";
strSql +=	"		 SUM(b.SUPPLYAMT + NVL(b.VATAMT,0)) TOTALSUM,                   	\n";
strSql +=	"		 SUM(DECODE(b.USAGEGUBUN ,'C', b.SUPPLYAMT + NVL(b.VATAMT,0),0)) COMPANYSUM,	\n";
strSql +=	"		 SUM(DECODE(b.USAGEGUBUN ,'P', b.SUPPLYAMT + NVL(b.VATAMT,0),0)) +          	\n";
strSql +=	"		 SUM(DECODE(b.USAGEGUBUN ,'1', b.SUPPLYAMT + NVL(b.VATAMT,0),0)) PERSONSUM  	\n";
strSql +="from T_CARD_ACCOUNTING_MASTER a ,                                                	\n";
strSql +="		 T_CARD_ACCOUNTING_DETAIL b	,                                                 \n";
strSql +="		 T_ACC_SLIP_HEAD          c ,                                                 \n";
strSql +="		 T_CARD_MEMBER_HISTORY    e ,                                                 \n";
strSql +="		 Z_AUTHORITY_USER         f ,                                                 \n";
strSql +="		 T_BANK_MAIN              g                                                   \n";
strSql +="where a.CARDNUMBER      = b.CARDNUMBER                                           	\n";
strSql +="and   a.ADJUSTYEARMONTH = b.ADJUSTYEARMONTH                                      	\n";
strSql +="and  	b.Slip_id  	      = c.Slip_id(+)                                         		\n";
strSql +="and   a.CARDNUMBER      = e.CARDNUMBER                                           	\n";
strSql +="and   e.CARDOWNEREMPNO  = f.EMPNO                                                	\n";
strSql +="and   e.Bank_Main_Code  = g.Bank_Main_Code                                       	\n";
strSql +="And		a.Comp_Code       =  ?                                                    	\n";
strSql +="And		a.ADJUSTYEARMONTH =  ?                                                    	\n";
if(!"".equals(strCARDNUMBER))  strSql +="And   Replace(a.CARDNUMBER,'-','') = Replace( ? ,'-','') 				\n";
strSql +="group by a.CARDNUMBER ,a.ADJUSTYEARMONTH,f.NAME ,e.AccNo ,e.Bank_Main_Code ,g.Bank_Main_Name    \n";

			lrArgData.addColumn("1CompCode", CITData.VARCHAR2);
			lrArgData.addColumn("2YEARMONTH", CITData.VARCHAR2);
			if(!"".equals(strCARDNUMBER)) lrArgData.addColumn("3CARDNUMBER", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("1CompCode", strCompCode);
			lrArgData.setValue("2YEARMONTH", strYEARMONTH);
			if(!"".equals(strCARDNUMBER)) lrArgData.setValue("3CARDNUMBER", strCARDNUMBER);
			
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("CARDNUMBER", true);
				lrReturnData.setKey("ADJUSTYEARMONTH", true);
				
				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001","MAIN Select 오류-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("COPY"))
		{
			strSql  = " Select \n";
			strSql += " 	'XXXXXXXXXXXXXXXX' CARDNUMBER, \n";
			strSql += " 	'XXXXXX' ADJUSTYEARMONTH \n";
			strSql += " From	DUAL \n";

			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001","COPY Select 오류-> "+ ex.getMessage());
			}
		}		
	}
	catch (Exception ex)
	{
		if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
		GauceInfo.response.writeException("SYS", "100001", "페이지 초기화 오류 -> " + ex.getMessage());
	}
	finally
	{
		try
		{
			CITCommon.finalServerPage(GauceInfo);
		}
		catch (Exception ex)
		{
			if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
			GauceInfo.response.writeException("SYS", "100002", "페이지 종료 오류 -> " + ex.getMessage());
		}
	}
%>