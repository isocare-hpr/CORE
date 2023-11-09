using System;
using CoreSavingLibrary;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;

using CoreSavingLibrary.WcfNAdmin;
using DataLibrary;
using Sybase.DataWindow;
using System.Web.Services.Protocols;

namespace Saving.Applications.admin
{
    public partial class w_sheet_ad_adduser : PageWebSheet, WebSheet
    {

        protected String jsSearch;
        protected String jsDescription;
        public void InitJsPostBack()
        {
            jsSearch = WebUtil.JsPostBack(this, "jsSearch");
            jsDescription = WebUtil.JsPostBack(this, "jsDescription");
        }

        public void WebSheetLoadBegin()
        {
            if (!IsPostBack)
            {
                DwUserName.InsertRow(0);
            }
            else
            {
                this.RestoreContextDw(DwUserName);

            }
        }

        public void CheckJsPostBack(string eventArg)
        {
            switch (eventArg)
            {
                case "jsSearch":
                    JsSearch();
                    break;
                case "jsDescription":
                    DescriptionCheck();
                    break;
            }
        }

        public void DescriptionCheck()
        {
            HdCkDes.Value = "1";
            string user_n = DwUserName.GetItemString(1, "user_name");
            string des = DwUserName.GetItemString(1, "full_name");
            string sqlck = "select full_name from amsecusers where full_name ='" + des + "' and user_name <>'" + user_n + "'";
            Sdt ckdes = WebUtil.QuerySdt(sqlck);
            if (ckdes.Next())
            {
                LtServerMessage.Text = WebUtil.WarningMessage("ชื่อนี้มีอยู่แล้วในระบบ กรุณากรอกชื่อใหม่");
                HdCkDes.Value = "0";
            }
        }
        public void JsSearch()
        {
            string user_id = DwUserName.GetItemString(1, "user_name");

            try
            {
                DwUtil.RetrieveDataWindow(DwUserName, "ad_user.pbl", null, user_id);
                string test = DwUserName.GetItemString(1, "user_name");
                LtServerMessage.Text = WebUtil.WarningMessage("รหัสนี้มีอยุ่ในระบบแล้ว");
            }
            catch
            {
                DwUserName.InsertRow(0);
                DwUserName.SetItemString(1, "user_name", user_id);
                DwUserName.SetItemString(1, "coop_id", state.SsCoopId);
                DwUserName.SetItemString(1, "password", "1234");
                DwUserName.SetItemString(1, "coopbranch_id", "000");
                DwUserName.SetItemString(1, "tablefin_code", "XXX");
                DwUserName.SetItemDecimal(1, "user_type", 1);
                DwUserName.SetItemDecimal(1, "freez_flag", 0);
            }
        }

        public void SaveWebSheet()
        {
            string error = "";
            n_adminClient adminService = wcf.NAdmin;
            string user_name = DwUserName.GetItemString(1,"user_name");
            string full_name = DwUserName.GetItemString(1, "full_name");
            DwUserName.SetItemString(1, "coop_control", state.SsCoopControl);
            int result=2;
            try
            {
                result = adminService.of_existinguser(state.SsWsPass, user_name, full_name);
            }
            catch (Exception e)
            { LtServerMessage.Text = WebUtil.ErrorMessage(e); }


            if (result == 0 && HdCkDes.Value == "1")
            {
                String d_um_user_xml = DwUserName.Describe("Datawindow.data.XML");
                try
                {
                    int resultsave = adminService.of_savenewuser(state.SsWsPass, d_um_user_xml, ref error);
                    if (resultsave == 1)
                    {
                        LtServerMessage.Text = WebUtil.CompleteMessage("เพิ่มรหัสผู้ใช้งานใหม่สำเร็จ");
                    }
                    else { LtServerMessage.Text = WebUtil.ErrorMessage("บันทึกข้อมูลผู้ใช้ไม่สำเร็จ"+error); }
                }
                catch (Exception ex)
                {
                    LtServerMessage.Text = WebUtil.ErrorMessage(ex);
                }
            }
            else
            { LtServerMessage.Text = WebUtil.WarningMessage("รหัสผู้ใช้งาน หรือ ชื่อผู้ใช้งานซ้ำ"); }



        }

        public void WebSheetLoadEnd()
        {
            DwUtil.RetrieveDDDW(DwUserName, "apvlevel_id", "ad_user.pbl", null);
            DwUserName.SaveDataCache();
        }
    }
}