using System;
using CoreSavingLibrary;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;

namespace Saving.Applications.cmd.dlg
{
    public partial class w_dlg_alert_destitute : System.Web.UI.Page
    {
        private WebState state;
        private DwTrans sqlca;
        private string is_sql;


        protected void Page_Load(object sender, EventArgs e)
        {
            state = new WebState(Session, Request);
            if (state.IsLogin)
            {
                sqlca = new DwTrans();
                sqlca.Connect();
                Dw_main.SetTransaction(sqlca);

                //try
                //{
                //    if (!IsPostBack)
                //    {
                //        HSqlTemp.Value = is_sql;
                //    }
                //}
                //catch { }

               // Dw_main.SetSqlSelect(HSqlTemp.Value);
                Dw_main.Retrieve();

            }
            else
            {

            }
        }

        protected void Page_LoadComplete()
        {
            try
            {
                sqlca.Disconnect();
            }
            catch { }
        }

      
    }
}
