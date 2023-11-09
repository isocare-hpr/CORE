<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="w_dlg_alert_destitute.aspx.cs"
    Inherits="Saving.Applications.cmd.dlg.w_dlg_alert_destitute" %>

<%@ Register Assembly="WebDataWindow" Namespace="Sybase.DataWindow.Web" TagPrefix="dw" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>เตือนพัสดุ-ครุภัณฑ์ใกล้หมด</title>
</head>
<body>
    <form id="form2" runat="server">
    <asp:Panel ID="Panel2" runat="server" Width="580px" Font-Bold="True" Font-Names="tahoma"
        Font-Size="12px" ForeColor="#660033" GroupingText="เตือนพัสดุ-ครุภัณฑ์">
        <dw:WebDataWindowControl ID="Dw_main" runat="server" DataWindowObject="d_alert_destitute"
            LibraryList="~/DataWindow/Cmd/productdetai.pbl">
        </dw:WebDataWindowControl>
    </asp:Panel>
    <asp:HiddenField ID="HSqlTemp" runat="server" Value="0" Visible="False" />
    </form>
</body>
</html>
