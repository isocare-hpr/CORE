﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using CoreSavingLibrary;

namespace Saving.Applications.mbshr.ws_sl_edit_salary_ctrl
{
    public partial class DsMain : DataSourceFormView
    {
        public DataSet1.DataTable1DataTable DATA { get; set; }

        public void InitDsMain(PageWeb pw)
        {
            css1.Visible = false;
            DataSet1 ds = new DataSet1();
            this.DATA = ds.DataTable1;
            this.EventItemChanged = "OnDsMainItemChanged";
            this.EventClicked = "OnDsMainClicked";
            this.InitDataSource(pw, FormView1, this.DATA, "dsMain");
            this.Button.Add("b_search");
            this.Register();
        }
        public void RetrieveMain(String member_no)
        {
            String sql = @"  select mbmembmaster.coop_id,   
                             mbmembmaster.member_no,   
                             mbmembmaster.prename_code,   
                             mbmembmaster.memb_name,   
                             mbmembmaster.memb_surname,   
                             mbmembmaster.membgroup_code,   
                             mbmembmaster.salary_amount,   
                             mbmembmaster.member_type,   
                             mbmembmaster.incomeetc_amt,   
                             shsharemaster.periodbase_amt,   
                             shsharemaster.periodshare_amt,   
                             shsharetype.unitshare_value,   
                             mbucfprename.prename_desc,   
                             mbucfmembgroup.membgroup_desc,
                             shsharemaster.sharetype_code
                        from mbmembmaster,   
                             shsharemaster,   
                             mbucfmembgroup,   
                             mbucfprename,   
                             shsharetype  
                       where (mbmembmaster.member_no = {1}) and
                             ( mbmembmaster.coop_id = {0} ) and  
                             ( mbmembmaster.coop_id = shsharemaster.coop_id ) and  
                             ( mbmembmaster.coop_id = mbucfmembgroup.coop_id ) and  
                             ( mbmembmaster.member_no = shsharemaster.member_no ) and  
                             ( mbmembmaster.prename_code = mbucfprename.prename_code ) and  
                             ( mbmembmaster.membgroup_code = mbucfmembgroup.membgroup_code ) and  
                             ( shsharemaster.coop_id = shsharetype.coop_id ) and  
                             ( shsharemaster.sharetype_code = shsharetype.sharetype_code )";
            sql = WebUtil.SQLFormat(sql,state.SsCoopControl,member_no);
            DataTable dt = WebUtil.Query(sql);
            this.ImportData(dt);
        }
    }
}