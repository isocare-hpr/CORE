<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="w_dlg_st_product_search_repair.aspx.cs"
    Inherits="Saving.Applications.cmd.dlg.w_dlg_st_product_search_repair" %>

<%@ Register Assembly="WebDataWindow" Namespace="Sybase.DataWindow.Web" TagPrefix="dw" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>ค้นหาข้อมูลพัสดุครุภัณฑ์</title>
    <script type="text/javascript">
        // function selectRow จากdatawindow  "objd_sl_product_search_list" 
        // ส่งค่าตาม Request ของ main window ด้วยฟังค์ชั่น--->Getitem_idFromDlg(product_id, product_name);
        // จากนั้นก็จะปิดตัวเองลง
        function OnDetailClick(sender, rowNumber, objectName) {

            var product_id = objdw_detail.GetItem(rowNumber, "product_id");
            var create_id = objdw_detail.GetItem(rowNumber, "create_id");
            var itemtype_id = objdw_detail.GetItem(rowNumber, "itemtype_id");
            var product_name = objdw_detail.GetItem(rowNumber, "product_name");
            var product_bal = objdw_detail.GetItem(rowNumber, "product_bal");
            //            var isConfirm = confirm("ยืนยันต้องการเลือกข้อมูล " + create_id + ":" + product_name);
            //            if (isConfirm) {
            window.opener.Getitem_idFromDlg(product_id, product_name, itemtype_id, create_id, product_bal);
            window.close();
            //            }
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <asp:Panel ID="Panel1" runat="server" Width="540px" Font-Bold="True" Font-Names="tahoma"
        Font-Size="12px" ForeColor="#660033" GroupingText="ค้นหาข้อมูลพัสดุ-ครุภัณฑ์">
        <table style="width: 540px;">
            <tr>
                <td>
                    <dw:WebDataWindowControl ID="Dw_main" runat="server" ClientScriptable="True" DataWindowObject="d_sl_product_search_criteria_repair"
                        LibraryList="~/DataWindow/Cmd/pointofsale_repair.pbl" Width="470px" ClientEventButtonClicked="b_search_click">
                    </dw:WebDataWindowControl>
                </td>
                <td>
                    <asp:Button ID="b_search" runat="server" Text="ค้นหา" Height="50px" Width="50px"
                        OnClick="b_search_Click" />
                </td>
            </tr>
        </table>
    </asp:Panel>
    <div>
        <asp:Panel ID="Panel2" runat="server" Width="540px" Font-Bold="True" Font-Names="tahoma"
            Font-Size="12px" ForeColor="#660033" GroupingText="รายละเอียดการค้น">
            <dw:WebDataWindowControl ID="dw_detail" runat="server" DataWindowObject="d_sl_product_search_list_repair"
                LibraryList="~/DataWindow/Cmd/pointofsale_repair.pbl" Width="530px" Style="top: 0px;
                left: 0px" RowsPerPage="15" HorizontalScrollBar="NoneAndClip" VerticalScrollBar="NoneAndClip"
                ClientEventClicked="OnDetailClick" ClientScriptable="True">
                <PageNavigationBarSettings NavigatorType="NumericWithQuickGo" Visible="True">
                </PageNavigationBarSettings>
            </dw:WebDataWindowControl>
        </asp:Panel>
    </div>
    <asp:HiddenField ID="HSqlTemp" runat="server" Value="0" Visible="False" />
    </form>
</body>
</html>
