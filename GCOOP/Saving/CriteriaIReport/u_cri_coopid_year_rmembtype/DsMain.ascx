<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="DsMain.ascx.cs" Inherits="Saving.CriteriaIReport.u_cri_coopid_year_rmembtype.DsMain" %>
<link id="css1" runat="server" href="../../JsCss/DataSourceTool.css" rel="stylesheet"
    type="text/css" />
<asp:FormView ID="FormView1" runat="server" DefaultMode="Edit">
    <EditItemTemplate>
        <table class="iReportDataSourceFormView">
            <tr>
                <td>
                    <div>
                        <span>สาขา:</span>
                    </div>
                </td>
                <td >
                    <asp:DropDownList ID="as_coopid" runat="server">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td>
                    <div>
                        <span>ปี:</span></div>
                </td>
                <td >
                    <asp:TextBox ID="as_year" runat="server" Style="text-align: center"></asp:TextBox>
                </td>
            </tr>
             <tr>
                <td>
                    <div>
                        <span>ตั้งแต่สังกัด:</span></div>
                </td>
                <td >
                    <asp:DropDownList ID="as_smembtype" runat="server">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td>
                    <div>
                        <span>ถึงสังกัด:</span></div>
                </td>
                <td >
                    <asp:DropDownList ID="as_emembtype" runat="server">
                    </asp:DropDownList>
                </td>
            </tr>
        </table>
    </EditItemTemplate>
</asp:FormView>
