<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
     String arg_check = req.getParameter("arg_check");
     
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("company",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("empno",GauceDataColumn.TB_STRING,50));
	 dSet.addDataColumn(new GauceDataColumn("hname",GauceDataColumn.TB_STRING,50));
	 dSet.addDataColumn(new GauceDataColumn("dept",GauceDataColumn.TB_STRING,50));
	 dSet.addDataColumn(new GauceDataColumn("deptnm",GauceDataColumn.TB_STRING,50));
	 dSet.addDataColumn(new GauceDataColumn("stsgbn",GauceDataColumn.TB_STRING,50));
	 dSet.addDataColumn(new GauceDataColumn("coentdt",GauceDataColumn.TB_STRING,50));
	 dSet.addDataColumn(new GauceDataColumn("retdt",GauceDataColumn.TB_STRING,50));
	 dSet.addDataColumn(new GauceDataColumn("lic_cd",GauceDataColumn.TB_STRING,50));
	 dSet.addDataColumn(new GauceDataColumn("lic_cdnm",GauceDataColumn.TB_STRING,50));
	 dSet.addDataColumn(new GauceDataColumn("lic_grd",GauceDataColumn.TB_STRING,50));
	 dSet.addDataColumn(new GauceDataColumn("lic_grdnm",GauceDataColumn.TB_STRING,50));
	 dSet.addDataColumn(new GauceDataColumn("ymdfr",GauceDataColumn.TB_STRING,50));
	 dSet.addDataColumn(new GauceDataColumn("ymdto",GauceDataColumn.TB_STRING,50));
	 dSet.addDataColumn(new GauceDataColumn("pay_yn",GauceDataColumn.TB_STRING,50));
	 dSet.addDataColumn(new GauceDataColumn("licorg",GauceDataColumn.TB_STRING,50));
	 dSet.addDataColumn(new GauceDataColumn("logymd",GauceDataColumn.TB_STRING,50));
	 dSet.addDataColumn(new GauceDataColumn("logno",GauceDataColumn.TB_STRING,50));
	 dSet.addDataColumn(new GauceDataColumn("std_yn",GauceDataColumn.TB_STRING,50));
	 dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,50));
	 dSet.addDataColumn(new GauceDataColumn("wrkymd",GauceDataColumn.TB_STRING,50));
	 dSet.addDataColumn(new GauceDataColumn("wrkemp",GauceDataColumn.TB_STRING,50));
	 dSet.addDataColumn(new GauceDataColumn("pre_person",GauceDataColumn.TB_STRING,50));
	 dSet.addDataColumn(new GauceDataColumn("remark1",GauceDataColumn.TB_STRING,50));
     
    String query ="  select a.company, a.empno, 		/*�����ȣ*/"   +
" 	         b.hname, 		/*�ѱۼ���*/"   +
" 			 b.dept,	 		/*�μ��ڵ�*/"   +
" 			 b.deptnm,		/*�μ���*/"   +
" 			 b.stsgbn, 		/*��������*/"   +
" 			 b.coentdt, 		/*����Ի���*/"   +
"         b.retdt,           /*��������*/"   +
" 			 a.lic_cd,		/*�ڰ����ڵ�*/"   +
" 			 a.lic_cdnm,	/*�ڰ�����*/"   +
" 			 a.lic_grd,     /*�ڰ��������	��*/"   +
" 			 a.lic_grdnm,	/*�ڰ�����޸�*/"   +
" 			 a.ymdfr,		/*�������*/"   +
" 			 a.ymdto,		/*��������*/"   +
" 			 decode(a.pay_yn,'Y','T','F') pay_yn,		/*�������޿���*/"   +
" 			 a.licorg,		/*����ó*/"   +
" 			 a.logymd,		/*�������*/"   +
" 			 a.logno,		/*��Ϲ�ȣ*/"   +
" 			 a.std_yn,		/*���뿩��*/"   +
" 			 a.remark,		/*���*/"   +
" 			 a.wrkymd,		/*�ý��۵������*/"   +
" 			 a.wrkemp, 		/*�ý��۵�ϻ��*/"   +
"         c.pre_person, " +
"         c.remark remark1 " +
" 	from PLIC001VV@CJHRM a,"   +
" 		     PMAS001VV@CJHRM b,"   +
"          R_LICENSE_INFO_CJ_DETAIL c " +
"  where A.company = B.company(+)"   +
"     and A.empno   = B.empno(+)" +
"     and A.company = c.company " +
"     and A.empno = c.empno " +
"     and A.lic_cd = c.lic_cd " +
"     and A.lic_grd = c.lic_grd " +
"		and B.stsgbn like '%" + arg_check + "%' " +
"ORDER BY A.EMPNO";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>