using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CoreSavingLibrary;
using DataLibrary;

namespace Saving.CriteriaIReport.u_cri_coopid_rage_rmembgroup_rsalary
{
    public partial class u_cri_coopid_rage_rmembgroup_rsalary : PageWebReport, WebReport
    {
        protected String app;
        protected String gid;
        protected String rid;

        public void InitJsPostBack()
        {
            dsMain.InitDsMain(this);
        }

        public void WebSheetLoadBegin()
        {
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

            if (!IsPostBack)
            {
                dsMain.DdCoopId();
                dsMain.DATA[0].S_AGE ="10";
                dsMain.DATA[0].E_AGE = "60";
                dsMain.DdSmembgroup();
                dsMain.DdEmembgroup();
                string[] minmax = ReportUtil.GetMinMaxMembgroup();
                dsMain.DATA[0].S_MEMBGROUP = minmax[0];
                dsMain.DATA[0].E_MEMBGROUP = minmax[1];
                dsMain.DATA[0].S_SALARY = "1000";
                dsMain.DATA[0].E_SALARY = "50000" ;
            }
        }

        public void CheckJsPostBack(string eventArg)
        {

        }

        public void RunReport()
        {
            string as_coopid = state.SsCoopControl;
            string an_sage = dsMain.DATA[0].S_AGE.ToString();
            string an_eage = dsMain.DATA[0].E_AGE.ToString();
            string as_smembgroup = dsMain.DATA[0].S_MEMBGROUP;
            string as_emembgroup = dsMain.DATA[0].E_MEMBGROUP;
            string an_ssalary = dsMain.DATA[0].S_SALARY.ToString();
            string an_esalary = dsMain.DATA[0].E_SALARY.ToString();

            try
            {
                iReportArgument arg = new iReportArgument();


                arg.Add("an_eage", iReportArgumentType.String, an_eage);
                arg.Add("an_esalary", iReportArgumentType.String, an_esalary);
                arg.Add("an_sage", iReportArgumentType.String, an_sage);
                arg.Add("an_ssalary", iReportArgumentType.String, an_ssalary);
              
                arg.Add("as_coopid", iReportArgumentType.String, as_coopid);
                arg.Add("as_smembgroup", iReportArgumentType.String, as_smembgroup);
                arg.Add("as_emembgroup", iReportArgumentType.String, as_emembgroup);



                iReportBuider report = new iReportBuider(this, arg);

                report.Retrieve();
            }
            catch (Exception ex)
            {
                LtServerMessage.Text = WebUtil.ErrorMessage(ex);
            }
        }

        public void WebSheetLoadEnd()
        {

        }
    }
}