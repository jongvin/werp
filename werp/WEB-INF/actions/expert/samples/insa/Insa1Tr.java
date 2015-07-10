/**
 * Insa1Tr.java : [expert.samples.insa] Created on 2005. 1. 14. ¿ÀÈÄ 1:22:35
 * 
 * Copyright (c) 2000-2004 Shift Information & Communication Co.
 * 3F, Seongsu Venture town, 231-1, Seongsu2-Gam Seongdong-Gu, Seoul, Korea 133-826
 * All rights reserved.
 *
 * This software is the confidential and proprietary information of
 * Shift Information & Communication Co. ("Confidential Information").  You shall not
 * disclose such Confidential Information and shall use it only in
 * accordance with the terms of the license agreement you entered into
 * with Shift Information & Communication.
 */
package expert.samples.insa;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.sql.DataSource;

import com.gauce.GauceDataRow;
import com.gauce.gsaf.ActionChain;
import com.gauce.gsaf.GauceAction;
import com.gauce.gsaf.TxEvent;
import com.gauce.http.HttpGauceRequest;

/**
 * @author sunny
 */
public class Insa1Tr extends GauceAction {
    
    
    public void invoke(HttpGauceRequest request, ActionChain chain)
            throws IOException, ServletException {
        
        Connection con = null;
        try {
            DataSource ds = (DataSource) request.getAttribute("GauceDB$sampledb");
            con = ds.getConnection();
            fireTxEvent(request, con);
        } catch (SQLException sqle) {
            throw new ServletException("Failed to execute transaction", sqle);
        } finally {
            if (con != null) {
                try { con.close(); } catch (Exception e) {}
            }
        }        
        chain.invokeNext(request);        
        
    }
    
    public int insertStand(TxEvent event) throws SQLException {
        GauceDataRow row = event.getDataRow();
        Connection con = (Connection) event.getResource();
        String query = ""+
        " insert into T_HM1000 "+
        "			(ARMY_TYPE, 		BEF_EMP, 		KOR_NM, 		BRANCHE_GB, 	"+
        "			 GRADE_CD, 			ENG_NM, 		ARMS_GB, 		HANJA_NM,       "+
        "			 JUMIN_NO, 			BIRTH_DT, 		ACC_CD, 		DEPT_CD,        "+
        "			 JIKGUP_CD,         JIKCHK_CD, 		ACCEPT_GB, 		TRAIN_ST_DT,    "+
        "			 TRAIN_ED_DT, 		LAST_SCHOOL,    LEVEL_GB, 		PRO_GB,         "+
        "			 IN_DT, 			OUT_STD_DT, 	OUT_DT, 		BON_ADDRESS,    "+
        "	         BORN_AREA_GB, 		CUR_ZIP_NO, 	CUR_ADDRESS, 	PHONE_NO,       "+
        "	         H_PHONE_NO,        IN_PHONE_NO, 	MAIL_ADDRESS, 	PASS_NO,        "+
        "	         PASS_VALID_DT, 	FOREIGN_YN,     PARTNER, 		BUYANG_CNT,     "+
        "	         BANK_OWN1, 		BANK_CD1, 		BANK_RECV1, 	BANK_AMT1,      "+
        "	         JANGAE_CNT, 		OLDMAN_CNT, 	BANK_CD2, 		BANK_ACCNO1,    "+
        "	         BANK_ACCNO2,       HEIGHT, 		BANK_OWN2, 		WEIGHT,         "+
        "	         BANK_RECV2, 		BANK_AMT2, 		BANK_SEQNO,     E_INSURE_YN,    "+
        "	         BLOOD_TYPE, 		CHILD6_CNT, 	PENSION_YN, 	WOMANHD_YN,     "+
        "	         ETCMAN1_CNT, 		PENSION_CD, 	ETCMAN2_CNT, 	AUDIT_ID,       "+
        "	         H_INSURE_CD,       AUDIT_TM, 		H_INSURE_YN, 	H_INSURE_NO,    "+
        "	         PROMOT_DT, 		COMP_GB,        ORDER_CD, 		ORDER_DT,       "+
        "	         LAYOFF_YN, 		LAYOFF_DT, 		PHOTO_URL,      SERVE_STATUS,   "+
        "	         ETC_CD2, 			ADDJOB_DEPTCD, 	ADDJOB_DT, 		STAFF_GB,       "+
        "	         ETC_CD1, 			ADDJOB_JIKCHK, 	ETC_CD3, 		ADDJOB_YN,      "+
        "	         SEX_GB, 			EMP_NO )                                        "+
        " values "+
        "			(?, 				?, 				?, 				?, 				"+
        "			 ?, 				?, 				?, 				?,       		"+
        "			 ?, 				?, 				?, 				?,        		"+
        "			 ?,         		?, 				?, 				?,    			"+
        "			 ?, 				?,    			?, 				?,         		"+
        "			 ?, 				?, 				?, 				?,    			"+
        "	         ?, 				?, 				?, 				?,       		"+
        "	         ?,        			?, 				?, 				?,        		"+
        "	         ?, 				?,     			?, 				?,     			"+
        "	         ?, 				?, 				?, 				?,      		"+
        "	         ?, 				?, 				?, 				?,    			"+
        "	         ?,       			?, 				?, 				?,         		"+
        "	         ?, 				?, 				?,     			?,    			"+
        "	         ?, 				?, 				?, 				?,     			"+
        "	         ?, 				?, 				?, 				?,       		"+
        "	         ?,       			?, 				?, 				?,    			"+
        "	         ?, 				?,        		?, 				?,       		"+
        "	         ?, 				?, 				?,      		?,   			"+
        "	         ?, 				?, 				?, 				?,       		"+
        "	         ?, 				?, 				?, 				?,      		"+
        "	         ?, 				? )";
        PreparedStatement insert = con.prepareStatement(query);  
        try {
            insert.setString(1, row.getString(event.indexOfColumn("ARMY_TYPE")));
            insert.setString(2, row.getString(event.indexOfColumn("BEF_EMP")));
            insert.setString(3, row.getString(event.indexOfColumn("KOR_NM")));
            insert.setString(4, row.getString(event.indexOfColumn("BRANCHE_GB")));            
            insert.setString(5, row.getString(event.indexOfColumn("GRADE_CD")));
            insert.setString(6, row.getString(event.indexOfColumn("ENG_NM")));
            insert.setString(7, row.getString(event.indexOfColumn("ARMS_GB")));
            insert.setString(8, row.getString(event.indexOfColumn("HANJA_NM")));            
            insert.setString(9, row.getString(event.indexOfColumn("JUMIN_NO")));
            insert.setString(10,row.getString(event.indexOfColumn("BIRTH_DT")));
            insert.setString(11,row.getString(event.indexOfColumn("ACC_CD")));
            insert.setString(12,row.getString(event.indexOfColumn("DEPT_CD")));            
            insert.setString(13,row.getString(event.indexOfColumn("JIKGUP_CD")));
            insert.setString(14,row.getString(event.indexOfColumn("JIKCHK_CD")));
            insert.setString(15,row.getString(event.indexOfColumn("ACCEPT_GB")));
            insert.setString(16,row.getString(event.indexOfColumn("TRAIN_ST_DT")));            
            insert.setString(17,row.getString(event.indexOfColumn("TRAIN_ED_DT")));
            insert.setString(18,row.getString(event.indexOfColumn("LAST_SCHOOL")));
            insert.setString(19,row.getString(event.indexOfColumn("LEVEL_GB")));
            insert.setString(20,row.getString(event.indexOfColumn("PRO_GB")));
            insert.setString(21,row.getString(event.indexOfColumn("IN_DT")));
            insert.setString(22,row.getString(event.indexOfColumn("OUT_STD_DT")));
            insert.setString(23,row.getString(event.indexOfColumn("OUT_STD_DT")));
            insert.setString(24,row.getString(event.indexOfColumn("BON_ADDRESS")));            
            insert.setString(25,row.getString(event.indexOfColumn("BORN_AREA_GB")));
            insert.setString(26,row.getString(event.indexOfColumn("CUR_ZIP_NO")));
            insert.setString(27,row.getString(event.indexOfColumn("CUR_ADDRESS")));
            insert.setString(28,row.getString(event.indexOfColumn("PHONE_NO")));
            insert.setString(29,row.getString(event.indexOfColumn("H_PHONE_NO")));
            insert.setString(30,row.getString(event.indexOfColumn("IN_PHONE_NO")));
            insert.setString(31,row.getString(event.indexOfColumn("MAIL_ADDRESS")));
            insert.setString(32,row.getString(event.indexOfColumn("PASS_NO")));
            insert.setString(33,row.getString(event.indexOfColumn("PASS_VALID_DT")));
            insert.setString(34,row.getString(event.indexOfColumn("FOREIGN_YN")));
            insert.setString(35,row.getString(event.indexOfColumn("PARTNER")));
            insert.setString(36,row.getString(event.indexOfColumn("BUYANG_CNT")));
            insert.setString(37,row.getString(event.indexOfColumn("BANK_OWN1")));
            insert.setString(38,row.getString(event.indexOfColumn("BANK_CD1")));
            insert.setString(39,row.getString(event.indexOfColumn("BANK_RECV1")));
            insert.setString(40,row.getString(event.indexOfColumn("BANK_AMT1")));
            insert.setString(41,row.getString(event.indexOfColumn("JANGAE_CNT")));
            insert.setString(42,row.getString(event.indexOfColumn("OLDMAN_CNT")));
            insert.setString(43,row.getString(event.indexOfColumn("BANK_CD2")));
            insert.setString(44,row.getString(event.indexOfColumn("BANK_ACCNO1")));
            insert.setString(45,row.getString(event.indexOfColumn("BANK_ACCNO2")));
            insert.setString(46,row.getString(event.indexOfColumn("HEIGHT")));
            insert.setString(47,row.getString(event.indexOfColumn("BANK_OWN2")));
            insert.setString(48,row.getString(event.indexOfColumn("WEIGHT")));
            insert.setString(49,row.getString(event.indexOfColumn("BANK_RECV2")));
            insert.setString(50,row.getString(event.indexOfColumn("BANK_AMT2")));
            insert.setString(51,row.getString(event.indexOfColumn("BANK_SEQNO")));
            insert.setString(52,row.getString(event.indexOfColumn("E_INSURE_YN")));
            insert.setString(53,row.getString(event.indexOfColumn("BLOOD_TYPE")));
            insert.setString(54,row.getString(event.indexOfColumn("CHILD6_CNT")));
            insert.setString(55,row.getString(event.indexOfColumn("PENSION_YN")));
            insert.setString(56,row.getString(event.indexOfColumn("WOMANHD_YN")));
            insert.setString(57,row.getString(event.indexOfColumn("ETCMAN1_CNT")));
            insert.setString(58,row.getString(event.indexOfColumn("PENSION_CD")));
            insert.setString(59,row.getString(event.indexOfColumn("ETCMAN2_CNT")));
            insert.setString(60,row.getString(event.indexOfColumn("AUDIT_ID")));
            insert.setString(61,row.getString(event.indexOfColumn("H_INSURE_CD")));
            insert.setString(62,row.getString(event.indexOfColumn("AUDIT_TM")));
            insert.setString(63,row.getString(event.indexOfColumn("H_INSURE_YN")));
            insert.setString(64,row.getString(event.indexOfColumn("H_INSURE_NO")));
            insert.setString(65,row.getString(event.indexOfColumn("PROMOT_DT")));
            insert.setString(66,row.getString(event.indexOfColumn("COMP_GB")));
            insert.setString(67,row.getString(event.indexOfColumn("ORDER_CD")));
            insert.setString(68,row.getString(event.indexOfColumn("ORDER_DT")));
            insert.setString(69,row.getString(event.indexOfColumn("LAYOFF_YN")));
            insert.setString(70,row.getString(event.indexOfColumn("LAYOFF_DT")));
            insert.setString(71,row.getString(event.indexOfColumn("PHOTO_URL")));
            insert.setString(72,row.getString(event.indexOfColumn("SERVE_STATUS")));
            insert.setString(73,row.getString(event.indexOfColumn("ETC_CD2")));
            insert.setString(74,row.getString(event.indexOfColumn("ADDJOB_DEPTCD")));
            insert.setString(75,row.getString(event.indexOfColumn("ADDJOB_DT")));
            insert.setString(76,row.getString(event.indexOfColumn("STAFF_GB")));
            insert.setString(77,row.getString(event.indexOfColumn("ETC_CD1")));
            insert.setString(78,row.getString(event.indexOfColumn("ADDJOB_JIKCHK")));
            insert.setString(79,row.getString(event.indexOfColumn("ETC_CD3")));          
            insert.setString(80,row.getString(event.indexOfColumn("ADDJOB_YN")));
            insert.setString(81,row.getString(event.indexOfColumn("SEX_GB")));
            insert.setString(82,row.getString(event.indexOfColumn("EMP_NO"))); 
            return insert.executeUpdate();
        } finally {
            insert.close();
        }
    }
    
    public int updateStand(TxEvent event) throws SQLException {
        GauceDataRow row = event.getDataRow();
        Connection con = (Connection) event.getResource();
        String query = "" +
        " UPDATE T_HM1000 SET "+
        "			 ARMY_TYPE=?, 		BEF_EMP=?, 		KOR_NM=?, 		BRANCHE_GB=?, 	  "+
        "			 GRADE_CD=?, 		ENG_NM=?, 		ARMS_GB=?, 		HANJA_NM=?,       "+
        "			 JUMIN_NO=?, 		BIRTH_DT=?, 	ACC_CD=?, 		DEPT_CD=?,        "+
        "			 JIKGUP_CD=?,       JIKCHK_CD=?, 	ACCEPT_GB=?, 	TRAIN_ST_DT=?,    "+
        "			 TRAIN_ED_DT=?, 	LAST_SCHOOL=?,  LEVEL_GB=?, 	PRO_GB=?,         "+
        "			 IN_DT=?, 			OUT_STD_DT=?, 	OUT_DT=?, 		BON_ADDRESS=?,    "+
        "	         BORN_AREA_GB=?, 	CUR_ZIP_NO=?, 	CUR_ADDRESS=?, 	PHONE_NO=?,       "+
        "	         H_PHONE_NO=?,      IN_PHONE_NO=?, 	MAIL_ADDRESS=?, PASS_NO=?,        "+
        "	         PASS_VALID_DT=?, 	FOREIGN_YN=?,   PARTNER=?, 		BUYANG_CNT=?,     "+
        "	         BANK_OWN1=?, 		BANK_CD1=?, 	BANK_RECV1=?, 	BANK_AMT1=?,      "+
        "	         JANGAE_CNT=?, 		OLDMAN_CNT=?, 	BANK_CD2=?, 	BANK_ACCNO1=?,    "+
        "	         BANK_ACCNO2=?,     HEIGHT=?, 		BANK_OWN2=?, 	WEIGHT=?,         "+
        "	         BANK_RECV2=?, 		BANK_AMT2=?, 	BANK_SEQNO=?,   E_INSURE_YN=?,    "+
        "	         BLOOD_TYPE=?, 		CHILD6_CNT=?, 	PENSION_YN=?, 	WOMANHD_YN=?,     "+
        "	         ETCMAN1_CNT=?, 	PENSION_CD=?, 	ETCMAN2_CNT=?, 	AUDIT_ID=?,       "+
        "	         H_INSURE_CD=?,     AUDIT_TM=?, 	H_INSURE_YN=?, 	H_INSURE_NO=?,    "+
        "	         PROMOT_DT=?, 		COMP_GB=?,      ORDER_CD=?, 	ORDER_DT=?,       "+
        "	         LAYOFF_YN=?, 		LAYOFF_DT=?, 	PHOTO_URL=?,    SERVE_STATUS=?,   "+
        "	         ETC_CD2=?, 		ADDJOB_DEPTCD=?,ADDJOB_DT=?, 	STAFF_GB=?,       "+
        "	         ETC_CD1=?, 		ADDJOB_JIKCHK=?,ETC_CD3=?, 		ADDJOB_YN=?,      "+
        "	         SEX_GB=?					                                          "+
        "   WHERE    EMP_NO = ?";
        PreparedStatement update = con.prepareStatement(query);
        try {
            update.setString(1, row.getString(event.indexOfColumn("ARMY_TYPE")));
            update.setString(2, row.getString(event.indexOfColumn("BEF_EMP")));
            update.setString(3, row.getString(event.indexOfColumn("KOR_NM")));
            update.setString(4, row.getString(event.indexOfColumn("BRANCHE_GB")));            
            update.setString(5, row.getString(event.indexOfColumn("GRADE_CD")));
            update.setString(6, row.getString(event.indexOfColumn("ENG_NM")));
            update.setString(7, row.getString(event.indexOfColumn("ARMS_GB")));
            update.setString(8, row.getString(event.indexOfColumn("HANJA_NM")));            
            update.setString(9, row.getString(event.indexOfColumn("JUMIN_NO")));
            update.setString(10,row.getString(event.indexOfColumn("BIRTH_DT")));
            update.setString(11,row.getString(event.indexOfColumn("ACC_CD")));
            update.setString(12,row.getString(event.indexOfColumn("DEPT_CD")));
            update.setString(13,row.getString(event.indexOfColumn("JIKGUP_CD")));
            update.setString(14,row.getString(event.indexOfColumn("JIKCHK_CD")));
            update.setString(15,row.getString(event.indexOfColumn("ACCEPT_GB")));
            update.setString(16,row.getString(event.indexOfColumn("TRAIN_ST_DT")));            
            update.setString(17,row.getString(event.indexOfColumn("TRAIN_ED_DT")));
            update.setString(18,row.getString(event.indexOfColumn("LAST_SCHOOL")));
            update.setString(19,row.getString(event.indexOfColumn("LEVEL_GB")));
            update.setString(20,row.getString(event.indexOfColumn("PRO_GB")));            
            update.setString(21,row.getString(event.indexOfColumn("IN_DT")));
            update.setString(22,row.getString(event.indexOfColumn("OUT_STD_DT")));
            update.setString(23,row.getString(event.indexOfColumn("OUT_DT")));
            update.setString(24,row.getString(event.indexOfColumn("BON_ADDRESS")));            
            update.setString(25,row.getString(event.indexOfColumn("BORN_AREA_GB")));
            update.setString(26,row.getString(event.indexOfColumn("CUR_ZIP_NO")));
            update.setString(27,row.getString(event.indexOfColumn("CUR_ADDRESS")));
            update.setString(28,row.getString(event.indexOfColumn("PHONE_NO")));            
            update.setString(29,row.getString(event.indexOfColumn("H_PHONE_NO")));
            update.setString(30,row.getString(event.indexOfColumn("IN_PHONE_NO")));
            update.setString(31,row.getString(event.indexOfColumn("MAIL_ADDRESS")));
            update.setString(32,row.getString(event.indexOfColumn("PASS_NO")));
            update.setString(33,row.getString(event.indexOfColumn("PASS_VALID_DT")));
            update.setString(34,row.getString(event.indexOfColumn("FOREIGN_YN")));
            update.setString(35,row.getString(event.indexOfColumn("PARTNER")));
            update.setString(36,row.getString(event.indexOfColumn("BUYANG_CNT")));
            update.setString(37,row.getString(event.indexOfColumn("BANK_OWN1")));
            update.setString(38,row.getString(event.indexOfColumn("BANK_CD1")));
            update.setString(39,row.getString(event.indexOfColumn("BANK_RECV1")));
            update.setString(40,row.getString(event.indexOfColumn("BANK_AMT1")));
            update.setString(41,row.getString(event.indexOfColumn("JANGAE_CNT")));
            update.setString(42,row.getString(event.indexOfColumn("OLDMAN_CNT")));
            update.setString(43,row.getString(event.indexOfColumn("BANK_CD2")));
            update.setString(44,row.getString(event.indexOfColumn("BANK_ACCNO1")));
            update.setString(45,row.getString(event.indexOfColumn("BANK_ACCNO2")));
            update.setString(46,row.getString(event.indexOfColumn("HEIGHT")));
            update.setString(47,row.getString(event.indexOfColumn("BANK_OWN2")));
            update.setString(48,row.getString(event.indexOfColumn("WEIGHT")));
            update.setString(49,row.getString(event.indexOfColumn("BANK_RECV2")));
            update.setString(50,row.getString(event.indexOfColumn("BANK_AMT2")));
            update.setString(51,row.getString(event.indexOfColumn("BANK_SEQNO")));
            update.setString(52,row.getString(event.indexOfColumn("E_INSURE_YN")));
            update.setString(53,row.getString(event.indexOfColumn("BLOOD_TYPE")));
            update.setString(54,row.getString(event.indexOfColumn("CHILD6_CNT")));
            update.setString(55,row.getString(event.indexOfColumn("PENSION_YN")));
            update.setString(56,row.getString(event.indexOfColumn("WOMANHD_YN")));
            update.setString(57,row.getString(event.indexOfColumn("ETCMAN1_CNT")));
            update.setString(58,row.getString(event.indexOfColumn("PENSION_CD")));
            update.setString(59,row.getString(event.indexOfColumn("ETCMAN2_CNT")));
            update.setString(60,row.getString(event.indexOfColumn("AUDIT_ID")));
            update.setString(61,row.getString(event.indexOfColumn("H_INSURE_CD")));
            update.setString(62,row.getString(event.indexOfColumn("AUDIT_TM")));
            update.setString(63,row.getString(event.indexOfColumn("H_INSURE_YN")));
            update.setString(64,row.getString(event.indexOfColumn("H_INSURE_NO")));
            update.setString(65,row.getString(event.indexOfColumn("PROMOT_DT")));
            update.setString(66,row.getString(event.indexOfColumn("COMP_GB")));
            update.setString(67,row.getString(event.indexOfColumn("ORDER_CD")));
            update.setString(68,row.getString(event.indexOfColumn("ORDER_DT")));          
            update.setString(69,row.getString(event.indexOfColumn("LAYOFF_YN")));
            update.setString(70,row.getString(event.indexOfColumn("LAYOFF_DT")));
            update.setString(71,row.getString(event.indexOfColumn("PHOTO_URL")));
            update.setString(72,row.getString(event.indexOfColumn("SERVE_STATUS")));
            update.setString(73,row.getString(event.indexOfColumn("ETC_CD2")));
            update.setString(74,row.getString(event.indexOfColumn("ADDJOB_DEPTCD")));
            update.setString(75,row.getString(event.indexOfColumn("ADDJOB_DT")));
            update.setString(76,row.getString(event.indexOfColumn("STAFF_GB")));            
            update.setString(77,row.getString(event.indexOfColumn("ETC_CD1")));
            update.setString(78,row.getString(event.indexOfColumn("ADDJOB_JIKCHK")));
            update.setString(79,row.getString(event.indexOfColumn("ETC_CD3")));          
            update.setString(80,row.getString(event.indexOfColumn("ADDJOB_YN")));            
            update.setString(81,row.getString(event.indexOfColumn("SEX_GB")));
            update.setString(82,row.getString(event.indexOfColumn("EMP_NO")));     
            return update.executeUpdate();
        } finally {
            update.close();
        }
    }
    
    public int deleteStand(TxEvent event) throws SQLException {
        GauceDataRow row = event.getDataRow();
        Connection con = (Connection) event.getResource();
        String query = " DELETE FROM T_HM1000 WHERE EMP_NO = ? ";
        PreparedStatement delete = con.prepareStatement(query);
        try {
            delete.setString(1,row.getString(event.indexOfColumn("EMP_NO")));  
            return delete.executeUpdate();    
        } finally {
            delete.close();
        }
    }
    
    public int insertFamily(TxEvent event) throws SQLException {
        GauceDataRow row = event.getDataRow();
        Connection con = (Connection) event.getResource();
        String query = ""+
	   	" insert into T_HM1100 "+
       	"			(  	SEQ, 		RELATION, 			NAME, 			JUMIN_NO, 		"+
       	"				JOB, 		PARTNER_YN, 		BUYANG_YN,      AUDIT_ID, 	    "+
       	"				OLDMAN_YN,  AUDIT_TM, 			JANGAE_YN, 		ADDRESS, 		"+	
       	"				EMP_NO,     CHILD6_YN )                                         "+
        " values "+
			"			(?, 				?, 				?, 				?, 				"+
		"			 ?, 				?, 				?, 				?,       		"+
		"			 ?, 				?, 				?, 				?,        		"+
		"	         ?, 				? )                                         	";
        PreparedStatement insert = con.prepareStatement(query);  
        try {
            insert.setDouble(1, row.getDouble(event.indexOfColumn("SEQ")));
            insert.setString(2, row.getString(event.indexOfColumn("RELATION")));
            insert.setString(3, row.getString(event.indexOfColumn("NAME")));
            insert.setString(4, row.getString(event.indexOfColumn("JUMIN_NO")));
            insert.setString(5, row.getString(event.indexOfColumn("JOB")));
            insert.setString(6, row.getString(event.indexOfColumn("PARTNER_YN")));
            insert.setString(7, row.getString(event.indexOfColumn("BUYANG_YN")));
            insert.setString(8, row.getString(event.indexOfColumn("AUDIT_ID")));
            insert.setString(9, row.getString(event.indexOfColumn("OLDMAN_YN")));
            insert.setString(10,row.getString(event.indexOfColumn("AUDIT_TM")));
            insert.setString(11,row.getString(event.indexOfColumn("JANGAE_YN")));
            insert.setString(12,row.getString(event.indexOfColumn("ADDRESS")));
            insert.setString(13,row.getString(event.indexOfColumn("EMP_NO")));
            insert.setDouble(14,row.getDouble(event.indexOfColumn("CHILD6_YN")));
            return insert.executeUpdate();
        } finally {
            insert.close();
        }
    }
    
    public int updateFamily(TxEvent event) throws SQLException {
        GauceDataRow row = event.getDataRow();
        Connection con = (Connection) event.getResource();
        String query = "" +
	    " UPDATE T_HM1100 SET "+
       	"			  				    RELATION=?, 	NAME=?, 		JUMIN_NO=?, 	"+
       	"				JOB=?, 			PARTNER_YN=?, 	BUYANG_YN=?,   	AUDIT_ID=?, 	"+
       	"				OLDMAN_YN=?, 	AUDIT_TM=?, 	JANGAE_YN=?, 	ADDRESS=?, 		"+	
       	"				     			CHILD6_YN=?                                     "+
		"   WHERE    EMP_NO = ?	AND SEQ=?												";
        PreparedStatement update = con.prepareStatement(query);
        try {
        	update.setString(1, row.getString(event.indexOfColumn("RELATION")));
            update.setString(2, row.getString(event.indexOfColumn("NAME")));
            update.setString(3, row.getString(event.indexOfColumn("JUMIN_NO")));
            update.setString(4, row.getString(event.indexOfColumn("JOB")));
            update.setString(5, row.getString(event.indexOfColumn("PARTNER_YN")));
            update.setString(6, row.getString(event.indexOfColumn("BUYANG_YN")));
            update.setString(7, row.getString(event.indexOfColumn("AUDIT_ID")));
            update.setString(8, row.getString(event.indexOfColumn("OLDMAN_YN")));
            update.setString(9, row.getString(event.indexOfColumn("AUDIT_TM")));
            update.setString(10,row.getString(event.indexOfColumn("JANGAE_YN")));
            update.setString(11,row.getString(event.indexOfColumn("ADDRESS")));
            update.setString(12,row.getString(event.indexOfColumn("CHILD6_YN")));
            update.setString(13,row.getString(event.indexOfColumn("EMP_NO")));
            update.setString(14,row.getString(event.indexOfColumn("SEQ")));     
            return update.executeUpdate();
        } finally {
            update.close();
        }
    }
    
    public int deleteFamily(TxEvent event) throws SQLException {
        GauceDataRow row = event.getDataRow();
        Connection con = (Connection) event.getResource();
        String query = "" +
		   " DELETE FROM T_HM1100 WHERE EMP_NO = ? AND SEQ=? ";
        PreparedStatement delete = con.prepareStatement(query);
        try {
        	delete.setString(1,row.getString(event.indexOfColumn("EMP_NO")));
        	delete.setString(2,row.getString(event.indexOfColumn("SEQ")));        
            return delete.executeUpdate();    
        } finally {
            delete.close();
        }
    }
    
    public int insertCareer(TxEvent event) throws SQLException {
        GauceDataRow row = event.getDataRow();
        Connection con = (Connection) event.getResource();
        String query = ""+
	   	" insert into T_HM1200 "+
       	"			 ( 	SEQ, 			IN_DT, 			OUT_DT, 		COMPANY_NM, 	"+
       	"				JIKCHK_NM, 		JOB, 			OUT_CAUSE,      CAREER_YEAR, 	"+
       	"				CAREER_MONTH,  	AUDIT_ID, 		AUDIT_TM, 		EMP_NO 	)		"+	
        " values "+
			"			(?, 				?, 				?, 				?, 				"+
		"			 ?, 				?, 				?, 				?,       		"+
		"			 ?, 				?, 				?, 				?       ) 		";
        PreparedStatement insert = con.prepareStatement(query);  
        try {
            insert.setString(1, row.getString(event.indexOfColumn("SEQ")));
            insert.setString(2, row.getString(event.indexOfColumn("IN_DT")));
            insert.setString(3, row.getString(event.indexOfColumn("OUT_DT")));
            insert.setString(4, row.getString(event.indexOfColumn("COMPANY_NM")));
            insert.setString(5, row.getString(event.indexOfColumn("JIKCHK_NM")));
            insert.setString(6, row.getString(event.indexOfColumn("JOB")));
            insert.setString(7, row.getString(event.indexOfColumn("OUT_CAUSE")));
            insert.setString(8, row.getString(event.indexOfColumn("CAREER_YEAR")));
            insert.setString(9, row.getString(event.indexOfColumn("CAREER_MONTH")));
            insert.setString(10,row.getString(event.indexOfColumn("AUDIT_ID")));
            insert.setString(11,row.getString(event.indexOfColumn("AUDIT_TM")));
            insert.setString(12,row.getString(event.indexOfColumn("EMP_NO")));
            return insert.executeUpdate();
        } finally {
            insert.close();
        }
    }
    
    public int updateCareer(TxEvent event) throws SQLException {
        GauceDataRow row = event.getDataRow();
        Connection con = (Connection) event.getResource();
        String query = "" +
	    " UPDATE T_HM1200 SET "+
       	"			  	 			    	IN_DT=?, 		OUT_DT=?, 		COMPANY_NM=?, 	"+
       	"				JIKCHK_NM=?, 		JOB=?, 			OUT_CAUSE=?,    CAREER_YEAR=?, 	"+
       	"				CAREER_MONTH=?,  	AUDIT_ID=?, 	AUDIT_TM=?     			"+	
		"   WHERE    EMP_NO = ?	AND SEQ=?												";
        PreparedStatement update = con.prepareStatement(query);
        try {
        	update.setString(1, row.getString(event.indexOfColumn("IN_DT")));
            update.setString(2, row.getString(event.indexOfColumn("OUT_DT")));
            update.setString(3, row.getString(event.indexOfColumn("COMPANY_NM")));
            update.setString(4, row.getString(event.indexOfColumn("JIKCHK_NM")));
            update.setString(5, row.getString(event.indexOfColumn("JOB")));
            update.setString(6, row.getString(event.indexOfColumn("OUT_CAUSE")));
            update.setString(7, row.getString(event.indexOfColumn("CAREER_YEAR")));
            update.setString(8, row.getString(event.indexOfColumn("CAREER_MONTH")));
            update.setString(9, row.getString(event.indexOfColumn("AUDIT_ID")));
            update.setString(10,row.getString(event.indexOfColumn("AUDIT_TM")));
            update.setString(11,row.getString(event.indexOfColumn("EMP_NO")));
            update.setDouble(12,row.getDouble(event.indexOfColumn("SEQ")));     
            return update.executeUpdate();
        } finally {
            update.close();
        }
    }
    
    public int deleteCareer(TxEvent event) throws SQLException {
        GauceDataRow row = event.getDataRow();
        Connection con = (Connection) event.getResource();
        String query = "" +
        " DELETE FROM T_HM1200 WHERE EMP_NO = ? AND SEQ=? ";
        PreparedStatement delete = con.prepareStatement(query);
        try {
            delete.setString(1,row.getString(event.indexOfColumn("EMP_NO")));
            delete.setString(2,row.getString(event.indexOfColumn("SEQ")));     
            return delete.executeUpdate();    
        } finally {
            delete.close();
        }
    }
    
}
