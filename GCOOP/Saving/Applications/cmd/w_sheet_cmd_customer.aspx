<%@ Page Language="C#" MasterPageFile="~/Frame.Master" AutoEventWireup="true" CodeBehind="w_sheet_cmd_customer.aspx.cs"
    Inherits="Saving.Applications.cmd.w_sheet_cmd_customer" Title="Untitled Page"
    ValidateRequest="false" %>

<%@ Register Assembly="WebDataWindow" Namespace="Sybase.DataWindow.Web" TagPrefix="dw" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <%=initJavaScript %>
    <%=changedis%>
    <%=changePostcode%>
    <%=newClear%>
    <%=postStatus_repair%>
    <%=postparner%>
    <script type="text/javascript">

        function Validate() {
            return confirm("ยืนยันการบันทึกข้อมูล?");
        }
        function MenubarNew() {
            if (confirm("ยืนยันการล้างข้อมูลบนหน้าจอ")) {
                newClear();
            }
        }
        function Dw_mainChanged(sender, row, columnName, newValue) {
            switch (columnName) {
                case "status_repair":
                    objDw_main.SetItem(row, columnName, newValue);
                    objDw_main.AcceptText();
                    Gcoop.GetEl("HdStatus_repair").value = newValue;
                    postStatus_repair();
                    break;
            }
        }

        function Dw_listClick(sender, row, name) {
            var parner_id = objDw_list.GetItem(row, "parner_id");
            Gcoop.GetEl("HdParner_id").value = parner_id;
            postparner();
        }

        function itemChange(sender, rowNumber, columnName, newValue) {
            if (columnName == "province") {
                objDw_detail.SetItem(rowNumber, columnName, newValue);
                Gcoop.GetEl("HdProvince").value = newValue;
                objDw_detail.AcceptText();
                changedis();
            }
            if (columnName == "district") {
                objDw_detail.SetItem(rowNumber, columnName, newValue);
                Gcoop.GetEl("HdDistrict").value = newValue;
                objDw_detail.AcceptText();
                changePostcode();
            }
            //            else if (columnName == "district") {
            //                objDw_detail.SetItem(rowNumber, columnName, newValue);
            //                objDw_detail.AcceptText();
            //                changePostcode();
            //            }
        }
        //        function Dw_detailClick(sender, row, name) {
        //            if (name == "district") {
        //                if (objDw_detail.GetItem(1, "province") == null || objDw_detail.GetItem(1, "province") == "") {
        //                    alert("กรุณาเลือก \"จังหวัดก่อน");
        //                    return 2;
        //                }
        //            }
        //            else if (name == "tambol") {
        //                if (objDw_detail.GetItem(1, "district") == null || objDw_detail.GetItem(1, "district") == "" && objDw_detail.GetItem(1, "province") == null || objDw_detail.GetItem(1, "province") == "") {
        //                    alert("กรุณาเลือก \"อำเภอก่อน");
        //                    return 2;
        //                }
        //            }
        //        }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlace" runat="server">
    <asp:Literal ID="LtServerMessage" runat="server"></asp:Literal>
    <asp:HiddenField ID="HdStatus_repair" runat="server" />
    <asp:HiddenField ID="HdParner_id" runat="server" />
    <asp:HiddenField ID="HdProvince" runat="server" />
    <asp:HiddenField ID="HdDistrict" runat="server" />
    <table style="width: 100%;">
        <tr>
            <td colspan="2" align="left">
                <dw:WebDataWindowControl ID="Dw_main" runat="server" DataWindowObject="d_cmd_status_repair"
                    LibraryList="~/DataWindow/Cmd/customer.pbl" AutoRestoreContext="False" AutoRestoreDataCache="True"
                    AutoSaveDataCacheAfterRetrieve="True" ClientScriptable="True" ClientEventItemChanged="Dw_mainChanged">
                </dw:WebDataWindowControl>
            </td>
        </tr>
        <tr>
            <td rowspan="2" valign="top">
                <dw:WebDataWindowControl ID="Dw_list" runat="server" DataWindowObject="d_stk_customernew1"
                    LibraryList="~/DataWindow/Cmd/customer.pbl" AutoRestoreContext="False" AutoRestoreDataCache="True"
                    AutoSaveDataCacheAfterRetrieve="True" ClientScriptable="True" ClientEventClicked="Dw_listClick">
                </dw:WebDataWindowControl>
            </td>
            <td valign="top" align="left">
                <div class="searchform">
                    <asp:Panel ID="pnl_search" runat="server" Visible="false">
                        <input id="txt_search" type="text" value="type to search..." onclick="clearTXT('txt_search')"
                            onkeyup="searchPage('txt_search',event)" style="width: 220px;" />
                        <div class="div_dropdown" id="div_list">
                        </div>
                        <asp:HiddenField ID="hidden_WIN_OBJECT" runat="server" />
                        <asp:HiddenField ID="hidden_WIN_DESCRIPTION" runat="server" />
                    </asp:Panel>
                </div>
                <%--พิมพ์รายชื่อที่ต้องการค้นหา แล้วกด "Enter"
                <asp:TextBox ID="TextBox1" runat="server" Width="430px" Height="25px" BackColor="#CCCCFF"></asp:TextBox>--%>
            </td>
        </tr>
        <tr>
            <td>
                <dw:WebDataWindowControl ID="Dw_detail" runat="server" DataWindowObject="d_stk_customer"
                    LibraryList="~/DataWindow/Cmd/customer.pbl" AutoRestoreContext="False" AutoRestoreDataCache="True"
                    AutoSaveDataCacheAfterRetrieve="True" ClientScriptable="True" ClientEventItemChanged="itemChange"
                    ClientEventClicked="Dw_detailClick">
                </dw:WebDataWindowControl>
                &nbsp;
            </td>
        </tr>
    </table>
</asp:Content>
