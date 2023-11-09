<%@ Page Language="C#" MasterPageFile="~/Frame.Master" AutoEventWireup="true" CodeBehind="w_sheet_sl_loan_edit.aspx.cs"
    Inherits="Saving.Applications.shrlon.w_sheet_sl_loan_edit" Title="Untitled Page" %>

<%@ Register Assembly="WebDataWindow" Namespace="Sybase.DataWindow.Web" TagPrefix="dw" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <%=initJavaScript %>

    <script type="text/javascript">
        function Validate() {
            return confirm("ยืนยันการบันทึกข้อมูล");
        }

        function showTabPage(tab) {
            var i = 1;
            var tabamount = 4;
            for (i = 1; i <= tabamount; i++) {
                document.getElementById("tab" + i).style.visibility = "hidden";
                document.getElementById("stab_" + i).style.backgroundColor = "rgb(200,235,255)";
                if (i == tab) {
                    document.getElementById("tab" + i).style.visibility = "visible";
                    document.getElementById("stab_" + i).style.backgroundColor = "rgb(211,213,255)";

                }
            }
        }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlace" runat="server">
    <asp:Literal ID="LtServerMessage" runat="server"></asp:Literal>
    <asp:HiddenField ID="HfLncontno" runat="server" />
    <dw:WebDataWindowControl ID="dw_main" runat="server" DataWindowObject="d_sl_loan_edit_member"
        LibraryList="~/DataWindow/shrlon/sl_loan_edit.pbl" ClientScriptable="True" ClientEvents="true"
        ClientEventItemChanged="itemChanged" AutoRestoreContext="False" AutoRestoreDataCache="True"
        AutoSaveDataCacheAfterRetrieve="True">
    </dw:WebDataWindowControl>
    <table style="width: 100%;">
        <tr>
            <td style="background-color: rgb(200,235,255);" id="Td1" align="center" width="16%">
                รายละเอียดสัญญาเงินกู้
            </td>
            <td style="background-color: rgb(211,213,255); cursor: pointer;" id="stab_1" onclick="showTabPage(1);"
                align="center" width="21%">
                รายละเอียด1
            </td>
            <td style="background-color: rgb(200,235,255); cursor: pointer;" id="stab_2" onclick="showTabPage(2);"
                align="center" width="21%">
                รายละเอียด2
            </td>
            <td style="background-color: rgb(200,235,255); cursor: pointer;" id="stab_3" onclick="showTabPage(3);"
                align="center" width="21%">
                Statement
            </td>
            <td style="background-color: rgb(200,235,255); cursor: pointer;" id="stab_4" onclick="showTabPage(4);"
                align="center" width="21%">
                หลักประกัน
            </td>
        </tr>
        <tr>
            <td  valign="top">
                <dw:WebDataWindowControl ID="dw_list" runat="server" DataWindowObject="d_sl_loan_edit_list"
                    LibraryList="~/DataWindow/shrlon/sl_loan_edit.pbl" AutoRestoreContext="False"
                    AutoRestoreDataCache="True" AutoSaveDataCacheAfterRetrieve="True" ClientScriptable="True">
                </dw:WebDataWindowControl>
            </td>
            <td colspan="4" valign="top">
                <div id="tab1" style="visibility: visible; position: absolute;">
                    <dw:WebDataWindowControl ID="dw_detail1" runat="server" DataWindowObject="d_sl_loan_edit_detail1"
                        LibraryList="~/DataWindow/shrlon/sl_loan_edit.pbl" ClientScriptable="True" AutoRestoreContext="False"
                        AutoRestoreDataCache="True" AutoSaveDataCacheAfterRetrieve="True">
                    </dw:WebDataWindowControl>
                </div>
                <div id="tab2" style="visibility: hidden; position: absolute;">
                    <dw:WebDataWindowControl ID="dw_detail2" runat="server" DataWindowObject="d_sl_loan_edit_detail2"
                        LibraryList="~/DataWindow/shrlon/sl_loan_edit.pbl" ClientScriptable="True" AutoRestoreContext="False"
                        AutoRestoreDataCache="True" AutoSaveDataCacheAfterRetrieve="True">
                    </dw:WebDataWindowControl>
                </div>
                <div id="tab3" style="visibility: hidden; position: absolute;">
                    <dw:WebDataWindowControl ID="dw_statement" runat="server" DataWindowObject="d_sl_loan_edit_statement"
                        LibraryList="~/DataWindow/shrlon/sl_loan_edit.pbl" ClientScriptable="True" AutoRestoreContext="False"
                        AutoRestoreDataCache="True" AutoSaveDataCacheAfterRetrieve="True" Width="520px" Height="350px">
                    </dw:WebDataWindowControl>
                </div>
                <div id="tab4" style="visibility: hidden; position: absolute;">
                    <dw:WebDataWindowControl ID="dw_collateral" runat="server" DataWindowObject="d_sl_loan_edit_collateral"
                        LibraryList="~/DataWindow/shrlon/sl_loan_edit.pbl" ClientScriptable="True" AutoRestoreContext="False"
                        AutoRestoreDataCache="True" AutoSaveDataCacheAfterRetrieve="True">
                    </dw:WebDataWindowControl>
                </div>
            </td>
        </tr>
    </table>
</asp:Content>
