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
using DataLibrary;
using System.Globalization;
using System.Data.OracleClient;
using Sybase.DataWindow;

namespace Saving.Applications.cmd
{
    public partial class w_sheet_cmducf_unitcode : PageWebSheet, WebSheet
    {
        String pbl = "cmd_ucfunitcode.pbl";
        Sdt ta;
        protected String jsPostDelete;

        public void InitJsPostBack()
        {
            jsPostDelete = WebUtil.JsPostBack(this, "jsPostDelete");
        }

        public void WebSheetLoadBegin()
        {
            this.ConnectSQLCA();
            DwDetail.SetTransaction(sqlca);

            if (!IsPostBack)
            {
                DwMain.InsertRow(0);
                DwDetail.Retrieve();
            }
            else
            {
                this.RestoreContextDw(DwMain);
                this.RestoreContextDw(DwDetail);
            }
        }

        public void CheckJsPostBack(string eventArg)
        {
            switch (eventArg)
            {
                case "jsPostDelete":
                    PostOnDelete();
                    break;

            }
        }

        public void SaveWebSheet()
        {
            try
            {
                String unit_code = "", unit_desc;

                unit_desc = DwMain.GetItemString(1, "unit_desc").Trim();
                try
                {
                    String se = @"select max(unit_code)as unit_code from ptucfunitcode";
                    ta = WebUtil.QuerySdt(se);
                    if (ta.Next())
                    {
                        unit_code = ta.GetString("unit_code");
                    }
                    if (unit_code == null || unit_code == "")
                    {
                        unit_code = "0";
                    }
                    unit_code = Convert.ToString(Convert.ToDecimal(unit_code) + 1);

                    while (unit_code.Length < 3)
                    {
                        unit_code = "0" + unit_code;
                    }
                }
                catch { }
                try
                {
                    String insert = @"insert into ptucfunitcode
                                (unit_code,unit_desc)
                                values('" + unit_code + "','" + unit_desc + "' )";
                    ta = WebUtil.QuerySdt(insert);
                    DwDetail.Retrieve();
                    LtServerMessage.Text = WebUtil.CompleteMessage("บันทึกสำเร็จ");
                    DwMain.SetItemString(1, "unit_desc",null);

                }
                catch { }
            }
            catch (Exception ex)
            { LtServerMessage.Text = WebUtil.ErrorMessage(ex); }

        }

        public void WebSheetLoadEnd()
        {
            DwMain.SaveDataCache();
            DwDetail.SaveDataCache();
        }


        private void PostOnDelete()
        {
            String unitCode = "";
            Int32 row = Convert.ToInt32(HdR.Value);
            try
            {
                unitCode = DwDetail.GetItemString(row, "unit_code");
                String del = @"delete ptucfunitcode where unit_code = '" + unitCode + "'";
                ta = WebUtil.QuerySdt(del);
                DwDetail.Retrieve();
                LtServerMessage.Text = WebUtil.CompleteMessage("ทำการลบรายการ " + unitCode + " สำเร็จ");
            }
            catch (Exception ex)
            { LtServerMessage.Text = WebUtil.ErrorMessage(ex); }

        }

    }
}