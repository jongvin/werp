package gauce.samples.tr;

import java.io.IOException;
import java.io.FileInputStream;

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
public class SimpleTR extends GauceAction {
    
    public void init(ActionConfig config) throws ServletException {
        super.init(config);
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
    
    public int insertUser(TxEvent event) {
        System.out.println("insert...");
        GauceDataRow row = event.getDataRow();
        for (int i = 0; i < row.size(); i++) {
            if (i != 0) System.out.print(", ");
            System.out.print(row.getColumnValue(i));
        }
        System.out.println();
        return 0;
    }
    
    public int updateUser(TxEvent event) {
        System.out.println("update...");
        GauceDataRow row = event.getDataRow();
        for (int i = 0; i < row.size(); i++) {
            if (i != 0) System.out.print(", ");
            System.out.print(row.getColumnValue(i));
        }
        System.out.println();
        return 0;
    }
    
    public int deleteUser(TxEvent event) {
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
        System.out.println("SimpleTR is being destroyed.");
    }

}
