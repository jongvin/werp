/**
 * ImageUpload.java : [expert.samples.insa] Created on 2005. 1. 14. 오후 4:9:35
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

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.sql.DataSource;

import com.gauce.GauceDataRow;
import com.gauce.common.CommonUtil;
import com.gauce.gsaf.ActionChain;
import com.gauce.gsaf.ActionConfig;
import com.gauce.gsaf.GauceAction;
import com.gauce.gsaf.TxEvent;
import com.gauce.http.HttpGauceRequest;

/**
 * @author sunny
 */
public class ImageUpload extends GauceAction {
    
    private String path;
    private String empno;

    public void init(ActionConfig config) throws ServletException {
        super.init(config);
        path = config.getServletContext().getRealPath("sample40/insa/img/");
    }
    
    public void invoke(HttpGauceRequest request, ActionChain chain)
            throws IOException, ServletException {

        empno = request.getParameter("empno");
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
    
    public int insertInput1(TxEvent event) throws SQLException, IOException {
        System.out.println("insertInput1 ");
        GauceDataRow row = event.getDataRow();
        String img = row.getString(0);
        FileInputStream fis = new FileInputStream(img);
        File f = new File(img);        
        if(f.getName() != null) {            
            FileOutputStream os = new FileOutputStream(path + File.separator + empno + ".jpg");
            CommonUtil.copy(fis, os);
            fis.close();
            os.close();
        }
        
        //이미 파일이 올라간것이 있으므로 update문을 수행
        Connection con = (Connection) event.getResource();
        String query = " UPDATE T_HM1000 SET PHOTO_URL=? WHERE EMP_NO = ?";
        PreparedStatement update = con.prepareStatement(query);
        try {
            update.setString(1, "http://localhost:8080/sample40/insa/img/" + empno + ".jpg");
            update.setString(2, empno);
            return update.executeUpdate();
        } finally {
            update.close();
        }
    }
    
    public int deleteInput1(TxEvent event) throws SQLException {
        return 0;
    }
}
