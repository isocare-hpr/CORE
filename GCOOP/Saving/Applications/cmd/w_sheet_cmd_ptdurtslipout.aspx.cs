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
using Sybase.DataWindow;
using CoreSavingLibrary.WcfCommon;
using System.Data.SqlClient;

namespace Saving.Applications.cmd
{
    public partial class w_sheet_cmd_ptdurtslipout : PageWebSheet, WebSheet
    {
        protected String jsPostDel;
        protected String jsPostFindShow;

        String pbl = "cmd_ptdurtslipout.pbl";
        Sdt ta;
        private DwThDate tDwMain;

        public void InitJsPostBack()
        {
            tDwMain = new DwThDate(DwMain, this);
            tDwMain.Add("slip_date", "slip_tdate");
            tDwMain.Add("sale_date", "sale_tdate");

            jsPostDel = WebUtil.JsPostBack(this, "jsPostDel");
            jsPostFindShow = WebUtil.JsPostBack(this, "jsPostFindShow");
        }

        public void WebSheetLoadBegin()
        {

            if (!IsPostBack)
            {
                DwMain.InsertRow(0);
                DwDetail.InsertRow(0);
                PostReset();
            }
            else
            {
                this.RestoreContextDw(DwMain, tDwMain);
                this.RestoreContextDw(DwDetail);
            }
        }

        public void CheckJsPostBack(string eventArg)
        {
            switch (eventArg)
            {
                case "jsPostDel":
                    PostDel();
                    break;
                case "jsPostFindShow":
                    PostFindShow();
                    break;
            }
        }

        public void SaveWebSheet()
        {
            ///ptdurtslipout
            String insert = "", upsql = "";
            String slipout_no = "", committee_no = "", cutreason_code = "", ref_docno = "";
            Decimal slip_status = 1;
            DateTime slip_date, sale_date;
            ///ptdurtslipoutdet
            String durt_id = "", remark = "";
            Decimal price_bal = 0, sale_amt = 0, durt_status = 1;
            try
            {
                slipout_no = DwMain.GetItemString(1, "slipout_no").Trim();
                if (slipout_no == "AUTO")
                {
                    CommonClient com = wcf.Common;
                    slipout_no = com.GetNewDocNo(state.SsWsPass, "CMDSLIPOUTDURT");
                    try { slip_date = DwMain.GetItemDateTime(1, "slip_date"); }
                    catch { slip_date = state.SsWorkDate; }
                    try { sale_date = DwMain.GetItemDateTime(1, "sale_date"); }
                    catch { sale_date = state.SsWorkDate; }
                    try { ref_docno = DwMain.GetItemString(1, "ref_docno").Trim(); }
                    catch { ref_docno = ""; }
                    try { cutreason_code = DwMain.GetItemString(1, "cutreason_code"); }
                    catch { }
                    //insert ptdurtslipout
                    try
                    {
                        insert = @"insert into ptdurtslipout (slipout_no, slip_date, sale_date, committee_no,
	                    cutreason_code, ref_docno, slip_status) values
                        ('" + slipout_no + "',to_date('" + slip_date.ToString("dd/MM/yyyy") + @"','dd/MM/yyyy'), 
                        to_date('" + sale_date.ToString("dd/MM/yyyy") + @"','dd/MM/yyyy'),'" + committee_no + @"',
                        '" + cutreason_code + "','" + ref_docno + "'," + slip_status + ")";
                        ta = WebUtil.QuerySdt(insert);
                    }
                    catch (Exception ex)
                    { LtServerMessage.Text = WebUtil.ErrorMessage(ex); }

                    //insert ptdurtslipoutdet
                    for (Int32 i = 1; i <= DwDetail.RowCount; i++)
                    {
                        try { durt_id = DwDetail.GetItemString(i, "durt_id").Trim(); }
                        catch { }
                        try { price_bal = DwDetail.GetItemDecimal(i, "devaluebal_amt"); }
                        catch { price_bal = 0; }
                        try { sale_amt = DwDetail.GetItemDecimal(i, "sale_amt"); }
                        catch { sale_amt = 0; }
                        try { durt_status = DwDetail.GetItemDecimal(i, "durt_status"); }
                        catch { durt_status = -9; }
                        try { remark = DwDetail.GetItemString(i, "remark").Trim(); }
                        catch { remark = ""; }

                        try
                        {
                            insert = @"insert into ptdurtslipoutdet (durt_id, price_bal, price_sale , slipout_no) 
                                    values('" + durt_id + "'," + price_bal + "," + sale_amt + ", '" + slipout_no + "')";
                            ta = WebUtil.QuerySdt(insert);
                        }
                        catch (Exception ex)
                        { LtServerMessage.Text = WebUtil.ErrorMessage(ex); }
                        //update ptdurtmaster
                        try
                        {
                            upsql = @"update ptdurtmaster set sale_date = to_date('" + sale_date.ToString("dd/MM/yyyy") + @"','dd/mm/yyyy'),
                            durt_status = " + durt_status + ", sale_amt = " + sale_amt + ", remark = '" + remark + @"'
                            where durt_id = '" + durt_id + "'";
                            ta = WebUtil.QuerySdt(upsql);
                        }
                        catch (Exception ex)
                        { LtServerMessage.Text = WebUtil.ErrorMessage(ex); }
                    }
                }
                LtServerMessage.Text = WebUtil.CompleteMessage("ลงรับรายการ " + slipout_no + " สำเร็จ");
                DwMain.Reset();
                DwDetail.Reset();
                DwMain.InsertRow(0);
                DwDetail.InsertRow(0);
                PostReset();
            }
            catch (Exception ex)
            {
                LtServerMessage.Text = WebUtil.ErrorMessage(ex);
            }
        }

        public void WebSheetLoadEnd()
        {
            DwMain.SaveDataCache();
            DwDetail.SaveDataCache();
            tDwMain.Eng2ThaiAllRow();
        }

        private void PostReset()
        {
            DwMain.SetItemDateTime(1, "slip_date", state.SsWorkDate);
            DwMain.SetItemDateTime(1, "sale_date", state.SsWorkDate);
            DwDetail.SetItemDecimal(1, "sale_amt", 0);
            DwUtil.RetrieveDDDW(DwMain, "cutreason_code", pbl);
            DwUtil.RetrieveDDDW(DwDetail, "durt_status", pbl);
        }

        private void PostDel()
        {
            Int32 row = Convert.ToInt32(HdR.Value);
            DwDetail.DeleteRow(row);
        }

        private void PostFindShow()
        {
            String durt_id = "";
            try { durt_id = DwDetail.GetItemString(Convert.ToInt32(HdR.Value), "durt_id").Trim(); }
            catch { durt_id = HdDurtId.Value.Trim(); }
            DwUtil.RetrieveDataWindow(DwDetail, pbl, null, durt_id);
        }
    }
}