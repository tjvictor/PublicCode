<%@ Page Language="C#" AutoEventWireup="true" CodeFile="FileManagerDialog.aspx.cs" Inherits="userControl_FileManagerDialog" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:FileUpload ID="fileUploadBtn" runat="server" />
        <asp:Button ID="uploadBtn" runat="server" Text="上传" onclick="uploadBtn_Click" />
        <asp:Label ID="fileUploadStatus" runat="server"></asp:Label>
    </div>
    <div style="width:100%;height:1px;background-color:blue;margin:10px 0 10px 0;"></div>

    <asp:PlaceHolder ID="placeHolder" runat="server"></asp:PlaceHolder>

    <asp:Table ID="fileListTable" runat="server" Width="100%">
    </asp:Table>

    </form>
</body>
</html>
