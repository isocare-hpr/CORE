﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Frame.Master" AutoEventWireup="true" CodeBehind="w_sheet_sl_slip_cancel_inorder.aspx.cs" Inherits="Saving.Applications.shrlon.w_sheet_sl_slip_cancel_inorder" %>
<%@ Register Assembly="WebDataWindow" Namespace="Sybase.DataWindow.Web" TagPrefix="dw" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <%=initJavaScript %>
    <%=jsPostMember%>
    <%=jsPostPayInList %>
    <%=newClear%>

    <script type="text/javascript">
        function Validate() {
            return confirm("ยืนยันการบันทึกข้อมูล?");
        }

        function ItemChanged(sender, rowNumber, columnName, newValue) {
            if (columnName == "member_no") {
                objdw_main.SetItem(rowNumber, columnName, Gcoop.StringFormat(newValue, "000000"));
                objdw_main.AcceptText();
                Gcoop.GetEl("Hfmember_no").value = objdw_main.GetItem(rowNumber, "member_no");
                jsPostMember();
            }

        }
        function ListClick(s, r, c) {
            Gcoop.CheckDw(s, r, c, "operate_flag", 1, 0);
            Gcoop.GetEl("HfSlipNo").value = objdw_list.GetItem(r, "payinorder_no");
         //   alert(objdw_list.GetItem(r, "payinorder_no"));
            jsPostPayInList();
        }


        function CnvNumber(num) {
            if (IsNum(num)) {
                return parseFloat(num);
            }
            return 0;
        }
        function MenubarNew() {
            if (confirm("ยืนยันการล้างข้อมูลบนหน้าจอ")) {

                newClear();
            }
        }
        
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlace" runat="server">
    <asp:Literal ID="LtServerMessage" runat="server"></asp:Literal>
    <asp:HiddenField ID="Hfmember_no" runat="server" />
    <asp:HiddenField ID="HfSlipNo" runat="server" />
    <table style="width: 100%;">
        <tr>
            <td colspan="2" valign="top">
                <dw:WebDataWindowControl ID="dw_main" runat="server" DataWindowObject="d_lnccl_payin_memdet"
                    LibraryList="~/DataWindow/shrlon/sl_slipall.pbl" AutoRestoreContext="False"
                    AutoRestoreDataCache="True" AutoSaveDataCacheAfterRetrieve="True" ClientScriptable="True"
                    Width="720px" ClientEventItemChanged="ItemChanged" TabIndex="1" 
                    ClientFormatting="True">
                </dw:WebDataWindowControl>
            </td>
        </tr>
        <tr>
            <td rowspan="2" valign="top">
                <dw:WebDataWindowControl ID="dw_list" runat="server" DataWindowObject="d_sl_lnccl_orderlist_payin"
                    LibraryList="~/DataWindow/shrlon/sl_slipall.pbl" AutoRestoreContext="False"
                    AutoRestoreDataCache="True" AutoSaveDataCacheAfterRetrieve="True" ClientScriptable="True"
                    ClientEventClicked="ListClick" ClientFormatting="True" TabIndex="40">
                </dw:WebDataWindowControl>
            </td>
            <td valign="top">
                <dw:WebDataWindowControl ID="dw_head" runat="server" DataWindowObject="d_loansrv_order_payin"
                    
                    LibraryList="~/DataWindow/shrlon/sl_slipall.pbl" AutoRestoreContext="False"
                    AutoRestoreDataCache="True" AutoSaveDataCacheAfterRetrieve="True" ClientScriptable="True"
                    Width="530px" Height="140px" ClientFormatting="True" TabIndex="70" 
                    style="top: 0px; left: 0px">
                </dw:WebDataWindowControl>
            </td>
        </tr>
        <tr>
            <td valign="top">
                <dw:WebDataWindowControl ID="dw_detail" runat="server" DataWindowObject="d_loansrv_order_payindet"
                    LibraryList="~/DataWindow/shrlon/sl_slipall.pbl" AutoRestoreContext="False"
                    AutoRestoreDataCache="True" AutoSaveDataCacheAfterRetrieve="True" ClientScriptable="True"
                    ClientFormatting="True"  TabIndex="60">
                </dw:WebDataWindowControl>
            </td>
        </tr>
    </table>
</asp:Content>
