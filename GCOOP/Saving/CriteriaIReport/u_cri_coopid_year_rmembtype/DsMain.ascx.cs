using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CoreSavingLibrary;

namespace Saving.CriteriaIReport.u_cri_coopid_year_rmembtype
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
            this.DropDownDataBind(sql, "as_coopid", "coop_name", "coop_id");
        }

        public void DdMembtype()
        {
            string sql = @"
                select membtype_code , trim( membtype_code ) || trim(membtype_desc ) as display , 1 as sorter  from mbucfmembtype
                union
                select '00','กรุณาเลือก',0 from dual
                order by sorter,membtype_code"
            ;
            sql = WebUtil.SQLFormat(sql);
            this.DropDownDataBind(sql, "as_smembtype", "display", "membtype_code");
            this.DropDownDataBind(sql, "as_emembtype", "display", "membtype_code");
        }
    }
}