<%@ Page Title="" Language="C#" MasterPageFile="~/Frame.Master" AutoEventWireup="true"
    CodeBehind="ws_mbshr_adt_mbaudit.aspx.cs" Inherits="Saving.Applications.mbshr.ws_mbshr_adt_mbaudit_ctrl.ws_mbshr_adt_mbaudit" %>

<%@ Register Src="DsMain.ascx" TagName="DsMain" TagPrefix="uc1" %>
<%@ Register Src="DsList.ascx" TagName="DsList" TagPrefix="uc2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        var dsMain = new DataSourceTool;
        var dsList = new DataSourceTool;

        function OnDsMainItemChanged(s, r, c, v) {
            if (c == "member_no") {
                PostMember();
            } else if (c == "province_code") {
                PostProvince();
            } else if (c == "amphur_code") {
                PostAmpur();
            } else if (c == "currprovince_code") {
                PostCurrprovince();
            } else if (c == "curramphur_code") {
                PostCurramphur();
            } else if (c == "bank_name") {
                PostBank();
            } else if (c == "branch_name") {
                var branch_name = dsMain.GetItem(0, "branch_name");
                dsMain.SetItem(0, "expense_branch", branch_name);
            } else if (c == "expense_bank") {
                PostExpenseBank();
            } else if (c == "expense_branch") {
                PostExpenseBranch();
            } else if (c == "expense_code") {
                var expense_code = dsMain.GetItem(0, "expense_code");
                if (expense_code == "CSH") {
                    dsMain.GetElement(0, "expense_bank").readOnly = true;
                    dsMain.GetElement(0, "bank_name").disabled = true;
                    dsMain.GetElement(0, "b_bank").disabled = true;
                    dsMain.GetElement(0, "expense_branch").readOnly = true;
                    dsMain.GetElement(0, "branch_name").disabled = true;
                    dsMain.GetElement(0, "b_branch").disabled = true;
                    dsMain.GetElement(0, "bank_name").disabled = true;
                    dsMain.GetElement(0, "expense_accid").disabled = true;
                    dsMain.SetItem(0, "expense_bank", "");
                    dsMain.SetItem(0, "bank_name", "");
                    dsMain.SetItem(0, "expense_branch", "");
                    dsMain.SetItem(0, "branch_name", "");
                    dsMain.SetItem(0, "expense_accid", "");
                    dsMain.GetElement(0, "expense_bank").style.background = "#CCCCCC";
                    dsMain.GetElement(0, "bank_name").style.background = "#CCCCCC";
                    dsMain.GetElement(0, "b_bank").style.background = "#CCCCCC";
                    dsMain.GetElement(0, "expense_branch").style.background = "#CCCCCC";
                    dsMain.GetElement(0, "branch_name").style.background = "#CCCCCC";
                    dsMain.GetElement(0, "b_branch").style.background = "#CCCCCC";
                    dsMain.GetElement(0, "expense_accid").style.background = "#CCCCCC";
                } else if (expense_code == "TRN") {
                    dsMain.GetElement(0, "expense_bank").readOnly = true;
                    dsMain.GetElement(0, "bank_name").disabled = true;
                    dsMain.GetElement(0, "b_bank").disabled = true;
                    dsMain.GetElement(0, "expense_branch").readOnly = true;
                    dsMain.GetElement(0, "branch_name").disabled = true;
                    dsMain.GetElement(0, "b_branch").disabled = true;
                    dsMain.GetElement(0, "bank_name").disabled = true;
                    dsMain.GetElement(0, "expense_accid").disabled = false;
                    dsMain.SetItem(0, "expense_bank", "");
                    dsMain.SetItem(0, "bank_name", "");
                    dsMain.SetItem(0, "expense_branch", "");
                    dsMain.SetItem(0, "branch_name", "");
                    dsMain.SetItem(0, "expense_accid", "");
                    dsMain.GetElement(0, "expense_bank").style.background = "#CCCCCC";
                    dsMain.GetElement(0, "bank_name").style.background = "#CCCCCC";
                    dsMain.GetElement(0, "b_bank").style.background = "#CCCCCC";
                    dsMain.GetElement(0, "expense_branch").style.background = "#CCCCCC";
                    dsMain.GetElement(0, "branch_name").style.background = "#CCCCCC";
                    dsMain.GetElement(0, "b_branch").style.background = "#CCCCCC";
                    dsMain.GetElement(0, "expense_accid").style.background = "#FFFFFF";
                } else {
                    dsMain.GetElement(0, "expense_bank").readOnly = false;
                    dsMain.GetElement(0, "bank_name").disabled = false;
                    dsMain.GetElement(0, "b_bank").disabled = false;
                    dsMain.GetElement(0, "expense_branch").readOnly = false;
                    dsMain.GetElement(0, "branch_name").disabled = false;
                    dsMain.GetElement(0, "b_branch").disabled = false;
                    dsMain.GetElement(0, "bank_name").disabled = false;
                    dsMain.GetElement(0, "expense_accid").disabled = false;
                    dsMain.GetElement(0, "expense_bank").style.background = "#FFFFFF";
                    dsMain.GetElement(0, "bank_name").style.background = "#FFFFFF";
                    dsMain.GetElement(0, "b_bank").style.background = "#FFFFFF";
                    dsMain.GetElement(0, "expense_branch").style.background = "#FFFFFF";
                    dsMain.GetElement(0, "branch_name").style.background = "#FFFFFF";
                    dsMain.GetElement(0, "b_branch").style.background = "#FFFFFF";
                    dsMain.GetElement(0, "expense_accid").style.background = "#FFFFFF";
                }
            }
        }


        function OnDsMainClicked(s, r, c, v) {
            if (c == "b_search") {
                Gcoop.OpenIFrame("610", "590", "w_dlg_sl_member_search.aspx", "");
            } else if (c == "b_bank") {
                Gcoop.OpenIFrame("580", "590", "w_dlg_kp_bank_search.aspx", "");
            } else if (c == "btnposfind") {
                Gcoop.OpenDlg('400', '450', 'w_dlg_adu_position.aspx', '');
            } else if (c == "b_branch") {
                var bank_code = dsMain.GetItem(0, "expense_bank");
                Gcoop.OpenIFrame("580", "590", "w_dlg_kp_bankbranch_search.aspx", "?bank_code=" + bank_code);
            } else if (c == "b_linkaddress") {
                PostLinkAddress();
                //                var addr_no = dsMain.GetItem(0, "addr_no");
                //         
                //                var addr_moo = dsMain.GetItem(0, "addr_moo");
                //                var addr_village = dsMain.GetItem(0, "addr_village");
                //                var addr_road = dsMain.GetItem(0, "addr_road");
                //                var province_code = dsMain.GetItem(0, "province_code");
                //                var amphur_code = dsMain.GetItem(0, "amphur_code");
                //                var tambol_code = dsMain.GetItem(0, "tambol_code");
                //                var addr_postcode = dsMain.GetItem(0, "addr_postcode");
                //                var addr_phone = dsMain.GetItem(0, "addr_phone");
                //                alert("no" + addr_no);
                //                alert("moo" + addr_moo);
                //                alert("vill" + addr_village);
                //                alert("ro" + addr_road);
                //                alert("pro" + province_code);
                //                alert("am" + amphur_code);
                //                alert("tam" + tambol_code);
                //                alert("post" + addr_postcode);
                //                alert("phone" + addr_phone);
                //                dsMain.SetItem(0, "curraddr_no", addr_no);
                //                dsMain.SetItem(0, "curraddr_moo", addr_moo);
                //                dsMain.SetItem(0, "curraddr_village", addr_village);
                //                dsMain.SetItem(0, "curraddr_road", addr_road);
                //                dsMain.SetItem(0, "currprovince_code", province_code);
                //                dsMain.SetItem(0, "curramphur_code", amphur_code);
                //                dsMain.SetItem(0, "currtambol_code", tambol_code);
                //                dsMain.SetItem(0, "curraddr_postcode", addr_postcode);
                //                dsMain.SetItem(0, "curraddr_phone", addr_phone);
            }
        }

        function GetPositionFromDlg(poscode, postdesc) {
            //alert(poscode + postdesc);
            dsMain.SetItem(0, "position_code", poscode);
        }

        function GetValueFromDlg(memberno) {
            dsMain.SetItem(0, "member_no", memberno);
            PostMember();
        }
        function GetBankFromDlg(bank_code) {
            dsMain.SetItem(0, "expense_bank", bank_code);
            dsMain.SetItem(0, "bank_name", bank_code);

        }
        function GetBankBranchFromDlg(branch_id) {
            dsMain.SetItem(0, "expense_branch", branch_id);
            dsMain.SetItem(0, "branch_name", branch_id);
            //PostBranch();

        }
        function OnDsListClicked(s, r, c, v) {
            if (c == "b_del") {
                dsList.SetRowFocus(r);
                PostDeleteRow();
            }
        }

        function OnDsListItemChanged(s, r, c, v) {
            if (c == "bank_branch") {
                dsList.SetRowFocus(r);
                PostBankBranch();
            } 
            else if (c == "branch_name") {
                dsList.SetRowFocus(r);
                var BankCode = dsList.GetItem(r, "bank_code");
                Gcoop.OpenIFrame("450", "600", "w_dlg_mb_search_bankbranch.aspx", "?seach_key=" + v + "&bankCode=" + BankCode);
            }
        }

        function GetValueFromDlgSeachBankBranch(BankBranch_code, BankBranch_desc) {
            var row = dsList.GetRowFocus();
            dsList.SetItem(row, "bank_branch", Gcoop.Trim(BankBranch_code));
            dsList.SetItem(row, "branch_name", Gcoop.Trim(BankBranch_desc));
        }

        function Validate() {
            return confirm("ยืนยันการบันทึกข้อมูล");
        }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlace" runat="server">
    <asp:Literal ID="LtServerMessage" runat="server"></asp:Literal>
    <uc1:DsMain ID="dsMain" runat="server" />
    <div align="right">
        <span class="NewRowLink" onclick="PostInsertRow()">เพิ่มแถว</span>
    </div>
    <uc2:DsList ID="dsList" runat="server" />
    <br />
</asp:Content>
