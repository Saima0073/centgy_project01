using System;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Reflection;
using SHMA.Enterprise;
using SHMA.Enterprise.Data;
using SHMA.Enterprise.Shared;
using SHMA.Enterprise.Presentation;
using SHMA.Enterprise.Exceptions;
using shsm;
using SHAB.Data;
using SHAB.Business; 
using SHAB.Shared.Exceptions;

namespace SHAB.Presentation
{
	//shgn_gs_se_stdgridscreen_
	public partial class shgn_ss_se_stdscreen_ILUS_ET_UM_USERMANAGMENT : SHMA.Enterprise.Presentation.TwoStepController
	{
	
		//controls

		protected System.Web.UI.HtmlControls.HtmlInputButton btnHideLister;
		protected System.Web.UI.WebControls.Literal _lastEvent;


		protected System.Web.UI.WebControls.Literal MessageScript;
		protected System.Web.UI.WebControls.Literal FooterScript;
		protected System.Web.UI.WebControls.Literal HeaderScript;
		

		private int pageNumber=1;
		int PAGE_SIZE= SHMA.Enterprise.Configuration.AppSettings.GetInt("NoOfListerRows") ;
		private int recordCount=0;
		bool recordSelected = false;
		
		NameValueCollection columnNameValue=null;
	
		string[] AllProcess = {"shsm.SHSM_VerifyTransaction", "shsm.SHSM_RejectTransaction", "dummy_process"};
		string AllowedProcess = "";
		
		shgn.SHGNCommand entityClass;
		
		//============ Agency Setup IBAD CODE 18-FEB-2019	

		protected System.Web.UI.WebControls.CompareValidator Comparevalidator1;
	
		//============ Agency Setup IBAD CODE 18-FEB-2019
				
		#region pk variables declaration		
		private string  USE_USERID;
						
		#endregion
				
		#region Web Form Designer generated code
		override protected void OnInit(EventArgs e) 
		{
			InitializeComponent();
			base.OnInit(e);

			Response.Cache.SetCacheability(HttpCacheability.NoCache);
			Response.Cache.SetExpires(DateTime.Now.AddSeconds(-1));
			Response.Cache.SetNoStore();			
		}
		
		private void InitializeComponent()
		{
			this.lister.ItemDataBound += new System.Web.UI.WebControls.RepeaterItemEventHandler(this.lister_ItemDataBound);
			this.lister.ItemCommand += new System.Web.UI.WebControls.RepeaterCommandEventHandler(this.lister_ItemCommand);
			//============ Agency Setup IBAD CODE 18-FEB-2019

		}
	
		#endregion		


		#region Major methods of First Step		
		protected override void ValidateParams() 
		{
			base.ValidateParams ();			
			string[] param;
			foreach (string key in Request.Params.AllKeys)
			{
				if (key!=null && key.StartsWith("r_"))
				{
					param = Request[key].Split(',');
					SessionObject.Set(key.Replace("r_",""), param[param.Length-1]); 					
				}
			}
		}
		sealed protected override DataHolder GetInputData(DataHolder dataHolder)
		{			
			GetSessionValues();
			CheckKeyLevel();
			//recordCount = USE_USERMASTERDB.RecordCount;
			return   dataHolder;      
		}
	
		sealed protected override void BindInputData(DataHolder dataHolder)
		{
			string usertype=SessionObject.GetString("s_USE_TYPE");
			string bankcode =SessionObject.GetString("s_CCD_CODE");

			IDataReader LAAG_AGENTReader0 = LAAG_AGENTDB.GetDDL_ILUS_ET_UM_USERMANAGMENT_AAG_AGCODE_RO(usertype,bankcode);
			ddlAAG_AGCODE.DataSource = LAAG_AGENTReader0 ;
			ddlAAG_AGCODE.DataBind();
			LAAG_AGENTReader0.Close();

			IDataReader rdr = SmRlRoleDB.GetUserType(usertype);
			ddlUSE_TYPE.DataSource = rdr ;
			ddlUSE_TYPE.DataBind();
			rdr.Close();

			//======= Agency Setup IBAD CODE 18-FEB-2019
			DataTable DTUserType = LAAG_AGENTDB.USE_USERTYPE();
			if (DTUserType.Rows.Count > 0)
			{
				ddlUSE_USERTYPE.DataSource = DTUserType;				
				ddlUSE_USERTYPE.DataBind();
				ddlUSE_USERTYPE.Enabled = false;
			}
			//======= Agency Setup IBAD CODE 18-FEB-2019	
						
			_lastEvent.Text = "New";		

			DataTable table = new DataTable("USE_USERMASTER");
			IDataReader USE_USERMASTERReader;

			if(usertype=="B" && bankcode=="5")
			{
				USE_USERMASTERReader= USE_USERMASTERDB.GetILUS_ET_UM_USERMANAGMENT_lister_RO_ByBank(pageNumber * PAGE_SIZE, PAGE_SIZE);
			}
			else
			{
				USE_USERMASTERReader= USE_USERMASTERDB.GetILUS_ET_UM_USERMANAGMENT_lister_RO(pageNumber * PAGE_SIZE, PAGE_SIZE);
			}

			recordSelected = IsRecordSelected();
			if (recordSelected)
			{
				recordCount = Utilities.Reader2Table(USE_USERMASTERReader, table, PAGE_SIZE, USE_USERMASTER.PrimaryKeys, out pageNumber);
			}
			else
			{
				recordCount = Utilities.Reader2Table(USE_USERMASTERReader, table, PAGE_SIZE, pageNumber);
			}
			USE_USERMASTERReader.Close();
			BindLister(table);							
		

			HeaderScript.Text = EnvHelper.Parse("") ;
			FooterScript.Text = EnvHelper.Parse("") ;
				
			
		
			/************** Array Data Script **************/
			
			
			RegisterArrayDeclaration("AllowedProcess", AllowedProcess);
			pagerList.SelectedIndex = pageNumber-1;		
			
			SetLastEvent();
			SetListerVisibility();
		}
		#endregion
    
		#region Major methods of the final step
		protected override void ValidateRequest() 
		{
			base.ValidateRequest();									
			foreach (string key in USE_USERMASTER.PrimaryKeys)
			{
				Control ctrl = myForm.FindControl("txt" + key);				
				if (ctrl!=null)
				{
					if (ctrl is WebControl)
					{
						//TextBox textBox = (TextBox)ctrl;
						WebControl control = (WebControl)ctrl;
						if ((control.Enabled == false) && (Request[control.UniqueID]!=null))
						{
							control.Enabled = true;
						}				
					}
				}
			}			
		}
		sealed protected override DataHolder GetData(DataHolder dataHolder) 
		{	
			pageNumber = pagerList.SelectedIndex +1;
			//recordCount = USE_USERMASTERDB.RecordCount;
			return dataHolder;
		}      
	
		sealed protected override void ApplyDomainLogic(DataHolder dataHolder)
		{
			SHSM_AuditTrail auditTrail = new SHSM_AuditTrail();
			columnNameValue=new NameValueCollection();
			SaveTransaction = false;	
	
			entityClass=new ace.ILUS_USE_USERMASTER();
			entityClass.setNameValueCollection(columnNameValue);
			
			SHSM_SecurityPermission security;
			switch ((EnumControlArgs)ControlArgs[0])
			{
				case (EnumControlArgs.Save):
					_lastEvent.Text = "Save";
					DB.BeginTransaction();
					SaveTransaction = true;
					dataHolder = new USE_USERMASTERDB(dataHolder).FindByPK(txtUSE_USERID.Text);
					columnNameValue.Add("USE_USERID",txtUSE_USERID.Text.Trim()==""?null:txtUSE_USERID.Text);
					columnNameValue.Add("USE_NAME",txtUSE_NAME.Text.Trim()==""?null:txtUSE_NAME.Text);
					columnNameValue.Add("USE_TYPE",ddlUSE_TYPE.SelectedValue.Trim()==""?null:ddlUSE_TYPE.SelectedValue);
					columnNameValue.Add("AAG_AGCODE",ddlAAG_AGCODE.SelectedValue.Trim()==""?null:ddlAAG_AGCODE.SelectedValue);
					columnNameValue.Add("USE_ACTIVE",ddlUSE_ACTIVE.SelectedValue.Trim()==""?null:ddlUSE_ACTIVE.SelectedValue);
								
					//======= Agency Setup IBAD CODE 18-FEB-2019
					columnNameValue.Add("USE_USERTYPE",ddlUSE_USERTYPE.SelectedValue.Trim()==""?null:ddlUSE_USERTYPE.SelectedValue);
					columnNameValue.Add("USE_JOBDESCRIP",System.DateTime.Now.ToString()==""?null:System.DateTime.Now.ToString());
					columnNameValue.Add("USE_DESIGNATI",ddlAGNTCODE.SelectedValue.Trim()==""?null:ddlAGNTCODE.SelectedValue);
					//======= Agency Setup IBAD CODE 18-FEB-2019

					security = new SHSM_SecurityPermission( Utilities.File2EntityID(this.ToString()), USE_USERMASTER.PrimaryKeys, columnNameValue, "USE_USERMASTER");
					if (security.SaveAllowed)
					{
						entityClass.fsoperationBeforeSave();
						new USE_USERMASTER(dataHolder).Add(columnNameValue,getAllFields(),"ILUS_ET_UM_USERMANAGMENT",null);
						dataHolder.Update(DB.Transaction);
						auditTrail.fssaveAuditLog(Utilities.File2EntityID(this.ToString()),USE_USERMASTER.PrimaryKeys, columnNameValue, SHSM_AuditTrail.DML_OPERATION_INSERT, "USE_USERMASTER");
						entityClass.fsoperationAfterSave();
						_lastEvent.Text = "Save"; 					
						PrintMessage("Record has been saved");
					}
					else
					{
						PrintMessage("You are not autherized to Save.");
					}
					break;
				case (EnumControlArgs.Update):					
					DB.BeginTransaction();
					SaveTransaction = true;
					dataHolder = new USE_USERMASTERDB(dataHolder).FindByPK(txtUSE_USERID.Text);				
					columnNameValue.Add("USE_USERID",txtUSE_USERID.Text.Trim()==""?null:txtUSE_USERID.Text);
					columnNameValue.Add("USE_NAME",txtUSE_NAME.Text.Trim()==""?null:txtUSE_NAME.Text);
					columnNameValue.Add("USE_TYPE",ddlUSE_TYPE.SelectedValue.Trim()==""?null:ddlUSE_TYPE.SelectedValue);
					columnNameValue.Add("AAG_AGCODE",ddlAAG_AGCODE.SelectedValue.Trim()==""?null:ddlAAG_AGCODE.SelectedValue);
					columnNameValue.Add("USE_ACTIVE",ddlUSE_ACTIVE.SelectedValue.Trim()==""?null:ddlUSE_ACTIVE.SelectedValue);

					//======= Agency Setup IBAD CODE 18-FEB-2019
					columnNameValue.Add("USE_USERTYPE",ddlUSE_USERTYPE.SelectedValue.Trim()==""?null:ddlUSE_USERTYPE.SelectedValue);
					columnNameValue.Add("USE_JOBDESCRIP",System.DateTime.Now.ToString()==""?null:System.DateTime.Now.ToString());
					columnNameValue.Add("USE_DESIGNATI",ddlAGNTCODE.SelectedValue.Trim()==""?null:ddlAGNTCODE.SelectedValue);
					//======= Agency Setup IBAD CODE 18-FEB-2019

					security = new SHSM_SecurityPermission( Utilities.File2EntityID(this.ToString()), USE_USERMASTER.PrimaryKeys, columnNameValue, "USE_USERMASTER");
					if (security.UpdateAllowed)
					{
						entityClass.fsoperationBeforeUpdate();
						new USE_USERMASTER(dataHolder).Update(Utilities.File2EntityID(this.ToString()),columnNameValue);
						dataHolder.Update(DB.Transaction);
						auditTrail.fssaveAuditLog(Utilities.File2EntityID(this.ToString()), USE_USERMASTER.PrimaryKeys, columnNameValue, SHSM_AuditTrail.DML_OPERATION_UPDATE, "USE_USERMASTER");
						entityClass.fsoperationAfterUpdate();
						recordSelected = true;
						PrintMessage("Record has been updated");
					}
					else
					{
						PrintMessage("You are not autherized to Update.");
					}
					break;
				case (EnumControlArgs.Delete):
					DB.BeginTransaction();
					SaveTransaction = true;
					dataHolder = new USE_USERMASTERDB(dataHolder).FindByPK(txtUSE_USERID.Text);				
					columnNameValue.Add("USE_USERID",txtUSE_USERID.Text.Trim()==""?null:txtUSE_USERID.Text);
					columnNameValue.Add("USE_NAME",txtUSE_NAME.Text.Trim()==""?null:txtUSE_NAME.Text);
					columnNameValue.Add("USE_TYPE",ddlUSE_TYPE.SelectedValue.Trim()==""?null:ddlUSE_TYPE.SelectedValue);
				    columnNameValue.Add("AAG_AGCODE",ddlAAG_AGCODE.SelectedValue.Trim()==""?null:ddlAAG_AGCODE.SelectedValue);
					columnNameValue.Add("USE_ACTIVE",ddlUSE_ACTIVE.SelectedValue.Trim()==""?null:ddlUSE_ACTIVE.SelectedValue);
					
					//======= Agency Setup IBAD CODE 18-FEB-2019
					columnNameValue.Add("USE_USERTYPE",ddlUSE_USERTYPE.SelectedValue.Trim()==""?null:ddlUSE_USERTYPE.SelectedValue);
					columnNameValue.Add("USE_JOBDESCRIP",System.DateTime.Now.ToString()==""?null:System.DateTime.Now.ToString());
					columnNameValue.Add("USE_DESIGNATI",ddlAGNTCODE.SelectedValue.Trim()==""?null:ddlAGNTCODE.SelectedValue);
					//======= Agency Setup IBAD CODE 18-FEB-2019
					
					security = new SHSM_SecurityPermission( Utilities.File2EntityID(this.ToString()), USE_USERMASTER.PrimaryKeys, columnNameValue, "USE_USERMASTER");
					if (security.DeleteAllowed)
					{
				
						new USE_USERMASTER(dataHolder).Delete(columnNameValue);

						dataHolder.Update(DB.Transaction);
				
						auditTrail.fssaveAuditLog(Utilities.File2EntityID(this.ToString()), USE_USERMASTER.PrimaryKeys, columnNameValue, SHSM_AuditTrail.DML_OPERATION_DELETE, "USE_USERMASTER");
						PrintMessage("Record has been deleted");				
					}
					else
					{
						PrintMessage("You are not autherized to Delete.");
					}

					break;
				case (EnumControlArgs.Process):						
					DB.BeginTransaction();
					SaveTransaction = true;
					dataHolder = new USE_USERMASTERDB(dataHolder).FindByPK(txtUSE_USERID.Text);				
					columnNameValue.Add("USE_USERID",txtUSE_USERID.Text.Trim()==""?null:txtUSE_USERID.Text);
					columnNameValue.Add("USE_NAME",txtUSE_NAME.Text.Trim()==""?null:txtUSE_NAME.Text);
					columnNameValue.Add("USE_TYPE",ddlUSE_TYPE.SelectedValue.Trim()==""?null:ddlUSE_TYPE.SelectedValue);
					columnNameValue.Add("AAG_AGCODE",ddlAAG_AGCODE.SelectedValue.Trim()==""?null:ddlAAG_AGCODE.SelectedValue);
					columnNameValue.Add("USE_ACTIVE",ddlUSE_ACTIVE.SelectedValue.Trim()==""?null:ddlUSE_ACTIVE.SelectedValue);

					//======= Agency Setup IBAD CODE 18-FEB-2019
					columnNameValue.Add("USE_USERTYPE",ddlUSE_USERTYPE.SelectedValue.Trim()==""?null:ddlUSE_USERTYPE.SelectedValue);
					columnNameValue.Add("USE_JOBDESCRIP",System.DateTime.Now.ToString()==""?null:System.DateTime.Now.ToString());
					columnNameValue.Add("USE_DESIGNATI",ddlAGNTCODE.SelectedValue.Trim()==""?null:ddlAGNTCODE.SelectedValue);
					//======= Agency Setup IBAD CODE 18-FEB-2019

					security = new SHSM_SecurityPermission( Utilities.File2EntityID(this.ToString()), USE_USERMASTER.PrimaryKeys, columnNameValue, "USE_USERMASTER");
					string result="";					
					if (_CustomArgName.Value == "ProcessName")
					{
						string processName = _CustomArgVal.Value;	
						if (security.ProcessAllowed(processName))
						{
							Type type = Type.GetType(processName);											
							if (type != null)
							{
								shgn.ProcessCommand proccessCommand = (shgn.ProcessCommand)Activator.CreateInstance(type);
								NameValueCollection[] dataRows = new NameValueCollection[1];
								bool[] SelectedRowIndexes = new bool[1];
								//dataRows[0] = columnNameValue;
								dataRows[0] = getAllFields();
								SelectedRowIndexes[0] = true;
								proccessCommand.setAllFields(getAllFields());
								proccessCommand.setEntityID(Utilities.File2EntityID(this.ToString()));
								proccessCommand.setPrimaryKeys(USE_USERMASTER.PrimaryKeys);
								proccessCommand.setTableName("USE_USERMASTER");
								proccessCommand.setDataRows(dataRows);
								proccessCommand.setSelectedRows(SelectedRowIndexes);
								result = proccessCommand.processing();
								//auditTrail.fssaveAuditLog(Utilities.File2EntityID(this.ToString()), PR_GL_CA_ACCOUNT.PrimaryKeys, columnNameValue, SHSM_AuditTrail.DML_OPERATION_DELETE, "PR_GL_CA_ACCOUNT");
							}
						}
						else
						{
							result = "You are not Autherized to Execute Process.";
						}						
					}	
					recordSelected =true;
					if (result.Length>0)
						PrintMessage(result);
					break;
			}
		}
		
		sealed protected override void DataBind(DataHolder dataHolder)
		{			
			
		  	
			
			USE_USERMASTERDB USE_USERMASTERDB_obj = new USE_USERMASTERDB(dataHolder);		
			IDataReader USE_USERMASTERReader;
			DataTable table = new DataTable("USE_USERMASTER") ;

			if ((EnumControlArgs)ControlArgs[0] == EnumControlArgs.Edit)
			{
				DataRow row = USE_USERMASTERDB_obj.FindByPK(USE_USERID)["USE_USERMASTER"].Rows[0];
				ShowData(row);
			}		
			else
			{
				if ((EnumControlArgs)ControlArgs[0] == EnumControlArgs.Filter)
				{
					pageNumber = 1;
					ViewState["filterCol"] = _CustomArgName.Value;
					ViewState["filterVal"] = _CustomArgVal.Value;
				}

				

				if(SessionObject.GetString("s_USE_TYPE")=="B" && SessionObject.GetString("s_CCD_CODE")=="5")
				{
					if (ViewState["filterVal"]==null || ViewState["filterVal"].ToString().Trim()=="%")
						USE_USERMASTERReader = USE_USERMASTERDB.GetILUS_ET_UM_USERMANAGMENT_lister_RO_ByBank(pageNumber * PAGE_SIZE, PAGE_SIZE);//get_Orders_Data_RO();				
					else
						USE_USERMASTERReader = USE_USERMASTERDB.GetILUS_ET_UM_USERMANAGMENT_lister_filter_RO_ByBank(ViewState["filterCol"].ToString(), ViewState["filterVal"].ToString());//get_Orders_Data_RO(ViewState["filterCol"].ToString(), ViewState["filterVal"].ToString());
				}
				else
				{
					if (ViewState["filterVal"]==null || ViewState["filterVal"].ToString().Trim()=="%")
						USE_USERMASTERReader = USE_USERMASTERDB.GetILUS_ET_UM_USERMANAGMENT_lister_RO(pageNumber * PAGE_SIZE, PAGE_SIZE);//get_Orders_Data_RO();				
					else
						USE_USERMASTERReader = USE_USERMASTERDB.GetILUS_ET_UM_USERMANAGMENT_lister_filter_RO(ViewState["filterCol"].ToString(), ViewState["filterVal"].ToString());//get_Orders_Data_RO(ViewState["filterCol"].ToString(), ViewState["filterVal"].ToString());
				}
					recordCount = Utilities.Reader2Table(USE_USERMASTERReader, table, PAGE_SIZE, pageNumber);
				USE_USERMASTERReader.Close();
	
				BindLister(table);
				if ((EnumControlArgs)ControlArgs[0] == EnumControlArgs.Delete)
					RefreshDataFields();
				if ((EnumControlArgs)ControlArgs[0] == EnumControlArgs.Save)
				{
					ShowData(dataHolder["USE_USERMASTER"].Rows[0]);
				}		
			}
			/* a temporary work arround for errors in save replace it later with proper error flow */
			if (_lastEvent.Text == EnumControlArgs.View.ToString())
			{
				SHSM_SecurityPermission security = new SHSM_SecurityPermission( Utilities.File2EntityID(this.ToString()), USE_USERMASTER.PrimaryKeys, columnNameValue, "USE_USERMASTER");
				if (!security.UpdateAllowed)
					_lastEvent.Text = EnumControlArgs.View.ToString() ;
				else
				{
					if (ControlArgs[0] != null)
						_lastEvent.Text = ControlArgs[0].ToString();
				}
			}
			else
			{
				if ((EnumControlArgs)ControlArgs[0] == EnumControlArgs.Save)
				{
					_lastEvent.Text = EnumControlArgs.Edit.ToString();	
				}			
				else
				{
					if((EnumControlArgs)ControlArgs[0] == EnumControlArgs.Delete)
					{
						_lastEvent.Text = "New";
					}
					else
						_lastEvent.Text = ((EnumControlArgs)ControlArgs[0]).ToString();
				}
			}
			//for header & footer script					
			RegisterArrayDeclaration("AllowedProcess", AllowedProcess);	

			HeaderScript.Text = EnvHelper.Parse("");
			FooterScript.Text = EnvHelper.Parse("");

			pagerList.SelectedIndex = pageNumber - 1;			
			
			
			SetLastEvent();
			SetListerVisibility();
		}
		#endregion	

		#region Events
		//======= Agency Setup IBAD CODE 18-FEB-2019
		protected void ddlAGNTCODE_SelectedIndexChanged(object sender, System.EventArgs e)
		{		
			
			if (ddlAGNTCODE.SelectedIndex > 0)
			{
				if (txtAGNTCODE != null)
				{
					//======= Agency Setup IBAD CODE 18-FEB-2019
					DataTable DTAgentDet = LAAG_AGENTDB.SearchAgent(ddlAGNTCODE.SelectedValue);
					if (DTAgentDet.Rows.Count > 0)
					{
						ddlUSE_USERTYPE.SelectedValue = DTAgentDet.Rows[0]["AAG_BROKER"].ToString();
						ddlUSE_USERTYPE.Enabled=false;						
						txtAGNTCODE.Text = DTAgentDet.Rows[0]["AGNTCODE"].ToString(); 
						txtUSE_NAME.Text = DTAgentDet.Rows[0]["AAG_NAME"].ToString();
						txtUSE_USERID.Text = DTAgentDet.Rows[0]["AGNTCODE"].ToString(); 
					}
					if(ddlUSE_TYPE.SelectedValue == "S")
					{ txtUSE_USERID.Text = "BSO" + txtUSE_USERID.Text; }

					if (ddlUSE_TYPE.SelectedValue == "M")
					{ txtUSE_USERID.Text = "BM" + txtUSE_USERID.Text;}
					//======= Agency Setup IBAD CODE 18-FEB-2019					
				}	
				
			}			
		}
		
		protected void Button1_Click_1(object sender, System.EventArgs e)
		{
			//Response.Write("<script>alert('Button Clicked')</script>");
					
			ViewState["Name"] = txtUSE_NAME.Text;
			//txtUSE_NAME.Text = Hidden1.Value;
			//txtUSE_NAME.Attributes.Add("readonly", "readonly");
			if (txtAGNTCODE.Text != null)
			{
				ddlUSE_USERTYPE.ClearSelection();
				//======= Agency Setup IBAD CODE 18-FEB-2019
				DataTable DTAgentDet = LAAG_AGENTDB.SearchAgent(txtAGNTCODE.Text);
				if (DTAgentDet.Rows.Count > 0)
				{
					ddlAGNTCODE.DataSource = DTAgentDet;
					ddlAGNTCODE.DataBind();			
						
				}
				//======= Agency Setup IBAD CODE 18-FEB-2019
				if (ViewState["Name"] != null)
				{
					txtUSE_NAME.Text = 	ViewState["Name"].ToString();
				}
			}
				
			
		}
		//======= Agency Setup IBAD CODE 18-FEB-2019

		protected void pagerList_SelectedIndexChanged(object sender, System.EventArgs e) 
		{
			pageNumber = pagerList.SelectedIndex+1;
			ControlArgs=new object[1];
			ControlArgs[0]=EnumControlArgs.Pager;
			DoControl();
			pagerList.SelectedIndex=pageNumber-1;
		}
		private void btnViewAll_Click(object sender, System.EventArgs e) 
		{
			ControlArgs=new object[1];
			ControlArgs[0]=EnumControlArgs.Cancel  ;
			DoControl();
		}
		
		private void lister_ItemCommand(object source, System.Web.UI.WebControls.RepeaterCommandEventArgs e) 
		{
			foreach (RepeaterItem item in lister.Items)
			{
				if (item == e.Item)
				{
					((HtmlTableRow)item.FindControl("ListerRow")).Attributes["class"] = "ListerSelItem";
				}
				else
				{
					if (item.ItemType == ListItemType.Item)
						((HtmlTableRow)item.FindControl("ListerRow")).Attributes["class"] = "ListerItem";
					else
						((HtmlTableRow)item.FindControl("ListerRow")).Attributes["class"] = "ListerAlterItem";
				}
			}
			if (e.CommandName == "Edit") 
			{								
				if (e.Item.ItemType==ListItemType.Item)
				{									
					USE_USERID=((LinkButton)e.Item.FindControl("linkUSE_USERID1")).Text;

				}
				else if (e.Item.ItemType==ListItemType.AlternatingItem)
				{
					USE_USERID=((LinkButton)e.Item.FindControl("linkUSE_USERID2")).Text;
	
				}
				ControlArgs=new object[1];
				ControlArgs[0]=EnumControlArgs.Edit; 
				DoControl();								
			}				
		}	
		protected void _CustomEvent_ServerClick(object sender, System.EventArgs e) 
		{
			ControlArgs = new object[1];
			switch (_CustomEventVal.Value)
			{
				case "Update" :
					ControlArgs[0]=EnumControlArgs.Update;
					DoControl();
					break;
				case "Save" :
					ControlArgs[0]=EnumControlArgs.Save;
					DoControl();
					break;
				case "Delete" :
					ControlArgs[0]=EnumControlArgs.Delete;
					DoControl();
					break;
				case "Filter" :
					ControlArgs[0] = EnumControlArgs.Filter;
					DoControl();
					break;
				case "Process" :
					ControlArgs[0] = EnumControlArgs.Process;
					DoControl();
					break;	
			}
			_CustomEventVal.Value="";										
		}		
		private void lister_ItemDataBound(object sender, System.Web.UI.WebControls.RepeaterItemEventArgs e) 
		{
			if (recordSelected)
				FindAndSelectCurrentRecord(e);
			HtmlTableRow tRow = (HtmlTableRow)e.Item.FindControl("ListerRow");
			LinkButton linkUSE_USERID = new LinkButton();
			if (e.Item.ItemType==ListItemType.Item)
			{
				linkUSE_USERID = (LinkButton)e.Item.FindControl("linkUSE_USERID1");
			}
			else if (e.Item.ItemType==ListItemType.AlternatingItem)
			{
				linkUSE_USERID=(LinkButton)e.Item.FindControl("linkUSE_USERID2");	
			}			
			tRow.Attributes.Add("onclick", linkUSE_USERID.ClientID + ".click();" );
		}
		protected void Page_Unload(object sender, System.EventArgs e)
		{
			//base.OnUnload(e);
			if (SetFieldsInSession())
			{
				SessionObject.Set("USE_USERID",txtUSE_USERID.Text);
				SessionObject.Set("USE_NAME",txtUSE_NAME.Text);
				SessionObject.Set("USE_TYPE",ddlUSE_TYPE.SelectedValue);
				SessionObject.Set("AAG_AGCODE",ddlAAG_AGCODE.SelectedValue);
				SessionObject.Set("USE_ACTIVE",ddlUSE_ACTIVE.SelectedValue);
				///////===================== IBAD CODE FOR CHANNEL DETAIL 20-FEB-2019
				SessionObject.Set("USE_DESIGNATI",txtAGNTCODE.Text);
				SessionObject.Set("AGNTCODE",ddlAGNTCODE.SelectedValue);
				SessionObject.Set("CSD_TYPE",ddlUSE_USERTYPE.SelectedValue);
				///////===================== IBAD CODE FOR CHANNEL DETAIL 20-FEB-2019
			}
			
		}	
	
		#endregion 
		protected override bool TransactionRequired 
		{
			get 
			{
				return true;
			}
		}

		private void GetSessionValues()
		{
			if(SessionObject.Get("s_USE_TYPE")==null || SessionObject.GetString("s_USE_TYPE")!="A" && SessionObject.GetString("s_USE_TYPE")!= "B" )
            {
				throw new SHAB.Shared.Exceptions.SessionValNotFoundException("You are not authorized for this option");
			}

			if (false)
			{	
				DisableForm();
				throw new SHAB.Shared.Exceptions.SessionValNotFoundException("Select value first");
			}
			else
			{
				



				//ltlorg_code.Text = SessionObject.GetString("org_code");
			}
		}		
		
		private void CheckKeyLevel()
		{
			
		}

		void RefreshDataFields()
		{
			//SessionObject.Set(<entity-field>, row["<entity-field>"].ToString());
			txtUSE_USERID.Enabled = true;
			txtUSE_USERID.Text="";
			txtUSE_NAME.Text="";
			ddlUSE_TYPE.ClearSelection();
			ddlAAG_AGCODE.ClearSelection();
			ddlUSE_ACTIVE.ClearSelection();
		}

		protected void ShowData(DataRow objRow)
		{
			RefreshDataFields();
			txtUSE_USERID.Text=objRow["USE_USERID"].ToString();
			txtUSE_USERID.Enabled=false;
			txtUSE_NAME.Text=objRow["USE_NAME"].ToString();
			


			//======= Agency Setup IBAD CODE 20-FEB-2019
			txtAGNTCODE.Text = objRow["USE_DESIGNATI"].ToString();
			if (txtAGNTCODE.Text != null)
			{
				DataTable DTAgentDet = LAAG_AGENTDB.SearchAgent(txtAGNTCODE.Text);
				if (DTAgentDet.Rows.Count > 0)
				{
					ddlAGNTCODE.DataSource = DTAgentDet;
					ddlAGNTCODE.DataBind();	
					
					ddlAGNTCODE.ClearSelection();
					ListItem item8=ddlAGNTCODE.Items.FindByValue(objRow["USE_DESIGNATI"].ToString());
					if (item8!= null)
					{
						item8.Selected=true;
					}
				}				
			}
			//======= Agency Setup IBAD CODE 20-FEB-2019

			ddlUSE_TYPE.ClearSelection();
			ListItem item3=ddlUSE_TYPE.Items.FindByValue(objRow["USE_TYPE"].ToString());
			if (item3!= null)
			{
				item3.Selected=true;
			}

			ddlAAG_AGCODE.ClearSelection();
			ListItem item5=ddlAAG_AGCODE.Items.FindByValue(objRow["AAG_AGCODE"].ToString());
			if (item5!= null)
			{
				item5.Selected=true;
			}

			ddlUSE_ACTIVE.ClearSelection();
			ListItem item2=ddlUSE_ACTIVE.Items.FindByValue(objRow["USE_ACTIVE"].ToString());
			if (item2!= null)
			{
				item2.Selected=true;
			}

			//======= Agency Setup IBAD CODE 18-FEB-2019
			ddlUSE_USERTYPE.ClearSelection();
			ListItem item9=ddlUSE_USERTYPE.Items.FindByValue(objRow["USE_USERTYPE"].ToString());
			if (item9!= null)
			{
				item9.Selected=true;
				ddlUSE_USERTYPE.Enabled = false;
			}
			//======= Agency Setup IBAD CODE 18-FEB-2019

			if (columnNameValue == null || columnNameValue.Count == 0)
				columnNameValue = Utilities.RowToNameValue(objRow);
			SHSM_SecurityPermission security = new SHSM_SecurityPermission( Utilities.File2EntityID(this.ToString()), USE_USERMASTER.PrimaryKeys, columnNameValue, "USE_USERMASTER");
			foreach(string processName in AllProcess)
			{
				if (security.ProcessAllowed(processName))
				{
					AllowedProcess += "'" + processName + "'" + "," ;
				}
			}
			if (AllowedProcess.Length>0)
				AllowedProcess = AllowedProcess.Substring(0, AllowedProcess.Length-1);
			if (!security.UpdateAllowed)
			{
				_lastEvent.Text = EnumControlArgs.View.ToString();
			}
		}

		void SetLastEvent()
		{
			if (Request["Operation"] == "View")
				_lastEvent.Text = "View" ;
		}

		void SetListerVisibility()
		{

			Utilities.SetListerVisibility(this);
		}



		private void BindLister(DataTable table)
		{
			lister.DataSource = table;
			lister.DataBind();
			pagerList.Items.Clear();
			for (int i=1;recordCount>0; recordCount-=PAGE_SIZE)
			{				
				pagerList.Items.Add(i.ToString());		
				i++;
			}
			
			//pagerList.SelectedIndex = pageNumber-1;//commented bcz of pagging error
		}

		protected sealed override string ErrorHandle(string message)
		{
			message = base.ErrorHandle(message);
			PrintMessage(message);return message;
		}
		protected void PrintMessage(string message)
		{
			MessageScript.Text = string.Format("alert('{0}')", message.Replace("'","").Replace("\n","").Replace("\r",""));
		}

		bool SetFieldsInSession()
		{
			bool flag = false;
			if (_lastEvent.Text.Equals(EnumControlArgs.Edit.ToString()))
			{
				flag = true;
			}
			else 
			{				
				if (ControlArgs!=null)
				{
					if (ControlArgs[0]!=null)
					{
						EnumControlArgs arg = (EnumControlArgs)ControlArgs[0] ;
						if (arg.Equals(EnumControlArgs.Save) || arg.Equals(EnumControlArgs.Edit))
						{
							flag = true;
						}
					}					
				}
			}
			return flag;
		}

		/**
		 * New Method Added For New Support
		 */
		private NameValueCollection getAllFields() 
		{
			NameValueCollection allFields = new NameValueCollection();
			foreach(object key in columnNameValue.Keys) 
			{
				string strKey = key.ToString();
				allFields.add(strKey, columnNameValue.get(strKey));
			}

			//foreach (Control c in this.myForm.Controls) {	
			foreach (Control c in this.EntryTableDiv.Controls) 
			{	
				string _fieldName="";
				if (c is WebControl) 
				{
					switch (c.GetType().ToString()) 
					{
						case "System.Web.UI.WebControls.TextBox":
							if (c.ID.IndexOf("txt")==0)
								_fieldName = c.ID.Replace("txt","");
							else
								_fieldName = c.ID;
							if (!columnNameValue.Contains(_fieldName)) 
							{
								allFields.add(_fieldName, ((TextBox)c).Text);
							}
							break;
						case "SHMA.Enterprise.Presentation.WebControls.DropDownList":
							if (c.ID.IndexOf("ddl")==0)
								_fieldName = c.ID.Replace("ddl","");
							else
								_fieldName = c.ID;
							if (!columnNameValue.Contains(_fieldName)) 
							{
								allFields.add(_fieldName, ((DropDownList)c).SelectedValue.ToString());
							}
							break;
					}
				}
			}	
			return allFields;
		}


		bool IsRecordSelected()
		{
			bool selected = true;
			foreach (string pk in USE_USERMASTER.PrimaryKeys)
			{
				string strPK = SessionObject.GetString(pk);
				if (strPK == null || strPK.Trim().Length == 0)
				{
					selected  = false;
				}				
			}
			return selected ;
		}
		private void FindAndSelectCurrentRecord(System.Web.UI.WebControls.RepeaterItemEventArgs e)
		{
			RepeaterItem item=e.Item;
			bool recordFound = true;
			DataRowView row = (DataRowView)item.DataItem;
			foreach(string pk in  USE_USERMASTER.PrimaryKeys)
			{
				if ((SessionObject.Get(pk)!=null) && (!SessionObject.GetString(pk).Equals(row.Row[pk].ToString())))
					recordFound = false;
			}
			if (recordFound)
			{
				if (item.ItemType == ListItemType.Item)
				{
					USE_USERID=((LinkButton)e.Item.FindControl("linkUSE_USERID1")).Text;
	
				}
				else
				{
					USE_USERID=((LinkButton)e.Item.FindControl("linkUSE_USERID2")).Text;
	
				}
				((HtmlTableRow)item.FindControl("ListerRow")).Attributes["class"] = "ListerSelItem";
				DataRow selectedRow = new USE_USERMASTERDB(dataHolder).FindByPK(USE_USERID)["USE_USERMASTER"].Rows[0];
				ShowData(selectedRow);							
				_lastEvent.Text = "Edit";
			}
		}
		void DisableForm()
		{
			if (btnHideLister!=null)
				btnHideLister.Disabled=true;
			EntryTableDiv.Style.Add("visibility" , "hidden");
			ListerDiv.Style.Add("visibility" , "hidden");
			HeaderScript.Text = "";
			FooterScript.Text = "";
			_lastEvent.Text = EnumControlArgs.None.ToString();//new induction	

		}
		System.Web.UI.ControlCollection EntryFormFields
		{
			get
			{	
				return EntryTableDiv.Controls;
			}
		}
	}
}

