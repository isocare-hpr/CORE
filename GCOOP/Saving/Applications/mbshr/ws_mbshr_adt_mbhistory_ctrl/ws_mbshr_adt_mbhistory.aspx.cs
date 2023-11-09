﻿using System;
using CoreSavingLibrary;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Saving.Applications.mbshr.ws_mbshr_adt_mbhistory_ctrl
{
    public partial class ws_mbshr_adt_mbhistory : PageWebSheet, WebSheet
    {
        [JsPostBack]
        public String PostSearch { get; set; }
        [JsPostBack]
        public String PostDetail { get; set; }


        public void InitJsPostBack()
        {
            dsMain.InitDsMain(this);
            dsList.InitDsList(this);
            dsDetail.InitDsDetail(this);
        }

        public void WebSheetLoadBegin()
        {
            if (!IsPostBack)
            {
                dsList.Visible = false;
                dsDetail.Visible = false;
            }
        }

        public void CheckJsPostBack(string eventArg)
        {
            if (eventArg == "PostSearch")
            {
                String search = "";


                int sdate = dsMain.DATA[0].START_DATE.Year;
                int edate = dsMain.DATA[0].END_DATE.Year;
                //1/1/2043 0:00:00
                if ((sdate > 1900) && (edate > 1900))
                {
                    search += "and trunc(sys_logmodtb.entry_date) between to_date('" + dsMain.DATA[0].START_DATE.ToString("dd/MM/yyyy", WebUtil.EN) + @"','dd/MM/yyyy') 
                               and to_date('" + dsMain.DATA[0].END_DATE.ToString("dd/MM/yyyy",WebUtil.EN) + "','dd/MM/yyyy')";
                }

                if (dsMain.DATA[0].DOC_NO != "")
                {
                    search += "and sys_logmodtb.clmkey_desc like '%" + dsMain.DATA[0].DOC_NO + "%' ";
                }

                if (dsMain.DATA[0].USER_ID != "")
                {
                    search += "and sys_logmodtb.entry_id like '%" + dsMain.DATA[0].USER_ID + "%' ";
                }

                dsList.Visible = true;
                dsList.RetrieveList(search);
            }
            else if (eventArg == "PostDetail")
            {
                dsDetail.Visible = true;
                int row = Convert.ToInt32(HdCheckRow.Value);
                String doc_no = dsList.DATA[row].MODTBDOC_NO;
                dsDetail.RetrieveDetail(doc_no);
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