<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="DsList.ascx.cs" Inherits="Saving.Applications.mbshr_const.w_sheet_mb_mbucfresigncause_ctrl.DsList" %>
<link id="css1" runat="server" href="../../../JsCss/DataSourceTool.css" rel="stylesheet"
    type="text/css" />
<link id="css2" runat="server" href="../../JsCss/DataSourceTool.css" rel="stylesheet"
    type="text/css" />
<asp:Panel ID="Panel1" runat="server" HorizontalAlign="Center">
    <table class="DataSourceRepeater">
        <tr>
            <th width="10%">
                รหัส
            </th>
            <th width="80%">
                สาเหตุการลาออก
            </th>
            <th width="10%">
                ลบ
            </th>
        </tr>
    </table>
</asp:Panel>
<asp:Panel ID="Panel2" runat="server" Height="520px" ScrollBars="Auto" HorizontalAlign="Center">
    <table class="DataSourceRepeater">
        <asp:Repeater ID="Repeater1" runat="server">
            <ItemTemplate>
                <tr>
                    <td width="10%">
                        <asp:TextBox ID="RESIGNCAUSE_CODE" runat="server" Style="text-align: center;"></asp:TextBox>
                    </td>
                    <td width="80%">
                        <asp:TextBox ID="RESIGNCAUSE_DESC" runat="server"></asp:TextBox>
                    </td>
                    <td width="10%">
                        <asp:Button ID="b_del" runat="server" Text="ลบ" />
                    </td>
                </tr>
            </ItemTemplate>
        </asp:Repeater>
    </table>
</asp:Panel>
