<%@ Page Language="c#" CodeBehind="shgn_ss_se_stdscreen_ILUS_ET_NM_PER_PERSONALDETINS.aspx.cs" AutoEventWireup="True" Inherits="SHAB.Presentation.shgn_ss_se_stdscreen_ILUS_ET_NM_PER_PERSONALDETINS" %>

<%@ Register TagPrefix="SHMA" Namespace="SHMA.Enterprise.Presentation.WebControls" Assembly="Enterprise" %>
<%@ Register TagPrefix="UC" TagName="EntityHeading" Src="EntityHeading.ascx" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
<html>
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8">
    <meta content="text/html; charset=windows-1252" http-equiv="Content-Type">
    <meta name="GENERATOR" content="Microsoft Visual Studio 7.0">
    <meta name="CODE_LANGUAGE" content="C#">
    <meta name="vs_defaultClientScript" content="JavaScript">
    <meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
    <asp:Literal ID="CSSLiteral" runat="server" EnableViewState="True"></asp:Literal>
    <script language="javascript" src="JSFiles/PortableSQL.js"></script>
    <script language="javascript" src="JSFiles/JScriptFG.js"></script>
    <script language="javascript" src="JSFiles/msrsclient.js"></script>
    <script language="javascript" src="JSFiles/NumberFormat.js"></script>
    <!--<SCRIPT language="JavaScript" src='../shmalib/jscript/MI_ET_NM_PolicyEntry'></SCRIPT>-->
    <script language="JavaScript" src="../shmalib/jscript/WebUIValidation.js"></script>
    <script language="JavaScript" src="../shmalib/jscript/GeneralView.js"></script>
    <script language="JavaScript" src="../shmalib/jscript/PersonalDetail.js"></script>
    <script language="JavaScript" src="../shmalib/jscript/ClientUI/UIParameterization.js"></script>
    <script language="JavaScript" src='../shmalib/jscript/Date.js'></script>
    <script language="javascript">
        <asp:Literal id="MessageScript" runat="server" EnableViewState="False"></asp:Literal >
            <asp:Literal id="HeaderScript" runat="server" EnableViewState="True"></asp:Literal >
                _lastEvent = '<asp:Literal id="_lastEvent" runat="server" EnableViewState="True"></asp:Literal>';

        function RefreshFields() {
            myForm.ddlNPH_TITLE.selectedIndex = 0;
            myForm.ddlNPH_SEX.selectedIndex = 0;
            myForm.txtNPH_FULLNAME.value = "";
            myForm.txtNPH_FULLNAMEARABIC.value = "";
            myForm.txtNPH_BIRTHDATE.value = "";
            myForm.ddlCOP_OCCUPATICD.selectedIndex = 0;
            myForm.ddlCCL_CATEGORYCD.selectedIndex = 0;
            //myForm.ddlNPH_INSUREDTYPE.selectedIndex =0;
            myForm.ddlNPH_IDTYPE.selectedIndex = 0;
            myForm.txtCNIC_VALUE.value = "";
            //myForm.txtNU1_ACCOUNTNO.value ="";	
            myForm.ddlNPH_HEIGHTTYPE.selectedIndex = 2;
            myForm.txtNU1_ACTUALHEIGHT.value = "";
            myForm.txtNU1_CONVERTHEIGHT.value = "";
            myForm.txt_bmi.value = "";


            myForm.ddlNPH_WEIGHTTTYPE.selectedIndex = 1;
            myForm.txtNU1_ACTUALWEIGHT.value = "";
            myForm.txtNU1_CONVERTWEIGHT.value = "0.00";

            setDefaultValues();

        }

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
        function CalculateEntryAge(objDate) {
            var years = dateDiffYears(objDate.value, sysDate, parent.parent.ageRoundCriteria)
            if (isNaN(years)) {
                getField("NP2_AGEPREM").value = "";
                return false;
            }
            else {
                if (years < 0) {
                    getField("NP2_AGEPREM").value = "0";
                    alert("Invalid Date of Birth");
                    getField("NPH_BIRTHDATE").focus();
                    return false;
                }
                else {
                    getField("NP2_AGEPREM").value = years;
                    return true;
                }
            }
        }

        /********** dependent combo's queries **********/
        var str_QryCCL_CATEGORYCD = "SELECT c.ccl_categorycd " + getConcateOperator() + " '-' " + getConcateOperator() + " ccl_description,c.ccl_categorycd  FROM LCOP_OCCUPATION C,LCCL_CATEGORY L WHERE C.CCL_CATEGORYCD = L.CCL_CATEGORYCD AND C.COP_OCCUPATICD='~COP_OCCUPATICD~'";


        function formatNumber(myNum, numOfDec) {
            var decimal = 1
            for (i = 1; i <= numOfDec; i++)
                decimal = decimal * 10

            var myFormattedNum = (Math.round(myNum * decimal) / decimal).toFixed(numOfDec)
            return (myFormattedNum)
        }
        //Convert To Feets


        function backspaceFunc(e) {
            if (e != 'txtCNIC_VALUE') {
                var key = event.keyCode;
                if (key == 8) {
                    var str = document.getElementById(e).value;
                    var newStr = str.substring(0, str.length - 1);
                    document.getElementById(e).value = newStr;
                }
            }
            else {
                if (document.getElementById('txtCNIC_VALUE').readOnly != true) {
                    var key = event.keyCode;
                    if (key == 8) {
                        var str = document.getElementById(e).value;
                        var newStr = str.substring(0, str.length - 1);
                        document.getElementById(e).value = newStr;
                    }
                }

            }
        }
        function getIt(m) {


            //Number Checking..

            var b = IsNumeric(m.value);
            if (b == false) {
                alert('Please provide correct NIC number');

            }
            else {
                n = m.value;
                var str;
                var msg = "";
                var i = 0;

                for (i = 0; i < 5; i++) {
                    msg = msg + n.charAt(i);;
                    //alert(n.charAt(i));
                }
                msg = msg + "-";

                ///Next Portion

                for (i = 5; i < 12; i++) {
                    msg = msg + n.charAt(i);;
                }
                msg = msg + "-" + n.charAt(12);

                myForm.txtCNIC_VALUE.value = msg;

            }
        }


        function IsNumeric(sText) {
            var ValidChars = "0123456789.";
            var IsNumber = true;
            var Char;


            for (i = 0; i < sText.length && IsNumber == true; i++) {
                Char = sText.charAt(i);
                if (ValidChars.indexOf(Char) == -1) {
                    IsNumber = false;
                }
            }
            if (sText.length > 13) {
                IsNumber = false;

            }
            return IsNumber;

        }

    </script>
</head>
<body>
    <UC:EntityHeading ID="EntityHeading" runat="server" ParamValue="Policy Owner Personal Details" ParamSource="FixValue"></UC:EntityHeading>
    <form id="myForm" method="post" name="myForm" runat="server">
        <div style="z-index: 0" id="NormalEntryTableDiv" class="NormalEntryTableDiv" runat="server">
            <table id="entryTable" border="0" cellspacing="0" cellpadding="2">
                <tr class="form_heading">
                    <td height="20" colspan="4">&nbsp; Personal Details of Life Insured
                    </td>
                </tr>
                <tr>
                    <td height="10" colspan="4"></td>
                </tr>
                <tr id="rowNPH_TITLE" class="TRow_Normal">
                    <td id="lblddlNPH_TITLE" class="<%=getHighLighted()%>" width="110" align="right">Title</td>
                    <td style="width: 213px" width="213">
                        <SHMA:DropDownList ID="ddlNPH_TITLE" TabIndex="1" runat="server" BlankValue="True" DataTextField="desc_f" onkeydown="return cancelBack(0)"
                            DataValueField="CSD_TYPE" Onchange="Title_ChangeEvent(this);" Width="184px" CssClass="RequiredField" HighLighted="True">
                        </SHMA:DropDownList><asp:CompareValidator ID="cfvNPH_TITLE" runat="server" ControlToValidate="ddlNPH_TITLE" Operator="DataTypeCheck"
                            Type="String" ErrorMessage="String Format is Incorrect " EnableClientScript="False" Display="Dynamic"></asp:CompareValidator><asp:RequiredFieldValidator ID="rfvNPH_TITLE" runat="server" ControlToValidate="ddlNPH_TITLE" ErrorMessage="Required"
                                Display="Dynamic"></asp:RequiredFieldValidator></td>
                    <td id="lbltxtCNIC_VALUE" width="110" align="right">
                        <SHMA:DropDownList ID="ddlNPH_IDTYPE" TabIndex="2" Style="border-bottom: #444 0px solid; border-left: #444 0px solid; border-top: #444 0px solid; border-right: #444 0px solid" onkeydown="return cancelBack(0)"
                            runat="server" CssClass="RequiredField" Width="100px" DataValueField="NPH_IDTYPE" DataTextField="desc_f"
                            BlankValue="false">
                        </SHMA:DropDownList>
                    </td>
                    <td id="ctltxtCNIC_VALUE" width="186" style="height: 23px">
                        <SHMA:TextBox onblur="NIC_Blur(this)" ID="txtCNIC_VALUE" onfocus="NIC_Focus(this)" TabIndex="3"
                            onkeypress="return NIC_KeyPress(event,this)" onkeyup="NIC_KeyUp(event,this)" runat="server" onkeydown="backspaceFunc('txtCNIC_VALUE')"
                            CssClass="RequiredField" Width="184px" DESIGNTIMEDRAGDROP="79" MaxLength="15"></SHMA:TextBox>
                    </td>
                    <td id="lbltxtNPH_IDNO2" width="110" style="display: none" align="right">N.I.C(OLD)</td>
                    <td id="ctltxtNPH_IDNO2" width="186" style="display: none">
                        <SHMA:TextBox ReadOnly="true" ID="txtNPH_IDNO2" TabIndex="3" Style="display: none" runat="server"
                            CssClass="RequiredField" Width="184px" DESIGNTIMEDRAGDROP="79" MaxLength="15"></SHMA:TextBox>
                    </td>
                </tr>
                <tr class="TRow_Alt" class="TRow_Alt">
                    <td width="106" align="right" id="TD5">CNIC Issue Date
                    </td>
                    <td width="186" id="ctltxtNPH_DOCISSUEDAT">
                        <SHMA:DatePopUp ID="txtNPH_DOCISSUEDAT" TabIndex="4" runat="server" CssClass="RequiredField"
                            onkeydown="backspaceFunc('txtNPH_DOCISSUEDAT')" Width="110px" ImageUrl="Images/image1.jpg"
                            ExternalResourcePath="jsfiles/DatePopUp.js" maxlength="0">
                        </SHMA:DatePopUp>
                    </td>
                    <td width="106" align="right" id="TD7">CNIC Expiry Date
                    </td>
                    <td width="186" id="ctltxtNPH_DOCEXPIRDAT">
                        <SHMA:DatePopUp ID="txtNPH_DOCEXPIRDAT" TabIndex="5" runat="server" CssClass="RequiredField"
                            onkeydown="backspaceFunc('txtNPH_DOCEXPIRDAT')" Width="110px" ImageUrl="Images/image1.jpg"
                            ExternalResourcePath="jsfiles/DatePopUp.js" maxlength="0">
                        </SHMA:DatePopUp>
                    </td>
                </tr>
                <tr id="rowNPH_FULLNAME" class="TRow_Alt">
                    <td id="lbltxtNPH_FULLNAME" class="<%=getHighLighted()%>" width="110" align="right">Name 
							in English</td>
                    <td id="ctltxtNPH_FULLNAME" style="width: 213px" width="213">
                        <div id="personNameDiv" class="form_heading" style="z-index: 1000; display: none">
                            <table>
                                <tr>
                                    <td>
                                        <table border="0">
                                            <tr style="color: #e1e1e1">
                                                <td>First Name
                                                </td>
                                                <td>Middle Name
                                                </td>
                                                <td>Last Name
                                                </td>
                                                <td></td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <SHMA:TextBox ID="txtNPH_FIRSTNAME" TabIndex="6" runat="server" Width="160px" MaxLength="50"
                                                        onkeydown="backspaceFunc('txtNPH_FIRSTNAME')" BaseType="Character" onblur="toTitleCase(this);"></SHMA:TextBox>
                                                </td>
                                                <td>
                                                    <SHMA:TextBox ID="txtNPH_SECONDNAME" TabIndex="6" runat="server" Width="160px" MaxLength="50"
                                                        onkeydown="backspaceFunc('txtNPH_SECONDNAME')" BaseType="Character" onblur="toTitleCase(this);"></SHMA:TextBox>
                                                </td>
                                                <td>
                                                    <SHMA:TextBox ID="txtNPH_LASTNAME" TabIndex="6" runat="server" Width="160px" MaxLength="50"
                                                        onkeydown="backspaceFunc('txtNPH_LASTNAME')" BaseType="Character" onblur="toTitleCase(this);"></SHMA:TextBox>
                                                </td>
                                                <td>
                                                    <a href="#" class="button2" tabindex="6" onclick="btnOK_Click()">OK</a>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <SHMA:TextBox ID="txtNPH_FULLNAME" TabIndex="7" runat="server" Width="183px" CssClass="RequiredField" onchange="generateID(IDFormat);" HighLighted="True" MaxLength="50" BaseType="Character"></SHMA:TextBox>
                        <label id="nameFormat" style="display: none">
                            <font color="#009900">First&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Middle&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Last</font>
                        </label>
                        &nbsp;<input class="BUTTON" title="Open Proposal List Of Values" tabindex="5" onclick="openPersonsLOV();" style="display: none" value=".." type="button" name="ProposalLov">
                        <asp:CompareValidator ID="cfvNPH_FULLNAME" runat="server" ControlToValidate="txtNPH_FULLNAME" Operator="DataTypeCheck"
                            Type="String" ErrorMessage="String Format is Incorrect " EnableClientScript="False" Display="Dynamic"></asp:CompareValidator><asp:RequiredFieldValidator ID="rfvNPH_FULLNAME" runat="server" ControlToValidate="txtNPH_FULLNAME" ErrorMessage="Required"
                                Display="Dynamic"></asp:RequiredFieldValidator>

                    </td>
                    <td id="lbltxtNPH_FULLNAMEARABIC" class="<%=getHighLighted()%>" width="110" align="right">Name 
							in Arabic</td>
                    <td id="ctltxtNPH_FULLNAMEARABIC" width="186">
                        <SHMA:TextBox ID="txtNPH_FULLNAMEARABIC" TabIndex="8" runat="server" HighLighted="True" Width="184px"
                            onkeydown="backspaceFunc('txtNPH_FULLNAMEARABIC')" BaseType="Character" MaxLength="50"></SHMA:TextBox>
                        <asp:CompareValidator ID="cfvNPH_FULLNAMEARABIC" runat="server" Display="Dynamic" EnableClientScript="False"
                            ErrorMessage="String Format is Incorrect " Type="String" Operator="DataTypeCheck" ControlToValidate="txtNPH_FULLNAMEARABIC"></asp:CompareValidator></td>
                </tr>
                <tr class="TRow_Alt">
                    <td width="106" align="right" id="TD1">Father/Husband Name
                    </td>
                    <td width="186" id="ctltxtNPH_FATHERNAME">
                        <SHMA:TextBox ID="txtNPH_FATHERNAME" TabIndex="9" runat="server" Width="184px" CssClass="RequiredField"
                            onkeydown="backspaceFunc('txtNPH_FATHERNAME')" MaxLength="30" ReadOnly="false"></SHMA:TextBox>
                        <asp:RequiredFieldValidator ID="rfctxtNPH_FATHERNAME" runat="server" Display="Dynamic"
                            ErrorMessage="Required" ControlToValidate="txtNPH_FATHERNAME"></asp:RequiredFieldValidator>
                    </td>
                    <td width="106" align="right" id="TD3">Maiden Name
                    </td>
                    <td width="186" id="ctltxtNPH_MAIDENNAME">
                        <SHMA:TextBox ID="txtNPH_MAIDENNAME" TabIndex="10" runat="server" Width="184px" CssClass="RequiredField"
                            onkeydown="backspaceFunc('txtNPH_MAIDENNAME')" MaxLength="30" ReadOnly="false"></SHMA:TextBox>
                        <asp:RequiredFieldValidator ID="rfctxtNPH_MAIDENNAME" runat="server" Display="Dynamic"
                            ErrorMessage="Required" ControlToValidate="txtNPH_MAIDENNAME"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr id="rowNPH_BIRTHDATE" class="TRow_Normal">
                    <td id="lbltxtNPH_BIRTHDATE" class="<%=getHighLighted()%>" width="110" align="right">Date 
							of Birth</td>
                    <td id="ctltxtNPH_BIRTHDATE" style="width: 213px" width="213">
                        <SHMA:DatePopUp ID="txtNPH_BIRTHDATE" TabIndex="11" runat="server" onchange="formatDate(this,'DD/MM/YYYY');CalculateEntryAge(this);"
                            Width="90px" CssClass="RequiredField" HighLighted="True" maxlength="0" ExternalResourcePath="jsfiles/DatePopUp.js" ImageUrl="Images/image1.jpg">
                            <WeekdayStyle Font-Size="XX-Small" Font-Names="Verdana,Helvetica,Tahoma,Arial" ForeColor="Black"
                                CssClass="WeekdayStyle" BackColor="White"></WeekdayStyle>
                            <MonthHeaderStyle Font-Size="XX-Small" Font-Names="Verdana,Helvetica,Tahoma,Arial" ForeColor="Black"
                                CssClass="MonthHeaderStyle" BackColor="Yellow"></MonthHeaderStyle>
                            <OffMonthStyle Font-Size="XX-Small" Font-Names="Verdana,Helvetica,Tahoma,Arial" ForeColor="Gray"
                                BackColor="AntiqueWhite"></OffMonthStyle>
                            <GoToTodayStyle Font-Size="XX-Small" Font-Names="Verdana,Helvetica,Tahoma,Arial" ForeColor="Black"
                                BackColor="White"></GoToTodayStyle>
                            <TodayDayStyle Font-Size="XX-Small" Font-Names="Verdana,Helvetica,Tahoma,Arial" ForeColor="Black"
                                CssClass="TodayDayStyle" BackColor="LightGoldenrodYellow"></TodayDayStyle>
                            <DayHeaderStyle Font-Size="XX-Small" Font-Names="Verdana,Helvetica,Tahoma,Arial" ForeColor="Black"
                                CssClass="DayHeaderStyle" BackColor="Orange"></DayHeaderStyle>
                            <WeekendStyle Font-Size="XX-Small" Font-Names="Verdana,Helvetica,Tahoma,Arial" ForeColor="Black"
                                CssClass="WeekendStyle" BackColor="LightGray"></WeekendStyle>
                            <SelectedDateStyle Font-Size="XX-Small" Font-Names="Verdana,Helvetica,Tahoma,Arial" ForeColor="Black"
                                CssClass="SelectedDateStyle" BackColor="Yellow"></SelectedDateStyle>
                            <ClearDateStyle Font-Size="XX-Small" Font-Names="Verdana,Helvetica,Tahoma,Arial" ForeColor="Black"
                                BackColor="White"></ClearDateStyle>
                            <HolidayStyle Font-Size="XX-Small" Font-Names="Verdana,Helvetica,Tahoma,Arial" ForeColor="Black"
                                CssClass="HolidayStyle" BackColor="White"></HolidayStyle>
                        </SHMA:DatePopUp>
                        &nbsp;<font id="lbltxtNP2_AGEPREM">Age</font>&nbsp;<SHMA:TextBox ID="txtNP2_AGEPREM" TabIndex="12" CssClass="RequiredField" runat="server" Width="40px"
                            MaxLength="2" BaseType="Number" ReadOnly="True"></SHMA:TextBox>
                        <asp:CompareValidator ID="msgNPH_BIRTHDATE" runat="server" CssClass="CalendarFormat" ControlToValidate="txtNPH_BIRTHDATE"
                            Operator="DataTypeCheck" Type="Date" ErrorMessage="{dd/mm/yyyy} " Display="Dynamic" Enabled="true"></asp:CompareValidator><asp:RequiredFieldValidator ID="rfvNPH_BIRTHDATE" runat="server" ControlToValidate="txtNPH_BIRTHDATE" ErrorMessage="Required"
                                Display="Dynamic"></asp:RequiredFieldValidator></td>
                    <td id="lblddlNPH_SEX" class="<%=getHighLighted()%>" width="110" align="right">Gender</td>
                    <td id="ctlddlNPH_SEX" width="186">
                        <SHMA:DropDownList Style="z-index: 0" ID="ddlNPH_SEX" Onchange="Gender_ChangeEvent(this);" TabIndex="13"
                            onkeydown="return cancelBack(0)" runat="server" HighLighted="True" Width="184px">
                            <asp:ListItem Selected="True"></asp:ListItem>
                            <asp:ListItem Value="M">Male</asp:ListItem>
                            <asp:ListItem Value="F">Female</asp:ListItem>
                        </SHMA:DropDownList>
                        <asp:CompareValidator Style="z-index: 0" ID="cfvNPH_SEX" runat="server" Display="Dynamic" EnableClientScript="False"
                            ErrorMessage="String Format is Incorrect " Type="String" Operator="DataTypeCheck" ControlToValidate="ddlNPH_SEX"></asp:CompareValidator>
                        <asp:RequiredFieldValidator Style="z-index: 0" ID="rfvNPH_SEX" runat="server" Display="Dynamic" ErrorMessage="Required"
                            ControlToValidate="ddlNPH_SEX"></asp:RequiredFieldValidator></td>
                </tr>

                <tr id="rowCCL_CATEGORYCD" class="TRow_Alt">
                    <td id="lblddlCOP_OCCUPATICD" class="<%=getHighLighted()%>" width="110" align="right">Occupation</td>
                    <td id="ctlddlCOP_OCCUPATICD" style="width: 213px" width="213">
                        <SHMA:DropDownList Style="z-index: 0" ID="ddlCOP_OCCUPATICD" TabIndex="14" runat="server" HighLighted="True"
                            onkeydown="return cancelBack(0)" CssClass="RequiredField" Width="184px" DataValueField="COP_OCCUPATICD" DataTextField="desc_f" BlankValue="True">
                        </SHMA:DropDownList>
                        <asp:CompareValidator Style="z-index: 0" ID="cfvCOP_OCCUPATICD" runat="server" Display="Dynamic" EnableClientScript="False"
                            ErrorMessage="String Format is Incorrect " Type="String" Operator="DataTypeCheck" ControlToValidate="ddlCOP_OCCUPATICD"></asp:CompareValidator></td>

                    <td id="lblddlCCL_CATEGORYCD" class="<%=getHighLighted()%>" width="110" align="right">Occupational&nbsp;Class</td>
                    <td id="ctlddlCCL_CATEGORYCD" width="186">
                        <SHMA:DropDownList ID="ddlCCL_CATEGORYCD" TabIndex="15" runat="server" BlankValue="True" DataTextField="desc_f"
                            onkeydown="return cancelBack(0)" DataValueField="CCL_CATEGORYCD" Width="184px" HighLighted="True" Style="z-index: 0">
                        </SHMA:DropDownList><asp:CompareValidator ID="cfvCCL_CATEGORYCD" runat="server" ControlToValidate="ddlCCL_CATEGORYCD" Operator="DataTypeCheck"
                            Type="String" ErrorMessage="String Format is Incorrect " EnableClientScript="False" Display="Dynamic" Style="z-index: 0"></asp:CompareValidator></td>
                </tr>

                <tr id="rowNU1_SMOKER" class="TRow_Normal">
                    <td id="lblddlNU1_SMOKER" width="110" align="right">Smoker</td>
                    <td id="ctlddlNU1_SMOKER" width="186">
                        <SHMA:DropDownList Style="z-index: 0" ID="ddlNU1_SMOKER" TabIndex="16" runat="server" CssClass="RequiredField" onkeydown="return cancelBack(0)"
                            Width="184px">
                            <asp:ListItem Selected="True"></asp:ListItem>
                            <asp:ListItem Value="Y">Yes</asp:ListItem>
                            <asp:ListItem Value="N">No</asp:ListItem>
                        </SHMA:DropDownList>
                        <%--		<asp:comparevalidator style="Z-INDEX: 0" id="cfvNU1_SMOKER" runat="server" Display="Dynamic" EnableClientScript="False"
								ErrorMessage="String Format is Incorrect " Type="String" Operator="DataTypeCheck" ControlToValidate="ddlNU1_SMOKER"></asp:comparevalidator></TD>
						<asp:comparevalidator id="cfvNU1_ACCOUNTNO" runat="server" Display="Dynamic" EnableClientScript="False"
							ErrorMessage="String Format is Incorrect " Type="String" Operator="DataTypeCheck" ControlToValidate="txtNU1_ACCOUNTNO"></asp:comparevalidator></TD></TR>
                        --%>
                </tr>
                <tr class="TRow_Alt">
                    <td id="lblddlNPH_HEIGHTTYPE" style="height: 21px" width="110" align="right">Height</td>
                    <td id="ctlddlNPH_HEIGHTTYPE" style="height: 21px" width="186">
                        <SHMA:DropDownList Style="z-index: 0" ID="ddlNPH_HEIGHTTYPE" TabIndex="17" runat="server" Width="65px"
                            onkeydown="return cancelBack(0)" Onchange="convert_to_feet()">
                            <asp:ListItem Selected="True"></asp:ListItem>
                            <asp:ListItem Value="I">Inches</asp:ListItem>
                            <asp:ListItem Value="F">Feet</asp:ListItem>
                            <asp:ListItem Value="C">Centimeter</asp:ListItem>
                            <asp:ListItem Value="M">Meters</asp:ListItem>
                        </SHMA:DropDownList>
                        <SHMA:TextBox Style="z-index: 0" ID="txtNU1_ACTUALHEIGHT" TabIndex="17" runat="server" CssClass="RequiredField"
                            onkeydown="backspaceFunc('txtNU1_ACTUALHEIGHT')" Width="48px" BaseType="Character" MaxLength="4" onchange="convert_to_feet()"></SHMA:TextBox>
                        <SHMA:TextBox Style="z-index: 0" ID="txtNU1_CONVERTHEIGHT" TabIndex="17" runat="server" CssClass="RequiredField"
                            onkeydown="backspaceFunc('txtNU1_CONVERTHEIGHT')" Width="48px" BaseType="Character" MaxLength="12" ReadOnly="True"></SHMA:TextBox>m</td>
                    <td id="lblddlNPH_WEIGHTTTYPE" width="106" align="right">Weight</td>
                    <td id="ctlddlNPH_WEIGHTTTYPE" width="186">
                        <SHMA:DropDownList Style="z-index: 0" ID="ddlNPH_WEIGHTTTYPE" TabIndex="18" runat="server" Width="65px"
                            CssClass="requiredfield" Onchange="Weight_Conversion()" onkeydown="return cancelBack(0)">
                            <asp:ListItem Selected="True"></asp:ListItem>
                            <asp:ListItem Value="K">Kilogram</asp:ListItem>
                            <asp:ListItem Value="L">LBs</asp:ListItem>
                        </SHMA:DropDownList>
                        <SHMA:TextBox Style="z-index: 0" ID="txtNU1_ACTUALWEIGHT" TabIndex="18" runat="server" CssClass="RequiredField"
                            onkeydown="backspaceFunc('txtNU1_ACTUALHEIGHT')" Width="48px" MaxLength="3" BaseType="Character" onchange="Weight_Conversion()"></SHMA:TextBox>
                        <SHMA:TextBox Style="z-index: 0" ID="txtNU1_CONVERTWEIGHT" TabIndex="18" runat="server" CssClass="RequiredField"
                            onkeydown="backspaceFunc('txtNU1_CONVERTWEIGHT')" Width="48px" MaxLength="12" BaseType="Character" ReadOnly="True"></SHMA:TextBox>kg
							<asp:CompareValidator ID="Comparevalidator3" runat="server" ControlToValidate="txtNU1_ACTUALWEIGHT" Operator="DataTypeCheck"
                                Type="Double" ErrorMessage="Number Format is Incorrect " Display="Dynamic"></asp:CompareValidator>
                    </td>
                </tr>
                <tr style="display: none">
                    <td id="lblddlCNT_NATCD" style="height: 23px" align="right" width="106">Nationality
                    </td>
                    <td id="ctlddlCNT_NATCD" style="height: 23px" width="186">
                        <SHMA:DropDownList ID="ddlCNT_NATCD" TabIndex="21" runat="server" CssClass="RequiredField"
                            onkeydown="return cancelBack(0)" Width="184px" DataValueField="CNT_NATCD" DataTextField="desc_f"
                            BlankValue="True">
                        </SHMA:DropDownList>
                    </td>
                </tr>
                <tr class="TRow_Normal">
                    <td id="lbltxt_bmi" width="106" align="right">BMI&nbsp;</td>
                    <td id="ctltxt_bmi" width="186">
                        <SHMA:TextBox Style="z-index: 0" ID="txt_bmi" TabIndex="20" runat="server" CssClass="RequiredField" onkeydown="backspaceFunc('txt_bmi')"
                            Width="184px" BaseType="Character" MaxLength="12"></SHMA:TextBox></td>
                    <td style="height: 21px" width="106" align="right">&nbsp;</td>
                    <td style="height: 21px" width="186"></td>
                </tr>
                <tr id="rowNPH_INSUREDTYPE" class="TRow_Alt">
                    <td id="TDddlNPH_INSUREDTYPE" width="110" align="right"></td>
                    <td width="186">
                        <p style="z-index: 0">
                            <asp:Label Style="z-index: 0" ID="lblServerError" runat="server" EnableViewState="false" ForeColor="Red"
                                Visible="False"></asp:Label>
                        </p>
                    </td>
                </tr>
            </table>
            <!--</fieldset>-->
        </div>
        <input id="HiddenNIC" type="hidden" name="HiddenNIC" runat="server">
        <input id="_CustomArgName" type="hidden" name="_CustomArgName" runat="server">
        <input id="_CustomArgVal" type="hidden" name="_CustomArgVal" runat="server">
        <input id="_CustomEventVal" type="hidden" name="_CustomEventVal" runat="server">
        <input style="width: 0px" id="_CustomEvent" value="Button" type="button" name="_CustomEvent"
            runat="server" onserverclick="_CustomEvent_ServerClick">
        <input id="frm_FetchData_qry" type="hidden" name="frm_FetchData_qry">
        <SHMA:TextBox ID="txtNPH_CODE" runat="server" BaseType="Character" Width="0px"></SHMA:TextBox>
        <asp:CompareValidator ID="cfvNPH_CODE" runat="server" Display="Dynamic" EnableClientScript="False" ErrorMessage="String Format is Incorrect "
            Type="String" Operator="DataTypeCheck" ControlToValidate="txtNPH_CODE"></asp:CompareValidator>
        <SHMA:TextBox ID="txtNPH_LIFE" runat="server" BaseType="Character" Width="0px"></SHMA:TextBox>
        <asp:CompareValidator ID="cfvNPH_LIFE" runat="server" Display="Dynamic" EnableClientScript="False" ErrorMessage="String Format is Incorrect "
            Type="String" Operator="DataTypeCheck" ControlToValidate="txtNPH_LIFE"></asp:CompareValidator>
        <script language="javascript">

</script>
    </form>
    <script language="javascript"><asp:literal id="FooterScript" runat="server" EnableViewState="True"></asp:literal >		if (_lastEvent == 'New') addClicked(); fcStandardFooterFunctionsCall();


        Weight_Conversion();
        convert_to_feet();
        myForm.txtNPH_FULLNAMEARABIC.disabled = true;
        function filterClass(obj_Ref) {

            fcfilterChildCombo(obj_Ref, str_QryCCL_CATEGORYCD, "ddlCCL_CATEGORYCD");
            document.getElementById('ddlCCL_CATEGORYCD').selectedIndex = 1;
        }


        function openPersonsLOV() {
            var wOpen;
            var sOptions;
            var aURL = "../Presentation/PersonSelectionLOV.aspx";
            var aWinName = "Persons_list";

            setFixedValuesInSession('opener=S');

            sOptions = "status=yes,menubar=no,scrollbars=no,resizable=no,toolbar=no";
            sOptions = sOptions + ',width=' + (screen.availWidth / 2).toString();
            sOptions = sOptions + ',height=' + (screen.availHeight / 2.6).toString();
            sOptions = sOptions + ',left=300,top=300';

            wOpen = window.open('', aWinName, sOptions);
            wOpen.location = aURL;
            wOpen.focus();
            return wOpen;
        }


        try {
            parent.frames[1].setViewSecondLife(parent.frames[1].document.getElementById('ddlNPH_INSUREDTYPE1').value);
        } catch (e) { }


        //try{CalculateEntryAge(myForm.txtNPH_BIRTHDATE);}catch(e){myForm.txtNP2_AGEPREM.value='0';}
        CalculateEntryAge(myForm.txtNPH_BIRTHDATE);


        attachViewByNameNormal('txtNPH_BIRTHDATE');
        attachViewFocus('INPUT');
        attachViewFocus('SELECT');


        /************************************************************************/
        /********************* Screen Parameterization **************************/
        setFieldStatusAsPerClientSetup("PERSONNEL2");

        //Set ID Format
        IDFormat = getFieldFormatFromSetup("PERSONNEL", document.getElementById("txtCNIC_VALUE"));

        function checkMandatoryColumns() {
            if (getField("NPH_TITLE").value == "") {
                alert("Please select Title.");
                getField("NPH_TITLE").focus();
                return false;

            }

            if (getField("NPH_SEX").value == "") {
                alert("Please select Gender.");
                getField("NPH_SEX").focus();
                return false;
            }

            if (getField("NPH_BIRTHDATE").value == "") {
                alert("Please select Date of Birth.");
                getField("NPH_BIRTHDATE").focus();
                return false;
            }

            if (CalculateEntryAge(getField("NPH_BIRTHDATE")) == false) {
                getField("NPH_BIRTHDATE").focus();
                return false;
            }

            return true;
        }


        function beforeSave() {
            if (checkMandatoryColumns() == false) {
                return false;
            }
            else {
                //generateID(IDFormat);		

                document.getElementById("txtNU1_CONVERTHEIGHT").readOnly = false;
                document.getElementById("txtNU1_CONVERTWEIGHT").readOnly = false;

                EnableFieldsBeforeSubmitting();
                return true;
            }
        }
        function beforeUpdate() {
            if (checkMandatoryColumns() == false) {
                return false;
            }
            else {
                //generateID(IDFormat);
                EnableFieldsBeforeSubmitting();
                return true;
            }
        }
        function getElementTop(Elem) {
            if (document.getElementById) {
                var elem = document.getElementById(Elem);
            } else if (document.all) {
                var elem = document.all[Elem];
            }

            var yPos = elem.offsetTop;
            tempEl = elem.offsetParent;
            while (tempEl != null) {
                yPos += tempEl.offsetTop;
                tempEl = tempEl.offsetParent;
            }
            return yPos - 10 + 'px';
        }

        function getElementLeft(Elem) {
            if (document.getElementById) {
                var elem = document.getElementById(Elem);
            } else if (document.all) {
                var elem = document.all[Elem];
            }

            var xPos = elem.offsetLeft;
            tempEl = elem.offsetParent;
            while (tempEl != null) {
                xPos += tempEl.offsetLeft;
                tempEl = tempEl.offsetParent;
            }
            return xPos - 16 + 'px';
        }	

        function setDivPos() {
            personNameDiv.style.position = "absolute";
            personNameDiv.style.top = getElementTop("txtNPH_FULLNAME");
            personNameDiv.style.left = getElementLeft("txtNPH_FULLNAME");
        }


        //Variable related to NAMES Div only - should work only for IE-6
        var CombosHide = false;
        function showNameDiv(bln) {
            var gender = getField("NPH_SEX");
            var Occupation = getField("COP_OCCUPATICD");
            var OccupationClass = getField("CCL_CATEGORYCD");


            if (bln == true) {
                personNameDiv.style.display = "";
                setDivPos();
                getField("NPH_FIRSTNAME").focus();

                if (gender.style.display == '' || gender.style.visibility == 'visible') gender.style.visibility = 'hidden';
                if (Occupation.style.display == '' || Occupation.style.visibility == 'visible') Occupation.style.visibility = 'hidden';
                if (OccupationClass.style.display == '' || OccupationClass.style.visibility == 'visible') OccupationClass.style.visibility = 'hidden';

                CombosHide = true;
            }
            else {
                personNameDiv.style.display = "none";

                if (CombosHide == true) {
                    if (gender.style.visibility == 'hidden') gender.style.visibility = 'visible';
                    if (Occupation.style.visibility == 'hidden') Occupation.style.visibility = 'visible';
                    if (OccupationClass.style.visibility == 'hidden') OccupationClass.style.visibility = 'visible';
                }
                CombosHide = false;

                getField("NPH_FATHERNAME").focus();
            }
        }
        function btnOK_Click() {
            if (Trim(getField("NPH_FIRSTNAME").value).length > 0) {
                //*********************** Set Name first ***************************//
                //First Name
                getField("NPH_FULLNAME").value = Trim(getField("NPH_FIRSTNAME").value);
                //Second Name
                if (Trim(getField("NPH_SECONDNAME").value).length > 0) getField("NPH_FULLNAME").value += " " + Trim(getField("NPH_SECONDNAME").value);
                //Last Name
                if (Trim(getField("NPH_LASTNAME").value).length > 0) getField("NPH_FULLNAME").value += " " + Trim(getField("NPH_LASTNAME").value);

                //*********************** Generate ID Now ***************************//
                showNameDiv(false);
                //Generate ID
                generateID(IDFormat);
            }
            else {
                alert("First Name can't be empty");
            }
        }
        function Name_GotFocus(objName) {
            document.getElementById("nameFormat").style.display = "";
            showNameDiv(true);
        }
        function Name_LostFocus(objName) {
            document.getElementById("nameFormat").style.display = "none";
        }
		/************************************************************************/
    </script>
    <script language="C#" runat="server">
        public int getHighLighted()
        {
            return 0;
        }
    </script>
</body>
</html>
