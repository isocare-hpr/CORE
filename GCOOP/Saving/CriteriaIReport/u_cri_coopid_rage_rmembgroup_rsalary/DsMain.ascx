<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="DsMain.ascx.cs" Inherits="Saving.CriteriaIReport.u_cri_coopid_rage_rmembgroup_rsalary.DsMain" %>
<link id="css1" runat="server" href="../../JsCss/DataSourceTool.css" rel="stylesheet"
    type="text/css" />
<asp:FormView ID="FormView1" runat="server" DefaultMode="Edit" >
    <EditItemTemplate>
        <table class="iReportDataSourceFormView">
            <tr>
                <td>
                    <div>
                        <span>สหกรณ์:</span>
                    </div>
                </td>
                <td colspan="5">
                    <asp:DropDownList ID="coop_id" runat="server">
                    </asp:DropDownList>
                </td>
            </tr>

            <tr>
                <td>
                    <div>
                        <span>ช่วงอายุ :</span>
                    </div>
                </td>
                <td colspan="2">
                    <asp:TextBox ID="S_AGE" runat="server">
                    </asp:TextBox>
                </td>
           <td> - </td>
                <td colspan="2">
                    <asp:TextBox ID="E_AGE" runat="server">
                    </asp:TextBox>
                </td>
            </tr>

            <tr>
                <td>
                    <div>
                        <span>ตั้งแต่สังกัด:</span>
                    </div>
                </td>
                <td colspan="5">
                    <asp:DropDownList ID="S_MEMBGROUP" runat="server">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td>
                    <div>
                        <span>ถึงสังกัด:</span>
                    </div>
                </td>
                <td colspan="5">
                    <asp:DropDownList ID="E_MEMBGROUP" runat="server">
                    </asp:DropDownList>
                </td>
            </tr>
             <tr>
                <td>
                    <div>
                        <span>เงินเดือน :</span>
                    </div>
                </td>
                <td colspan="2">
                    <asp:TextBox ID="S_SALARY"  runat="server">
                    </asp:TextBox>
                </td>
           <td> - </td>
                <td colspan="2">
                    <asp:TextBox ID="E_SALARY"  runat="server">
                    </asp:TextBox>
                </td>
            </tr>
        </table>
    </EditItemTemplate>
</asp:FormView>
