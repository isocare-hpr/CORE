using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
//using CoreSavingLibrary.WcfShrlon;
using CoreSavingLibrary.WcfNShrlon;
using System.Drawing;
using CoreSavingLibrary;


namespace Saving.Applications.mbshr.ws_sl_share_withdraw_ctrl
{
    public partial class ws_sl_share_withdraw : PageWebSheet, WebSheet
    {
        [JsPostBack]
        public string PostCheckSelect { get; set; }
        [JsPostBack]
        public string PostShowData { get; set; }
        [JsPostBack]
        public string PostListMemberNo { get; set; }
        [JsPostBack]
        public string Postmember_serach { get; set; }
        [JsPostBack]
        public string PostPrintSlippayin { get; set; }

        public void InitJsPostBack()
        {
            dsMain.InitDsMain(this);
            dsList.InitDsList(this);
        }

        public void WebSheetLoadBegin()
        {
            if (!IsPostBack)
            {
                //String xmlList = wcf.NShrlon.InitShareWithdrawList(state.SsWsPass, state.SsCoopControl);
                //String xmlList = wcf.NShrlon.of_initlist_shrwtd(state.SsWsPass, state.SsCoopControl);
                //dsList.ImportData(xmlList);
                dsMain.RetrieveCoop();
                dsMain.DATA[0].coop_id = state.SsCoopId;
                dsList.RetrieveList(dsMain.DATA[0].coop_id);
                Hdrow_member.Value = "-1";
            }
        }

        public void CheckJsPostBack(string eventArg)
        {
            if (eventArg == PostShowData)
            {
                //String xmlList = wcf.NShrlon.InitShareWithdrawList(state.SsWsPass, state.SsCoopControl);
                //String xmlList = wcf.NShrlon.of_initlist_shrwtd(state.SsWsPass, state.SsCoopControl);
                //dsList.ImportData(xmlList);
                dsList.RetrieveList(dsMain.DATA[0].coop_id);
            }
            else if (eventArg == PostCheckSelect)
            {
                if (dsMain.DATA[0].checkselect == 0)
                {
                    for (int i = 0; i < dsList.RowCount; i++)
                    {
                        dsList.SetItem(i, dsList.DATA.OPERATE_FLAGColumn, 0);
                    }
                }
                else if (dsMain.DATA[0].checkselect == 1)
                {
                    for (int i = 0; i < dsList.RowCount; i++)
                    {
                        dsList.SetItem(i, dsList.DATA.OPERATE_FLAGColumn, 1);
                    }
                }
            }
            else if (eventArg == Postmember_serach)
            {
                int index_row = Convert.ToInt16(Hdrow_member.Value);
                setcolordefault();
                setcolor_row(index_row);
                Hdrow_member.Value = Convert.ToString(index_row);
                dsMain.DATA[0].MEMBER_NO = Hdmember_no.Value;
            }
            else if (eventArg == PostPrintSlippayin)
            {
                string payinslip_no = HdSlipno.Value;
                Printing.PrintSlipSlInIreportTnt(this, payinslip_no, state.SsCoopId);
            }
        }

        public void SaveWebSheet()
        {

        }

        public void WebSheetLoadEnd()
        {

            if (state.SsCoopControl == "013001")//GSB
            {
                if (HdSlipno.Value == "")
                {
                    dsMain.FindButton(0, "b_print").Style.Add(HtmlTextWriterStyle.Visibility, "hidden");
                }
                else
                {
                    dsMain.FindButton(0, "b_print").Style.Add(HtmlTextWriterStyle.Visibility, "visible");
                }
            }
            else
            {
                dsMain.FindButton(0, "b_print").Style.Add(HtmlTextWriterStyle.Visibility, "hidden");
            }
        }

        private void setcolor_row(int index_row)
        {
            Color myRgbColor = new Color();
            myRgbColor = Color.FromArgb(92, 172, 238);

            dsList.FindTextBox(index_row, "sharetype_code").BackColor = myRgbColor;
            dsList.FindTextBox(index_row, "member_no").BackColor = myRgbColor;
            dsList.FindTextBox(index_row, "cp_mbname").BackColor = myRgbColor;
            dsList.FindTextBox(index_row, "membgroup_code").BackColor = myRgbColor;
            dsList.FindTextBox(index_row, "resign_date").BackColor = myRgbColor;
            dsList.FindTextBox(index_row, "cp_shareamt").BackColor = myRgbColor;
            dsList.FindTextBox(index_row, "cp_sharemasterstatus").BackColor = myRgbColor;
            dsList.FindCheckBox(index_row, "operate_flag").BackColor = myRgbColor;

        }

        private void setcolordefault()
        {
            Color myRgbColor = new Color();
            myRgbColor = Color.FromArgb(255, 255, 255);
            for (int i = 0; i < dsList.RowCount; i++)
            {
                dsList.FindTextBox(i, "sharetype_code").BackColor = myRgbColor;
                dsList.FindTextBox(i, "member_no").BackColor = myRgbColor;
                dsList.FindTextBox(i, "cp_mbname").BackColor = myRgbColor;
                dsList.FindTextBox(i, "membgroup_code").BackColor = myRgbColor;
                dsList.FindTextBox(i, "resign_date").BackColor = myRgbColor;
                dsList.FindTextBox(i, "cp_shareamt").BackColor = myRgbColor;
                dsList.FindTextBox(i, "cp_sharemasterstatus").BackColor = myRgbColor;
                dsList.FindCheckBox(i, "operate_flag").BackColor = myRgbColor;
            }
        }
    }
}