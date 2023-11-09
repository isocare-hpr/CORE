<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="w_acc_popup_trilebalance.aspx.cs" Inherits="Saving.Applications.cmd.dlg.w_acc_popup_trilebalance" %>

<%@ Register Assembly="WebDataWindow" Namespace="Sybase.DataWindow.Web" TagPrefix="dw" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
     <script type="text/javascript">

         function click(sender, rowNumber, objectName) {
             var account_year = objDw_main.GetItem(rowNumber, "account_year");
             var isConfirm = confirm("ยืนยันต้องการเลือกข้อมูล " + account_year );
             window.location = "?account_year=" + objDw_main.GetItem(rowNumber, "account_year");
             return 1;
           
         }
        // function selectRow จากdatawindow  "objd_sl_product_search_list" 
        // ส่งค่าตาม Request ของ main window ด้วยฟังค์ชั่น--->Getitem_idFromDlg(product_id, product_name);
         // จากนั้นก็จะปิดตัวเองลง
        
        function selectRow(sender, rowNumber, objectName) {

            var account_year = objDw_detail.GetItem(rowNumber, "account_year");
            var period = objDw_detail.GetItem(rowNumber, "period");
            var isConfirm = confirm("ยืนยันต้องการเลือกข้อมูล " + account_year + ":" + period);
            if (isConfirm) {
                window.opener.Getitem_idFromDlg(account_year, period);
                window.close();
            }
        }
    </script>
    
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:Panel ID="Panel1" runat="server" BorderColor="#99CCFF" BorderWidth="2px" Width="550px">
        <dw:WebDataWindowControl ID="Dw_main" runat="server" 
                DataWindowObject="d_acc_start_accyear_delserisenew" Height="100px" 
                LibraryList="~/DataWindow/Cmd/calculate_depreciationnew.pbl" Width="550px" 
                ClientEventClicked="click" ClientScriptable="True">
        </dw:WebDataWindowControl>
            <dw:WebDataWindowControl ID="Dw_detail" runat="server" 
                DataWindowObject="d_acc_popup_period" LibraryList="~/DataWindow/Cmd/calculate_depreciationnew.pbl" 
                Height="250px" Width="550px" ClientEventClicked="selectRow" 
                ClientScriptable="True">
            </dw:WebDataWindowControl>
        </asp:Panel>
        
    </div>
    </form>
</body>
</html>
