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
using CoreSavingLibrary.WcfNCommon;
using System.Data.SqlClient;

namespace Saving.Applications.cmd
{
    public partial class w_sheet_cmd_ptdurtslipin : PageWebSheet, WebSheet
    {
        String pbl = "cmd_ptdurtslipin.pbl";
        Sdt ta;
        protected String jsPostFindShow;
        private DwThDate tDwMain;
        protected String jsPostDurtgrpCode;

        public void InitJsPostBack()
        {
            tDwMain = new DwThDate(DwMain, this);
            tDwMain.Add("slip_date", "slip_tdate");
            tDwMain.Add("entry_date", "entry_tdate");
            tDwMain.Add("buy_date", "buy_tdate");
            tDwMain.Add("devaluestart_date", "devaluestart_tdate");
            jsPostFindShow = WebUtil.JsPostBack(this, "jsPostFindShow");
            jsPostDurtgrpCode = WebUtil.JsPostBack(this, "jsPostDurtgrpCode");
        }

        public void WebSheetLoadBegin()
        {
            if (!IsPostBack)
            {
                DwMain.InsertRow(0);
                PostReset();
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
                case "jsPostDurtgrpCode":
                    PostDurtgrpCode();
                    break;
                case "jsPostFindShow":
                    PostFindShow();
                    break;
            }
        }

        public void SaveWebSheet()
        {
            String insert = "";
            String slipin_no = "", durt_name = "", brand_name = "", model_desc = "", unit_code = "", durt_id = "";
            String durtgrp_code = "", durtrcv_code = "", entry_id = "", ref_docno, dept_code = "", holder_name = "", durt_regno = "";
            Decimal devalue_percent = 0, devaluelastcal_year = 0, unit_price = 0, durt_qty = 0, slip_status = 1, SeqNo = 0;
            DateTime slip_date, buy_date, devaluestart_date, entry_date;
            try
            {
                slipin_no = DwMain.GetItemString(1, "slipin_no").Trim();
                if (slipin_no == "AUTO")
                {
                    n_commonClient com = wcf.NCommon;
                    slipin_no = com.of_getnewdocno(state.SsWsPass,state.SsCoopId, "CMDSLIPINDURT");
                    entry_date = state.SsWorkDate;
                    entry_id = state.SsUsername;
                    DwMain.SetItemString(1, "slipin_no", slipin_no);
                    try { slip_date = DwMain.GetItemDateTime(1, "slip_date"); }
                    catch { slip_date = state.SsWorkDate; }
                    try { buy_date = DwMain.GetItemDateTime(1, "buy_date"); }
                    catch { buy_date = state.SsWorkDate; }
                    try { devaluestart_date = DwMain.GetItemDateTime(1, "devaluestart_date"); }
                    catch { devaluestart_date = state.SsWorkDate; }
                    try { ref_docno = DwMain.GetItemString(1, "ref_docno").Trim(); }
                    catch { ref_docno = ""; }
                    try { durt_name = DwMain.GetItemString(1, "durt_name").Trim(); }
                    catch { durt_name = ""; }
                    try { brand_name = DwMain.GetItemString(1, "brand_name").Trim(); }
                    catch { brand_name = ""; }
                    try { model_desc = DwMain.GetItemString(1, "model_desc").Trim(); }
                    catch { model_desc = ""; }
                    try { devalue_percent = DwMain.GetItemDecimal(1, "devalue_percent"); }
                    catch { devalue_percent = 0; }
                    try { devaluelastcal_year = DwMain.GetItemDecimal(1, "devaluelastcal_year"); }
                    catch { devaluelastcal_year = 0; }
                    try { unit_code = DwMain.GetItemString(1, "unit_code").Trim(); }
                    catch { unit_code = ""; }
                    try { unit_price = DwMain.GetItemDecimal(1, "unit_price"); }
                    catch { unit_price = 0; }
                    try { durt_qty = DwMain.GetItemDecimal(1, "durt_qty"); }
                    catch { durt_qty = 0; }
                    try { durtgrp_code = DwMain.GetItemString(1, "durtgrp_code").Trim(); }
                    catch { durtgrp_code = ""; }
                    try { durtrcv_code = DwMain.GetItemString(1, "durtrcv_code").Trim(); }
                    catch { durtrcv_code = ""; }
                    try { ref_docno = DwMain.GetItemString(1, "ref_docno").Trim(); }
                    catch { ref_docno = ""; }
                    devaluelastcal_year = devaluelastcal_year - 543;
                    //insert ptdurtslipin
                    try
                    {
                        insert = @"insert into  ptdurtslipin (slipin_no, slip_date, buy_date, durt_name, brand_name, model_desc,
	                    devalue_percent, devaluestart_date, devaluelastcal_year, unit_code, unit_price, durt_qty,
	                    durtgrp_code, durtrcv_code, slip_status, entry_id, entry_date, ref_docno ) values
                        ('" + slipin_no + "',to_date('" + slip_date.ToString("dd/MM/yyyy") + @"','dd/MM/yyyy'), 
                        to_date('" + buy_date.ToString("dd/MM/yyyy") + @"','dd/MM/yyyy'),'" + durt_name + "','" + brand_name + @"',
                        '" + model_desc + "'," + devalue_percent + ",to_date('" + devaluestart_date.ToString("dd/MM/yyyy") + @"','dd/MM/yyyy'),
                        " + devaluelastcal_year + ",'" + unit_code + "'," + unit_price + "," + durt_qty + ",'" + durtgrp_code + "','" + durtrcv_code + @"',
                        1,'" + entry_id + "', to_date('" + entry_date.ToString("dd/MM/yyyy") + @"','dd/MM/yyyy'),
                        '" + ref_docno + "')";
                        ta = WebUtil.QuerySdt(insert);
                    }
                    catch (Exception ex)
                    { LtServerMessage.Text = WebUtil.ErrorMessage(ex); }

                    //insert ptdurtslipindet
                    Int32 rowde = 0;
                    rowde = Convert.ToInt32(durt_qty);
                    for (Int32 i = 1; i <= rowde; i++)
                    {

                        durt_id = com.of_getnewdocno(state.SsWsPass,state.SsCoopId, "CMDPRODUCT");
                        try { durt_regno = DwMain.GetItemString(1, "durt_regno").Trim(); }
                        catch { durt_regno = ""; }
                        try { dept_code = DwMain.GetItemString(1, "dept_code").Trim(); }
                        catch { dept_code = ""; }
                        try { holder_name = DwMain.GetItemString(1, "holder_name").Trim(); }
                        catch { holder_name = ""; }
                        SeqNo = i;
                
                        try
                        {
                            insert = @"insert into ptdurtslipindet (seq_no, durt_regno, dept_code ,holder_name, slipin_no 
                                    , durt_id) 
                                    values('" + SeqNo + "','" + durt_regno + "','" + dept_code + "','" + holder_name + "','" + slipin_no + @"',
                                    '" + durt_id + "')";
                            ta = WebUtil.QuerySdt(insert);
                        }
                        catch (Exception ex)
                        { LtServerMessage.Text = WebUtil.ErrorMessage(ex); }
                        //insert ptdurtmaster
                        try
                        {
                            insert = @"insert into ptdurtmaster
                        (
	                        durt_id , durt_regno , durt_name , durtgrp_code , brand_name , model_desc ,
	                        unit_code , devalue_percent , devaluestart_date , devaluelastcal_year ,
	                        lot_id , dept_code , holder_name , unit_price , buy_date ,
	                        durt_status , devaluebal_amt  ) values
                        ( '" + durt_id + "', '" + durt_regno + "', '" + durt_name + "', '" + durtgrp_code + "', '" + brand_name + "', '" + model_desc + @"',
                          '" + unit_code + "', " + devalue_percent + ", to_date('" + devaluestart_date.ToString("dd/MM/yyyy") + "','dd/mm/yyyy'), " + devaluelastcal_year + @",
                          '" + slipin_no + "', '" + dept_code + "', '" + holder_name + "', " + unit_price + ", to_date('" + buy_date.ToString("dd/MM/yyyy") + @"','dd/mm/yyyy'),
                          1, " + unit_price + ")";
                            ta = WebUtil.QuerySdt(insert);
                        }
                        catch (Exception ex)
                        { LtServerMessage.Text = WebUtil.ErrorMessage(ex); }
                    }
                }
                LtServerMessage.Text = WebUtil.CompleteMessage("ลงรับรายการ " + slipin_no + " สำเร็จ");
                DwMain.Reset();
                DwMain.InsertRow(0);
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
            tDwMain.Eng2ThaiAllRow();
        }

        #region function
        private void PostReset()
        {
            String Accyear = "";
            DwMain.SetItemDateTime(1, "slip_date", state.SsWorkDate);
            DwMain.SetItemDateTime(1, "entry_date", state.SsWorkDate);
            DwMain.SetItemDateTime(1, "buy_date", state.SsWorkDate);
            DwMain.SetItemDateTime(1, "devaluestart_date", state.SsWorkDate);
            DwUtil.RetrieveDDDW(DwMain, "durtrcv_code", pbl);
            DwUtil.RetrieveDDDW(DwMain, "durtgrp_code", pbl);
            DwUtil.RetrieveDDDW(DwMain, "unit_code", pbl);
            DwMain.SetItemDecimal(1, "devalue_percent", 0);
            DwMain.SetItemDecimal(1, "durt_qty", 0);
            DwMain.SetItemDecimal(1, "unit_price", 0);

            Accyear = GetAccYear(state.SsWorkDate);
            DwMain.SetItemDecimal(1, "devaluelastcal_year", Convert.ToDecimal(Accyear) + 543);
        }
        private void PostDurtgrpCode()
        {
            String durtgrp_code = "";
            Decimal devalue_percent = 0;
            try { durtgrp_code = DwMain.GetItemString(1, "durtgrp_code").Trim(); }
            catch { durtgrp_code = ""; }
            try
            {
                String se = @"select devalue_percent from ptucfdurtgrpcode where durtgrp_code = '" + durtgrp_code + "'";
                ta = WebUtil.QuerySdt(se);
                if (ta.Next())
                {
                    devalue_percent = ta.GetDecimal("devalue_percent");
                }
                DwMain.SetItemDecimal(1, "devalue_percent", devalue_percent);
            }
            catch (Exception ex)
            { LtServerMessage.Text = WebUtil.ErrorMessage(ex); }

        }
        private void PostFindShow()
        {
            String durt_id = "", durt_name = "", durtgrp_code = "", brand_name = "", model_desc = "", unit_code = "";
            Decimal devalue_percent = 0, devaluelastcal_year = 0, unit_price = 0;
            DateTime devaluestart_date = new DateTime();
            DateTime buy_date = new DateTime();

            Sdt ta;
            Int32 row = Convert.ToInt32(HdurtId.Value);
            durt_id = DwMain.GetItemString(row, "durt_id").Trim();
            try
            {
                String se = @"select durt_id,durt_name ,durtgrp_code,brand_name,model_desc,unit_code,unit_price,
                          buy_date,devalue_percent,DEVALUESTART_DATE,devaluelastcal_year
                          from ptdurtmaster where  durt_id = '" + durt_id + "'";
                ta = WebUtil.QuerySdt(se);
                if (ta.Next())
                {
                    durt_name = ta.GetString("durt_name").Trim();
                    durtgrp_code = ta.GetString("durtgrp_code").Trim();
                    brand_name = ta.GetString("brand_name").Trim();
                    model_desc = ta.GetString("model_desc").Trim();
                    unit_code = ta.GetString("unit_code").Trim();
                    devalue_percent = ta.GetDecimal("devalue_percent");
                    devaluelastcal_year = ta.GetDecimal("devaluelastcal_year");
                    unit_price = ta.GetDecimal("unit_price");
                    devaluestart_date = ta.GetDate("devaluestart_date");
                    buy_date = ta.GetDate("buy_date");
                }
                DwMain.SetItemString(row, "durt_name", durt_name);
                DwMain.SetItemString(row, "durtgrp_code", durtgrp_code);
                DwMain.SetItemString(row, "brand_name", brand_name);
                DwMain.SetItemString(row, "model_desc", model_desc);
                DwMain.SetItemString(row, "unit_code", unit_code);
                DwMain.SetItemDecimal(row, "devalue_percent", devalue_percent);
                DwMain.SetItemDecimal(row, "devaluelastcal_year", devaluelastcal_year);
                DwMain.SetItemDecimal(row, "unit_price", unit_price);
                DwMain.SetItemDateTime(row, "devaluestart_date", devaluestart_date);
                DwMain.SetItemDateTime(row, "buy_date", buy_date);
            }
            catch { }
        }
        String GetAccYear(DateTime entry_date)
        {
            String AccYear = "";

            try
            {
                String se = @"select accperiod.account_year as account_year 
                            from	accperiod  
                            where accperiod.period_end_date in 
                            (	select	min( accperiod.period_end_date)
                            from accperiod  
                            where accperiod.period_end_date >= to_date('" + entry_date.ToString("dd/MM/yyyy") + @"','dd/MM/yyyy') ) ";
                ta = WebUtil.QuerySdt(se);
                if (ta.Next())
                {
                    AccYear = ta.GetString("account_year").Trim();
                }
            }
            catch { }
            return AccYear;
        }
        #endregion
    }
}