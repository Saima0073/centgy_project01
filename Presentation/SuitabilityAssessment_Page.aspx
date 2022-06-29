<%@ Page language="c#"  EnableEventValidation="false" CodeBehind="SuitabilityAssessment_Page.aspx.cs" AutoEventWireup="True" Inherits="SHAB.Presentation.SuitabilityAssessment_Page" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<%@ Register TagPrefix="SHMA" Namespace="SHMA.Enterprise.Presentation.WebControls"
    Assembly="Enterprise" %>
<HTML>
	<HEAD>
		<title>MedicalDetail</title>
		<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8">
		<meta name="GENERATOR" Content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" Content="C#">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<asp:Literal id="CSSLiteral" runat="server" EnableViewState="True"></asp:Literal>
		<script language="javascript" src="JSFiles/JScriptFG.js"></script>
		<script language="javascript" src="JSFiles/jquery-1.4.3.min.js"></script>
		<SCRIPT language="JavaScript" src="../shmalib/jscript/WebUIValidation.js"></SCRIPT>
		<script language="javascript">
		parent.closeWait();
		<asp:Literal id="HeaderScript" runat="server" EnableViewState="True"></asp:Literal>
		</script>
             <script type="text/javascript" language="javascript">

                 function cancelBack(val) {
                     if (val == 0) {
                         var key = event.keyCode;
                         if (key == 8) {
                             return false;
                         }
                         else {
                         }
                     }
                     else {
                     }

                 }

                 function backspaceFunc(e) {
                     var key = event.keyCode;
                     if (key == 8) {
                         var str = document.getElementById(e).value;
                         var newStr = str.substring(0, str.length - 1);
                         document.getElementById(e).value = newStr;
                     }
                 }
    </script>
	</HEAD>
	<body MS_POSITIONING="GridLayout" onkeydown="return cancelBack(0)">
		<form id="Form1" method="post" runat="server">
			<table cellpadding="0" cellspacing="0" width="100%" border="0">
				<tr class="form_heading">
					<td height="30" colSpan="5" style="vertical-align:central">Suitability Assessment</td>
				</tr>
				<tr>
					<td colspan="5"> 
						<asp:DataGrid ID="dGrid1" Runat="server" CellPadding="0" BorderWidth="1px" BackColor="White" BorderStyle="Solid" ShowFooter="false"
							AutoGenerateColumns="False" CssClass="text_font" Width="100%">
							<SelectedItemStyle Font-Bold="True" ForeColor="Red" Width="50px" BackColor="#FFE0C0"></SelectedItemStyle>
							<AlternatingItemStyle CssClass="ItemStyleAlt"></AlternatingItemStyle>
							<ItemStyle Wrap="False" BorderWidth="2px" BorderStyle="Ridge" Width="50px" Height="30" CssClass="ItemStyle"></ItemStyle>
							<HeaderStyle Font-Names="Helvetica" Height="22px" ForeColor="White" CssClass="form_heading_2"></HeaderStyle>
							<Columns>
								<asp:TemplateColumn HeaderText="Code">
									<ItemTemplate>
										<asp:Label ID="lblCode" Runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.CQN_CODE") %>'>
										</asp:Label>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn HeaderText="Description">
									<ItemTemplate>
										<asp:Label ID="lblDesc" Runat="server" CssClass="text_font" Text='<%# DataBinder.Eval(Container, "DataItem.CQN_DESC") %>'>
										</asp:Label>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn HeaderText="Selection">
									<ItemStyle VerticalAlign="Middle" HorizontalAlign="Center"></ItemStyle>
									<ItemTemplate>
										<asp:DropDownList runat="server"  ID="ddl_values" Width="200px" CssClass="text_font"></asp:DropDownList>
									</ItemTemplate>
								</asp:TemplateColumn>
                                 <asp:TemplateColumn HeaderText="Scores">
                                    <ItemStyle VerticalAlign="Middle" HorizontalAlign="Center"></ItemStyle>
									<ItemTemplate>
										<asp:TextBox ID="txtScores" Runat="server"  Width="50px" CssClass="text_font" onkeydown="backspaceFunc(this.id)"></asp:TextBox>		
                                        <asp:TextBox ID="txtAssignScores" Runat="server"  Width="0px" style="display:none" CssClass="text_font" onkeydown="backspaceFunc(this.id)"></asp:TextBox>									
									</ItemTemplate>
                                </asp:TemplateColumn>
                                <asp:TemplateColumn HeaderText="Remarks">
                                    <ItemStyle VerticalAlign="Middle" HorizontalAlign="Center"></ItemStyle>
									<ItemTemplate>
										<asp:TextBox ID="txtRemarks" Runat="server"  CssClass="text_font" onkeydown="backspaceFunc(this.id)"></asp:TextBox>									
									</ItemTemplate>
								</asp:TemplateColumn>
                                
							</Columns>
                            
						</asp:DataGrid>
					</td>
				</tr>
                <tr>
                    <td colspan="1" style="text-align:right;width:270px"><label class="text_font" style="font-weight:bold">GRAND TOTAL</label></td>
                    <td  style="text-align:right;width:160px"><asp:Label runat="server" CssClass="text_font" style="font-weight:bold" ID="lbl_TotalAssignScores"></asp:Label></td>
                    <td  style="width:50px;text-align:right;"><asp:Label runat="server" CssClass="text_font" style="font-weight:bold" ID="lbl_totalScores"></asp:Label></td>
                    <td  style="width:80px;text-align:right;"><asp:Label runat="server" CssClass="text_font" style="font-weight:bold" ID="lbl_TotalPercentage"></asp:Label></td>
                </tr> 
                <tr>
                    <td colspan="4" style="text-align:right"><asp:Label runat="server" CssClass="text_font" style="font-weight:bold;color:red" ID="lbl_Decisions"></asp:Label></td>
                </tr>
			</table>
			<asp:Button ID="btnSave" Runat="server" Visible="False" Text="Save"></asp:Button>
			<INPUT id="_CustomEventVal" type="hidden" name="_CustomEventVal" runat="server">
			<INPUT id="_CustomEvent" style="WIDTH: 0px" type="button" value="Button" name="_CustomEvent"
				runat="server" onserverclick="_CustomEvent_ServerClick">
		</form>
		<script language="javascript">
		<asp:Literal id="_result" runat="server" EnableViewState="False"></asp:Literal>



		function isAnswerGiven(sender, args){
				//txtSubAnswerVLD
			    //txtSubAnswer		    
				
				var txtID = sender.id.substring(0,sender.id.lastIndexOf('_')+1)+'txtSubAnswer';
				var txt = document.getElementById(txtID);
				var jqTxt = $('#'+txtID);
				
				var subDivId = sender.id.substring(0, sender.id.indexOf('__ctl')+7) +'subDiv';				
				var subdiv = document.getElementById(subDivId);
			
				//txtID = sender.id.substr(0,sender.id.length-3);
				
				//if(subdiv.style.display=='block' && txt.value == ""){
					
					//alert(subdiv.style.display+" - "+subDivId+" - "+txtID+"  -  " + txt.value + " - "+ txt.className);
				//args.IsValid = false;
				//	return;
					
				//}
			    
				args.IsValid = true;
				return;
			    
			}
			/*
			void Validate(Object sender, EventArgs e){
			if (Page.IsValid == false)
			{
				if(status=="N")
					window.alert("helllloooooo");
			}
			else
				window.alert("empty");
			}
			*/
		/*
		function Page_ClientValidate()
		{
			return true;
		}*/
		function saveUpdate()
		{					
			if(document.getElementById('dGrid1')!=null)
			{
				document.getElementById("_CustomEventVal").value = "Save";
				__doPostBack("_CustomEvent", "_CustomEvent_ServerClick");
			}
			else
			{
				parent.closeWait();
				alert('There is nothing to save in case of minor');
			}
		}		

            function fnOnIndexChanged(obj, cid) {
                try {
                    var rangeqlc = '<%= Session["qlc_noofquestion"] %>';
                    var rangeqnc = '<%= Session["qnc_noofquestion"] %>';
                    var score = obj.value;
                    document.getElementById(cid + '_txtScores').value = score.split('-')[1];
                    var qualitativeScores = 0;
                    var qualitativeAssignScores = 0;
                    var quantitativeScores = 0;
                    var quantitativeAssignScores = 0;
                    for (var i = 3; i < (parseInt(rangeqlc)+3); i++) {
                        qualitativeScores += parseInt(document.getElementById('dGrid1__' + 'ctl' + i + '_txtScores').value);
                        qualitativeAssignScores += parseInt(document.getElementById('dGrid1__' + 'ctl' + i + '_txtAssignScores').value);

                    }
                    for (var i = 12; i < (parseInt(rangeqnc) + 12); i++) {
                        quantitativeScores += parseInt(document.getElementById('dGrid1__' + 'ctl' + i + '_txtScores').value);
                        quantitativeAssignScores += parseInt(document.getElementById('dGrid1__' + 'ctl' + i + '_txtAssignScores').value);
                    }
                    var qualitativePercent = (qualitativeScores / qualitativeAssignScores) * 40;
                    var quantitativePercent = ((quantitativeScores / quantitativeAssignScores) * 60);

                   // var preValue = parseInt(document.getElementById(cid + '_txtScores').value);
                   
                   // var totalscore = parseInt(document.getElementById('lbl_totalScores').innerHTML)
                   // totalscore = (totalscore - preValue) + parseInt(score.split('-')[1]);
                    document.getElementById('lbl_totalScores').innerHTML = qualitativeScores + quantitativeScores;
                    //var Percentage = ((totalscore / parseInt(document.getElementById('lbl_TotalAssignScores').innerHTML)) * 100).toFixed(2);
                    document.getElementById('lbl_TotalPercentage').innerHTML = ((qualitativePercent + quantitativePercent).toFixed(2))+'%';
                    if (parseInt(qualitativePercent + quantitativePercent) > 30) {
                        document.getElementById('lbl_Decisions').innerHTML = "Normal case no approval required";
                    }
                    else if (parseInt(qualitativePercent + quantitativePercent) >= 20 && parseInt(qualitativePercent + quantitativePercent) <= 30) {
                        document.getElementById('lbl_Decisions').innerHTML = "RHB Approval Required";
                    }
                    else {
                        document.getElementById('lbl_Decisions').innerHTML = "Declined";
                    }
                } catch (e) {

                }
                

            }

		function fnOnClickRadio(subgrid,obj,objId)
		{	
			var subDivId = obj.id.substring(0,obj.id.lastIndexOf('_')+1)+'subDiv';				
			var subdiv = document.getElementById(subDivId);
			var rdoArray = subgrid.getElementsByTagName("input");
			if(subdiv!=null)
			{	
				if(objId == 'rdoYes')
				{
					if(rdoArray.length > 0)
					{	
						if (subdiv.id == 'dGrid__ctl11_subDiv')
						{  slideToggle('#'+subDivId,false);	}					
						else {slideToggle('#'+subDivId,true);	}
					}
					else
					{	if (subdiv.id == 'dGrid__ctl11_subDiv')
						{  slideToggle('#'+subDivId,false);	}	
						else {slideToggle('#'+subDivId,false);}
					}
				}
				else
				{	
					if(rdoArray.length > 0)
					{	
						if (subdiv.id == 'dGrid__ctl11_subDiv')
						{  slideToggle('#'+subDivId,true);	}
						else { slideToggle('#'+subDivId,false); }
					}
					else
					{
						if (subdiv.id == 'dGrid__ctl11_subDiv')
						{  slideToggle('#'+subDivId,true);	}						
						else {	slideToggle('#'+subDivId,true);	}
					}					
				}
			}
		}
		
		function slideToggle(el, bShow)
		{
			var $el = $(el), height = $el.data("originalHeight"), visible = $el.is(":visible");
			if( arguments.length == 1 ) bShow = !visible;
			if( bShow == visible ) return false;		  
			
			if( !height )
			{	
				height = $el.show().height();
				if (height == '24')
				{height = '45';}
				$el.data("originalHeight", height);				
				if( !visible ) $el.hide().css({height: 0});
			}
			
			if( bShow )
			{								
				//$el.slideDown(500);				
				$el.slideDown(700);				
			} 
			else 
			{
				$el.animate({height: 0}, {duration: 250, complete:function (){
					$el.hide();
				}
				});
			}
		}
		
		function uncheckIfSelected(subgridObj)
		{
			var rdoArray = subgridObj.getElementsByTagName("input");
			for(i=0;i<=rdoArray.length-1;i++)  
			{  
				if(rdoArray[i].type == 'radio')
				{	  
					rdoArray[i].checked = false;  						  
				}					
			}
		}
		
		function getNextRowObj(rowID)
		{			
			var nextRowNum = parseInt(rowID.substring(rowID.lastIndexOf('l')+1,rowID.length))+1;
			var nextRowID = rowID.substring(0,rowID.lastIndexOf('l')+1)+ nextRowNum;
			return nextRowID;			
		}
		function setQuestionState(objRow,txtVis,visible)
		{
			if(visible)
			{	
				objRow.style.display = 'block';			
				txtVis.value = 'block';
			}
			else
			{	
				objRow.style.display = 'none';			
				txtVis.value = 'none';
			}
		}
		
		function showHideSubQuestion(rdoY,rdoN,objRow,chkSH,prevRowObj,txtVis)
		{			
			
			if(parseInt(chkSH)==1)
			{				
				setQuestionState(objRow,txtVis,true)
			}
			else
			{
				rdoY.checked = false;
				rdoN.checked = false;								
				setQuestionState(objRow,txtVis,false);				
				var RowID = getNextRowObj(objRow.id);
				var nextRowObj = document.getElementById(RowID);				
				var nextRdoY = document.getElementById(RowID+'_rdoYes');
				var nextRdoN = document.getElementById(RowID+'_rdoNo');
				var nextTxtVis = document.getElementById(RowID+'_txtVisible');		
				
				if(document.getElementById(objRow.id+'_txtIsChildExist').value == RowID)
				{			
					showHideSubQuestion(nextRdoY,nextRdoN,nextRowObj,0,null,nextTxtVis);				
				}
			}			
		}
		
		</script>
	</body>
</HTML>
