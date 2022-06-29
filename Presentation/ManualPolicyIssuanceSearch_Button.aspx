<%@ Page language="c#" Codebehind="ManualPolicyIssuanceSearch_Button.aspx.cs" AutoEventWireup="True"  EnableEventValidation="false" Inherits="SHAB.Presentation.ManualPolicyIssuanceSearch_Button" %>
<%@ Register TagPrefix="CV" Namespace="SHMA.CodeVision.Presentation.WebControls" Assembly="CodeVision" %>
<html>
	<head>
    	<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8" >
		<%
			Response.Write(ace.Ace_General.loadInnerStyle());
		%>
		<script language="javascript" src="JSFiles/PortableSQL.js"></script>
		<script language="javascript" src="JSFiles/JScriptFG.js"></script>
		<script language="javascript" src="JSFiles/msrsclient.js"></script>
		<script language="javascript" src="JSFiles/NumberFormat.js"></script>
	</head>
	<body>
		<br>
		<table width="100%">
			<tr>
				<td class="button2TD" align="right">
					<a href="#" class="button2" onclick="callUpdate();">&nbsp;&nbsp;Mark Status&nbsp;&nbsp;</a>
				</td>				
			</tr>
		</table>
	</body>
</html>

<script language="javascript">

	function callUpdate()
	{
		if (parent.frames[0].Page_ClientValidate())
		{
			parent.openWait('Saving Data');
			parent.frames[0].saveUpdate();			
		}
	}
</script>
