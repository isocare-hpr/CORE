<%@ Page Title="" Language="C#" MasterPageFile="~/FrameDialog.Master" AutoEventWireup="true"
    CodeBehind="ws_dlg_share_withdraw.aspx.cs" Inherits="Saving.Applications.mbshr.ws_sl_share_withdraw_ctrl.ws_dlg_share_withdraw_ctrl.ws_dlg_share_withdraw" %>

<%@ Register Src="DsMain.ascx" TagName="DsMain" TagPrefix="uc1" %>
<%@ Register Src="DsDetailLoan.ascx" TagName="DsDetailLoan" TagPrefix="uc2" %>
<%@ Register Src="DsDetailEtc.ascx" TagName="DsDetailEtc" TagPrefix="uc3" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        var dsMain = new DataSourceTool;
        var dsDetailLoan = new DataSourceTool;
        var dsDetailEtc = new DataSourceTool;

        function Validate() {
        }

        function OnDsMainItemChanged(s, r, c, v) {
            if (c == "moneytype_code") {
                PostMoneyType();
            }
            else if (c == "slip_date") {
                PostSlipDate();
            }
            else if (c == "expense_bank") {
                PostExpenseBank();
            }
            else if (c == "setshrarr_flag") {
                PostSetshrarrFlag();
            }
        }

        function OnDsDetailEtcItemChanged(s, r, c, v) {
            if (c == "operate_flag") {
                PostOperateFlagCheck();
            }
        }
        function OnDsDetailLoanItemChanged(s, r, c, v) {
            if (c == "operate_flag") {
                var operate_flag = dsDetailLoan.GetItem(r, "operate_flag");
                if (operate_flag == 1) {
                    var payoutnet_amt = dsMain.GetItem(0, "payoutnet_amt");

                    var bfshrcont_balamt = dsDetailLoan.GetItem(r, "bfshrcont_balamt");
                    var interest_period = dsDetailLoan.GetItem(r, "interest_period");
                    var rkeep_principal = dsDetailLoan.GetItem(r, "rkeep_principal");
                    var bfpxaftermthkeep_type = dsDetailLoan.GetItem(r, "bfpxaftermthkeep_type");

                    //เช็คว่ามีเรียกเก็บอยู่หรือไม่
                    if (bfpxaftermthkeep_type == 1 && rkeep_principal > 0) {
                        principal_payamt = bfshrcont_balamt - rkeep_principal;
                    } else {
                        principal_payamt = bfshrcont_balamt;
                    }
                    var item_payamt = principal_payamt + interest_period;

                    if (item_payamt > payoutnet_amt) {
                        if (payoutnet_amt >= interest_period) {
                            var principal_payamt = payoutnet_amt - interest_period;
                            item_payamt = principal_payamt + interest_period;
                            dsDetailLoan.SetItem(r, "item_payamt", item_payamt);
                            dsDetailLoan.SetItem(r, "interest_payamt", interest_period);
                            dsDetailLoan.SetItem(r, "principal_payamt", principal_payamt);
                            dsDetailLoan.SetItem(r, "item_balance", bfshrcont_balamt - principal_payamt);
                        }
                    } else {
                        dsDetailLoan.SetItem(r, "principal_payamt", principal_payamt);
                        var principal_payamt = bfshrcont_balamt;
                        dsDetailLoan.SetItem(r, "interest_payamt", interest_period);
                        var interest_payamt = interest_period;
                        dsDetailLoan.SetItem(r, "item_payamt", principal_payamt + interest_payamt);
                        dsDetailLoan.SetItem(r, "item_balance", bfshrcont_balamt - principal_payamt);
                    }
                    SetSumPay();
                } else if (operate_flag == 0) {

                    var bfshrcont_balamt = dsDetailLoan.GetItem(r, "bfshrcont_balamt");
                    dsDetailLoan.SetItem(r, "principal_payamt", 0);
                    dsDetailLoan.SetItem(r, "interest_payamt", 0);
                    dsDetailLoan.SetItem(r, "item_payamt", 0);
                    dsDetailLoan.SetItem(r, "item_balance", bfshrcont_balamt);
                    SetSumPay();
                }
            } else if (c == "principal_payamt" || c == "interest_payamt") {
                var payoutnet_amt = dsMain.GetItem(0, "payoutnet_amt");

                var bfshrcont_balamt = dsDetailLoan.GetItem(r, "bfshrcont_balamt");
                var principal_payamt = dsDetailLoan.GetItem(r, "principal_payamt");
                var interest_payamt = dsDetailLoan.GetItem(r, "interest_payamt");
                var rkeep_principal = dsDetailLoan.GetItem(r, "rkeep_principal");
                var bfpxaftermthkeep_type = dsDetailLoan.GetItem(r, "bfpxaftermthkeep_type");

                //เช็คว่ายอดชำระเกินยอดคงเหลือ - ยอดเรียกเก็บหรือไม่
                if (principal_payamt > (bfshrcont_balamt - rkeep_principal)) {
                    principal_payamt = bfshrcont_balamt - rkeep_principal;
                    dsDetailLoan.SetItem(r, "principal_payamt", principal_payamt);

                    if (rkeep_principal == 0) {
                        alert("ชำระต้นเงินเกินยอดคงเหลือ");
                    } else {
                        alert("ชำระต้นเงินเกินยอดที่สามารถชำระได้ มียอดรอเรียกเก็บอยู่ " + rkeep_principal.format(2, 3, ',', '.'));
                    }
                }

                var item_payamt = principal_payamt + interest_payamt;
                dsDetailLoan.SetItem(r, "item_payamt", item_payamt);
                dsDetailLoan.SetItem(r, "item_balance", bfshrcont_balamt - principal_payamt);
                SetSumPay();
            }
        }

        Number.prototype.format = function (n, x, s, c) {
            var re = '\\d(?=(\\d{' + (x || 3) + '})+' + (n > 0 ? '\\D' : '$') + ')',
        num = this.toFixed(Math.max(0, ~ ~n));

            return (c ? num.replace('.', c) : num).replace(new RegExp(re, 'g'), '$&' + (s || ','));
        };

        function SetSumPay() {
            var sumitem_payamt = 0;
            for (var row = 0; row < dsDetailLoan.GetRowCount(); row++) {
                var operate_flag = dsDetailLoan.GetItem(row, "operate_flag");
                if (operate_flag == "1") {
                    sumitem_payamt += dsDetailLoan.GetItem(row, "item_payamt");
                }
            }
            dsMain.SetItem(0, "payoutclr_amt", sumitem_payamt);
            var payoutnet_amt = dsMain.GetItem(0, "payout_amt") - dsMain.GetItem(0, "payoutclr_amt");
            dsMain.SetItem(0, "payoutnet_amt", payoutnet_amt);
        }

        function OnDsDetailEtcClicked(s, r, c) {
            if (c == "b_del") {
                dsDetailEtc.SetRowFocus(r);
                PostDeleteRow();
            }
        }

        function DialogLoadComplete() {

        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlace" runat="server">
    <asp:Literal ID="LtServerMessage" runat="server"></asp:Literal>
    <br />
    <div>
        <asp:Label ID="lbCurrentShare" runat="server" Text="Label" Style="margin-left: 40px;"></asp:Label>
        <input type="button" value="บันทึก" onclick="PostSave()" style="margin-left: 630px;" />
        <input type="button" value="ยกเลิก" onclick="PostCancel()" style="margin-left: 2px;" />
    </div>
    <br />
    <div align="center">
        <table style="background-color: ButtonFace;">
            <tr>
                <td>
                    <uc1:DsMain ID="dsMain" runat="server" />
                    <br />
                </td>
            </tr>
            <tr>
                <td>
                    <uc2:DsDetailLoan ID="dsDetailLoan" runat="server" />
                    <br />
                </td>
            </tr>
            <tr>
                <td>
                    <div align="right" style="margin-right: 1px; width: 750px;">
                        <span class="NewRowLink" onclick="PostInsertRow()">เพิ่มแถว</span>
                    </div>
                    <uc3:DsDetailEtc ID="dsDetailEtc" runat="server" />
                    <br />
                </td>
            </tr>
        </table>
        <asp:HiddenField ID="HdIndex" runat="server" />
        <asp:HiddenField ID="HfFormType" runat="server" />
    </div>
</asp:Content>
