using System;
using CoreSavingLibrary;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Xml.Linq;
using System.Data.OracleClient;
using Sybase.DataWindow;

namespace Saving.Applications.account
{
    public partial class w_sheet_cm_constant_config : PageWebSheet, WebSheet 
    {
        protected String postDeleteRow;
        protected String postAddRow;

        //==================================
        private void JspostAddRow()
        {
            Dw_data.InsertRow(0);  
            decimal row = Dw_data.RowCount;
            if (row > 0)
            {
                for (int i=1; i <= row; i++)
                {
                    Dw_data.SetItemString(i, "coop_id", state.SsCoopId);
                }
            }
            else { LtServerMessage.Text = WebUtil.ErrorMessage("ไม่มี Row"); }
              

        }

        private void JspostDeleteRow()
        {
            try 
            {
                Int16 RowDetail = Convert.ToInt16(Hd_row.Value);
                Dw_data.DeleteRow(RowDetail);
                Dw_data.UpdateData();
                LtServerMessage.Text = WebUtil.CompleteMessage("ลบข้อมูลเสร็จเรียบร้อยแล้ว");
            }
            catch (Exception ex)
            { 
                LtServerMessage.Text = WebUtil.ErrorMessage(ex.Message);
            }
        }
        //==============================
        #region WebSheet Members

        public void InitJsPostBack()
        {
            postDeleteRow = WebUtil.JsPostBack(this, "postDeleteRow");
            postAddRow = WebUtil.JsPostBack(this, "postAddRow");
        }

        public void WebSheetLoadBegin()
        {
            this.ConnectSQLCA();
            Dw_data.SetTransaction(sqlca);
            if (!IsPostBack)
            {
                String coop_id = state.SsCoopId;
                Dw_data.Retrieve(coop_id);
                
            } 
            else
            {
                this.RestoreContextDw(Dw_data);
            }
        }

        public void CheckJsPostBack(string eventArg)
        {
            if (eventArg == "postDeleteRow")
            {
                JspostDeleteRow();
            }
            else if (eventArg == "postAddRow")
            {
                JspostAddRow();
            }
        }

        public void SaveWebSheet()
        {
            try 
            {
                Dw_data.SetItemString(1, "coop_id",state.SsCoopId);
                Dw_data.UpdateData();
                LtServerMessage.Text = WebUtil.CompleteMessage("บันทึกข้อมูลเรียบร้อยแล้ว");
            }
            catch(Exception ex)
            {
                LtServerMessage.Text = WebUtil.ErrorMessage(ex.Message);
            }
        }

        public void WebSheetLoadEnd()
        {
            Dw_data.SaveDataCache();
        }

        #endregion
    }
}
