﻿using System;
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
using CoreSavingLibrary.WcfNAccount;
using CoreSavingLibrary.WcfNCommon;
using Sybase.DataWindow;
using System.Web.Services.Protocols;
using System.Globalization;
using Sybase.DataWindow.Web;
using System.IO;

namespace Saving.Applications.account
{
    public partial class w_acc_report_excel_voucher : PageWebSheet, WebSheet
    {
        DataStore DStore;
        private n_accountClient acc;
        protected String postNewClear;
        protected String jsButtonShowData;
        protected String expExcel;
        private DwThDate tDwMain;

        private void JspostNewClear()
        {
            Dw_main.Reset();
            Dw_main.InsertRow(0);
            Dw_main1.Reset();
            Dw_main1.InsertRow(0);
        }

        public void InitJsPostBack()
        {
            postNewClear = WebUtil.JsPostBack(this, "postNewClear");
            jsButtonShowData = WebUtil.JsPostBack(this, "jsButtonShowData");
            expExcel = WebUtil.JsPostBack(this, "expExcel");
            //=========================
            tDwMain = new DwThDate(Dw_main, this);
            tDwMain.Add("start_date", "start_tdate");
            tDwMain.Add("end_date", "end_tdate");
        }

        public void WebSheetLoadBegin()
        {
            DwUtil.RetrieveDDDW(Dw_main, "acc_id", "vc_report.pbl", null);
            try
            {
                this.ConnectSQLCA();
            }
            catch { LtServerMessage.Text = WebUtil.CompleteMessage("ติดต่อ Database ไม่ได้"); }

            try
            {
                acc = wcf.NAccount;
            }
            catch { LtServerMessage.Text = WebUtil.CompleteMessage("ติดต่อ Service ไม่ได้"); }

            Dw_main.SetTransaction(sqlca);
            Dw_main1.SetTransaction(sqlca);

            if (!IsPostBack)
            {
                JspostNewClear();
                detail.Visible = false;
            }
            else
            {
                detail.Visible = true;
                this.RestoreContextDw(Dw_main);
                this.RestoreContextDw(Dw_main1);
            }
        }

        public void CheckJsPostBack(string eventArg)
        {
            if (eventArg == "postNewClear")
            {
                JspostNewClear();
            }
            else if (eventArg == "jsButtonShowData")
            {
                JsButtonShowData();
            }
            else if (eventArg == "expExcel")
            {
                SaveFile();
            }
        }

        public void SaveWebSheet()
        {

        }

        public void WebSheetLoadEnd()
        {
            Dw_main.SaveDataCache();
            Dw_main1.SaveDataCache();
        }

        private void JsButtonShowData()
        {
            try
            {
                DateTime startDate = Dw_main.GetItemDateTime(1, "start_date");
                DateTime endDate = Dw_main.GetItemDateTime(1, "end_date");
                String drcr = Dw_main.GetItemString(1, "acc_drcr");
                String acc_id = Dw_main.GetItemString(1, "acc_id");
                Dw_main1.Retrieve(startDate, endDate, state.SsCoopControl, acc_id, drcr);
            }
            catch (Exception ex)
            {

            }
        }

        private void SaveFile()
        {
            String acc_id = Dw_main.GetItemString(1, "acc_id");
            String acc_name = Dw_main1.GetItemString(1, "compute_4");
            DateTime startDate = Dw_main.GetItemDateTime(1, "start_date");
            String drcr = Dw_main.GetItemString(1, "acc_drcr");
            if (drcr == "DR")
            {
                drcr = "DR";
            }
            else
            {
                drcr = "CR";
            }
            try
            {
                str_rptexcel astr_rptexcel = new str_rptexcel();
                astr_rptexcel.as_xmldw = Dw_main1.Describe("DataWindow.Data.XML");
                int result = wcf.NCommon.of_dwexportexcel_etn(state.SsWsPass, astr_rptexcel);
                if (astr_rptexcel.as_xmldw != "")
                {
                    String xml_detail = astr_rptexcel.as_xmldw;
                    String filename = drcr + acc_id + startDate.ToString("yyyyMMdd") + ".xls";
                    String path = WebUtil.GetStoreFile(state.SsApplication, "sms_excel\\" + filename);

                    DStore = new DataStore();
                    DStore.LibraryList = WebUtil.PhysicalPath + @"Saving\DataWindow\account\vc_report.pbl";
                    DStore.DataWindowObject = "d_acc_report_excel_voucher";
                    DStore.ImportString(xml_detail, FileSaveAsType.Xml);
                    int row = DStore.RowCount;
                    int i = 1;
                    string a, b, c, d, e, f, h, k, l, m, n, p, r;
                    Decimal s;
                    StreamWriter writer = new StreamWriter(path);
                    try
                    {
                        e = acc_name;
                    }
                    catch
                    {
                        e = "";
                    }
                    writer.WriteLine(e.Replace(Environment.NewLine, "<br/>"));
                    p = drcr;
                    writer.WriteLine(p.Replace(Environment.NewLine, "<br/>"));
                    try
                    {
                        f = "ว/ด/ป"; writer.Write(f); writer.Write('\t');
                        h = "รายละเอียด"; writer.Write(h); writer.Write('\t'); writer.Write('\t');
                        //k = "เลขทะเบียน"; writer.Write(k); writer.Write('\t');

                    }
                    catch
                    {
                        f = ""; h = ""; //k = "";
                    }
                    l = "จำนวนเงิน";
                    writer.WriteLine(l.Replace(Environment.NewLine, "<br/>"));
                    while (i < row + 1)
                    {
                        try
                        {
                            a = DStore.GetItemString(i, "compute_2");
                        }
                        catch
                        {
                            a = "";
                        }
                        try
                        {
                            b = DStore.GetItemString(i, "vcvoucherdetdetail_item_desc");
                        }
                        catch
                        {
                            b = "";
                        }
                        try
                        {
                            if (p == "DR")
                            {
                                c = DStore.GetItemString(i, "vcvoucherdetdetail_dr_amt");
                            }
                            else
                            {
                                c = DStore.GetItemString(i, "vcvoucherdetdetail_cr_amt");
                            }
                        }
                        catch
                        {
                            c = "";
                        }
                        //try
                        //{
                        //    d = DStore.GetItemString(i, "member_no");
                        //}
                        //catch
                        //{
                        //    d = "";
                        //}
                        //try
                        //{
                        //    r = DStore.GetItemString(i, "deptslip_amt");
                        //}
                        //catch
                        //{
                        //    r = "";
                        //}
                        writer.Write(a);
                        writer.Write('\t');
                        writer.Write(b);
                        writer.Write('\t');
                        //writer.Write(c);
                        //writer.Write('\t');
                        //writer.Write(d);
                        writer.Write('\t');
                        writer.WriteLine(c.Replace(Environment.NewLine, "<br/>"));
                        i++;
                    }
                    m = "รวม"; writer.Write(m); writer.Write('\t'); writer.Write('\t'); writer.Write('\t');
                    try
                    {
                        if (p == "DR")
                        {
                            n = DStore.GetItemString(1, "compute_5");
                        }
                        else 
                        {
                            n = DStore.GetItemString(1, "compute_6");
                        }
                    }
                    catch
                    {
                        n = "";
                    }
                    writer.WriteLine(n.Replace(Environment.NewLine, "<br/>"));
                    writer.Close();
                    JspostNewClear();
                    string path2 = WebUtil.CreateLinkDownload(state.SsApplication, "sms_excel/" + filename);
                    LtServerMessage.Text = WebUtil.CompleteMessage("บันทึกข้อมูลสำเร็จ คุณสามารถดาวน์โหลดไฟล์ได้ที่นี่  <a href=\"" + path2 + "\" target='_blank'>" + filename + "</a>");
                }
                else
                {
                    LtServerMessage.Text = WebUtil.ErrorMessage("ไม่พบข้อมูล กรุณาตรวจสอบใหม่");
                    JspostNewClear();
                }

            }
            catch (SoapException ex)
            {
                LtServerMessage.Text = WebUtil.ErrorMessage("เกิดข้อผิดพลาด " + WebUtil.SoapMessage(ex));
            }
        }
    }
}
