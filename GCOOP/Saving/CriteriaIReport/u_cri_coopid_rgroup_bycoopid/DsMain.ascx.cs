﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CoreSavingLibrary;
using System.Data;

namespace Saving.CriteriaIReport.u_cri_coopid_rgroup_bycoopid
{
    public partial class DsMain : DataSourceFormView
    {
        public DataSet1.DataTable1DataTable DATA { get; set; }

        public void InitDsMain(PageWeb pw)
        {
            css1.Visible = false;
            DataSet1 ds = new DataSet1();
            this.DATA = ds.DataTable1;
            this.InitDataSource(pw, FormView1, this.DATA, "dsMain");
            this.EventItemChanged = "OnDsMainItemChanged";
            this.EventClicked = "OnDsMainClicked";
            this.Register();
        }

        public void DdMembgroup()
        {
            string sql = @"
                select membgroup_code,membgroup_code||' '||membgroup_desc as display,1 as sorter from mbucfmembgroup 
                union
                select '','',0 from dual
                order by sorter,membgroup_code"
            ;
            sql = WebUtil.SQLFormat(sql);
            this.DropDownDataBind(sql, "membgroup_start", "display", "membgroup_code");
            this.DropDownDataBind(sql, "membgroup_end", "display", "membgroup_code");
        }

        public void DdCoopId()
        {
            String sql = @"select coop_id, coop_name from cmcoopmaster";
            sql = WebUtil.SQLFormat(sql);
            DataTable dt = WebUtil.Query(sql);
            this.DropDownDataBind(dt, "coop_id", "coop_name", "coop_id");
            this.DropDownDataBind(dt, "coop_id2", "coop_name", "coop_id");
        }
    }
}