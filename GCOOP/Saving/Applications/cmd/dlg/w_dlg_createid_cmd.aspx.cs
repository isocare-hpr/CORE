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

using Sybase.DataWindow;
using DataLibrary;
using CoreSavingLibrary.WcfNCommon;


namespace Saving.Applications.cmd.dlg
{
    public partial class w_dlg_createid_cmd : PageWebDialog, WebDialog
    {
        protected String newClear;
        protected String changetitemtype;
        protected String getProduct;
        protected String changetDomain;
        protected String saveWebSheet;
        String newDocNo = "";
        String itemtype_id;
        String itemtypechk;
        private DwThDate tdw_create;
        private string sqlStr;

        protected String jsPostblank;

        #region WebDialog Member

        public void InitJsPostBack()
        {
            newClear = WebUtil.JsPostBack(this, "newClear");
            changetitemtype = WebUtil.JsPostBack(this, "changetitemtype");
            getProduct = WebUtil.JsPostBack(this, "getProduct");
            changetDomain = WebUtil.JsPostBack(this, "changetDomain");
            saveWebSheet = WebUtil.JsPostBack(this, "saveWebSheet");
            jsPostblank = WebUtil.JsPostBack(this, "jsPostblank");
            tdw_create = new DwThDate(dw_create, this);

            tdw_create.Add("operate_date", "operate_tdate");
        }

        public void WebDialogLoadBegin()
        {
            try
            {
                this.ConnectSQLCA();
                Hcreate_id.Value = "";
                dw_create.SetTransaction(sqlca);

                if (!IsPostBack)
                {
                    itemtype_id = Request["ch_b"].ToString().Trim();
                    Hitemtype_id.Value = itemtype_id;
                    PostTextField(Hitemtype_id.Value);

                    if (dw_create.RowCount < 1)
                    {
                        dw_create.InsertRow(0);
                        dw_create.SetItemString(1, "entry_id", state.SsUsername);
                        dw_create.SetItemDateTime(1, "operate_date", state.SsWorkDate);
                        //dw_create.SetItemString(1, "operate_tdate", state.SsWorkDate.ToString("ddMMyyyy"));
                        dw_create.SetItemString(1, "itemtype_id", itemtype_id);
                    }
                }
                else
                {
                    try
                    {
                        //dw_create.RestoreContext();
                        this.RestoreContextDw(dw_create);

                        itemtype_id = Hitemtype_id.Value;
                        PostTextField(itemtype_id);
                    }
                    catch (Exception ex)
                    {
                        String err = ex.ToString();
                    }
                }
            }
            catch (Exception ex) { ex.ToString(); }
        }

        public void CheckJsPostBack(string eventArg)
        {
            switch (eventArg)
            {
                case "newClear":
                    NewClear();
                    break;
                case "changetitemtype":
                    Changetitemtype();
                    break;
                case "getProduct":
                    GetProduct();
                    break;
                case "changetDomain":
                    ChangetDomain();
                    break;
                case "saveWebSheet":
                    SaveWebSheet();
                    break;
                case "jsPostblank": //HC ThDate
                    String date = dw_create.GetItemString(1, "operate_tdate");
                    int day = Convert.ToInt16(date.Substring(0, 2));
                    int month = Convert.ToInt16(date.Substring(2, 2));
                    int year = Convert.ToInt16(date.Substring(4, 4)) - 543;
                    DateTime dt = new DateTime(year, month, day);
                    dw_create.SetItemDateTime(1, "operate_date", dt);
                    break;
            }
        }

        public void SaveWebSheet()
        {
            try
            {
                String product_id = dw_create.GetItemString(1, "product_id").Trim();
                if (product_id == "AUTO" || product_id == null)
                {
                    n_commonClient comm = wcf.NCommon;
                    Int32 maxdoc = Convert.ToInt32(comm.of_getnewdocno(state.SsWsPass,state.SsCoopId, "CMDPRODUCT"));
                    String itemtype_id = dw_create.GetItemString(1, "itemtype_id");
                    String domain_id = dw_create.GetItemString(1, "domain_id");
                    String group_id = dw_create.GetItemString(1, "group_id");
                    String product_name = dw_create.GetItemString(1, "product_name");
                    String subgroup_id = "";
                    String coop_id = state.SsCoopId;
                    DateTime operate_date = state.SsWorkDate;
                    String operate_tdate = "";
                    String operate_sdate = "";
                    String owner = "";
                    try { operate_date = dw_create.GetItemDateTime(1, "operate_date"); }
                    catch { operate_date = state.SsWorkDate; }
                    operate_tdate = operate_date.ToString("dd/MM/yyyy", WebUtil.EN);
                    Hoperate_date.Value = dw_create.GetItemString(1, "operate_tdate");
                    try { owner = dw_create.GetItemString(1, "owner"); }
                    catch { owner = ""; }
                    //                    Sta ta = new Sta(sqlca.ConnectionString);
                    //                    String sql = @"  SELECT   
                    //                                        MAX( PTNMLSUBGROUP.SUBGROUP_ID)  as SUBGROUP_ID
                    //                                 FROM PTNMLSUBGROUP  
                    //                                  WHERE ( PTNMLSUBGROUP.DOMAIN_ID ='" + domain_id + @"' ) and  
                    //                                         ( PTNMLSUBGROUP.GROUP_ID ='" + group_id + @"' ) and 
                    //                                      ( PTNMLSUBGROUP.ITEMTYPE_ID ='" + itemtype_id + "' )";
                    //                    Sdt td = ta.Query(sql);
                    //                    if (td.Next())
                    //                    {
                    //                        String subgroup = td.GetString("SUBGROUP_ID");
                    //                        Int32 maxsubgroup = Convert.ToInt32(subgroup) + 1;
                    //                        subgroup_id = maxsubgroup.ToString("000");
                    //                    }

                    try
                    {
                        Sta ta = new Sta(sqlca.ConnectionString);
                        String sql = @"  SELECT  MAX( PTNMLSUBGROUP.SUBGROUP_ID)  as SUBGROUP_ID
                                         FROM PTNMLSUBGROUP  
                                         WHERE ( PTNMLSUBGROUP.DOMAIN_ID ='" + domain_id + @"' ) and  
                                               ( PTNMLSUBGROUP.GROUP_ID ='" + group_id + @"' ) and 
                                               ( PTNMLSUBGROUP.ITEMTYPE_ID ='" + itemtype_id + @"' ) and 
                                               ( PTNMLSUBGROUP.coop_id ='" + coop_id + @"') and
                                               ( PTNMLSUBGROUP.OWNER = '" + owner + @"')
                                      ";
                        Sdt td = ta.Query(sql);
                        if (td.Next())
                        {
                            String subgroup = td.GetString("SUBGROUP_ID");
                            Int32 maxsubgroup = Convert.ToInt32(subgroup) + 1;
                            subgroup_id = maxsubgroup.ToString("00");
                        }
                    }
                    catch
                    {
                        String subgroup = "00"; //SUBGROUP_ID
                        Int32 maxsubgroup = Convert.ToInt32(subgroup) + 1;
                        subgroup_id = maxsubgroup.ToString("00");
                    }

                    Sta taInsert = new Sta(sqlca.ConnectionString);
                    try
                    {
                        String sql_sub = @" INSERT INTO PTNMLSUBGROUP  
                                     ( DOMAIN_ID,   
                                       GROUP_ID,   
                                       SUBGROUP_ID,   
                                       ITEMTYPE_ID,   
                                       SUBGROUP_NAME,   
                                       TITLENAME,   
                                       CUS_SUBGROUP_ID,
                                       COOP_ID,
                                       OWNER
                                     )  
                              VALUES ( '" + domain_id + @"',   
                                       '" + group_id + @"',   
                                       '" + subgroup_id + @"',   
                                       '" + itemtype_id + @"',   
                                       '" + product_name + @"',   
                                       null,   
                                       null,
                                       '" + coop_id + @"',
                                       '" + owner + @"'
                                      )";
                        taInsert.Exe(sql_sub);
                    }
                    catch (Exception ex) { ex.ToString(); }

                    operate_tdate = operate_date.ToString("dd.MM.yyyy", WebUtil.TH);
                    operate_sdate = string.Format("{0:d/M/yyyy}", operate_date);
                    if (itemtype_id == "01") { newDocNo = owner + "-" + group_id + "-" + subgroup_id + "(" + operate_tdate + ")"; }
                    else { newDocNo = itemtype_id + domain_id + group_id + subgroup_id; }

                    dw_create.SetItemString(1, "product_id", itemtype_id + maxdoc.ToString("000000"));
                    try
                    {
                        Sta taInsert2 = new Sta(sqlca.ConnectionString);
                        sqlStr = @"INSERT INTO ptnmlitemcreatemas (create_id,
                                                               domain_id,
                                                                group_id,
                                                             subgroup_id,
                                                             itemtype_id,
                                                                entry_id,
                                                            operate_date,
                                                                 coop_id,
                                                                   owner
                                                    )
                                             VALUES ('" + newDocNo + @"',
                                                    '" + domain_id + @"',
                                                     '" + group_id + @"',
                                                  '" + subgroup_id + @"',
                                                  '" + itemtype_id + @"',
                                             '" + state.SsUsername + @"',
                                             to_date('" + operate_sdate + @"','DD/MM/YYYY'),
                                                      '" + coop_id + @"',
                                                        '" + owner + @"'
                                                    )";
                        taInsert2.Exe(sqlStr);
                        taInsert2.Close();
                    }
                    catch (Exception ex) { ex.ToString(); }
                    dw_create.SetItemString(1, "create_id", newDocNo);
                    String b_name, model_name, unit_id;
                    Decimal qty_max, qty_reorder;
                    try { unit_id = dw_create.GetItemString(1, "unit_id"); }
                    catch { unit_id = ""; }
                    try { b_name = dw_create.GetItemString(1, "b_name"); }
                    catch { b_name = ""; }
                    try { model_name = dw_create.GetItemString(1, "model_name"); }
                    catch { model_name = ""; }
                    try { qty_max = dw_create.GetItemDecimal(1, "qty_max"); }
                    catch { qty_max = 0; }
                    try { qty_reorder = dw_create.GetItemDecimal(1, "qty_reorder"); }
                    catch { qty_reorder = 0; }
                    String productid = itemtype_id + maxdoc.ToString("000000");
                    String createid = newDocNo;
                    String xmldw_detail = dw_create.Describe("DataWindow.Data.XML");
                    //   dw_create.UpdateData(); 
                    //SaveData_Detail();//สร้าง CREATE_ID
                    try
                    {
                        sqlStr = @"  INSERT INTO PTNMLPRODUCT  
                                         ( PRODUCT_ID,   
                                           PRODUCTSTATUS_ID,   
                                           CREATE_ID,        
                                           PRODUCT_NAME,   
                                           B_NAME,   
                                           MODEL_NAME,   
                                           QTY_MAX,   
                                           QTY_REORDER,   
                                           UNIT_ID, 
                                           COOP_ID )  
                                  VALUES ( '" + productid + @"',    
                                           '001',    
                                           '" + createid + @"',                                                     
                                           '" + product_name + @"',   
                                           '" + b_name + @"',   
                                           '" + model_name + @"',   
                                           " + qty_max + @",   
                                           " + qty_reorder + @",   
                                           '" + unit_id + @"',
                                           '" + coop_id + "')";
                        taInsert.Exe(sqlStr);
                        taInsert.Close();
                    }
                    catch (Exception ex) { ex.ToString(); }
                    Hcreate_id.Value = newDocNo;
                  
                   
                }
                else
                {
                    dw_create.UpdateData();
                }
                tdw_create.Eng2ThaiAllRow();
            }
            catch (Exception ex)
            {
                String err = ex.ToString();
            }
        }

        public void WebDialogLoadEnd()
        {
            tdw_create.Eng2ThaiAllRow();
            dw_create.SaveDataCache();
            ChangetDomain();
            Changetitemtype();
        }

        #endregion

        #region Function

        private void ChangetDomain()
        {
            try
            {
                if (dw_create.GetItemString(1, "group_id") != null)
                {
                    DataWindowChild child = dw_create.GetChild("group_id");
                    child.SetTransaction(sqlca);
                    child.Retrieve();
                    String domain_id = dw_create.GetItemString(1, "domain_id");
                    String itemtype_id = dw_create.GetItemString(1, "itemtype_id");
                    child.SetFilter("domain_id='" + domain_id + "' and  itemtype_id='" + itemtype_id + "' ");
                    child.Filter();
                }
            }
            catch (Exception ex)
            {
                String err = ex.ToString();
            }
            PostTextField(Hitemtype_id.Value);
        }

        private void SaveData_Detail()
        {
            Sta taInsert = new Sta(sqlca.ConnectionString);
            try
            {
                String itemtype_id = dw_create.GetItemString(1, "itemtype_id");
                String domain_id = dw_create.GetItemString(1, "domain_id");
                String group_id = dw_create.GetItemString(1, "group_id");
                String entry_id = dw_create.GetItemString(1, "entry_id");
                String subgroup_id = "";
                DateTime operate_date = state.SsWorkDate;
                String operate_tdate = "";
                try { operate_date = dw_create.GetItemDateTime(1, "operate_date"); }
                catch { operate_date = state.SsWorkDate; }
                operate_tdate = operate_date.ToString("dd/MM/yyyy", WebUtil.EN);
                Sta ta = new Sta(sqlca.ConnectionString);
                String sql = @"  SELECT  MAX( PTNMLSUBGROUP.SUBGROUP_ID)  as SUBGROUP_ID
                                 FROM PTNMLSUBGROUP  
                                 WHERE ( PTNMLSUBGROUP.DOMAIN_ID ='" + domain_id + @"' ) and  
                                       ( PTNMLSUBGROUP.GROUP_ID ='" + group_id + @"' ) and 
                                       ( PTNMLSUBGROUP.ITEMTYPE_ID ='" + itemtype_id + @"') and 
                                       ( PTNMLSUBGROUP.coop_id ='" + state.SsCoopId + "') ";
                Sdt td = ta.Query(sql);
                if (td.Next())
                {
                    subgroup_id = td.GetString("SUBGROUP_ID");
                }

                String sqlinsert = @"  INSERT INTO PTNMLITEMCREATEMAS ( CREATE_ID,    
                                                                        DOMAIN_ID,  
                                                                         GROUP_ID,
                                                                      SUBGROUP_ID, 
                                                                      ITEMTYPE_ID, 
                                                                         ENTRY_ID,
                                                                     OPERATE_DATE, 
                                                                          COOP_ID )  
                                                     VALUES ( '" + newDocNo + @"',
                                                             '" + domain_id + @"', 
                                                              '" + group_id + @"', 
                                                           '" + subgroup_id + @"',
                                                           '" + itemtype_id + @"', 
                                                              '" + entry_id + @"', 
                                 to_date('" + operate_tdate + @"', 'dd/mm/yyyy') ,
                                                        '" + state.SsCoopId + @"') ";
                taInsert.Exe(sqlinsert);
                //Hoperate_date.Value = operate_tdate;
            }
            catch (Exception ex)
            {
                String err = ex.ToString();
            }
            taInsert.Close();
        }

        private void NewClear()
        {
            try
            {
                dw_create.Reset();
                dw_create.InsertRow(0);
                dw_create.SetItemString(1, "entry_id", state.SsUsername);
                dw_create.SetItemDateTime(1, "operate_date", state.SsWorkDate);
                //dw_create.SetItemString(1, "operate_tdate", state.SsWorkDate.ToString("ddMMyyyy"));
                //dw_detail.Reset();
                //dw_detail.InsertRow(0);
                //dw_detail.SetItemString(1, "entry_id", state.SsUsername);
            }
            catch (Exception ex)
            {
                String err = ex.ToString();
            }
        }

        private void Changetitemtype()
        {
            try
            {
                if (dw_create.GetItemString(1, "domain_id") != null)
                {
                    DataWindowChild child = dw_create.GetChild("domain_id");
                    child.SetTransaction(sqlca);
                    child.Retrieve();
                    String itemtype_id = dw_create.GetItemString(1, "itemtype_id");
                    child.SetFilter("itemtype_id='" + itemtype_id + "'");
                    child.Filter();
                }
            }
            catch (Exception ex)
            {
                String err = ex.ToString();
            }

            itemtypechk = Hitemtype_id.Value;
            PostTextField(itemtypechk);
        }

        private void GetProduct_id()
        {
            String product_id = null;
            try
            {
                product_id = dw_create.GetItemString(1, "product_id");
                dw_create.Reset();
                dw_create.Retrieve(product_id);
            }
            catch
            {
                product_id = null;
                dw_create.Reset();
            }
        }

        private void GetProduct()
        {
            dw_create.Reset();
            dw_create.InsertRow(1);
            String create_id = newDocNo;
            Sta ta = new Sta(sqlca.ConnectionString);

            try
            {
                String sqlselect = @"   SELECT PTNMLPRODUCT.PRODUCT_ID,   
                                 PTNMLPRODUCT.PRODUCT_NAME,                                     
                                 PTNMLPRODUCT.PRODUCTSTATUS_ID,   
                                 PTNMLPRODUCT.QTY_MAX,   
                                 PTNMLPRODUCT.QTY_REORDER, 
                                 PTNMLPRODUCT.B_NAME,   
                                 PTNMLPRODUCT.MODEL_NAME,    PTNMLPRODUCT.UNIT_ID, 
                                 PTNMLITEMCREATEMAS.CREATE_ID,   
                                 PTNMLITEMCREATEMAS.DOMAIN_ID,   
                                 PTNMLITEMCREATEMAS.GROUP_ID,   
                                 PTNMLITEMCREATEMAS.SUBGROUP_ID,   
                                 PTNMLITEMCREATEMAS.ITEMTYPE_ID , PTNMLITEMCREATEMAS.ENTRY_ID, coop_id
                            FROM PTNMLPRODUCT,   
                                 PTNMLITEMCREATEMAS  
                           WHERE ( PTNMLPRODUCT.CREATE_ID = PTNMLITEMCREATEMAS.CREATE_ID )    
                           AND   ( PTNMLITEMCREATEMAS.CREATE_ID = '" + create_id + @"'  
                           AND   ( PTNMLITEMCREATEMAS.coop_id = '" + state.SsCoopId + "') ";

                Sdt td = ta.Query(sqlselect);
                if (td.Next())
                {
                    String product_id = td.GetString("PRODUCT_ID");
                    String group_id = td.GetString("GROUP_ID");
                    String itemtype_id = td.GetString("ITEMTYPE_ID");
                    String domain_id = td.GetString("DOMAIN_ID");
                    String entry_id = td.GetString("ENTRY_ID");
                    String product_name = td.GetString("PRODUCT_NAME");
                    String unit_id = td.GetString("UNIT_ID");
                    String b_name = td.GetString("B_NAME");
                    String model_name = td.GetString("MODEL_NAME");
                    Double qty_max = td.GetDouble("QTY_MAX");
                    Double qty_reorder = td.GetDouble("QTY_REORDER");
                    dw_create.SetItemString(1, "product_id", product_id);
                    dw_create.SetItemString(1, "create_id", create_id);
                    dw_create.SetItemString(1, "domain_id", domain_id);
                    dw_create.SetItemString(1, "itemtype_id", itemtype_id);
                    dw_create.SetItemString(1, "group_id", group_id);
                    dw_create.SetItemString(1, "product_name", product_name);
                    dw_create.SetItemString(1, "unit_id", unit_id);
                    dw_create.SetItemString(1, "b_name", b_name);
                    dw_create.SetItemString(1, "model_name", model_name);
                    dw_create.SetItemString(1, "entry_id", entry_id);
                    dw_create.SetItemDouble(1, "qty_max", qty_max);
                    dw_create.SetItemDouble(1, "qty_reorder", qty_reorder);
                    ChangetDomain_g();
                }
            }
            catch (Exception ex)
            {
                String err = ex.ToString();
            }
            //   ta.Close();
        }

        private void ChangetDomain_g()
        {
            try
            {
                if (dw_create.GetItemString(1, "group_id") != null)
                {
                    DataWindowChild child = dw_create.GetChild("group_id");
                    child.SetTransaction(sqlca);
                    child.Retrieve();
                    String domain_id = dw_create.GetItemString(1, "domain_id");
                    String group_id = dw_create.GetItemString(1, "group_id");
                    child.SetFilter("domain_id='" + domain_id + "' and  group_id='" + group_id + "' ");
                    child.Filter();
                }
            }
            catch (Exception ex)
            {
                String err = ex.ToString();
            }
            PostTextField(Hitemtype_id.Value);
        }

        private void PostTextField(string itemtype_id) //change Label
        {
            try
            {
                //itemtypechk = Request["ch_b1"].ToString().Trim();
                String setting1 = dw_create.Describe("product__name_t.text");
                String setting2 = dw_create.Describe("b_name_t.text");
                String setting3 = dw_create.Describe("model_name_t.text");
                String setting4 = dw_create.Describe("product_id_t.text");

                switch (itemtype_id)
                {
                    case "01":
                        try
                        {
                            dw_create.Modify("product__name_t.text='ชื่อครุภัณฑ์:'");
                            dw_create.Modify("b_name_t.text='ชื่อยี่ห้อครุภัณฑ์:'");
                            dw_create.Modify("model_name_t.text='ชื่อรุ่นครุภัณฑ์'");
                            dw_create.Modify("product_id_t.text='รหัสครุภัณฑ์'");
                        }
                        catch (Exception ex) { ex.ToString(); }
                        break;

                    case "02":
                        try
                        {
                            dw_create.Modify("product__name_t.text='ชื่อวัสดุ:'");
                            dw_create.Modify("b_name_t.text='ชื่อยี่ห้อวัสดุ:'");
                            dw_create.Modify("model_name_t.text='ชื่อรุ่นวัสดุ'");
                            dw_create.Modify("product_id_t.text='รหัสวัสดุ'");
                        }
                        catch (Exception ex) { ex.ToString(); }
                        break;

                    case "03":
                        try
                        {
                            dw_create.Modify("product__name_t.text='ชื่อวัสดุประชาสัมพันธ์:'");
                            dw_create.Modify("b_name_t.text='ชื่อยี่ห้อวัสดุประชาสัมพันธ์:'");
                            dw_create.Modify("model_name_t.text='ชื่อรุ่นวัสดุประชาสัมพันธ์'");
                            dw_create.Modify("product_id_t.text='รหัสวัสดุประชาสัมพันธ์'");
                        }
                        catch (Exception ex) { ex.ToString(); }
                        break;
                }
            }
            catch { itemtype_id = ""; }

        }

        #endregion
    }
}
