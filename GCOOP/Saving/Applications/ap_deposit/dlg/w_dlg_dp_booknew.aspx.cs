using System;
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
//using CoreSavingLibrary.WcfNCommon;
//using CoreSavingLibrary.WcfNDeposit;
using CoreSavingLibrary.WcfNCommon;
using CoreSavingLibrary.WcfNDeposit;
using Sybase.DataWindow;
using DataLibrary;
using CoreSavingLibrary;

namespace Saving.Applications.ap_deposit.dlg
{
    public partial class w_dlg_dp_booknew : PageWebDialog, WebDialog
    {
        protected String newClear;
        protected String postSubmit;
        protected String filterBookNO;

        private n_depositClient ndept;
        private n_commonClient ncommon;
        public void InitJsPostBack()
        {
            newClear = WebUtil.JsPostBack(this, "newClear");
            postSubmit = WebUtil.JsPostBack(this, "postSubmit");
            filterBookNO = WebUtil.JsPostBack(this, "filterBookNO");
        }

        public void WebDialogLoadBegin()
        {
            HdCloseDlg.Value = "false";
            if (!IsPostBack)
            {
                HdDeptAccountNo.Value = Request["deptAccountNo"].Trim();
                DwMain.InsertRow(0);
                try
                {
                    HdLastSeqNo.Value = int.Parse(Request["seqNo"]).ToString();
                    DwMain.SetItemString(1, "as_bookno", Request["deptPassBookNo"].Trim()); 
                }
                catch (Exception ex)
                {
                    LtServerMessage.Text = WebUtil.ErrorMessage("ไม่พบเลขลำดับรายการ");
                }
                //DwUtil.RetrieveDDDW(DwMain, "as_bookno", "dp_slip.pbl", Request["deptTypeCode"].Trim(), state.SsCoopControl);
            }
            else
            {
                this.RestoreContextDw(DwMain);
            }
        }

        public void CheckJsPostBack(string eventArg)
        {
            if (eventArg == "newClear")
            {
                JsNewClear();
            }
            else if (eventArg == "postSubmit")
            {
                JsPostSubmit();
            }
            else if (eventArg == "filterBookNO")
            {
                JsFilterBookNO();
            }
        }

        public void WebDialogLoadEnd()
        {
            try
            {
                DwUtil.RetrieveDDDW(DwMain, "as_bookreson", "dp_slip.pbl", null);
                DwUtil.RetrieveDDDW(DwMain, "as_bookno", "dp_slip.pbl", Request["deptTypeCode"].Trim(),state.SsCoopControl);
                DwMain.SetItemString(1, "as_oldbook", Request["deptPassbookNo"].Trim());

            }
            catch
            {
            }
            DwMain.SaveDataCache();
        }

        private void JsNewClear()
        {
            String oldBook = "";
            String deptTypeCode = "";
            String bookBase = "";
            String bookGrp = "";
            if (IsPostBack)
            {
                DwMain.Reset();
            }
            DwMain.InsertRow(0);
            deptTypeCode = Request["deptTypeCode"];
            DataTable dt = WebUtil.Query("select book_stmbase as bookBase, book_group as bookGrp from dpdepttype where depttype_code='" + deptTypeCode + "'");
            if (dt.Rows.Count > 0)
            {
                bookBase = dt.Rows[0]["bookBase"].ToString().Trim();
                bookGrp = dt.Rows[0]["bookGrp"].ToString().Trim();
            }
            try
            {
                oldBook = Request["deptPassBookNo"].ToString().Trim();
                if (oldBook != "" || oldBook != null)
                {
                    DwMain.SetItemString(1, "as_oldbook", oldBook);
                }
                DwUtil.RetrieveDDDW(DwMain, "as_bookno", "dp_slip.pbl", state.SsCoopId, deptTypeCode);
                DwUtil.RetrieveDDDW(DwMain, "as_bookreson", "dp_slip.pbl", null);
                String sql = "select min(Book_No) as mBN  from DPDEPTBOOKHIS,DPDEPTTYPE where DPDEPTBOOKHIS.Book_Status = '8' and DPDEPTBOOKHIS.Coop_Id = '" + state.SsCoopId + "' and (DPDEPTTYPE.BOOK_GROUP = DPDEPTBOOKHIS.BOOK_GRP) and DPDEPTTYPE.DEPTTYPE_CODE = '" + deptTypeCode + "'";
                DataTable dt2 = WebUtil.Query(sql);
                string as_bookno = dt2.Rows[0]["mBN"].ToString().Trim();
                DwMain.SetItemString(1, "as_bookno", as_bookno);
                DataWindowChild bookNo = DwMain.GetChild("as_bookno");
                bookNo.SetFilter("( book_type ='" + bookBase + "' ) and ( book_grp ='" + bookGrp + "' )");
                bookNo.Filter();

                //try
                //{
                //    if (DwSaving.GetItemString(1, "book_stmbase") != null)
                //    {
                //        String bookType = DwSaving.GetItemString(1, "book_stmbase");
                //        DataWindowChild dc2 = DwSaving.GetChild("book_group");
                //        dc2.SetTransaction(sqlca);
                //        dc2.Retrieve();
                //        dc2.SetFilter("book_type = '" + bookType + "'");
                //        dc2.Filter();
                //    }
                //}
                //catch (Exception)
                //{

                //}
            }
            catch { }
        }

        private void JsPostSubmit()
        {
            int lastSeqNo = -1;
            try
            {
                lastSeqNo = int.Parse(HdLastSeqNo.Value);
            }
            catch
            {
                LtServerMessage.Text = WebUtil.ErrorMessage("ไม่พบเลขลำดับรายการ");
                return;
            }
            //DepositClient dep = wcf.Deposit;
            ndept = wcf.NDeposit;
            String apvId = state.SsUsername;
            String bookNo = DwUtil.GetString(DwMain, 1, "as_bookno", "");
            String reason = DwUtil.GetString(DwMain, 1, "as_bookreson", "");
            short normFlag = 1;
            try
            {
                short printStatus = 1;
                string xml_return = "", xml_return_bf = "";
                short reprint = 1;
                //String resonCode = DwMain.GetItemString(1, "");    // edit by mike ไม่ได้ใช้งาน และทำให้เกิด error
                
                if ((reason == "01"
                       || reason == "02")
                    && state.SsCoopControl == "008001")
                {
                    PostFeeOfBook();
                }

                //ndept.of_print_book_firstpage(state.SsWsPass, HdDeptAccountNo.Value, state.SsCoopId, state.SsWorkDate, state.SsUsername, bookNo, reason, apvId, state.SsPrinterSet, normFlag, reprint, printStatus, ref xml_return, ref xml_return_bf);
                ndept.of_print_book_firstpage(state.SsWsPass, HdDeptAccountNo.Value, state.SsCoopId, state.SsWorkDate, state.SsUsername, bookNo, reason, apvId, normFlag, state.SsPrinterSet, reprint, printStatus, ref xml_return);
               
                if (xml_return != "" && printStatus == 1)
                {
                    UpdateNewBookLastPB( HdDeptAccountNo.Value, lastSeqNo);
                    Printing.DeptPrintBookFirstPage(this, xml_return);                  


                    HdCloseDlg.Value = "true";
                }
           //     HdCloseDlg.Value = "true";
            }
            catch (Exception ex)
            {
                Label1.Text = WebUtil.ErrorMessage(ex);
            }
        }

        private void JsFilterBookNO()
        {

        }
        private void PostFeeOfBook()
        {
             ncommon = wcf.NCommon;
            string member_no ="" ;
            string deptname = "";
            DataTable dt = WebUtil.Query("select member_no,deptaccount_name from dpdeptmaster where deptaccount_no='" + HdDeptAccountNo.Value + "'");
            if (dt.Rows.Count > 0)
            {
                member_no = dt.Rows[0]["member_no"].ToString().Trim();
                deptname = dt.Rows[0]["deptaccount_name"].ToString();
            }
            string ss = state.SsWorkDate.ToString().Substring(0, 10).Trim();
           // string ls_finslipno = ncommon.GetNewDocNo(state.SsWsPass, "FNRECEIVENO");
            string ls_finslipno = ncommon.of_getnewdocno(state.SsWsPass, state.SsCoopControl, "FNRECEIVENO");
            String sqlInsert = @"INSERT INTO FINSLIP
                                (COOP_ID,slip_no,entry_id,entry_date,operate_date,from_system,payment_status,cash_type,payment_desc,
                                 itempay_amt,member_no ,itempaytype_code,pay_recv_status,member_flag,nonmember_detail,machine_id,tofrom_accid,account_no,remark,ref_system                       
                                ) 
                                VALUES 
                                ('" + state.SsCoopId + "','" + ls_finslipno + "','" + state.SsUsername + "',to_date('" + state.SsWorkDate.ToString().Substring(0,10).Trim() + "','mm/dd/yyyy'),to_date('" +
                                    state.SsWorkDate.ToString().Substring(0, 10).Trim() + "','mm/dd/yyyy')" + ",'DEP','" + 8 + "','CSH','ค่าปรับสมุดบัญชีใหม่','" + 50 + "','" + member_no + "','" +
                                "FEE','"+ 0 + "','"+1+"','"+deptname+"','"+state.SsClientIp+"','11030100','"+HdDeptAccountNo.Value+"','" + HdDeptAccountNo.Value + "','DEP')";
            Sta taInsert = new Sta(state.SsConnectionString);
            int result = taInsert.Exe(sqlInsert);

        }

        public int UpdateNewBookLastPB(string deptAccountNo, int seqNo)
        {
           // Security sec = new Security(wsPass);
            //Sta ta = new Sta(sec.ConnectionString);
            try
            {
                int seqNew = seqNo - 1;
                seqNew = seqNew < 0 ? 0 : seqNew; //ถ้าน้อยกว่า 0 ให้เป็น 0

                String sql = "update dpdeptmaster set lastrec_no_pb = " + seqNew + ", lastline_no_pb = 1, lastpage_no_pb = 1 where coop_id = '" + state.SsCoopControl + "' and deptaccount_no='" + deptAccountNo + "'";
               // int ii = ta.Exe(sql);
                Sdt dt = WebUtil.QuerySdt(sql);
                //if (ii < 1)
                //{
                //    throw new Exception("ไม่พบการ update lastrec_no_pb " + deptAccountNo);
                //}
                //ta.Close();
            }
            catch (Exception ex)
            {
               // ta.Close();
                throw ex;
            }
            return 1;
        }
    }
}