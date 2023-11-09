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
using CoreSavingLibrary.WcfNCommon;
using CoreSavingLibrary.WcfNShrlon;
using System.Globalization;
using Sybase.DataWindow;
using DataLibrary;

namespace Saving.Applications.shrlon
{
    public partial class w_sheet_sl_loanrcv_cancel : PageWebSheet, WebSheet
    {
        private DwThDate tdwhead;
        private n_shrlonClient shrlonService;
        private n_commonClient commonService;
        protected String jsPostMember;
        protected String jsPostLnrcvList;
        protected String newClear;
        DateTime cancel_date;
        //register event สำหรับการใช้งานในหน้าจ
        public void InitJsPostBack()
        {
            jsPostMember = WebUtil.JsPostBack(this, "jsPostMember");
            jsPostLnrcvList = WebUtil.JsPostBack(this, "jsPostLnrcvList");
            tdwhead = new DwThDate(dw_head, this);
            tdwhead.Add("slip_date", "slip_tdate");
            tdwhead.Add("operate_date ", "operate_tdate ");
            newClear = WebUtil.JsPostBack(this, "newClear");
        }

        //method แรกเมื่อ sheet ดังกล่าวถูกเปิดขึ้น
        public void WebSheetLoadBegin()
        {
            try
            {
                shrlonService = wcf.NShrlon;
                commonService = wcf.NCommon;
            }
            catch
            {
                LtServerMessage.Text = WebUtil.ErrorMessage("ติดต่อ Web Service ไม่ได้");
                return;
            }
            this.ConnectSQLCA();

            if (IsPostBack)
            {

                try
                {
                    dw_main.RestoreContext();
                    dw_list.RestoreContext();
                    dw_head.RestoreContext();
                    this.RestoreContextDw(dw_detail);

                }
                catch { }

            }
            if (dw_main.RowCount < 1)
            {
                dw_main.InsertRow(0);
                dw_list.InsertRow(0);
                dw_head.InsertRow(0);
                dw_detail.InsertRow(0);

                //DwUtil.RetrieveDDDW(dw_head, "moneytype_code", "sl_slipall.pbl", null);
            }

        }

        //เป็นฟังก์ชันไว้สำหรับตรวจสอบ event ที่มีการ register ไว้ กรณีมีการเรียกใช้งาน event นั้นๆ
        public void CheckJsPostBack(string eventArg)
        {
            if (eventArg == "jsPostMember")
            {
                JsPostMember();
            }
            else if (eventArg == "jsPostLnrcvList")
            {
                JsPostLnrcvList();
                checkclsday();
            }
            else if (eventArg == "newClear")
            {
                JsNewClear();
            }
        }

        //เป็น method สำหรับการบันทึกข้อมูลของ sheet นั้นๆ 
        public void SaveWebSheet()
        {
            try
            {
                DateTime dt_canceldate = dw_head.GetItemDate(1, "cancel_date");
                //String dwhead_XML = dw_head.Describe("DataWindow.Data.XML");
                //String dwdetail_XML = dw_detail.Describe("DataWindow.Data.XML");
                //String slip_no = dw_head.GetItemString(1, "payoutslip_no");
                //String cancel_id = dw_head.GetItemString(1, "entry_id");
                //tdwhead.Eng2ThaiAllRow();
                //DateTime cancel_date = state.SsWorkDate;
                dw_head.SetItemString(1, "entry_id", state.SsUsername);
                str_slipcancel slipcancle = new str_slipcancel();

                slipcancle.xml_sliphead = dw_head.Describe("DataWindow.Data.XML");
                slipcancle.xml_slipdetail = dw_detail.Describe("DataWindow.Data.XML");
                slipcancle.slip_no = dw_head.GetItemString(1, "payoutslip_no");
                slipcancle.cancel_id = state.SsUsername;
                if (dw_head.GetItemDate(1, "slip_date") > dt_canceldate)
                {
                    slipcancle.cancel_date = dw_head.GetItemDate(1, "slip_date");
                }
                else
                {
                    slipcancle.cancel_date = dt_canceldate;
                }
                slipcancle.operateccl_date = dt_canceldate;
                slipcancle.slipcoop_id = state.SsCoopId;
                slipcancle.memcoop_id = state.SsCoopId;
                slipcancle.cancel_coopid = state.SsCoopId;



                int result = shrlonService.of_saveccl_lnrcv(state.SsWsPass,ref slipcancle);
                if (result == 1)
                {
                    LtServerMessage.Text = WebUtil.CompleteMessage("บันทึกเรียบร้อย");
                    JsNewClear();
                }
            }
            catch (Exception ex) { LtServerMessage.Text = WebUtil.ErrorMessage(ex); }
        }

        //เป็น method สุดท้ายของ web sheet นี้
        public void WebSheetLoadEnd()
        {
            //DwUtil.RetrieveDDDW(dw_head, "moneytype_code", "sl_slipall.pbl", null);
            if (dw_head.RowCount > 1)
            {
                dw_head.DeleteRow(dw_head.RowCount);
            }
            if (dw_main.RowCount > 1)
            {
                dw_main.DeleteRow(dw_main.RowCount);
            }
            dw_detail.SaveDataCache();
            dw_head.SaveDataCache();
        }

        private void JsPostMember()
        {
            try
            {
                dw_list.Reset();
                dw_head.Reset();
                dw_head.InsertRow(0);
                dw_detail.Reset();

                String member_no = WebUtil.MemberNoFormat(Hfmember_no.Value);
                DwUtil.RetrieveDataWindow(dw_main, "sl_slipall.pbl", null, state.SsCoopControl, member_no);

                if (dw_main.RowCount < 1)
                {
                    LtServerMessage.Text = WebUtil.ErrorMessage("ไม่พบข้อมูลสมาชิก กรุณาตรวจสอบใหม่");
                }
                else
                {
                    try
                    {
                        DwUtil.RetrieveDataWindow(dw_list, "sl_slipall.pbl", null, state.SsCoopControl, member_no);

                        if (dw_list.RowCount < 1)
                        {
                            LtServerMessage.Text = WebUtil.ErrorMessage("ไม่พบข้อมูล กรุณาตรวจสอบใหม่");
                        }
                    }
                    catch (Exception ex) { LtServerMessage.Text = WebUtil.ErrorMessage(ex); }
                }
            }
            catch (Exception ex) { LtServerMessage.Text = WebUtil.ErrorMessage(ex); }
        }


        private void JsPostLnrcvList()
        {
            try
            {
                //String payoutslip_no = dw_list.GetItemString(1, "payoutslip_no");
                String payoutslip_no = HfSlipNo.Value;
                String coop_id = state.SsCoopControl;
                String slipclear_no = "";

                String sql = "select slipclear_no from slslippayout where payoutslip_no = '" + payoutslip_no + "'";
                sql = WebUtil.SQLFormat(sql, payoutslip_no);
                Sdt dt = WebUtil.QuerySdt(sql);
                if (dt.Next())
                {
                    slipclear_no = dt.GetString("slipclear_no");
                }

                dw_head.Reset();
                dw_detail.Reset();
                
                DwUtil.RetrieveDataWindow(dw_head, "sl_slipall.pbl", null, coop_id, payoutslip_no);
                DwUtil.RetrieveDataWindow(dw_detail, "sl_slipall.pbl", null, coop_id, slipclear_no);
            }
            catch (Exception ex)
            {
                LtServerMessage.Text = WebUtil.ErrorMessage(ex);
            }
        }

        //เช็คปิดวัน
        public void checkclsday()
        {
            CultureInfo th = System.Globalization.CultureInfo.GetCultureInfo("th-TH");
            if (state.SsCloseDayStatus == 1)
            {
                try
                {
                    DateTime adtm_nextworkdate = new DateTime();
                    int result = wcf.NCommon.of_getnextworkday(state.SsWsPass, state.SsWorkDate, ref adtm_nextworkdate);
                    if (result == 1)
                    {
                        this.SetOnLoadedScript("alert('ระบบได้ทำการปิดวันไปแล้ว เปลี่ยนวันใบเสร็จเป็น " + adtm_nextworkdate.ToString("dd/MM/yyyy", th) + " ')");
                        dw_head.SetItemDate(1, "cancel_date", adtm_nextworkdate);
                    }
                }
                catch (Exception ex) { LtServerMessage.Text = WebUtil.ErrorMessage(ex); }
            }
            else
            {
                cancel_date = state.SsWorkDate;
                dw_head.SetItemDate(1, "cancel_date", cancel_date);
            }
        }
   
        private void JsNewClear()
        {
            dw_main.Reset();
            dw_list.Reset();
            dw_head.Reset();
            dw_detail.Reset();
            dw_main.InsertRow(0);
            dw_list.InsertRow(0);
            dw_head.InsertRow(0);
            dw_detail.InsertRow(0);
        }

    }
}
