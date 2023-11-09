using System;
using CoreSavingLibrary;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Xml.Linq;
using Sybase.DataWindow;
using CoreSavingLibrary.WcfCommon;
using DataLibrary;

namespace Saving.Applications.cmd
{
    public partial class w_sheet_cmd_customer : PageWebSheet, WebSheet
    {
        protected String changedis;
        protected String changePostcode;
        protected String newClear;
        String newDocNo = "";
        protected String postStatus_repair;
        protected String postparner;
        string pbl = "customer.pbl";

        #region WebSheet Members

        public void InitJsPostBack()
        {
            changedis = WebUtil.JsPostBack(this, "changedis");
            changePostcode = WebUtil.JsPostBack(this, "changePostcode");
            newClear = WebUtil.JsPostBack(this, "newClear");
            postStatus_repair = WebUtil.JsPostBack(this, "postStatus_repair");
            postparner = WebUtil.JsPostBack(this, "postparner");
        }

        public void WebSheetLoadBegin()
        {
            this.ConnectSQLCA();
            Dw_main.SetTransaction(sqlca);
            Dw_detail.SetTransaction(sqlca);
            Dw_list.SetTransaction(sqlca);

            String status_repair = "";
            String parner_id = "";
            try
            {
                status_repair = Request["status_repair"];
                parner_id = Request["parner_id"];
            }
            catch { status_repair = ""; parner_id = ""; }

            if (!IsPostBack)
            {
                Dw_main.InsertRow(0);
                Dw_list.InsertRow(0);
                Dw_detail.InsertRow(0);
            }
            else
            {
                try
                {
                    Dw_main.RestoreContext();
                    Dw_list.RestoreContext();
                    Dw_detail.RestoreContext();
                }
                catch { }
            }

            if (state.IsReadable)
            {
                try
                {
                    if (Request["status_repair"] != null && Request["status_repair"].Trim() != "")
                    {
                        Dw_list.Retrieve(Request["status_repair"].Trim());
                    }
                }
                catch { }
                try
                {
                    if (Request["parner_id"] != null && Request["parner_id"].Trim() != "")
                    {
                        Dw_detail.Retrieve(Request["parner_id"].Trim());
                    }
                }
                catch { }
            }
        }

        public void CheckJsPostBack(string eventArg)
        {
            switch (eventArg)
            {
                case "changedis":
                    Changedis();
                    break;
                case "changePostcode":
                    ChangePostcode();
                    break;
                case "newClear":
                    NewClear();
                    break;
                case "postStatus_repair":
                    PostStatus_repair();
                    break;
                case "postparner":
                    Postparner();
                    break;
            }
        }

        public void SaveWebSheet()
        {
            //try
            //{
            //    Dw_detail.InsertRow(0);
            //    CommonClient comm = wcf.Common;
            //    Int32 maxdoc = Convert.ToInt32(comm.GetNewDocNo(state.SsWsPass, "CMDSTKDOCNO"));
            //    newDocNo = maxdoc.ToString("000");
            //    Dw_detail.SetItemString(1, "parner_id", newDocNo);
            //    Dw_detail.UpdateData();
            //    Dw_detail.Reset();
            //    Dw_detail.InsertRow(0);
            //}
            //catch (Exception ex)
            //{
            //    String err = ex.ToString();
            //}
//---
            Sta ta = new Sta(sqlca.ConnectionString);
            String sqlStr;
            String parner_id;
            String PARNER_ID = "";
            Decimal PARNER_MAXID;
            try
            {
                try { parner_id = Dw_detail.GetItemString(1, "parner_id"); }
                catch { parner_id = ""; }
                //Dw_detail.InsertRow(0);
                //Common comm = WsCalling.Common;
                //Int32 maxdoc = Convert.ToInt32(comm.GetNewDocNo(state.SsWsPass, "CMDSTKDOCNO"));
                //newDocNo = maxdoc.ToString("000");
                //Dw_detail.SetItemString(1, "parner_id", newDocNo);
                sqlStr = @" SELECT *
                           FROM   PTNMLCUSTOMERMAS
                           WHERE (PARNER_ID =  '" + parner_id + "') ";
                Sdt dt = ta.Query(sqlStr);

                if (!dt.Next())
                {
                    String sql = @" SELECT MAX(PARNER_ID) AS PARNER_ID
                                    FROM PTNMLCUSTOMERMAS ";
                    Sdt dt2 = ta.Query(sql);
                    if (dt2.Next())
                    {
                        PARNER_ID = dt2.GetString("PARNER_ID");
                        PARNER_MAXID = Convert.ToDecimal(PARNER_ID);
                        PARNER_MAXID += 1;
                        PARNER_ID = PARNER_MAXID.ToString("000");

                        Dw_detail.SetItemString(1, "parner_id", PARNER_ID);

                        DwUtil.InsertDataWindow(Dw_detail, pbl, "PTNMLCUSTOMERMAS");
                        Dw_detail.Reset();
                        Dw_detail.InsertRow(0);
                        PostStatus_repair();
                    }
                }
                else
                {
                    //Dw_detail.UpdateData();
                    DwUtil.UpdateDataWindow(Dw_detail, pbl, "PTNMLCUSTOMERMAS");
                    Dw_detail.Reset();
                    Dw_detail.InsertRow(0);
                    PostStatus_repair();
                }
            }
            catch (Exception ex)
            {
                String err = ex.ToString();
            }

        }

        public void WebSheetLoadEnd()
        {
            throw new NotImplementedException();
        }

        #endregion

        #region Function

        protected void Dw_detail_BeginUpdate(object sender, System.ComponentModel.CancelEventArgs e)
        {
            try
            {
                CommonClient comm = wcf.Common;
                Int32 maxdoc = Convert.ToInt32(comm.GetNewDocNo(state.SsWsPass, "CMDSTKDOCNO"));
                newDocNo = maxdoc.ToString("000");
                Dw_detail.SetItemString(1, "parner_id", newDocNo);
                Dw_detail.Reset();

            }
            catch (Exception ex)
            {
                String err = ex.ToString();
            }

        }

        protected void Dw_detail_EndUpdate(object sender, Sybase.DataWindow.EndUpdateEventArgs e)
        {
            if (true)
            {
                sqlca.Commit();
            }
        }

        protected void Changedis()
        {
            try
            {
                if (Dw_detail.GetItemString(1, "district") != null)
                {
                    DataWindowChild childdis = Dw_detail.GetChild("district");
                    childdis.SetTransaction(sqlca);
                    childdis.Retrieve();
                    String provincecode = Dw_detail.GetItemString(1, "province");
                    childdis.SetFilter("province_code='" + provincecode + "'");
                    childdis.Filter();
                }
            }
            catch (Exception ex)
            {
                String err = ex.ToString();
            }

        }

        protected void ChangePostcode()
        {
            try
            {
                Changedis();
                String district_code = Dw_detail.GetItemString(1, "district");
                String sql = @"SELECT POSTCODE   FROM MBUCFDISTRICT
                                WHERE DISTRICT_CODE = '" + district_code + "' ";
                Sdt dtpostcode = WebUtil.QuerySdt(sql);
                if (dtpostcode.Next())
                {
                    Dw_detail.SetItemSqlString(1, "postcode", dtpostcode.GetString("postcode"));
                }

                //DataWindowChild childdis = Dw_detail.GetChild("district");
                //childdis.SetTransaction(sqlca);
                //childdis.Retrieve();
                //String provincecode = Dw_detail.GetItemString(1, "province");
                //childdis.SetFilter("province_code='" + provincecode + "'");
                //childdis.Filter();
                //----------------------------------------------------------------
                //DataWindowChild childpostcode = Dw_detail.GetChild("postcode");
                //childpostcode.SetTransaction(sqlca);
                //childpostcode.Retrieve();
                //String district = Dw_detail.GetItemString(1, "district");
                //String district_code = WebUtil.Right(district, 3);

                //childpostcode.SetFilter("district_code='" + district_code + "'");
                //childpostcode.Filter();
            }
            catch (Exception ex)
            {
                String err = ex.ToString();
            }

        }

        //protected void ChangePostcode()
        //{

        //    DataWindowChild childpostcode = Dw_detail.GetChild("postcode");
        //    childpostcode.SetTransaction(SQLCA);
        //    childpostcode.Retrieve();
        //    String district = Dw_detail.GetItemString(1, "district");
        //    String district_code=WebUtil.Right(district, 3);

        //    childpostcode.SetFilter("district_code='" + district_code + "'");
        //    childpostcode.Filter();


        //}

        private void NewClear()
        {
            try
            {
                Dw_main.Reset();
                Dw_list.Reset();
                Dw_detail.Reset();
                Dw_main.InsertRow(0);
                Dw_list.InsertRow(0);
                Dw_detail.InsertRow(0);
            }
            catch { }
        }

        public void PostStatus_repair()
        {
            //try
            //{
            //    String status_repair = HdStatus_repair.Value;
            //    Dw_list.Retrieve(status_repair);
            //    Dw_detail.Reset();
            //    Dw_detail.InsertRow(0);
            //}
            //catch (Exception ex) { ex.ToString(); }

            String parner_id = HdStatus_repair.Value;
            Dw_list.Retrieve(parner_id);
            Dw_detail.Reset();
            Dw_detail.InsertRow(0);
        }

        public void Postparner()
        {
            String province_id = "", district_id = "";
            String parner_id = HdParner_id.Value;

            DwUtil.RetrieveDataWindow(Dw_detail, pbl, null, parner_id);

            try { province_id = Dw_detail.GetItemString(1, "province"); }
            catch { province_id = ""; }
            try { district_id = Dw_detail.GetItemString(1, "district"); }
            catch { district_id = ""; }

            Changedis();//!!??

            HdProvince.Value = province_id;
            HdDistrict.Value = district_id;//ยังไม่ได้ลองเมื่อเป็นค่าว่าง
        }

        #endregion

    }
}
