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
using Sybase.DataWindow;
using CoreSavingLibrary.WcfNCommon;
using System.Data.SqlClient;

namespace Saving.Applications.cmd
{
    public partial class w_sheet_cmd_ptinvtslipcancle : PageWebSheet, WebSheet
    {
        String pbl = "cmd_ptinvtslipcancle.pbl";
        String refitem_type = "005";
        Sdt ta;
        private DwThDate tDwMain;
        protected String jsPostRefSlipNo;
        protected String jsPostRefSlipnoDlg;

        public void InitJsPostBack()
        {
            tDwMain = new DwThDate(DwMain, this);
            tDwMain.Add("slip_date", "slip_tdate");
            tDwMain.Add("buy_date", "buy_tdate");
            jsPostRefSlipNo = WebUtil.JsPostBack(this, "jsPostRefSlipNo");
            jsPostRefSlipnoDlg = WebUtil.JsPostBack(this, "jsPostRefSlipnoDlg");
        }

        public void WebSheetLoadBegin()
        {
            this.ConnectSQLCA();
            DwMain.SetTransaction(sqlca);
            if (!IsPostBack)
            {
                DwMain.InsertRow(0);
                DwDetail.InsertRow(0);
                DwMain.SetItemDateTime(1, "slip_date", state.SsWorkDate);
                DwMain.SetItemDateTime(1, "buy_date", state.SsWorkDate);
            }
            else
            {
                DwMain.SetItemString(1, "branch_code", "001");
                this.RestoreContextDw(DwMain, tDwMain);
                this.RestoreContextDw(DwDetail);
            }
        }

        public void CheckJsPostBack(string eventArg)
        {
            switch (eventArg)
            {
                case "jsPostRefSlipNo":
                    PostRefSlipNo();
                    break;
                case "jsPostRefSlipnoDlg":
                    PostRefSlipnoDlg();
                    break;
                //case "jsPostInvtId":
                //    PostInvtId();
                //    break;
            }
        }

        public void SaveWebSheet()
        {
            String ref_slipno = "", item_code = "";
            String invt_id = "", reflot_id = "", branch_code = "";
            Decimal slip_status = -9, qty_amt = 0 ;
            DateTime slip_date, buy_date;
            String update = "";
            try
            {
                ref_slipno = DwMain.GetItemString(1, "ref_slipno");
                try { item_code = DwMain.GetItemString(1, "item_code"); }
                catch { throw new Exception("รายการที่เลือกไม่ถูกต้อง กรุณาเลือกรายการยกเลิกใหม่"); }
                try { slip_date = DwMain.GetItemDateTime(1, "slip_date"); }
                catch { slip_date = state.SsWorkDate; }
                try { buy_date = DwMain.GetItemDateTime(1, "buy_date"); }
                catch { buy_date = state.SsWorkDate; }
                try { invt_id = DwMain.GetItemString(1, "invt_id").Trim(); }
                catch { }
                try { reflot_id = DwMain.GetItemString(1, "reflot_id").Trim(); }
                catch { }
                try { qty_amt = DwMain.GetItemDecimal(1, "qty_amt"); }
                catch { qty_amt = 0; }
                //try { takereason_code = DwMain.GetItemString(1, "takereason_code"); }
                //catch { }
                //try { dept_code = DwMain.GetItemString(1, "dept_code"); }
                //catch { }
                //try { branch_code = DwMain.GetItemString(1, "branch_code"); }
                //catch { }
                if (item_code == "001")
                {
                    ///update ptinvtslipin
                    try
                    {
                        update = @"update ptinvtslipin set slip_status = " + slip_status + ", cancel_id = '" + state.SsUsername + "', cancel_date = to_date('" + state.SsWorkDate.ToString("dd/MM/yyyy")
                            + @"','dd/MM/yyyy') where slipin_no = '" + ref_slipno + "'";
                        ta = WebUtil.QuerySdt(update);
                    }
                    catch (Exception ex)
                    { LtServerMessage.Text = WebUtil.ErrorMessage(ex); }
                }
                else if (item_code == "002")
                {
                    ///update ptinvtslipout
                    try
                    {
                        update = @"update ptinvtslipout set slip_status = " + slip_status + ", cancel_id = '" + state.SsUsername + "', cancel_date = to_date('" + state.SsWorkDate.ToString("dd/MM/yyyy")
                            + @"','dd/MM/yyyy') where slipout_no = '" + ref_slipno + "'"; 
                        ta = WebUtil.QuerySdt(update);
                    }
                    catch (Exception ex)
                    { LtServerMessage.Text = WebUtil.ErrorMessage(ex); }
                }
                UpQtyBal(ref_slipno, item_code);
                LtServerMessage.Text = WebUtil.CompleteMessage("บันทึกรายการยกเลิกสำเร็จ " + ref_slipno);
                DwMain.Reset();
                DwMain.InsertRow(0);
            }
            catch(Exception ex)
            { LtServerMessage.Text = WebUtil.ErrorMessage(ex) ; }
        }

        public void WebSheetLoadEnd()
        {
            DwMain.SaveDataCache();
            tDwMain.Eng2ThaiAllRow();
        }

        #region Extra Function

        private void PostRefSlipNo()
        {
            String ref_slipno = "", invt_id = "", full_name = "";
            //ref_slipno = DwMain.GetItemString(1, "ref_slipno").Trim();
            ref_slipno = HdRefSlipno.Value;
            DwMain.Retrieve(ref_slipno);
            for (int i = 1; i <= DwMain.RowCount; i++)
            {
                invt_id = DwMain.GetItemString(i, "invt_id").Trim();
                String se = "select trim(invt_id) || ' - ' || trim(invt_name) as fullname from ptinvtmast where invt_id = '" + invt_id + "'";
                ta = WebUtil.QuerySdt(se);
                if (ta.Next())
                {
                    full_name = ta.GetString("fullname").Trim();
                }
                DwMain.SetItemString(i, "fullnameinvt", full_name);
            }
        }
        /// <summary>
        /// get data from dialog
        /// </summary>
        private void PostRefSlipnoDlg()
        {
            String refslipNo = HdRefSlipno.Value.Trim();
            ///---> next step
        }

        /////update qty_bal in ptinvtmast 
        Decimal UpQtyBal(String ref_slipno, String item_code)
        {
            string InvtId = "";
            decimal QtyAmt = 0, qty_bal = 0;
            if (item_code == "001")
            {
                string se = "select * from ptinvtslipindet where slipin_no = '" + ref_slipno + "'";
                ta = WebUtil.QuerySdt(se);
                while (ta.Next())
                {
                    InvtId = ta.GetString("invt_id");
                    QtyAmt = ta.GetDecimal("invt_qty");
                    try
                    {
                        String sesql = "select qty_bal from ptinvtmast where invt_id = '" + InvtId + "'";
                        ta = WebUtil.QuerySdt(sesql);
                        if (ta.Next())
                        {
                            qty_bal = ta.GetDecimal("qty_bal");
                        }
                        qty_bal = qty_bal - QtyAmt;

                        String upsql = "update ptinvtmast set qty_bal = " + qty_bal + " where invt_id = '" + InvtId + "'";
                        ta = WebUtil.QuerySdt(upsql);

                        string upsql2 = "update ptmetlmastlot set qty_bal = 0 where invt_id = '" + InvtId + "' and lot_id = '"+ ref_slipno +"'";
                        ta = WebUtil.QuerySdt(upsql2);

                        InsertStatement(QtyAmt, qty_bal, ref_slipno, ref_slipno, InvtId, state.SsWorkDate);
                    }
                    catch (Exception ex)
                    { LtServerMessage.Text = WebUtil.ErrorMessage("ไม่สามารถอัพเดทยอดคงเหลือได้ " + ex); }
                }
            }
            else if (item_code == "002")
            {
                string se = "select * from ptinvtslipoutdet where slipout_no = '" + ref_slipno + "'";
                ta = WebUtil.QuerySdt(se);
                while (ta.Next())
                {
                    InvtId = ta.GetString("invt_id");
                    QtyAmt = ta.GetDecimal("invt_qty");                   
                    try
                    {
                        String sesql = "select qty_bal from ptinvtmast where invt_id = '" + InvtId + "'";
                        ta = WebUtil.QuerySdt(sesql);
                        if (ta.Next())
                        {
                            qty_bal = ta.GetDecimal("qty_bal");
                        }
                        qty_bal = qty_bal + QtyAmt;

                        String upsql = "update ptinvtmast set qty_bal = " + qty_bal + " where invt_id = '" + InvtId + "'";
                        ta = WebUtil.QuerySdt(upsql);

                        //ต้องเพิ่ม update lot แบบ auto ด้วย กรณีมี 1 รายการ ตัด lot มากกว่า 1 lot
                        decimal qtyballot = 0;
                        string sesql2 = "select qty_bal from ptmetlmastlot where invt_id = '" + InvtId + "' and lot_id = '" + ref_slipno + "'";
                        ta = WebUtil.QuerySdt(sesql2);
                        if (ta.Next())
                        {
                            qtyballot = ta.GetDecimal("qty_bal");
                        }
                        qty_bal = qty_bal + QtyAmt;
                        string upsql2 = "update ptmetlmastlot set qty_bal = "+ qty_bal +" where invt_id = '" + InvtId + "' and lot_id = '" + ref_slipno + "'";
                        ta = WebUtil.QuerySdt(upsql2);

                        InsertStatement(QtyAmt, qty_bal, ref_slipno, ref_slipno, InvtId, state.SsWorkDate);
                    }
                    catch (Exception ex)
                    { LtServerMessage.Text = WebUtil.ErrorMessage("ไม่สามารถอัพเดทยอดคงเหลือได้ " + ex); }
                }
            }
            return qty_bal;
        }

//        ///insert into ptinvtstatement เพิ่มการเคลื่อนไหว
//        private void InsertStatement(Decimal QtyAmt, Decimal QtyBal, String LotId, String SlipoutNo, String InvtId, DateTime SlipDate)
//        {
//            String item_code = "";
//            Decimal SeqNo = MaxSeqInvtId(InvtId);
//            try
//            {
//                String insert = @"insert into ptinvtstatement
//                    (
//	                    seq_no,
//	                    item_code,
//	                    qty_amt,
//	                    qty_bal,
//	                    operate_date,
//	                    ref_lotid,
//	                    invt_id,
//	                    ref_slipno,
//	                    slip_date 
//                    ) values
//                    (   " + SeqNo + @", 
//                        '" + item_code + @"', 
//                        " + QtyAmt + @", 
//                        " + QtyBal + @", 
//                        to_date('" + state.SsWorkDate.ToString("dd/MM/yyyy") + @"','dd/MM/yyyy'), 
//                        '" + LotId + @"',
//                        '" + InvtId + @"',
//                        '" + SlipoutNo + @"',
//                        to_date('" + SlipDate.ToString("dd/MM/yyyy") + @"','dd/MM/yyyy') 
//                    )";
//                ta = WebUtil.QuerySdt(insert);
//            }
//            catch (Exception ex)
//            { LtServerMessage.Text = WebUtil.ErrorMessage("ไม่สามารถบันทึกการเคลื่อนไหวการลงรับวัสดุได้ " + ex); }
//        }
        
//        ///update into ptmetlmastlot อัพเดท lot
//        private void UpdateMastLot(String InvtId,String LotId, Decimal InvQty)
//        {
//            Decimal qty_bal = 0;
//            try
//            {
//                String sesql = "select qty_bal from ptmetlmastlot where invt_id = '" + InvtId + "' and lot_id = '"+ LotId +"'";
//                ta = WebUtil.QuerySdt(sesql);
//                if (ta.Next())
//                {
//                    qty_bal = ta.GetDecimal("qty_bal");
//                }
//                qty_bal = qty_bal - InvQty;
//                String upsql = @"update ptmetlmastlot set qty_bal = "+ qty_bal +@" 
//                                where invt_id = '" + InvtId + "' and lot_id = '"+ LotId +"'";
//                ta = WebUtil.QuerySdt(upsql);
//            }
//            catch (Exception ex)
//            { LtServerMessage.Text = WebUtil.ErrorMessage("ไม่สามารถอัพเดทรายการลงเคลื่อนไหว LOT วัสดุได้ " + ex); }

//        }
        
//        ///update ptmetlmastlot แบบอัตโนมัติ + insert เคลื่อนไหว
//        private void UpdateMastLotAuto(String InvtId, Decimal InvQty, String SlipoutNo, DateTime SlipDate)
//        {
//            Decimal qty_bal = 0, ChkQtyBal = 0;
//            String lot_id = "", upsql = "";
//            try
//            {
//                String sesql = "select lot_id, qty_bal from ptmetlmastlot where invt_id = '" + InvtId + "' and qty_bal > 0 order by lot_id asc";
//                ta = WebUtil.QuerySdt(sesql);
//                if (ta.Next())
//                {
//                    lot_id = ta.GetString("lot_id").Trim();
//                    qty_bal = ta.GetDecimal("qty_bal");
//                }
//                if (qty_bal >= InvQty)
//                {
//                    qty_bal = qty_bal - InvQty;
//                    upsql = @"update ptmetlmastlot set qty_bal = " + qty_bal + @" 
//                                where invt_id = '" + InvtId + "' and lot_id = '" + lot_id + "'";
//                    ta = WebUtil.QuerySdt(upsql);
//                    InsertStatement(InvQty, qty_bal, lot_id, SlipoutNo, InvtId, SlipDate);
//                }
//                else
//                {
//                    ChkQtyBal = InvQty - qty_bal;
//                    upsql = @"update ptmetlmastlot set qty_bal = 0  
//                            where invt_id = '" + InvtId + "' and lot_id = '" + lot_id + "'";
//                    ta = WebUtil.QuerySdt(upsql);
//                    InsertStatement(qty_bal, 0, lot_id, SlipoutNo, InvtId, SlipDate);
//                }
//                if (ChkQtyBal > 0)
//                { UpdateMastLotAuto(InvtId, ChkQtyBal, SlipoutNo, SlipDate); }

//            }
//            catch (Exception ex)
//            { LtServerMessage.Text = WebUtil.ErrorMessage("ไม่สามารถอัพเดทรายการเคลื่อนไหว LOT วัสดุแบบอัตโนมัติได้ " + ex.Message); }
//        }

//        Decimal MaxSeqInvtId(String InvtId)
//        {
//            Decimal maxseq = 0;
//            String sesql = @"select max(seq_no) as seq_no from ptinvtstatement where invt_id = '" + InvtId.Trim() + "'";
//            ta = WebUtil.QuerySdt(sesql);
//            if (ta.Next())
//            {
//                maxseq = ta.GetDecimal("seq_no");
//            }
//            maxseq++;

//            return maxseq;
//        }

        private void InsertStatement(Decimal QtyAmt, Decimal QtyBal, String LotId, String SlipadjNo, String InvtId, DateTime SlipDate)
        {
            Decimal SeqNo = MaxSeqInvtId(InvtId);
            try
            {
                String insert = @"insert into ptinvtstatement
                    (
	                    seq_no, item_code, qty_amt, qty_bal, operate_date,
	                    ref_lotid, invt_id, ref_slipno, slip_date 
                    ) values
                    (   " + SeqNo + ",'" + refitem_type + "', " + QtyAmt + ", " + QtyBal + @", 
                        to_date('" + state.SsWorkDate.ToString("dd/MM/yyyy") + @"','dd/MM/yyyy'), 
                        '" + LotId + @"', '" + InvtId + @"', '" + SlipadjNo + @"',
                        to_date('" + SlipDate.ToString("dd/MM/yyyy") + @"','dd/MM/yyyy') 
                    )";
                ta = WebUtil.QuerySdt(insert);
            }
            catch (Exception ex)
            { LtServerMessage.Text = WebUtil.ErrorMessage("ไม่สามารถบันทึกการเคลื่อนไหวการลงรับวัสดุได้ " + ex); }
        }

        Decimal MaxSeqInvtId(String InvtId)
        {
            Decimal maxseq = 0;
            String sesql = @"select max(seq_no) as seq_no from ptinvtstatement where invt_id = '" + InvtId.Trim() + "'";
            ta = WebUtil.QuerySdt(sesql);
            if (ta.Next())
            {
                maxseq = ta.GetDecimal("seq_no");
            }
            maxseq++;

            return maxseq;
        }

    #endregion

    }
}

