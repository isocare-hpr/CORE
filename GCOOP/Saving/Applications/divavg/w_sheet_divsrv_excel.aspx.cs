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
using Sybase.DataWindow;
using DataLibrary;
using System.IO;
//using CoreSavingLibrary.WcfDivavg;
using CoreSavingLibrary.WcfNCommon;
using System.Web.Services.Protocols;
using System.Text;
using OfficeOpenXml;

namespace Saving.Applications.divavg
{
    public partial class w_sheet_divsrv_excel : PageWebSheet,WebSheet
    {
        public String pbl = "divsrv_reportexcel.pbl";
        private DwThDate tDw_option;
        protected String postNewClear;
        /// <summary>
        /// ============================================================
        /// </summary>

        public void InitJsPostBack()
        {
            postNewClear = WebUtil.JsPostBack(this, "postNewClear");
            //==============
            DwUtil.RetrieveDDDW(Dw_option, "start_membgroup_1", pbl, state.SsCoopControl);
            DwUtil.RetrieveDDDW(Dw_option, "end_membgroup_1", pbl, state.SsCoopControl);
            DwUtil.RetrieveDDDW(Dw_option, "coop_id", pbl, null);
            //==========================
            tDw_option = new DwThDate(Dw_option, this);
            tDw_option.Add("methpay_date", "methpay_tdate");
        }

        public void WebSheetLoadBegin()
        {
            if (!IsPostBack)
            {
                JspostNewClear();
            }
            else
            {
                this.RestoreContextDw(Dw_choice);
                this.RestoreContextDw(Dw_option);
            }
        }


        public void CheckJsPostBack(string eventArg)
        {
            if (eventArg == "postNewClear")
            {
                JspostNewClear();
            }
        }

        public void SaveWebSheet()
        {

        }

        public void WebSheetLoadEnd()
        {
            Dw_choice.SaveDataCache();
            Dw_option.SaveDataCache();
        }
        //==============================
        private void JspostNewClear()
        {
            Dw_choice.Reset();
            Dw_choice.InsertRow(0);
            Dw_choice.SetItemString(1, "report_id", "CBT");

            Dw_option.Reset();
            Dw_option.InsertRow(0);
            Dw_option.SetItemString(1, "coop_id", state.SsCoopId);
            Dw_option.SetItemString(1, "div_year", Convert.ToString(DateTime.Now.Year + 543));
            Dw_option.SetItemDate(1, "methpay_date", state.SsWorkDate);
            tDw_option.Eng2ThaiAllRow();

            string[] minmax = ReportUtil.GetMinMaxMembgroup();
            Dw_option.SetItemString(1, "start_membgroup", minmax[0]);
            Dw_option.SetItemString(1, "end_membgroup", minmax[1]);
        }

        protected void B_report_Click(object sender, EventArgs e)
        {
            String report_id = Dw_choice.GetItemString(1,"report_id");
            if(report_id!= "" || report_id != null)
            {
                String coop_id = Dw_option.GetItemString(1, "coop_id");
                String div_year = Dw_option.GetItemString(1, "div_year");
                String start_membgroup = Dw_option.GetItemString(1, "start_membgroup");
                String end_membgroup = Dw_option.GetItemString(1, "end_membgroup");
                DwUtil.RetrieveDataWindow(Dw_report, pbl, null, coop_id, div_year, report_id);
            }

            
        }

        protected void B_excel_Click(object sender, EventArgs e)
        {
            if(Dw_report.RowCount > 0){
            try 
            {
                using (var package = new ExcelPackage())
                {
                    var workbook = package.Workbook;

                    //*** Sheet 1
                    var worksheet = workbook.Worksheets.Add("Sheet1");


                    worksheet.Cells["A1"].Value = "Member_No";
                    worksheet.Cells["B1"].Value = "Memname";
                    worksheet.Cells["C1"].Value = "Expense_Accid";
                    worksheet.Cells["D1"].Value = "Divavg_Amt";

                    for (int i = 1; i <= Dw_report.RowCount;i++ )
                    {
                        worksheet.Cells["A" + (i + 1).ToString()].Value = Dw_report.GetItemString(i, "member_no");
                        worksheet.Cells["B" + (i + 1).ToString()].Value = Dw_report.GetItemString(i, "memname");
                        //string expenseaccid = "";
                        //if (Dw_report.GetItemString(i, "expense_accid").Trim() != "" ) 
                        //{
                        //    expenseaccid = Dw_report.GetItemString(i, "expense_accid").Trim();
                        //}
                        //worksheet.Cells["C" + (i + 1).ToString()].Value = expenseaccid;
                        worksheet.Cells["C" + (i + 1).ToString()].Value = Dw_report.GetItemString(i, "expense_accid").Trim() ;
                        worksheet.Cells["D" + (i + 1).ToString()].Value = Dw_report.GetItemDecimal(i, "divavg_amt");
                    }


                    string into = DateTime.Now.ToString("ddMMyyyyHHmmss") + "_myExcel.xlsx";
                    package.SaveAs(new FileInfo(Server.MapPath("~/filecommon/") + into));
                    string url_into = WebUtil.GetSavingUrlCurrent() + "filecommon/" + into;
                    LtServerMessage.Text = WebUtil.CompleteMessage("ออกรายงานในรูปแบบ Excel คุณสามารถดาวน์โหลดไฟล์ได้ที่นี่<br /><a href=\"" + url_into + "\" target='_blank'>DIV_Excal</a>");
                }
               }
            catch (Exception ex) { LtServerMessage.Text = WebUtil.ErrorMessage(ex.Message); }
            }
        }
    }
}