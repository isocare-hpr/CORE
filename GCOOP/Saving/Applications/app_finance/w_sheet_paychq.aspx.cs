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
using CoreSavingLibrary.WcfNCommon;
using Sybase.DataWindow;
using CoreSavingLibrary.WcfNFinance;
using System.Web.Services.Protocols;

namespace Saving.Applications.app_finance
{
    public partial class w_sheet_paychq : PageWebSheet, WebSheet
    {
        private n_commonClient com;
        private n_financeClient fin;
        private DwThDate tDwMain;
        private DwThDate tDwDateSearch;
        private String pbl = "paychq.pbl";
        protected String postInit;
        protected String postSearch;
        protected String postGetChqBook;
        protected String postSumChqList;
        protected String postBankBranch;


        #region WebSheet Members

        public void InitJsPostBack()
        {
            tDwMain = new DwThDate(DwMain, this);
            tDwMain.Add("cheque_date", "cheque_tdate");
            tDwDateSearch = new DwThDate(DwDateSearch, this);
            tDwDateSearch.Add("start_date", "start_tdate");
            postInit = WebUtil.JsPostBack(this, "postInit");
            postSearch = WebUtil.JsPostBack(this, "postSearch");
            postGetChqBook = WebUtil.JsPostBack(this, "postGetChqBook");
            postBankBranch = WebUtil.JsPostBack(this, "postBankBranch");
            postSumChqList = WebUtil.JsPostBack(this, "postSumChqList");
        }

        public void WebSheetLoadBegin()
        {
            com = wcf.NCommon;
            fin = wcf.NFinance;

            if (!IsPostBack)
            {
                Int32 resultXml;
                String mainXml = "", chqlistXml = "";
                resultXml = fin.of_init_paychq(state.SsWsPass, state.SsCoopId, state.SsWorkDate,ref mainXml,ref chqlistXml);

                DwDateSearch.InsertRow(0);
                DwMain.ImportString(mainXml, FileSaveAsType.Xml);
                if (chqlistXml != "")
                {
                    DwDetail.ImportString(chqlistXml, FileSaveAsType.Xml);
                }
                tDwMain.Eng2ThaiAllRow();
                DwDateSearch.SetItemDateTime(1, "start_date", state.SsWorkDate);
                tDwDateSearch.Eng2ThaiAllRow();

                DwUtil.RetrieveDDDW(DwMain, "frombank", "paychq.pbl", null);
                DwUtil.RetrieveDDDW(DwMain, "bank_code", "paychq.pbl", null);
                DwUtil.RetrieveDDDW(DwMain, "cheque_type", "paychq.pbl", state.SsCoopId);
                DwUtil.RetrieveDDDW(DwMain, "as_tofromaccid", "paychq.pbl", "CHQ");
            }
            else
            {
                this.RestoreContextDw(DwMain);
                this.RestoreContextDw(DwDetail);
                this.RestoreContextDw(DwDateSearch);
            }
        }

        public void CheckJsPostBack(string eventArg)
        {
            switch (eventArg)
            {
                case "postBankBranch":
                    GetBankBranch();
                    break;
                case "postGetChqBook":
                    GetChqBook();
                    break;
                case "postInit":
                    GetInit();
                    break;
                case "postSumChqList":
                    SumChqList();
                    break;
                case "postSearch":
                    Search();
                    break;
            }
        }

        //public void SaveWebSheet()
        //{
        //    String ls_main_xml, ls_chqlist_xml;

        //    ls_main_xml = DwMain.Describe("DataWindow.Data.XML");
        //    ls_chqlist_xml = DwDetail.Describe("DataWindow.Data.XML");

        //    try
        //    {
        //        String re = fin.OfPostPayChq(state.SsWsPass, state.SsCoopId, state.SsUsername, state.SsWorkDate, state.SsClientIp, ls_main_xml, ls_chqlist_xml, state.SsPrinterSet);

        //        if (re == "1")
        //        {
        //            LtServerMessage.Text = WebUtil.CompleteMessage("บันทึกเรียบร้อย");

        //            String[] result;
        //            result = fin.OfInitPayChq(state.SsWsPass, state.SsCoopId, state.SsWorkDate);
        //            DwMain.Reset();
        //            DwDetail.Reset();
        //            DwMain.ImportString(result[0], FileSaveAsType.Xml);
        //            DwDetail.ImportString(result[1], FileSaveAsType.Xml);
        //            tDwMain.Eng2ThaiAllRow();
        //        }
        //    }
        //    catch (SoapException ex)
        //    {
        //        LtServerMessage.Text = WebUtil.ErrorMessage(WebUtil.SoapMessage(ex));
        //    }
        //    catch (Exception ex)
        //    {
        //        LtServerMessage.Text = WebUtil.ErrorMessage(ex.Message);
        //    }
        //}


        public void SaveWebSheet()
        {
            String ls_main_xml, ls_chqlist_xml, slipStr , formSet = "",ls_chqtype_xml = "";
            formSet = DdPrintSetProfile.SelectedValue.ToString().Trim();
            tDwMain.Eng2ThaiAllRow();
            ls_main_xml = DwMain.Describe("DataWindow.Data.XML");
            ls_chqlist_xml = DwDetail.Describe("DataWindow.Data.XML");
            slipStr = "";
            DwDetail.SetFilter("ai_chqflag = 1");
            DwDetail.Filter();
            for (int i = 1; i <= DwDetail.RowCount; i++)
            {
                slipStr += DwDetail.GetItemString(i, "slip_no").Trim() + ",";
            }
            if (slipStr != "")
            {
                slipStr = slipStr.Trim();
                String simbol = "";
                int Len = slipStr.Length;
                simbol = slipStr.Substring(Len - 1, 1);
                if (simbol == ",")
                {
                    Len = Len - 1;
                    slipStr = slipStr.Substring(0, Len);
                }
            }
            try
            {
                String re = fin.of_postpaychq_fromslip(state.SsWsPass, state.SsCoopId, state.SsUsername, state.SsWorkDate, state.SsClientIp, ls_main_xml, slipStr, ls_chqtype_xml,ls_chqlist_xml, formSet);

                if (re == "1")
                {
                    LtServerMessage.Text = WebUtil.CompleteMessage("บันทึกเรียบร้อย");

                    Int32 result;
                    result = fin.of_init_paychq(state.SsWsPass, state.SsCoopId, state.SsWorkDate, ref ls_main_xml, ref ls_chqlist_xml);
                    DwMain.Reset();
                    DwDetail.Reset();
                    DwMain.ImportString(ls_main_xml, FileSaveAsType.Xml);
                    if (ls_chqlist_xml != "")
                    {
                        DwDetail.ImportString(ls_chqlist_xml, FileSaveAsType.Xml);
                    }
                    tDwMain.Eng2ThaiAllRow();
                }
            }
            catch (SoapException ex)
            {
                LtServerMessage.Text = WebUtil.ErrorMessage(WebUtil.SoapMessage(ex));
            }
            catch (Exception ex)
            {
                LtServerMessage.Text = WebUtil.ErrorMessage(ex.Message);
            }
        }

        public void WebSheetLoadEnd()
        {
            DwMain.SaveDataCache();
            DwDetail.SaveDataCache();
            DwDateSearch.SaveDataCache();
        }

        #endregion


        private void Search()
        {
            String ls_chqlist_xml = "";
            Int32 result;
            DateTime Start_date;

            Start_date = DwDateSearch.GetItemDateTime(1, "start_date");

            result = fin.of_retrievepaychqlist(state.SsWsPass, state.SsCoopId, Start_date, ref ls_chqlist_xml);
            DwDetail.Reset();
            if (ls_chqlist_xml != "")
            {
                DwDetail.ImportString(ls_chqlist_xml, FileSaveAsType.Xml);
            }
        }

        private void GetInit()
        {
            try
            {
                Int32 result;
                String ls_bank, ls_bankbranch, ls_chqbookno,accno = "",startchqno = "";

                ls_bank = DwMain.GetItemString(1, "bank_code").Trim();
                ls_bankbranch = DwMain.GetItemString(1, "bank_branch").Trim();
                ls_chqbookno = DwMain.GetItemString(1, "cheque_bookno").Trim();

                result = fin.of_init_chqnoandbank(state.SsWsPass, state.SsCoopId, ls_bank, ls_bankbranch, ls_chqbookno,ref accno,ref startchqno);

                DwMain.SetItemString(1, "account_no", startchqno);
                DwMain.SetItemString(1, "fromaccount_no", accno);

                DwUtil.RetrieveDDDW(DwMain, "account_no", pbl, state.SsCoopId, ls_bank, ls_bankbranch, ls_chqbookno);
                //DwUtil.RetrieveDDDW(DwMain, "account_no", "paychq_fromslip.pbl", null);
                //DataWindowChild DcChqNo = DwMain.GetChild("account_no");
                //DcChqNo.SetFilter("chequebook_no='" + ls_chqbookno + "'");
                //DcChqNo.Filter();
            }catch(SoapException ex){
                LtServerMessage.Text = WebUtil.ErrorMessage(WebUtil.SoapMessage(ex));
            }
        }

        private void SumChqList()
        {
            Decimal li_chqflag, item_amtnet;
            Decimal SumItemAmt = 0;

            for (int i = 1; i <= DwDetail.RowCount; i++)
            {
                try
                {
                    li_chqflag = DwDetail.GetItemDecimal(i, "ai_chqflag");
                }
                catch { li_chqflag = 0; }

                item_amtnet = DwDetail.GetItemDecimal(i, "item_amtnet");

                if (li_chqflag == 1)
                {
                    SumItemAmt = SumItemAmt + item_amtnet;
                }
            }

            try
            {
                DwMain.SetItemDecimal(1, "cheque_amt", SumItemAmt);
            }
            catch (SoapException ex)
            {
                LtServerMessage.Text = WebUtil.ErrorMessage(WebUtil.SoapMessage(ex));
            }
            catch (Exception ex)
            {
                LtServerMessage.Text = WebUtil.ErrorMessage(ex.Message);
            }
        }

        private void GetChqBook()
        {
            String BankCode, BankBranch;
            DwMain.SetItemString(1, "cheque_bookno", "");
            BankCode = DwMain.GetItemString(1, "bank_code");
            BankBranch = DwMain.GetItemString(1, "bank_branch");
            DwUtil.RetrieveDDDW(DwMain, "cheque_bookno", pbl, state.SsCoopId, BankCode, BankBranch);


            //DataWindowChild DcChqBookNo = DwMain.GetChild("cheque_bookno");
            //String DddwName = DwMain.Describe("cheque_bookno.dddw.name");
            //String DddwChqBookNo = com.GetDDDWXml(state.SsWsPass, DddwName);
            //DcChqBookNo.ImportString(DddwChqBookNo, FileSaveAsType.Xml);
            //DcChqBookNo.SetFilter("bank_code='" + BankCode + "' and bank_branch ='" + BankBranch + "'");
            //DcChqBookNo.Filter();

            String AccId = fin.of_defaultaccid(state.SsWsPass, "CHQ");
            DwMain.SetItemString(1, "as_tofromaccid", AccId);

            DwMain.SetItemString(1, "frombank", BankCode);
            DwMain.SetItemString(1, "frombranch", BankBranch);
        }

        private void GetBankBranch()
        {
            String ls_bank;

            try
            {
                ls_bank = DwMain.GetItemString(1, "bank_code");
            }
            catch
            {
                ls_bank = DwMain.GetItemString(1, "frombank");
            }

            object[] argBank = new object[1] { ls_bank };
            DwUtil.RetrieveDDDW(DwMain, "bank_branch", "paychq.pbl", argBank);

            //DataWindowChild DcBankBranch = DwMain.GetChild("bank_branch");
            //String BankBranchXml = fin.OfGetChildBankbranch(state.SsWsPass, ls_bank);
            //DcBankBranch.ImportString(BankBranchXml, FileSaveAsType.Text);
            //DcBankBranch.SetFilter("bank_code = '" + ls_bank + "'");
            //DcBankBranch.Filter();

            DwUtil.RetrieveDDDW(DwMain, "frombranch", "paychq.pbl", argBank);
            //DataWindowChild DcFromBranch = DwMain.GetChild("frombranch");
            //DcFromBranch.ImportString(BankBranchXml, FileSaveAsType.Text);
            //DcFromBranch.SetFilter("bank_code = '" + ls_bank + "'");
            //DcFromBranch.Filter();
        }
    }
}
