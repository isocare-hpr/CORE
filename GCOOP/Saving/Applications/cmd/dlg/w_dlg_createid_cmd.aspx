<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="w_dlg_createid_cmd.aspx.cs"
    Inherits="Saving.Applications.cmd.dlg.w_dlg_createid_cmd" %>

<%@ Register Assembly="WebDataWindow" Namespace="Sybase.DataWindow.Web" TagPrefix="dw" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <%--<%=initDataWindow %>--%>
    <%=newClear%>
    <%=changetitemtype%>
    <%=getProduct%>
    <%=changetDomain%>
    <%=saveWebSheet%>
    <%=jsPostblank %>
    <title>Withdraw Page</title>
    <script type="text/javascript">

        function ValidateForm() {
            var alertstr = "";
            var domain_id = objdw_create.GetItem(1, "domain_id");
            var group_id = objdw_create.GetItem(1, "group_id");
            var product_name = objdw_create.GetItem(1, "product_name");
            var unit_id = objdw_create.GetItem(1, "unit_id");
            if (domain_id == "เลือกหมวด") { alertstr = alertstr + "- กรุณาเลือกหมวด\n"; }
            if (group_id == "เลือกกลุ่ม") { alertstr = alertstr + "- กรุณาเลือกกลุ่ม\n"; }
            if (product_name == "" || product_name == null) { alertstr = alertstr + "- กรุณากรอกชื่อ\n"; }
            if (unit_id == "" || unit_id == null) { alertstr = alertstr + "- กรุณากรอกหน่วย\n"; }
            if (alertstr == "") {
                return true;
            } else {
                alert(alertstr);
                return false;
            }
        }

        function SaveWebSheet() {
            var result = false;
            result = ValidateForm();
            if (result == true) {
                saveWebSheet();
            }
        }

        function DialogLoadComplete() {
            var create_id = Gcoop.GetEl("Hcreate_id").value;
            var operate_tdate = objdw_create.GetItem(1, "operate_tdate");
            if (create_id != "") {
                window.opener.GetProductFromDlgCreate(create_id, operate_tdate);
                window.close();
            }
        }

        function GetProductFromDlg(create_id) {
            Gcoop.GetEl("Hproduct_id").value = create_id;
            getProduct();
        }

        function itemChange(sender, row, column, newValue) {
            sender.SetItem(row, column, newValue);
            sender.AcceptText();
            if (column == "itemtype_id") {
                Gcoop.GetEl("Hitemtype_id").value = newValue; //chk Label
                changetitemtype();
            } else if (column == "domain_id") {

                changetDomain();
            }
            else if (column == "operate_tdate") {
                jsPostblank();
            }
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <asp:Literal ID="LtServerMessage" runat="server"></asp:Literal>
    <asp:HiddenField ID="Hproduct_id" runat="server" />
    <asp:HiddenField ID="Hcreate_id" runat="server" />
    <asp:HiddenField ID="Hitemtype_id" runat="server" />
    <asp:HiddenField ID="Hoperate_date" runat="server" />
    <dw:WebDataWindowControl ID="dw_create" runat="server" DataWindowObject="d_stk_prodct"
        LibraryList="~/DataWindow/Cmd/cmd_item_cr.pbl" Width="620px" AutoRestoreContext="False"
        AutoRestoreDataCache="True" AutoSaveDataCacheAfterRetrieve="True" ClientScriptable="True"
        ClientEventItemChanged="itemChange" ClientFormatting="True">
    </dw:WebDataWindowControl>
    <input id="b_save" style="width: 100px; height: 35px; color: White; font-size: medium;
        font-weight: bold; background-color: Green;" type="button" onclick="SaveWebSheet()"
        value="บันทึก" />
    </form>
</body>
</html>
