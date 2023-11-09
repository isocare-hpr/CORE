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
using DataLibrary;
using Sybase.DataWindow;

namespace Saving.Applications.cmd.dlg
{
    public partial class w_acc_popup_trilebalance : System.Web.UI.Page
    {
        private DwTrans SQLCA;

        protected void Page_Load(object sender, EventArgs e)
        {
            SQLCA = new DwTrans();
            SQLCA.Connect();
            Dw_main.SetTransaction(SQLCA);
            Dw_detail.SetTransaction(SQLCA);
            Dw_main.Retrieve();
          
            if (!IsPostBack)
            {
                Dw_detail.InsertRow(0);
            }   
        
           try
           {   //เช็คค่าการรับ Request ว่าไม่ใช่ค่าว่าง
               if (Request["account_year"] != null && Request["account_year"].Trim() != "")
               {
                   //เป็นการ  Retrieve ข้อมูลของ datawindow
                   Dw_detail.Retrieve(Request["account_year"].Trim());
                 
               }
           }
           catch { }


        }

        protected void Page_LoadComplete()
        {
            SQLCA.Disconnect();
        }
           
    }
}
