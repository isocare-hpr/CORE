using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DataLibrary;
using CoreSavingLibrary;

namespace Saving.Applications.mbshr_const.ws_mb_ucfmemgrp_ctrl
{
    public partial class ws_mb_ucfmemgrp : PageWebSheet, WebSheet
    {
        [JsPostBack]
        public String PostDeleteRow { get; set; }
        [JsPostBack]
        public String PostGroupControl { get; set; }
        [JsPostBack]
        public String RefreshSheet { get; set; }

        public void InitJsPostBack()
        {

            dsSearch.InitDsSearch(this);
            dsList.InitDsList(this);
        }

        public void WebSheetLoadBegin()
        {
            if (!IsPostBack)
            {
                dsSearch.DdGroupControl();
            }
        }

        public void CheckJsPostBack(string eventArg)
        {
            if (eventArg == PostDeleteRow)
            {
                int ls_row = dsList.GetRowFocus();
                string ls_membgroup_code = dsList.DATA[ls_row].MEMBGROUP_CODE;

                ExecuteDataSource exed1 = new ExecuteDataSource(this);

                string sql = "delete from mbucfmembgroup where coop_id='" + state.SsCoopId + "' and membgroup_code='" + ls_membgroup_code + "'";
                exed1.SQL.Add(sql);
                exed1.Execute();

                LtServerMessage.Text = WebUtil.CompleteMessage("ลบข้อมูลสำเร็จ");
                dsList.RetrieveList(dsSearch.DATA[0].cp_groupcontrol);
            }
            else if (eventArg == PostGroupControl)
            {
                dsList.RetrieveList(dsSearch.DATA[0].cp_groupcontrol);
            }
            else if (eventArg == RefreshSheet)
            {
                dsList.RetrieveList(dsSearch.DATA[0].cp_groupcontrol);
            }
        }

        public void SaveWebSheet()
        {

        }

        public void WebSheetLoadEnd()
        {

        }


    }
}