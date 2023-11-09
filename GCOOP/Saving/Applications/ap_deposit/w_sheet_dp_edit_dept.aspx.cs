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
//using CoreSavingLibrary.WcfNDeposit; 
//using CoreSavingLibrary.WcfNCommon;

using CoreSavingLibrary.WcfNDeposit; //new deposit
using CoreSavingLibrary.WcfNCommon; //new common
using System.Web.Services.Protocols;

using Sybase.DataWindow;

namespace Saving.Applications.ap_deposit
{
    public partial class w_sheet_dp_edit_dept : PageWebSheet, WebSheet
    {
        protected String FilterBankBranch;
        protected String FilterProvince;
        protected String FilterDistrict;
        protected String postAccountNo;
        protected String postAddRow;
        protected String postChangeTran;
        protected String postChangeDwTabCon;
        protected String postExpenseAcc;
        protected String postMemberNo;
        protected String postChangeTranDeptAcc;
        protected String postPostOffice;
        //private DepositClient depServ;

        private n_depositClient ndept; //new deposit
        private String memNo;
        private String accNo;
        protected String CheckCoop;
        protected String setCoopname;

        private void JsPostExpenseAcc()
        {
            String postExAcc = DwMain.GetItemString(1, "expense_accno");
            postExAcc = ndept.of_analizeaccno(state.SsWsPass, postExAcc);

            //postExAcc = depServ.BaseFormatAccountNo(state.SsWsPass, postExAcc);
            DwTabTran.SetItemString(1, "expense_accno", postExAcc);
        }

        private void JsPostAddRow()
        {
            int seqNo = 0;
            int rowNew = DwTabEditCo.RowCount + 1;
            DwTabEditCo.InsertRow(rowNew);
            String deptAcc = DwMain.GetItemString(1, "deptaccount_no");
            //deptAcc = depServ.BaseFormatAccountNo(state.SsWsPass, deptAcc);
            deptAcc = ndept.of_analizeaccno(state.SsWsPass, deptAcc);

            for (int i = 1; i <= DwTabEditCo.RowCount; i++)
            {
                seqNo++;
                DwTabEditCo.SetItemDecimal(i, "seq_no", seqNo);
                DwTabEditCo.SetItemString(i, "deptaccount_no", deptAcc);
                DwTabEditCo.SetItemString(i, "coop_id", state.SsCoopControl);
            }
        }

        private void JspostChangeTran()
        {
            string expenseCode;
            expenseCode = DwTabTran.GetItemString(1, "expense_code");

            String dwAccNo = DwMain.GetItemString(1, "deptaccount_no");
            //accNo = depServ.BaseFormatAccountNo(state.SsWsPass, dwAccNo);

            accNo = ndept.of_analizeaccno(state.SsWsPass, dwAccNo);

            if (expenseCode == "TRN")
            {
                DwTabTran.Modify("expense_accno.protect=0");
                DwTabTran.Modify("expense_amount.protect=0");
            }
            else
            {
                DwTabTran.Modify("expense_accno.protect=1");
                DwTabTran.Modify("expense_amount.protect=1");
                DwTabTran.SetItemString(1, "expense_accno", null);
                DwTabTran.SetItemDecimal(1, "expense_amount", 0);
            }

            DwTabTran.SetItemString(1, "deptaccount_no", accNo);
            DwTabTran.SetItemString(1, "coop_id", state.SsCoopControl);
        }

        private void JsPostAccountNo()
        {
            string membName = "";
            string membSurname = "";
            try
            {
                String dwAccNo = DwMain.GetItemString(1, "deptaccount_no");
                //accNo = depServ.BaseFormatAccountNo(state.SsWsPass, dwAccNo);

                accNo = ndept.of_analizeaccno(state.SsWsPass, dwAccNo);
                DwMain.Reset();
                int rowRetrieve = DwMain.Retrieve(accNo, HfCoopid.Value);

                DwTabMem.Reset();
                DwTabAddress.Reset();
                DwTabCond.Reset();

                if (rowRetrieve > 0)
                {
                    DwMain.SetItemString(1, "deptaccount_no", accNo);
                    DwMain.Modify("deptaccount_no.EditMask.Mask='" + WebUtil.GetDeptCodeMask() + "'");

                    memNo = DwMain.GetItemString(1, "member_no");

                    DwTabMem.Retrieve(accNo, HfCoopid.Value);

                    try
                    {
                        membName = DwTabMem.GetItemString(1, "memb_name");
                        membSurname = DwTabMem.GetItemString(1, "memb_surname");
                        DwTabMem.SetItemString(1, "member_name", membName + ' ' + membSurname);
                    }
                    catch (Exception)
                    {
                        membName = "";
                        membSurname = "";
                    }

                    DwTabAddress.Retrieve(memNo, HfCoopid.Value);

                    DwTabEditCo.Retrieve(accNo, HfCoopid.Value);

                    DwTabCond.Retrieve(accNo, HfCoopid.Value);
                    //DwTabCond.SetItemString(1, "deptaccount_no", accNo);
                    //DwTabCond.SetItemString(1, "branch_id", HfCoopid.Value);

                    DwTabTran.Retrieve(accNo, HfCoopid.Value);
                }
                else
                {
                    DwMain.InsertRow(0);
                    LtServerMessage.Text = WebUtil.ErrorMessage("ไม่มีเลขที่บัญชี : " + accNo);
                }

            }
            catch (Exception ex)
            {
                LtServerMessage.Text = WebUtil.ErrorMessage(ex);
            }
        }

        private void JsPostPostOffice()
        {
            try
            {
                String postCode = DwTabCond.GetItemString(1, "tran_deptacc_no").Trim();
                String sql = "select membgroup_desc from mbucfmembgroup where membgroup_code = '" + postCode + "'";
                DataTable dt = WebUtil.Query(sql);
                if (dt.Rows.Count > 0)
                {
                    DwTabCond.SetItemString(1, "dept_tranacc_name", dt.Rows[0][0].ToString().Trim());
                }
                else
                {
                    DwTabCond.SetItemString(1, "dept_tranacc_name", "");
                    throw new Exception("ไม่พบรหัสปณ. : " + postCode);
                }
            }
            catch (Exception ex)
            {
                LtServerMessage.Text = WebUtil.WarningMessage(ex);
            }
        }

        private void JspostChangeDwTabCon()
        {
            decimal rateStatus = DwTabCond.GetItemDecimal(1, "spcint_rate_status");
            decimal monthIntPay = DwTabCond.GetItemDecimal(1, "monthintpay_meth");
            decimal taxStatus = DwTabCond.GetItemDecimal(1, "taxspcrate_status");
            //rateStatus
            if (rateStatus == 1)
            {
                DwTabCond.Modify("spcint_rate.protect=0");
            }
            else if (rateStatus == 2)
            {
                DwTabCond.SetItemDecimal(1, "spcint_rate", 0);
            }
            else
            {
                DwTabCond.SetItemDecimal(1, "spcint_rate", 0);
            }
            //monthIntPay
            if (monthIntPay == 1)
            {
                DwTabCond.SetItemString(1, "tran_bankacc_no", null);
            }
            else if (monthIntPay == 2)
            {
                DwTabCond.SetItemString(1, "tran_bankacc_no", null);
            }
            else if (monthIntPay == 3)
            {
            }
            else if (monthIntPay == 0)
            {
                DwTabCond.SetItemString(1, "tran_bankacc_no", "");
                DwTabCond.SetItemString(1, "dept_tranacc_name", null);
                DwTabCond.SetItemString(1, "bank_code", null);
                DwTabCond.SetItemString(1, "bank_branch", null);
            }
            //taxStatus
            if (taxStatus == 1)
            {
            }
            else
            {
                DwTabCond.SetItemDecimal(1, "f_tax_rate", 0);
            }
        }

        private void JspostMemberNo()
        {

            string memberNo = DwTabMem.GetItemString(1, "member_no");
            if (memberNo != null && memberNo != "")
            {
                try
                {
                    DataTable dt = WebUtil.Query(
                        "select a.memb_name || ' ' || a.memb_surname as \"fullname\" from mbmembmaster a" + @"
                        where a.member_no = '" + memberNo + "' ");

                    if (dt.Rows.Count > 0)
                    {
                        DwTabMem.SetItemString(1, "member_name", dt.Rows[0]["fullname"].ToString());
                    }
                }

                catch (Exception ex) { ex.ToString(); }

            }
            DwTabAddress.Reset();
            DwTabAddress.Retrieve(memberNo, HfCoopid.Value);
        }

        private void JsFilterBankBranch()
        {
            String bankCode = DwTabCond.GetItemString(1, "bank_code");
            DataWindowChild dc = DwTabCond.GetChild("bank_branch");
            dc.SetTransaction(sqlca);
            dc.Retrieve();
            dc.SetFilter("bank_code = '" + bankCode + "'");
            dc.Filter();
        }

        private void JsFilterProvince()
        {
            int Row = Convert.ToInt16(HdRowEditCo.Value);
            try
            {
                if (DwTabEditCo.GetItemString(1, "province") != null)
                {

                    String provinceCode = DwTabEditCo.GetItemString(Row, "province");
                    DataWindowChild dc2 = DwTabEditCo.GetChild("district");
                    dc2.SetTransaction(sqlca);
                    dc2.Retrieve();
                    dc2.SetFilter("province_code = '" + provinceCode + "'");
                    dc2.Filter();
                }
            }
            catch (Exception)
            {

            }
        }

        private void JsFilterDistrict()
        {
            int Row = Convert.ToInt16(HdRowEditCo.Value);
            try
            {
                if (DwTabEditCo.GetItemString(1, "district") != null)
                {
                    String districtCode = DwTabEditCo.GetItemString(Row, "district");
                    DataWindowChild dc2 = DwTabEditCo.GetChild("tumbol");
                    dc2.SetTransaction(sqlca);
                    dc2.Retrieve();
                    dc2.SetFilter("district_code = '" + districtCode + "'");
                    dc2.Filter();
                }
            }
            catch (Exception)
            {

            }
        }

        private void JspostChangeTranDeptAcc()
        {
            //string tranAccNo = depServ.BaseFormatAccountNo(state.SsWsPass, DwTabCond.GetItemString(1, "tran_deptacc_no"));

            string tranAccNo = ndept.of_analizeaccno(state.SsWsPass, DwTabCond.GetItemString(1, "tran_deptacc_no").Trim()).Trim();
            DwTabCond.SetItemString(1, "tran_deptacc_no", tranAccNo);
            if (tranAccNo != null && tranAccNo != "")
            {
                try
                {

                    DataTable dt = WebUtil.Query(
                        "select dept_tranacc_name as \"name\" from dpdeptmaster" + @"
                        where deptaccount_no = '" + tranAccNo + "' ");
                    if (dt.Rows.Count > 0)
                    {
                        DwTabCond.SetItemString(1, "dept_tranacc_name", dt.Rows[0]["name"].ToString());
                    }
                }
                catch (Exception) { }
            }
        }

        private void checkCoop()
        {
            decimal i = 0;
            decimal crossflag = DwListCoop.GetItemDecimal(1, "cross_coopflag");
            if (crossflag == 1)
            {
                try
                {
                    i = DwListCoop.GetItemDecimal(1, "cross_coopflag");
                }
                catch
                { }
                JsClear();
                DwUtil.RetrieveDDDW(DwListCoop, "dddwcoopname", "cm_constant_config.pbl", state.SsCoopControl, state.SsCoopControl);
            }
            else
            {
                try
                {
                    JsClear();
                    HfCoopid.Value = state.SsCoopControl;
                }
                catch
                { }
            }
        }

        private void JsSetCoopname()
        {
            String Coopid = HfCoopid.Value;
            String Coopname;
            DataTable dt = WebUtil.Query("select coop_name from cmcoopmaster where coop_id ='" + Coopid + "'");
            if (dt.Rows.Count > 0)
            {
                Coopname = dt.Rows[0]["coop_name"].ToString();
                DwListCoop.SetItemDecimal(1, "cross_coopflag", 1);
                DwUtil.RetrieveDDDW(DwListCoop, "dddwcoopname", "cm_constant_config.pbl", state.SsCoopControl, state.SsCoopControl);
                DwListCoop.SetItemString(1, "dddwcoopname", Coopname);
            }

            if (HfDlg.Value == "AccountDlg")
            {
                JsPostAccountNo();
            }
            else if (HfDlg.Value == "MemberDlg")
            {
                JspostMemberNo();
            }
        }

        private void JsClear()
        {
            DwMain.Reset();
            DwTabMem.Reset();
            DwTabAddress.Reset();
            DwTabEditCo.Reset();
            DwTabCond.Reset();
            DwTabTran.Reset();

            DwMain.InsertRow(0);
        }

        #region WebSheet Members

        public void InitJsPostBack()
        {
            
            postAccountNo = WebUtil.JsPostBack(this, "postAccountNo");
            postAddRow = WebUtil.JsPostBack(this, "postAddRow");
            postChangeTran = WebUtil.JsPostBack(this, "postChangeTran");
            postExpenseAcc = WebUtil.JsPostBack(this, "postExpenseAcc");
            postChangeDwTabCon = WebUtil.JsPostBack(this, "postChangeDwTabCon");
            postMemberNo = WebUtil.JsPostBack(this, "postMemberNo");
            postChangeTranDeptAcc = WebUtil.JsPostBack(this, "postChangeTranDeptAcc");
            FilterBankBranch = WebUtil.JsPostBack(this, "FilterBankBranch");
            FilterProvince = WebUtil.JsPostBack(this, "FilterProvince");
            FilterDistrict = WebUtil.JsPostBack(this, "FilterDistrict");
            postPostOffice = WebUtil.JsPostBack(this, "postPostOffice");
            CheckCoop = WebUtil.JsPostBack(this, "CheckCoop");
            setCoopname = WebUtil.JsPostBack(this, "setCoopname");
        }

        public void WebSheetLoadBegin()
        {
            this.ConnectSQLCA();
            //depServ = wcf.Deposit;
            ndept = wcf.NDeposit;
            DwMain.SetTransaction(sqlca);

            DwTabMem.SetTransaction(sqlca);
            DwTabAddress.SetTransaction(sqlca);

            DwTabEditCo.SetTransaction(sqlca);
            DwTabCond.SetTransaction(sqlca);
            DwTabTran.SetTransaction(sqlca);

            //try
            //{
            //DwMain.Modify("deptaccount_no.EditMask.Mask='" + depServ.GetDeptCodeMask(state.SsWsPass) + "'");
            //DwTabTran.Modify("expense_accno.EditMask.Mask='" + depServ.GetDeptCodeMask(state.SsWsPass) + "'");
            //DwTabCond.Modify("tran_bankacc_no.EditMask.Mask='" + depServ.GetDeptCodeMask(state.SsWsPass) + "'");
            //}
            //catch (Exception ex) { ex.ToString(); }

            if (!IsPostBack)
            {
                DwMain.InsertRow(0);
                DwListCoop.InsertRow(0);

                HfCoopid.Value = state.SsCoopControl;
            }
            else
            {
                this.RestoreContextDw(DwMain);
                this.RestoreContextDw(DwTabMem);
                this.RestoreContextDw(DwTabAddress);
                this.RestoreContextDw(DwTabEditCo);
                this.RestoreContextDw(DwTabCond);
                this.RestoreContextDw(DwTabTran);
                this.RestoreContextDw(DwListCoop);
            }
        }

        public void CheckJsPostBack(string eventArg)
        {
            switch (eventArg)
            {
                case "postAccountNo": JsPostAccountNo(); break;
                case "postAddRow": JsPostAddRow(); break;
                case "postExpenseAcc": JsPostExpenseAcc(); break;
                case "postChangeTran": JspostChangeTran(); break;
                case "postChangeDwTabCon": JspostChangeDwTabCon(); break;
                case "postMemberNo": JspostMemberNo(); break;
                case "postChangeTranDeptAcc": JspostChangeTranDeptAcc(); break;
                case "FilterBankBranch": JsFilterBankBranch(); break;
                case "FilterProvince": JsFilterProvince(); break;
                case "FilterDistrict": JsFilterDistrict(); break;
                case "postPostOffice": JsPostPostOffice(); break;
                case "CheckCoop": checkCoop(); break;
                case "setCoopname": JsSetCoopname(); break;
            }
        }

        public void SaveWebSheet()
        {
            try
            {
                String deptAccNo = DwMain.GetItemString(1, "deptaccount_no");
                if (deptAccNo != "" && deptAccNo != null)
                {
                    DwTabCond.SetItemString(1, "update_byentryid", state.SsUsername);
                    DwTabCond.SetItemString(1, "update_byentryip", state.SsClientIp);
                    DwMain.SetItemString(1, "update_byentryid", state.SsUsername);
                    DwMain.SetItemString(1, "update_byentryip", state.SsClientIp);
                    DwTabMem.SetItemString(1, "update_byentryid", state.SsUsername);
                    DwTabMem.SetItemString(1, "update_byentryip", state.SsClientIp);

                    DwMain.UpdateData();
                    DwTabEditCo.UpdateData();
                    DwTabCond.UpdateData();
                    DwTabTran.UpdateData();
                    DwTabMem.UpdateData();
                    LtServerMessage.Text = WebUtil.CompleteMessage("บันทึกข้อมูลเสร็จสิ้น");
                }
            }
            catch (Exception ex)
            {
                LtServerMessage.Text = WebUtil.ErrorMessage(ex.Message);
            }
        }

        public void WebSheetLoadEnd()
        {
            DwMain.SaveDataCache();
            DwTabMem.SaveDataCache();
            DwTabAddress.SaveDataCache();
            DwTabEditCo.SaveDataCache();
            DwTabCond.SaveDataCache();
            DwTabTran.SaveDataCache();
            DwListCoop.SaveDataCache();
        }

        #endregion
    }
}
