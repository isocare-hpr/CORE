using System;
using CoreSavingLibrary;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DataLibrary;
using System.Globalization;


namespace Saving.Applications.mis.w_sheet_mssysbal_ctrl
{
    public partial class w_sheet_mssysbal: PageWebSheet, WebSheet
    {
        [JsPostBack]
        public string PostInsertRow { get; set; } //สำสั่ง JS postback
        [JsPostBack]
        public string PostDeleteRow { get; set; } //สำสั่ง JS postback

        [JsPostBack]
        public string postsearch { get; set; } //สำสั่ง JS postback
        [JsPostBack]
        public string postprocess { get; set; } //สำสั่ง JS postback


        public void InitJsPostBack()
        {
            dsMain.InitDsMain(this);
            dsList.InitDsList(this);
        }

        public void WebSheetLoadBegin()
        {

            if (!IsPostBack)
            {
                dsMain.DATA[0].work_date = state.SsWorkDate;
                //dsList.retrieve(state.SsWorkDate);
            }
        }

        public void CheckJsPostBack(string eventArg)
        {
            if (eventArg == PostInsertRow)
            {
                dsList.InsertAtRow(0);
            }
            else if (eventArg == PostDeleteRow)
            {
                int Rowdelete = dsList.GetRowFocus();
                dsList.DeleteRow(Rowdelete);
            }
            else if (eventArg == postsearch)
            {
                //String a = state.SsWorkDate.ToString("ddMMyyyy", new CultureInfo("th-TH"));
                //String b = dsMain.DATA[0].work_date.Year.ToString();
                //int y = Convert.ToInt16(b) - 543;
                //String datework = dsMain.DATA[0].work_date.Day.ToString("00/") + dsMain.DATA[0].work_date.Month.ToString("00/") + dsMain.DATA[0].work_date.Year.ToString();
                //DateTime workwork = Convert.ToDateTime(datework);
                try
                {
                    dsList.ResetRow();
                    dsList.retrieve(dsMain.DATA[0].work_date);
                    if (dsList.RowCount <= 0) throw new Exception("ไม่พบข้อมูล");
                }
                catch (Exception ex)
                {
                    LtServerMessage.Text = WebUtil.ErrorMessage(ex);
                }
            }
            else if (eventArg == postprocess)
            {
                dsList.sql_mssysbal();
                dsList.retrieve(dsMain.DATA[0].work_date);
            }
        }

        public void SaveWebSheet()
        {
            try
            {
                ExecuteDataSource exed = new ExecuteDataSource(this);
                exed.AddRepeater(dsList);

                int result = exed.Execute();

                LtServerMessage.Text = WebUtil.CompleteMessage("บันทึกสำเร็จ"); //หากบันทึกให้ขึ้น บันทึกแล้ว
                dsList.retrieve(dsMain.DATA[0].work_date);
            }
            catch (Exception ex)
            {
                LtServerMessage.Text = WebUtil.ErrorMessage(ex.Message); // กรณีไม่สำเร็จ
            }

        }

        public void WebSheetLoadEnd()
        {
        }
    }
}