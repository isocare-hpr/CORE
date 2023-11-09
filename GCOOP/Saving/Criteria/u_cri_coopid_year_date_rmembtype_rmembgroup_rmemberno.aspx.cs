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
using Sybase.DataWindow;

namespace Saving.Criteria
{
    public partial class u_cri_coopid_year_date_rmembtype_rmembgroup_rmemberno : PageWebSheet, WebSheet
    {
        protected String app;
        protected String gid;
        protected String rid;
        protected String pdf;
        protected String runProcess;
        protected String popupReport;
        private DwThDate tdw_criteria;
        public String outputProcess = "";
        

        #region WebSheet Members

        public void InitJsPostBack()
        {
            HdOpenIFrame.Value = "False";
            runProcess = WebUtil.JsPostBack(this, "runProcess");
            tdw_criteria = new DwThDate(dw_criteria, this);
            tdw_criteria.Add("start_date", "start_tdate");
        }

        //protected void Page_Load(object sender, EventArgs e)
        public void WebSheetLoadBegin()
        {
            InitJsPostBack();
            //this.ConnectSQLCA();
            //dw_criteria.SetTransaction(sqlca);
            DwUtil.RetrieveDDDW(dw_criteria, "coop_id", "criteria.pbl", state.SsCoopControl);
            DwUtil.RetrieveDDDW(dw_criteria, "start_membtype", "criteria.pbl", state.SsCoopControl);
            DwUtil.RetrieveDDDW(dw_criteria, "end_membtype", "criteria.pbl", state.SsCoopControl);
            DwUtil.RetrieveDDDW(dw_criteria, "start_membgroup", "criteria.pbl", state.SsCoopControl);
            DwUtil.RetrieveDDDW(dw_criteria, "end_membgroup", "criteria.pbl", state.SsCoopControl);

            if (IsPostBack)
            {
                dw_criteria.RestoreContext();
            }
            else
            {
                //default values.
                dw_criteria.InsertRow(0);
                dw_criteria.SetItemString(1, "coop_id", state.SsCoopId);
                dw_criteria.SetItemString(1, "div_year", (DateTime.Now.Year + 543).ToString("0000"));
                dw_criteria.SetItemDateTime(1, "start_date", state.SsWorkDate);
                //dw_criteria.SetItemDateTime(1, "end_date", state.SsWorkDate);
                dw_criteria.SetItemString(1, "start_tdate", "");
                //dw_criteria.SetItemString(1, "end_tdate", "");
                string[] minmax = ReportUtil.GetMinMaxMembType();//.GetMinMaxMembgroupCoopid(state.SsCoopControl);
                dw_criteria.SetItemString(1, "start_membtype", minmax[0]);
                dw_criteria.SetItemString(1, "end_membtype", minmax[1]);
                string[] minmaxgrp = ReportUtil.GetMinMaxMembgroup();//.GetMinMaxMembgroupCoopid(state.SsCoopControl);
                dw_criteria.SetItemString(1, "start_membgroup", minmaxgrp[0]);
                dw_criteria.SetItemString(1, "end_membgroup", minmaxgrp[1]);
                string[] minmaxmembno = ReportUtil.GetMinMaxMembno();//.GetMinMaxMembgroupCoopid(state.SsCoopControl);
                dw_criteria.SetItemString(1, "start_memberno", minmaxmembno[0]);
                dw_criteria.SetItemString(1, "end_memberno", minmaxmembno[1]);
                tdw_criteria.Eng2ThaiAllRow();
                //JsGetYear();
              //  dw_criteria.SetItemString(1, "div_year", Convert.ToString(DateTime.Now.Year + 543));
            }

           
            //--- Page Arguments
            try
            {
                app = Request["app"].ToString();
            }
            catch { }
            if (app == null || app == "")
            {
                app = state.SsApplication;
            }
            try
            {
                gid = Request["gid"].ToString();
            }
            catch { }
            try
            {
                rid = Request["rid"].ToString();
            }
            catch { }

            //Report Name.
            try
            {
                Sta ta = new Sta(state.SsConnectionString);
                String sql = "";
                sql = @"SELECT REPORT_NAME  
                    FROM WEBREPORTDETAIL  
                    WHERE ( GROUP_ID = '" + gid + @"' ) AND ( REPORT_ID = '" + rid + @"' )";
                Sdt dt = ta.Query(sql);
                ReportName.Text = dt.Rows[0]["REPORT_NAME"].ToString();
                ta.Close();
            }
            catch
            {
                ReportName.Text = "[" + rid + "]";
            }

            //Link back to the report menu.
            LinkBack.PostBackUrl = String.Format("~/ReportDefault.aspx?app={0}&gid={1}", app, gid);
        }

        public void CheckJsPostBack(string eventArg)
        {
            if (eventArg == "runProcess")
            {
                RunProcess();
            }
            else if (eventArg == "popupReport")
            {
                PopupReport();
            }
            else if (eventArg == "post")
            {
                DwUtil.RetrieveDDDW(dw_criteria, "start_membtype", "criteria.pbl", null);
                DwUtil.RetrieveDDDW(dw_criteria, "end_membtype", "criteria.pbl", null);
                DwUtil.RetrieveDDDW(dw_criteria, "start_membgroup_1", "criteria.pbl", null);
                DwUtil.RetrieveDDDW(dw_criteria, "end_membgroup_1", "criteria.pbl", null);
            }
        }

        public void SaveWebSheet()
        {
        }

        public void WebSheetLoadEnd()
        {
        }
        #region Report Process
        private void RunProcess()
        {
            //อ่านค่าจากหน้าจอใส่ตัวแปรรอไว้ก่อน.
            String coop_id = dw_criteria.GetItemString(1, "coop_id");
            String div_year = dw_criteria.GetItemString(1, "div_year");
            String start_date = WebUtil.ConvertDateThaiToEng(dw_criteria, "start_tdate", null);
            String as_smembtype = dw_criteria.GetItemString(1, "start_membtype");
            String as_emembtype = dw_criteria.GetItemString(1, "end_membtype");
            String start_membgroup = dw_criteria.GetItemString(1, "start_membgroup");
            String end_membgroup = dw_criteria.GetItemString(1, "end_membgroup");
            String start_membno = dw_criteria.GetItemString(1, "start_memberno");
            String end_membno = dw_criteria.GetItemString(1, "end_memberno");
            start_membno = WebUtil.MemberNoFormat(start_membno.Trim());
            end_membno = WebUtil.MemberNoFormat(end_membno.Trim());

            //แปลง Criteria ให้อยู่ในรูปแบบมาตรฐาน.
            ReportHelper lnv_helper = new ReportHelper();
            lnv_helper.AddArgument(coop_id, ArgumentType.String);
            lnv_helper.AddArgument(div_year, ArgumentType.String);
            lnv_helper.AddArgument(start_date, ArgumentType.DateTime);
            lnv_helper.AddArgument(as_smembtype, ArgumentType.String);
            lnv_helper.AddArgument(as_emembtype, ArgumentType.String);
            lnv_helper.AddArgument(start_membgroup.Trim(), ArgumentType.String);
            lnv_helper.AddArgument(end_membgroup.Trim(), ArgumentType.String);
            lnv_helper.AddArgument(start_membno, ArgumentType.String);
            lnv_helper.AddArgument(end_membno, ArgumentType.String);

            //-------------------------------------------------------

            //ชื่อไฟล์ PDF = YYYYMMDDHHMMSS_<GID>_<RID>.PDF
            String pdfFileName = DateTime.Now.ToString("yyyyMMddHHmmss", WebUtil.EN);
            pdfFileName += "_" + gid + "_" + rid + ".pdf";
            pdfFileName = pdfFileName.Trim();

            //ส่งให้ ReportService สร้าง PDF ให้ {โดยปกติจะอยู่ใน C:\GCOOP\Saving\PDF\}.
            try
            {
                string printer = dw_criteria.GetItemString(1, "printer");
                String criteriaXML = lnv_helper.PopArgumentsXML();
                outputProcess = WebUtil.runProcessingReport(state, app, gid, rid, criteriaXML, pdfFileName, printer);
            }
            catch (Exception ex)
            {
                LtServerMessage.Text = WebUtil.ErrorMessage(ex);
                return;
            }
        
        }
        #endregion

        public void PopupReport()
        {
            //เด้ง Popup ออกรายงานเป็น PDF.
            String pop = "Gcoop.OpenPopup('" + pdf + "')";
            ClientScript.RegisterClientScriptBlock(this.GetType(), "DsReport", pop, true);
        }

        private void JsGetYear()
        {
            int account_year = 0;
            try
            {
                String sql = @"select max(current_year) from yrcfconstant";
                Sdt dt = WebUtil.QuerySdt(sql);
                if (dt.Next())
                {
                    account_year = int.Parse(dt.GetString("max(current_year)"));
                    dw_criteria.SetItemString(1, "div_year", Convert.ToString(account_year));
                }
                else
                {
                    sqlca.Rollback();
                }
            }
            catch (Exception ex)
            {
                account_year = DateTime.Now.Year;
                account_year = account_year + 543;
                dw_criteria.SetItemString(1, "div_year", account_year.ToString());
            }
        }
        #endregion

    }
}
