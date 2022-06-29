using System;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Web;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

namespace Bancassurance.Presentation
{
	/// <summary>
	/// Summary description for TransferPolicy_Group.
	/// </summary>
	/// 

	public partial class TransferPolicy_Group : SHMA.CodeVision.Presentation.GroupBase
	{
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

		}
		protected override void Page_Load(object sender, EventArgs e)
		{
		}
	}	
}
