using System;
using CoreSavingLibrary;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
//using CoreSavingLibrary.WcfShrlon;
//using CoreSavingLibrary.WcfNCommon;

using CoreSavingLibrary.WcfNShrlon;
using CoreSavingLibrary.WcfNCommon;
using DataLibrary;
using System.Data;

namespace Saving.Applications.mbshr.ws_mbshr_req_chgmthshr_ctrl
{
    public partial class ws_mbshr_req_chgmthshr : PageWebSheet, WebSheet
    {
        [JsPostBack]
        public string PostMemberNo { get; set; }
        [JsPostBack]
        public string PostChanegValue { get; set; }
        [JsPostBack]
        public string PostCheckStopShare { get; set; }
        [JsPostBack]
        public string PostGetFromDlg { get; set; }
        [JsPostBack]
        public string PostSalary { get; set; }
        
        public void InitJsPostBack()
        {
            dsMain.InitDsMain(this);
        }

        public void WebSheetLoadBegin()
        {
            if (!IsPostBack)
            {
                HdMemcoopid.Value = state.SsCoopControl;
                dsMain.DATA[0].PAYADJUST_DATE = state.SsWorkDate;
                dsMain.DATA[0].ENTRY_ID = state.SsUsername;
            }
        }

        public void CheckJsPostBack(string eventArg)
        {
            if (eventArg == PostMemberNo)
            {
                String memcoop_id = HdMemcoopid.Value;
                decimal req_status = 0;
                string membno = "";
                ///ตรวจคำขอเปลี่ยนแปลงค่าหุ้น EXAT
                if (state.SsCoopControl == "022001")
                {
                    membno = WebUtil.MemberNoFormat(dsMain.DATA[0].MEMBER_NO);
                    req_status = CheckReqChgmthshr(membno);            
                }
                if (req_status == 1)
                {
                    dsMain.RetrieveDocno(HdDocno.Value);
                    string is_message = "เลขสมาชิก " + membno + " มีคำขอแล้ว";
                    this.SetOnLoadedScript("alert('" + is_message + "')");
                }
                else
                {
                    try
                    {
                        String as_xmlreq = dsMain.ExportXml();
                        string member_no = WebUtil.MemberNoFormat(dsMain.DATA[0].MEMBER_NO);
                        string salary_id = GetSQL_Value("select salary_id as sql_value from mbmembmaster where member_no = '" + member_no + "' ");
                        DateTime adtm_datereq = dsMain.DATA[0].PAYADJUST_DATE;

                        //int result = wcf.NShrlon.InitRequestShrPayment(state.SsWsPass, state.SsCoopId, member_no, memcoop_id, adtm_datereq, ref as_xmlreq);
                        int result = wcf.NShrlon.of_initreq_chgmthshr(state.SsWsPass, state.SsCoopId, member_no, memcoop_id, adtm_datereq, ref as_xmlreq);

                        if (result == 1)
                        {
                            dsMain.ResetRow();
                            dsMain.ImportData(as_xmlreq);
                            dsMain.DATA[0].SALARY_ID = salary_id;
                        }
                        dsMain.DATA[0].ENTRY_ID = state.SsUsername;
                        dsMain.DATA[0].PAYADJUST_DATE = state.SsWorkDate;
                        JsGetShareBase();
                    }
                    catch (Exception ex)
                    {
                        LtServerMessage.Text = WebUtil.ErrorMessage(ex);
                    }
                }
            }
            else if (eventArg == PostSalary)
            {
                String memcoop_id = HdMemcoopid.Value;

                try
                {
                    String as_xmlreq = dsMain.ExportXml();
                    string salary_id = dsMain.DATA[0].SALARY_ID;

                    string member_no = GetSQL_Value("select member_no as sql_value from mbmembmaster where salary_id = '" + salary_id + "' ");
                    dsMain.DATA[0].MEMBER_NO = WebUtil.MemberNoFormat(member_no);

                    DateTime adtm_datereq = dsMain.DATA[0].PAYADJUST_DATE;

                    //int result = wcf.NShrlon.InitRequestShrPayment(state.SsWsPass, state.SsCoopId, member_no, memcoop_id, adtm_datereq, ref as_xmlreq);
                    int result = wcf.NShrlon.of_initreq_chgmthshr(state.SsWsPass, state.SsCoopId, member_no, memcoop_id, adtm_datereq, ref as_xmlreq);

                    if (result == 1)
                    {
                        dsMain.ResetRow();
                        dsMain.ImportData(as_xmlreq);
                        dsMain.DATA[0].SALARY_ID = salary_id;
                    }
                    dsMain.DATA[0].ENTRY_ID = state.SsUsername;
                    dsMain.DATA[0].PAYADJUST_DATE = state.SsWorkDate;
                    JsGetShareBase();
                }
                catch (Exception ex)
                {
                    LtServerMessage.Text = WebUtil.ErrorMessage(ex);
                }
            }
            else if (eventArg == PostChanegValue)
            {

                decimal salary_amount = dsMain.DATA[0].SALARY_AMOUNT;
                decimal new_periodvalue = dsMain.DATA[0].NEW_PERIODVALUE;
                decimal periodbase_value = dsMain.DATA[0].PERIODBASE_VALUE;
                //wa กรณีลดหุ้นต่ำกว่าหุ้นฐานให้อ่านค่างคงที่มาตรวจด้วย
                decimal share_period = dsMain.DATA[0].SHRLAST_PERIOD;
                decimal sharestk_value = dsMain.DATA[0].SHARESTK_VALUE;
                //tomy
                decimal salary_amount_20 = (salary_amount * 10) / 100;
                salary_amount_20 = Math.Round(salary_amount_20 / 10, 0) * 10;
                decimal salary_amount_5 = (salary_amount * 5) / 100;
                salary_amount_5 = Math.Round(salary_amount_5 / 10, 0) * 10;

                if (new_periodvalue % 10 != 0)
                {
                    this.SetOnLoadedScript("alert('มูลค่าหุ้นต่อ 1 หน่วย ไม่ตรงตามฐาน')");
                    dsMain.DATA[0].NEW_PERIODVALUE = new_periodvalue;
                }
                    //tomy เอาออก แพร่ไม่ใช้
                //else if (new_periodvalue < periodbase_value && share_period < 120 && sharestk_value < 60000)
                //{
                //    decimal new_paystatus = dsMain.DATA[0].NEW_PAYSTATUS;

                //    if (new_paystatus != -1)
                //    {
                //        this.SetOnLoadedScript("alert('หุ้นที่เปลี่ยนน้อยกว่าหุ้นฐาน หุ้นฐาน = " + periodbase_value + "')");
                //        dsMain.DATA[0].NEW_PERIODVALUE = periodbase_value;
                //    }
                //    else {
                //        dsMain.DATA[0].NEW_PERIODVALUE = 0;
                //    }
                //}
                //tomy ส่งหุ้นไม่เกิน 20 % ของเงินเดือน
                else if (new_periodvalue > salary_amount_20)
                {
                    this.SetOnLoadedScript("alert('มูลค่าหุ้นเกิน 10 %')");
                    dsMain.DATA[0].NEW_PERIODVALUE = dsMain.DATA[0].OLD_PERIODVALUE;
                }
                else if (new_periodvalue < salary_amount_5)
                {
                    this.SetOnLoadedScript("alert('มูลค่าหุ้นน้อยกว่า 5 %')");
                    dsMain.DATA[0].NEW_PERIODVALUE = dsMain.DATA[0].OLD_PERIODVALUE;
                }
                else
                {

                    decimal loan_pay = 0, salary_balance = 0;
                    string sql = @"SELECT sum(lncontmaster.period_payment) as loan_pay
                    FROM lncontmaster, 
                    lnloantype 
                    WHERE ( lncontmaster.loantype_code = lnloantype.loantype_code ) 
                    and ( lncontmaster.coop_id = lnloantype.coop_id ) 
                    and ( ( lncontmaster.memcoop_id = {0} ) 
                    and ( lncontmaster.member_no = {1} )
                    and ( lncontmaster.loanpay_code = 'KEP' )
                    and ( lncontmaster.principal_balance + lncontmaster.withdrawable_amt > 0 ) 
                    and ( lncontmaster.contract_status > 0 ) ) ";
                    sql = WebUtil.SQLFormat(sql, state.SsCoopControl, dsMain.DATA[0].MEMBER_NO);
                    Sdt dt = WebUtil.QuerySdt(sql);

                    if (dt.Next())
                    {
                        loan_pay = dt.GetDecimal("loan_pay");
                    }

                    salary_balance = salary_amount - new_periodvalue - loan_pay;

                    if (salary_balance < 2000)
                    {
                        this.SetOnLoadedScript("alert('เงินเดือนคงเหลือไม่เป็นไปตามที่กำหนด \\nเงินเดือน = " + salary_amount.ToString("#,##0.00") + "\\nหุ้นที่ต้องการเพิ่ม = " + new_periodvalue.ToString("#,##0.00") + "\\nหักหนี้โดยประมาณ = " + loan_pay.ToString("#,##0.00") + "\\nเงินเดือนคงเหลือ = " + salary_balance.ToString("#,##0.00") + "\\nเงินเดือนคงเหลือขั้นต่ำ = 2,000.00 \\nกรุณาตรวจสอบด้วย')");
                    }
                }
            }
            else if (eventArg == PostCheckStopShare)
            {
                decimal chkchgstopshr = CheckStopSharePeriod();
                decimal new_paystatus = dsMain.DATA[0].NEW_PAYSTATUS;
                if (new_paystatus == -1)
                {
                    if (chkchgstopshr == 1)
                    {
                        LtServerMessage.Text = WebUtil.ErrorMessage("งวดหุ้น = " + dsMain.DATA[0].SHRLAST_PERIOD + " ไม่สามารถงดส่งค่าหุ้นได้");
                        //dsMain.DATA[0].NEW_PAYSTATUS = 1;
                    }
                }
            }
            else if (eventArg == PostGetFromDlg)
            {
                dsMain.RetrieveDocno(HdDocno.Value);
            }
        }

        public void SaveWebSheet()
        {
            try
            {
                String as_xmlreq = dsMain.ExportXml();
                DateTime payadjust_date = dsMain.DATA[0].PAYADJUST_DATE;
                
                //int result = wcf.NShrlon.SaveRequestShrPayment(state.SsWsPass, as_xmlreq, state.SsUsername, payadjust_date);
                int result = wcf.NShrlon.of_savereq_chgmthshr(state.SsWsPass, as_xmlreq, state.SsUsername, payadjust_date);

                if (result == 1)
                {
                    LtServerMessage.Text = WebUtil.CompleteMessage("บันทึกสำเร็จ");
                    JsNewClear();
                }
            }
            catch (Exception ex)
            {
                LtServerMessage.Text = WebUtil.ErrorMessage(ex);
            }
        }

        public void WebSheetLoadEnd()
        {
        }

        private void JsNewClear()
        {
            dsMain.ResetRow();
            HdMemcoopid.Value = state.SsCoopControl;
            dsMain.DATA[0].PAYADJUST_DATE = state.SsWorkDate;
            dsMain.DATA[0].ENTRY_ID = state.SsUsername;
        }

        private void JsGetShareBase()
        {
            string member_no = WebUtil.MemberNoFormat(dsMain.DATA[0].MEMBER_NO);
            Decimal member_type = WebUtil.GetMemberType(state.SsCoopControl, member_no);
            string sharetype_code = WebUtil.GetShareType(state.SsCoopControl, member_no);

            Decimal salary_amount = dsMain.DATA[0].SALARY_AMOUNT;

            string coop_id = state.SsCoopId;

            Decimal minmaxshare = CalPayShareMonth(coop_id, sharetype_code, member_type, salary_amount);

            dsMain.DATA[0].PERIODBASE_VALUE = minmaxshare;
        }

        //คำนวณหุ้นฐาน TKS
        private Decimal CalPayShareMonth(String memcoop_id, String sharetype_code, Decimal member_type, Decimal salary_amount)
        {
            Decimal share = 0;
            member_type = 1;
            string sql1 = @"select * from shsharetypemthrate where coop_id = {0} and sharetype_code= {1} and {2} >= start_salary and {3} <= end_salary and member_type = {4}";
            string sql2 = @"select * from shsharetype where coop_id ={0} and sharetype_code = {1} and 1 = 1";

            sql1 = WebUtil.SQLFormat(sql1, state.SsCoopId, sharetype_code, salary_amount, salary_amount, member_type);
            sql2 = WebUtil.SQLFormat(sql2, state.SsCoopId, sharetype_code);

            Sdt dt = WebUtil.QuerySdt(sql1);
            Sdt dt2 = WebUtil.QuerySdt(sql2);

            bool Isdt2 = dt2.Next();
            while (dt.Next())
            {
                decimal maxshare_percent = dt.GetDecimal("maxshare_percent");
                decimal maxshare = dt.GetDecimal("maxshare_amt") * dt2.GetDecimal("unitshare_value");
                if (member_type == 1)
                {
                    maxshare_percent = dt.GetDecimal("maxshare_percent") * salary_amount;
                }
                else
                {
                    maxshare_percent = maxshare;
                }
                decimal temp;
                if (maxshare_percent >= maxshare)
                {
                    temp = maxshare;
                }
                else
                {
                    temp = maxshare_percent;
                }

                share = dt.GetDecimal("minshare_amt") * dt2.GetDecimal("unitshare_value");
            }
            return share;
        }

        private decimal CheckStopSharePeriod()
        {
            String coop_id = state.SsCoopControl;
            String member_no = dsMain.DATA[0].MEMBER_NO;
            String sharetype_code = WebUtil.GetShareType(state.SsCoopControl, dsMain.DATA[0].MEMBER_NO);
            decimal timeminshare_stop = 0;
            decimal chkchgstopshr = 0;

            string sql1 = "select * from shsharemaster where member_no ='" + member_no + "' and coop_id ='" + coop_id + "'";
            string sql2 = "select * from shsharetype  where sharetype_code ='" + sharetype_code + "' and coop_id ='" + coop_id + "'";
            //string sql3 = "select * from mbmembmaster where member_no ='" + member_no + "' and coop_id ='" + coop_id + "'";

            Sdt dt1 = WebUtil.QuerySdt(sql1);
            Sdt dt2 = WebUtil.QuerySdt(sql2);
            //Sdt dt3 = WebUtil.QuerySdt(sql3);

            bool Isdt2 = dt1.Next();
            sharetype_code = dt1.GetString("sharetype_code");

            while (dt2.Next())
            {
                int count = 0;
                Decimal last_period = Convert.ToDecimal(dt1.GetDecimal("last_period"));
                timeminshare_stop = Convert.ToDecimal(dt2.GetString("timeminshare_stop"));
                Decimal sharestk_amt = Convert.ToDecimal(dt1.GetDecimal("sharestk_amt"));
                sharestk_amt = sharestk_amt * 10;
                Decimal minshare_stop = Convert.ToDecimal(dt2.GetDecimal("minshare_stop"));
                //เป็นสมาชิก 15 ปี
                //if (chkmemdate<=DateTime.Now)
                //{
                //    count++;
                //}
                //ส่งค่าหุ้นมาแล้วไม่น้อยกว่า 120
                if (last_period >= timeminshare_stop)
                {
                    count++;
                }
                //มีหุ้น มากกว่า 2 แสนหรืออย่างใดอย่างหนึ่ง
                if (sharestk_amt >= minshare_stop)
                {
                    count++;
                }
                
                //ไม่มีหนี้สินกับสหกรณ์
                if (1 == 1)
                {
                    count++;
                }

                if (count == 2)
                {
                    chkchgstopshr = 0;
                }
                else
                {
                    chkchgstopshr = 1;
                }
            }
            return chkchgstopshr;
        }

        public string GetSQL_Value(string Select_Condition)
        {
            string sql_value = "";
            string sqlf = Select_Condition;
            Sdt dt = WebUtil.QuerySdt(sqlf);

            if (dt.Next())
            {
                sql_value = dt.GetString("sql_value");
            }
            return sql_value;
        }

        //เข็คสถานะกรณีมีคำขอการเปลี่ยนแปลงหุ้นแล้ว
        private decimal CheckReqChgmthshr(String MemberNo)
        {
            decimal checkstatus = 0;
            string payadjust_docno = "";
            string se = @"select * from shpaymentadjust where coop_id ={0} and member_no = {1} and shrpayadj_status = 8 ";
            se = WebUtil.SQLFormat(se, state.SsCoopId, MemberNo);
            Sdt dt = WebUtil.QuerySdt(se);
            if (dt.Next())
            {
                payadjust_docno = dt.GetString("payadjust_docno").Trim();
            }
            if (payadjust_docno != null && payadjust_docno != "")
            {
                HdDocno.Value = payadjust_docno;
                checkstatus = 1;
            }
            return checkstatus;
        }
    }
}