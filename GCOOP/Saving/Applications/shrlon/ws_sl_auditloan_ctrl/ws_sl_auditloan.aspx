<%@ Page Title="" Language="C#" MasterPageFile="~/Frame.Master" AutoEventWireup="true"
    CodeBehind="ws_sl_auditloan.aspx.cs" Inherits="Saving.Applications.shrlon.ws_sl_auditloan_ctrl.ws_sl_auditloan" %>

<%@ Register Src="DsMain.ascx" TagName="DsMain" TagPrefix="uc1" %>
<%@ Register Src="DsList.ascx" TagName="DsList" TagPrefix="uc2" %>
<%@ Register Src="DsDetail.ascx" TagName="DsDetail" TagPrefix="uc3" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">

        var dsMain = new DataSourceTool;
        var dsList = new DataSourceTool;
        var dsDetail = new DataSourceTool;

        function Validate() {
            return confirm("ยืนยันการบันทึกข้อมูล")
        }

        function OnDsMainItemChanged(s, r, c, v) {
            if (c == "member_no") {
                PostMemberNo();
            }
        }

        function OnDsListClicked(s, r, c) {
            if (c == "loantype_code" || c == "principal_balance" || c == "loancontract_no") {
                PostLoanContractNo();
            }
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlace" runat="server">
    <asp:Literal ID="LtServerMessage" runat="server"></asp:Literal>
    <uc1:DsMain ID="dsMain" runat="server" />
    <br />
    <table>
        <tr>
            <td valign="top">
                <uc2:DsList ID="dsList" runat="server" />
            </td>
            <td>
                <uc3:DsDetail ID="dsDetail" runat="server" />
            </td>
        </tr>
    </table>
    <br />
</asp:Content>
