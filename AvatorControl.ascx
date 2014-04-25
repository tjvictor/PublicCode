<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AvatorControl.ascx.cs"
    Inherits="WebApplication1.Control.AvatorControl" %>
<script src="../js/jquery.min.js" type="text/javascript"></script>
<script src="../js/jquery.Jcrop.js" type="text/javascript"></script>
<link rel="stylesheet" href="../css/jquery.Jcrop.css" type="text/css" />
<link rel="stylesheet" href="../css/demos.css" type="text/css" />
<script type="text/javascript">

    jQuery(function ($) {
        var jcrop_api, boundx, boundy;

        $('#<%= scrImage.ClientID%>').Jcrop({
            onChange: showCoords,
            onSelect: showCoords,
            onRelease: clearCoords,
            aspectRatio: 1
        }, function () {
            // Use the API to get the real image size
            var bounds = this.getBounds();
            boundx = bounds[0];
            boundy = bounds[1];
            // Store the API in the jcrop_api variable
            jcrop_api = this;
        });

        // Simple event handler, called from onChange and onSelect
        // event handlers, as per the Jcrop invocation above
        function showCoords(c) {
            $('#<%= x1.ClientID%>').val(c.x);
            $('#<%= y1.ClientID%>').val(c.y);
            $('#<%= x2.ClientID%>').val(c.x2);
            $('#<%= y2.ClientID%>').val(c.y2);
            $('#<%= w.ClientID%>').val(c.w);
            $('#<%= h.ClientID%>').val(c.h);
            updatePreview(c);
        };

        function clearCoords() {
            $('#coords input').val('');
            $('#h').css({ color: 'red' });
            window.setTimeout(function () {
                $('#h').css({ color: 'inherit' });
            }, 500);
        };

        function updatePreview(c) {
            if (parseInt(c.w) > 0) {
                var rx = 100 / c.w;
                var ry = 100 / c.h;

                $('#<%= previewImage.ClientID%>').css({
                    width: Math.round(rx * boundx) + 'px',
                    height: Math.round(ry * boundy) + 'px',
                    marginLeft: '-' + Math.round(rx * c.x) + 'px',
                    marginTop: '-' + Math.round(ry * c.y) + 'px'
                });
            }
        };
    });
</script>
<div>
    <asp:FileUpload ID="fileUpload" runat="server" Width="400px" />
    <asp:Button ID="uploadBtn" runat="server" Text="上传" OnClick="uploadBtn_Click" />
</div>
<div>
    <asp:Label ID="uploadRemindTxt" runat="server" Visible="false"></asp:Label>
    <input type="hidden" name="hiddenFileName" runat="server" id="hiddenFileName" />
</div>
<br />
<div>
    <asp:Panel ID="imagePanel" runat="server" Visible="false">
        <table>
            <tr>
                <td>
                    <asp:Image ID="scrImage" runat="server" />
                    <div>
                        <label>
                            X1
                            <input type="text" size="4" id="x1" name="x1" runat="server" /></label>
                        <label>
                            Y1
                            <input type="text" size="4" id="y1" name="y1" runat="server" /></label>
                        <label>
                            X2
                            <input type="text" size="4" id="x2" name="x2" runat="server" /></label>
                        <label>
                            Y2
                            <input type="text" size="4" id="y2" name="y2" runat="server" /></label>
                        <label>
                            W
                            <input type="text" size="4" id="w" name="w" runat="server" /></label>
                        <label>
                            H
                            <input type="text" size="4" id="h" name="h" runat="server" /></label>
                        <asp:Button ID="cutBtn" runat="server" Text="剪裁" OnClick="cutBtn_Click" />
                    </div>
                </td>
                <td>
                    <div style="width: 96px; height: 96px; overflow: hidden;">
                        <asp:Image ID="previewImage" runat="server" alt="Preview" />
                    </div>
                </td>
            </tr>
        </table>
    </asp:Panel>
</div>
AvatorControl.ascx
