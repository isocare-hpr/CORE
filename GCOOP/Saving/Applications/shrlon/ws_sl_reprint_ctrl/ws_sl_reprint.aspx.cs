using System;
using CoreSavingLibrary;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Globalization;
using DataLibrary;

namespace Saving.Applications.shrlon
{
    public partial class ws_sl_reprint : PageWebSheet, WebSheet
    {
        [JsPostBack]
        public string PostRetrieve { get; set; }
        [JsPostBack]
        public string PostPrint { get; set; }

        public void InitJsPostBack()
        {
            dsMain.InitDsMain(this);
            dsList.InitDsList(this);
        }

        public void WebSheetLoadBegin()
        {
            if (!IsPostBack)
            {
                dsMain.DdCode();
            }
        }

        public void CheckJsPostBack(string eventArg)
        {
            if (eventArg == PostRetrieve)
            {
                try
                {
                    string member_no = "";
                    string entry_id = "";
                    string sliptype_code = "";
                    string document_no_s = "";
                    string document_no_e = "";
                    DateTime slip_date_s = dsMain.DATA[0].SLIP_DATE_S;
                    DateTime slip_date_e = dsMain.DATA[0].SLIP_DATE_E;

                    member_no = dsMain.DATA[0].MEMBER_NO;
                    entry_id = dsMain.DATA[0].ENTRY_ID;
                    sliptype_code = dsMain.DATA[0].SLIPTYPE_CODE;
                    document_no_s = dsMain.DATA[0].document_no_e;
                    document_no_e = dsMain.DATA[0].document_no_e;

                    dsList.Retrieve(member_no, entry_id, sliptype_code, document_no_s, document_no_e, slip_date_s, slip_date_e);
                    int row = dsList.RowCount;
                    for (int i = 0; i < row; i++)
                    {
                        decimal slip_status = dsList.DATA[i].SLIP_STATUS;
                        if (slip_status < 0)
                        {                            
                            dsList.FindTextBox(i, "COMPUTE_1").BackColor = System.Drawing.Color.DarkGray;
                            dsList.FindTextBox(i, "document_no").BackColor = System.Drawing.Color.DarkGray;
                            dsList.FindTextBox(i, "slip_date").BackColor = System.Drawing.Color.DarkGray;
                            dsList.FindTextBox(i, "entry_date").BackColor = System.Drawing.Color.DarkGray;
                            dsList.FindTextBox(i, "member_no").BackColor = System.Drawing.Color.DarkGray;
                            dsList.FindTextBox(i, "COMPUTE_2").BackColor = System.Drawing.Color.DarkGray;
                            dsList.FindTextBox(i, "entry_id").BackColor = System.Drawing.Color.DarkGray;
                        }
                    }
                }
                catch { }
            }
            else if (eventArg == PostPrint)
            {
                string rslip = "";
                int[] prt_arr = new int[dsList.RowCount];

                for (int i = 0; i < dsList.RowCount; i++)
                {
                    if (dsList.DATA[i].checkselect == 1)
                    {
                        if (rslip == "")
                        {
                            rslip = "'" + dsList.DATA[i].PAYINSLIP_NO + "'";
                        }
                        else
                        {
                            rslip += ",'" + dsList.DATA[i].PAYINSLIP_NO + "'";
                        }                            
                    }
                }
                if (state.SsCoopId == "008001")
                {
                    Printing.RePrintSlippayinPEA(this, rslip, state.SsCoopControl);
                   
                }
                else
                {
                    Printing.RePrintSlipSlpayin(this, rslip, state.SsCoopControl);
                }                  
            }
        }

        private static string XmlReadVar(string responseData, string szVar)
        {
            int i1stLoc = responseData.IndexOf("<" + szVar + ">");
            if (i1stLoc < 0)
                return string.Empty;
            int ilstLoc = responseData.IndexOf("</" + szVar + ">");
            if (ilstLoc < 0)
                return string.Empty;
            int len = szVar.Length;
            return responseData.Substring(i1stLoc + len + 2, ilstLoc - i1stLoc - len - 2);
        }

        public void SaveWebSheet()
        {

        }

        public void WebSheetLoadEnd()
        {

        }
    }
}
