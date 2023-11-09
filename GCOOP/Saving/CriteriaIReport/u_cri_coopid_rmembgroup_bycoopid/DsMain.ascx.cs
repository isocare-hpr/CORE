using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CoreSavingLibrary;

namespace Saving.CriteriaIReport.u_cri_coopid_rmembgroup_bycoopid
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

        public void DdCoopId()
        {
            String sql = @"select coop_id, coop_name from cmcoopmaster ";
            sql = WebUtil.SQLFormat(sql);
            this.DropDownDataBind(sql, "coop_id", "coop_name", "coop_id");
            this.DropDownDataBind(sql, "coop_id2", "coop_name", "coop_id");
        }

        public void DdMembtype()
        {
            string sql = @"
                select membgroup_code , trim( membgroup_code ) || trim(membgroup_desc ) as display , 1 as sorter  from mbucfmembgroup ; 
                union
                select '00','กรุณาเลือก',0 from dual
                order by sorter,membtype_code"
            ;
            sql = WebUtil.SQLFormat(sql);
            this.DropDownDataBind(sql, "smembgroup_code", "display", "membgroup_code");
            this.DropDownDataBind(sql, "emembgroup_code", "display", "membgroup_code");
        }

        
    }
}