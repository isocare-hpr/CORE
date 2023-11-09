﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using CoreSavingLibrary;

namespace Saving.Applications.mbshr_const.ws_mb_ucfmemgrp_ctrl
{
    public partial class DsList : DataSourceRepeater
    {
        public DataSet1.MBUCFMEMBGROUPDataTable DATA { get; set; }
        public void InitDsList(PageWeb pw)
        {
            css1.Visible = false;
            css2.Visible = false;

            DataSet1 ds = new DataSet1();
            this.DATA = ds.MBUCFMEMBGROUP;
            this.EventItemChanged = "OnDsListItemChanged";
            this.EventClicked = "OnDsListClicked";
            this.InitDataSource(pw, Repeater1, this.DATA, "dsList");
            this.Button.Add("b_delete");
            this.Button.Add("b_detail");
            this.Register();
        }
        public void RetrieveList(string membgroup_control)
        {
            string sql = @"select coop_id,
                membgroup_code,
                membgroup_control,
                membgroup_desc,
                membgroup_agentgrg ,
                addr_no,
                addr_moo,
                addr_soi,
                addr_road,
                addr_tambol,
                addr_amphur,
                trim(addr_province) as addr_province,
                addr_phone,
                addr_fax,
                membgrptype_code
            from mbucfmembgroup
            where ( coop_id = {0} )
                and ( trim(membgroup_control) = {1} ) 
                order by membgroup_code ASC";
            sql = WebUtil.SQLFormat(sql, state.SsCoopId, membgroup_control);
            DataTable dt = WebUtil.Query(sql);
            this.ImportData(dt);

        }
    }
}