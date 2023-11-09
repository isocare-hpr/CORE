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
    public partial class w_sheet_cmd_ptinvtmast : PageWebSheet, WebSheet
    {
        protected String postFindShow;
        protected String jsPostOnInsert;
        Sdt dt = new Sdt();

        public void InitJsPostBack()
        {
            jsPostOnInsert = WebUtil.JsPostBack(this, "jsPostOnInsert");
            postFindShow = WebUtil.JsPostBack(this, "postFindShow");
        }

        public void WebSheetLoadBegin()
        {
            this.ConnectSQLCA();
            DwMain.SetTransaction(sqlca);
            DwDetail.SetTransaction(sqlca);

            if (!IsPostBack)
            {
                DwMain.InsertRow(0);
            }
            else
            {
                this.RestoreContextDw(DwMain);
                this.RestoreContextDw(DwDetail);
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
            String invt_id = "";
            try
            {
                invt_id = DwMain.GetItemString(1, "invt_id");
                if (invt_id == "AUTO")
                {
                    n_commonClient com = wcf.NCommon;
                    invt_id = com.of_getnewdocno(state.SsWsPass,state.SsCoopId, "CMDINVT");
                }
                DwMain.SetItemString(1, "invt_id", invt_id);
                DwMain.UpdateData();
                LtServerMessage.Text = WebUtil.CompleteMessage("บันทึกสำเร็จ " + invt_id);
                ResetPage();
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
        }

        #region Extra Function
        private void PostOnInsert()
        {
            DwMain.InsertRow(0);
        }

        private void jsPostFindShow()
        {
            String invt_id = HinvtId.Value;
            DwMain.Retrieve(invt_id);
            DwDetail.Retrieve(invt_id);
        }

        public void ResetPage()
        {
            DwMain.Reset();
            DwDetail.Reset();
            DwMain.InsertRow(0);           
        }
        #endregion

    }
}