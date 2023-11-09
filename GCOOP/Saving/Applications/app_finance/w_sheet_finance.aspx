﻿<%@ Page Language="C#" MasterPageFile="~/Frame.Master" AutoEventWireup="true" CodeBehind="w_sheet_finance.aspx.cs"
    Inherits="Saving.Applications.app_finance.w_sheet_finance" Title="Untitled Page" %>

<%@ Register Assembly="WebDataWindow" Namespace="Sybase.DataWindow.Web" TagPrefix="dw" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <%=initJavaScript %>
    <%=postInitUser %>
    <%=postChangeTeller %>
    <%=postPrintSlip %>
    <script type="text/javascript">

        function Validate() {
            objDwMain.AcceptText();
            return confirm("ยืนยันการบันทึกข้อมูล");
        }

        function MenubarNew() {
            if (confirm("ยืนยันการลบข้อมูล ??")) {
                window.location = Gcoop.GetUrl() + "Applications/app_finance/w_sheet_finance.aspx";
            }
        }

        function DwMainButtonClicked(sender, rowNumber, buttonName) {
            if (buttonName == "b_user") {
                Gcoop.OpenIFrame(500, 520, "w_dlg_fin_showuser.aspx", "");
            }
        }

        function DwMainItemChanged(sender, rowNumber, columnName, newValue) {
            objDwMain.SetItem(rowNumber, columnName, newValue);
            if (columnName == "item_type") {
                Gcoop.GetEl("HfTeller").value = newValue;
                Gcoop.GetEl("HfColumn").value = columnName;
                objDwMain.AcceptText();
                postChangeTeller();
            }
            else if (columnName == "operate_amt") {
                Gcoop.GetEl("HfValue").value = newValue;
                Gcoop.GetEl("HfColumn").value = columnName;
                objDwMain.AcceptText();
                postChangeTeller();
            }
            else if (columnName == "entry_id") {
                objDwMain.AcceptText();
                postInitUser();
            }
        }

        function AlertFin(type, status) {
            if (type == 11 && status == 11) {
                alert("มีสถานะเปิดอยู่แล้ว  ไม่สามารถเปิดได้อีก");
            }
            else if (type == 14 && status == 14) {
                alert("ยังไม่ทำการเปิดลิ้นชัก หรือ มีสถานะปิดลิ้นชักแล้ว");
            }
            else if (type == 15 && status == 14) {
                alert("ต้องมีสถานะเปิดลิ้นชักเท่านั้น");
            }
            else if (type == 16 && status == 14) {
                alert("ต้องมีสถานะเปิดลิ้นชักเท่านั้น");
            }
        }

        function SelectUser(username, full_name) {
            objDwMain.SetItem(1, "entry_id", username);
            Gcoop.GetEl("HfFullName").value = full_name;
            objDwMain.AcceptText();
            postInitUser();
        }

        function SheetLoadComplete() {
            if (Gcoop.GetEl("Hprintslip").value == "true") {
                Gcoop.GetEl("Hprintslip").value = "false";

               // if (confirm("ยืนยันการพิมพ์ใบทำรายการเบิก-จ่ายเงินสด")) {
               //     Gcoop.GetEl("Hprintslip").value = "false";
              //      postPrintSlip();
              //  }
            }
        }

        function DwUserLIstClick(sender, rowNumber, objectName) {
            var userName = objDwUserList.GetItem(rowNumber, "user_name");
            objDwMain.SetItem(1, "entry_id", userName);
            objDwMain.AcceptText();
            postInitUser();
        }
        
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlace" runat="server">
    <asp:Literal ID="LtServerMessage" runat="server"></asp:Literal>
    <asp:Literal ID="LtAlert" runat="server"></asp:Literal>
    <table border="0">
        <tr>
            <td valign="top">
                <asp:Panel ID="Panel1" runat="server" ScrollBars="Auto" Height="300px" Width="140px">
                    <dw:WebDataWindowControl ID="DwUserList" runat="server" AutoRestoreContext="False"
                        AutoRestoreDataCache="True" ClientScriptable="True" DataWindowObject="d_fn_user_all"
                        Height="80px" LibraryList="~/DataWindow/app_finance/finquery.pbl" AutoSaveDataCacheAfterRetrieve="True"
                        ClientEventClicked="DwUserLIstClick">
                    </dw:WebDataWindowControl>
                </asp:Panel>
            </td>
            <td>
                <dw:WebDataWindowControl ID="DwMain" runat="server" DataWindowObject="d_controlcash"
                    LibraryList="~/DataWindow/App_finance/finance.pbl" ClientEventButtonClicked="DwMainButtonClicked"
                    ClientScriptable="True" AutoRestoreContext="false" AutoRestoreDataCache="true"
                    ClientEventItemChanged="DwMainItemChanged" AutoSaveDataCacheAfterRetrieve="True"
                    ClientFormatting="True">
                </dw:WebDataWindowControl>
            </td>
        </tr>
    </table>
    <asp:HiddenField ID="HfColumn" runat="server" />
    <asp:HiddenField ID="HfFullName" runat="server" />
    <asp:HiddenField ID="HfTeller" runat="server" />
    <asp:HiddenField ID="HfValue" runat="server" />
    <asp:HiddenField ID="HfCashAmt" runat="server" />
    <asp:HiddenField ID="HfMoneyRemain" runat="server" />
    <asp:HiddenField ID="Husername" runat="server" />
    <asp:HiddenField ID="Happname" runat="server" />
    <asp:HiddenField ID="Hseqno" runat="server" />
    <asp:HiddenField ID="Hprintslip" runat="server" Value="false" />
</asp:Content>
