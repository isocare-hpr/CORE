using System;
using CoreSavingLibrary;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using Sybase.DataWindow;
using DataLibrary;
using System.Data.OracleClient;

namespace Saving.Applications.cmd.dlg
{

    public partial class w_dlg_cmd_ptdurtmaster : PageWebDialog, WebDialog
    {
        protected String postFindinvt;
        private string is_sql;

        //========================
        private void jspostFindinvt()
        {

            string ls_durt_id,ls_durt_name, ls_sqltext = "", ls_temp,ls_order = "";

            try
            {
                ls_durt_id = Dw_find.GetItemString(1, "durt_id");
            }
            catch
            {
                ls_durt_id = "";
            }
            try
            {
                ls_durt_name = Dw_find.GetItemString(1, "durt_name");
            }
            catch
            {
                ls_durt_name = "";
            }

            if (ls_durt_id.Length > 0)
            {
                ls_sqltext += "where ( PTDURTMASTER.DURT_ID LIKE  '%" + ls_durt_id + "%') ";
            }
            if (ls_durt_name.Length > 0)
            {
                ls_sqltext += "where ( PTDURTMASTER.DURT_NAME LIKE  '%" + ls_durt_name + "%') ";
            }
            ls_order = "ORDER BY DURT_ID ASC";
            ls_temp = is_sql + ls_sqltext + ls_order;
            HSqlTemp.Value = ls_temp;
            Dw_detail.SetSqlSelect(HSqlTemp.Value);
            Dw_detail.Retrieve();

            if (Dw_detail.RowCount < 1)
            {
                LtServerMessage.Text = WebUtil.CompleteMessage("ไม่พบรายการรหัสที่ค้นหา");
                Dw_detail.Reset();
            }

        }
        #region WebDialog Members

        public void InitJsPostBack()
        {
            postFindinvt = WebUtil.JsPostBack(this, "postFindinvt");
        }

        public void WebDialogLoadBegin()
        {
            this.ConnectSQLCA();
            Dw_find.SetTransaction(sqlca);
            Dw_detail.SetTransaction(sqlca);


            is_sql = Dw_detail.GetSqlSelect();

            if (!IsPostBack)
            {
                Dw_find.InsertRow(0);
                jspostFindinvt();
            }
            else
            {
                this.RestoreContextDw(Dw_find);
                this.RestoreContextDw(Dw_detail);
            }

        }

        public void CheckJsPostBack(string eventArg)
        {
            if (eventArg == "postFindinvt")
            {
                jspostFindinvt();
            }
        }

        public void WebDialogLoadEnd()
        {
            Dw_find.SaveDataCache();
            Dw_detail.SaveDataCache();
        }

        #endregion
    }
}
