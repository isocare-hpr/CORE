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
using CoreSavingLibrary.WcfNCommon;

namespace Saving.Applications.cmd
{
    public partial class w_sheet_cmd_ptreqchgprodholder : PageWebSheet, WebSheet
    {
        protected String postFindShow;
        protected String jsPostOnInsert;

        private DwThDate tDwMain; 
        Sdt dt = new Sdt();

        public void InitJsPostBack()
        {
            jsPostOnInsert = WebUtil.JsPostBack(this, "jsPostOnInsert");
            postFindShow = WebUtil.JsPostBack(this, "postFindShow");
            tDwMain = new DwThDate(DwMain, this);
            tDwMain.Add("reqchg_date", "reqchg_tdate");
        }

        public void WebSheetLoadBegin()
        {
            this.ConnectSQLCA();
            DwMain.SetTransaction(sqlca);
            

            if (!IsPostBack)
            {
                DwMain.InsertRow(0);
                tDwMain.Eng2ThaiAllRow();
                DwMain.SetItemDateTime(1, "reqchg_date", state.SsWorkDate);
            }
            else
            {
                this.RestoreContextDw(DwMain, tDwMain);
            }
        }

        public void CheckJsPostBack(string eventArg)
        {
            switch (eventArg)
            {
                case "jsPostOnInsert":
                    PostOnInsert();
                    break;
                case "postFindShow":
                    jsPostFindShow();
                    break;
            }
        }

        public void SaveWebSheet()
        {
            String durt_id = "", durt_regno = "", durt_name = "", dept_code = "", holder_name = "";
            String reqchg_no = "", old_deptcode = "", old_holdername = "";
            Decimal reqchg_status = 0 ;
            DateTime reqchg_date;

            Sdt ta;
            try
            {
                reqchg_no = DwMain.GetItemString(1, "reqchg_no");
                durt_id = DwMain.GetItemString(1, "durt_id");
                durt_regno = DwMain.GetItemString(1,"durt_regno").Trim();
                durt_name = DwMain.GetItemString(1,"durt_name").Trim();
                dept_code = DwMain.GetItemString(1, "dept_code").Trim();
                holder_name = DwMain.GetItemString(1, "holder_name").Trim();
                old_deptcode = DwMain.GetItemString(1, "old_deptcode").Trim();
                old_holdername = DwMain.GetItemString(1, "old_holdername").Trim();


                if (reqchg_no == "AUTO")
                {
                    n_commonClient com = wcf.NCommon;
                    reqchg_no = com.of_getnewdocno(state.SsWsPass,state.SsCoopId, "CMDREQCHG");
                    try { reqchg_date = DwMain.GetItemDateTime(1, "slip_date"); }
                    catch { reqchg_date = state.SsWorkDate; }

                    try
                    {
                        String insert = @"insert into ptreqchgprodholder 
                                       (reqchg_no,reqchg_date,old_deptcode,old_holdername,dept_code,
	                                   holder_name ,reqchg_status,durt_id)values
                                       ('" + reqchg_no + "', to_date('" + reqchg_date.ToString("dd/MM/yyyy") + @"','dd/MM/yyyy'),
                                        '" + old_deptcode + "','" + old_holdername + "','" + dept_code + "','" + holder_name + @"',
                                        " + reqchg_status + ",'" + durt_id + "')";

                        ta = WebUtil.QuerySdt(insert);
                        LtServerMessage.Text = WebUtil.CompleteMessage("บันทึกสำเร็จ");
                    }
                    catch { }
                    try
                    {
                        //update ข้อมูลลง ptdurtmaster
                        String upsql = @"update ptdurtmaster
                                set dept_code ='" + dept_code + @"'
                               ,holder_name='" + holder_name + @"'
                                where durt_id = '" + durt_id + "'";
                        ta = WebUtil.QuerySdt(upsql);
                        LtServerMessage.Text = WebUtil.CompleteMessage("บันทึกสำเร็จ");
                    }
                    catch (Exception ex)
                    { LtServerMessage.Text = WebUtil.ErrorMessage("ไม่สามารถอัพเดทข้อมูลได้ " + ex); }
                }
                else
                {
                }
            }
            catch (Exception ex)
            {

                LtServerMessage.Text = WebUtil.ErrorMessage(ex);
            }

        }

        public void WebSheetLoadEnd()
        {
            if (DwMain.RowCount > 1)
            {
                DwMain.DeleteRow(DwMain.RowCount);
            }
            tDwMain.Eng2ThaiAllRow();
            DwMain.SaveDataCache();
        }

        private void PostOnInsert()
        {
            DwMain.InsertRow(0);
        }

        private void jsPostFindShow()
        {
            String durt_id = "", durt_regno = "", durt_name = "", dept_code = "", holder_name = "";
            
            Sdt ta;
            Int32 row = 1;
            durt_id = DwMain.GetItemString(row, "durt_id").Trim();
            try
            {
                String se = @"select durt_id, durt_regno,durt_name, dept_code,holder_name 
                          from ptdurtmaster where  durt_id = '" + durt_id + "'";
                ta = WebUtil.QuerySdt(se);
                if (ta.Next())
                {
                    durt_regno = ta.GetString("durt_regno").Trim();
                    durt_name = ta.GetString("durt_name").Trim();
                    dept_code = ta.GetString("dept_code").Trim();
                    holder_name = ta.GetString("holder_name").Trim();
                }
                DwMain.SetItemString(row, "durt_regno", durt_regno);
                DwMain.SetItemString(row, "durt_name", durt_name);
                DwMain.SetItemString(row, "dept_code", dept_code);
                DwMain.SetItemString(row, "holder_name", holder_name);
                DwMain.SetItemString(row, "old_deptcode", dept_code );
                DwMain.SetItemString(row, "old_holdername", holder_name);
            }catch{}
        }


    }
}