package gauce.samples.blob;

import java.io.IOException;
import java.io.InputStream;
import java.io.FileOutputStream;
import java.io.FileInputStream;
import java.io.File;

import java.util.HashMap;
import java.util.Map;
import java.util.List;
import java.util.ArrayList;

import javax.servlet.ServletException;

import com.gauce.GauceDataRow;
import com.gauce.common.CommonUtil;
import com.gauce.http.HttpGauceRequest;
import com.gauce.gsaf.GauceAction;
import com.gauce.gsaf.ActionChain;
import com.gauce.gsaf.ActionConfig;
import com.gauce.gsaf.TxEvent;

/**
 * @author Administrator
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class BlobTR extends GauceAction {
    private String path;
    
    public void init(ActionConfig config) throws ServletException {
        super.init(config);
        path = config.getServletContext().getRealPath("gauce40/blob");
    }
    /* (non-Javadoc)
     * @see com.gauce.gsaf.Action#invoke(com.gauce.http.HttpGauceRequest, com.gauce.gsaf.ActionChain)
     */
    public void invoke(HttpGauceRequest request, ActionChain chain)
            throws IOException, ServletException {
        fireTxEvent(request, null);
        request.setAttribute("ResultMessage", "success");
        chain.invokeNext(request);
    }
    
    public int insertBlob(TxEvent event) throws IOException {
        System.out.println("insert...");
        // Column name:[data_name/data_url_type/data_url_size/data_url]
        GauceDataRow row = event.getDataRow();
        String name = row.getString(0); // "data_name"
        System.out.println("image name : " + name);
        InputStream is = (InputStream) row.getInputStream(3); // "data_url"
        FileOutputStream os = new FileOutputStream(path + File.separatorChar + name);
        CommonUtil.copy(is, os);
        is.close();
        os.close();
        return 0;
    }
    
    public int updateBlob(TxEvent event) {
        System.out.println("update...");
        GauceDataRow row = event.getDataRow();
        for (int i = 0; i < row.size(); i++) {
            if (i != 0) System.out.print(", ");
            System.out.print(row.getColumnValue(i));
        }
        System.out.println();
        return 0;
    }
    
    public int deleteBlob(TxEvent event) {
        System.out.println("delete...");
        GauceDataRow row = event.getDataRow();
        for (int i = 0; i < row.size(); i++) {
            if (i != 0) System.out.print(", ");
            System.out.print(row.getColumnValue(i));
        }
        System.out.println();
        return 0;
    } 

    public void destroy() {
        System.out.println("BlobTR is being destroyed.");
    }

}
