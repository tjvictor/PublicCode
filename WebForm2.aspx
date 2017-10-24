<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm2.aspx.cs" Inherits="AjaxWebSite.WebForm2" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
        <script src="Scripts/jquery-1.10.2.js" type="text/javascript"></script>
    <script src="Scripts/common.js" type="text/javascript"></script>
    <script src="Scripts/ajaxfileupload.js" type="text/javascript"></script>
    <script type="text/javascript">

        $(function () {
            callAjax('webHandler.ashx?action=filelist', '', 'filelistCallback', '', '', '', '')
        });

        function filelistCallback(dataStr) {
            var data = JSON.parse(dataStr)
            if (data.Status == "ok") {
                var fileList = data.callBackEntity;
                for (var i = 0; i < data.CallBackEntity.length; i++ ) {
                    var file = data.CallBackEntity[i];

                    var filePathFormat = file.FilePath.replace(/\\/g, "/");
                    var tr_pre = '<tr uid="' + filePathFormat + '"><td>';
                    var fileNameLink = '<a href="javascript:void(0)" style="float:left;" onclick="downloading(' + "'" + file.FileName + "','" + filePathFormat + "'" + ')">' + file.FileName + '</a>';
                    var fileDeleteLink = '<a href="javascript:void(0)" style="float:right;margin-left:20px;" onclick="deleteFile(' + "'" + filePathFormat + "'" + ')">Delete</a>';
                    var fileDateSpan = '<span style="float:right">'+file.FileDate+'</span>';
                    var tr_suf = '</td></tr>';

                    $('#fileListTB').html($('#fileListTB').html() + tr_pre + fileNameLink + fileDeleteLink + fileDateSpan + tr_suf);
                }
            }
        }

        function uploading() {
            $.ajaxFileUpload({
                url: 'webHandler.ashx?action=uploadX', //文件上传到哪个地址，告诉ajaxFileUpload
                secureuri: false, //一般设置为false
                fileElementId: 'fileUpload', //文件上传控件的Id  <input type="file" id="fileUpload" name="file" />
                //dataType: 'json', //返回值类型 一般设置为json
                success: function (dataObj, status)  //服务器成功响应处理函数
                {
                    var data = JSON.parse(dataObj.body.innerText)
                    if (data.Status == "ok") {
                        var file = data.CallBackEntity;
                        $('#reminder').css("color", "green");
                        $('#reminder').text(file.FileName);

                        var filePathFormat = file.FilePath.replace(/\\/g, "/");
                        var tr_pre = '<tr uid="' + filePathFormat + '"><td>';
                        var fileNameLink = '<a href="javascript:void(0)" style="float:left;" onclick="downloading(' + "'" + file.FileName + "','" + filePathFormat + "'" + ')">' + file.FileName + '</a>';
                        var fileDeleteLink = '<a href="javascript:void(0)" style="float:right;margin-left:20px;" onclick="deleteFile(' + "'" + filePathFormat + "'" + ')">Delete</a>';
                        var fileDateSpan = '<span style="float:right">' + file.FileDate + '</span>';
                        var tr_suf = '</td></tr>';

                        $('#fileListTB').html(tr_pre + fileNameLink + fileDeleteLink + fileDateSpan + tr_suf + $('#fileListTB').html());

                    } else {
                        $('#reminder').css("color", "red");
                        $('#reminder').text(data.Prompt);
                    }
                },
                error: function (xhr, textStatus) {

                },
                complete: function (data) {

                }
            });
        }

        function deleteFile(filePath) {
            callAjax('webHandler.ashx?action=delete&filePath=' + filePath, '', 'deleteCallback', '', '', '', '')
        }

        function deleteCallback(dataStr) {
            var data = JSON.parse(dataStr)
            if (data.Status == "ok") {
                $('#reminder').css("color", "green");
                $('#reminder').text(data.Prompt);

                $('#fileListTB tr[uid="' + data.CallBackEntity.FilePath + '"]').remove();

            } else {
                $('#reminder').css("color", "red");
                $('#reminder').text(data.Prompt);
            }
        }

        function downloading(fileName, filePath) {
            var form = $("<form>"); //定义一个form表单
            form.attr("style", "display:none");
            form.attr("target", "");
            form.attr("method", "post");
            form.attr("action", "webHandler.ashx?action=download&fileName=" + fileName + "&filePath=" + filePath);
            var input1 = $("<input>");
            input1.attr("type", "hidden");
            input1.attr("name", "webHandler.ashx?action=download");
            input1.attr("value", (new Date()).getMilliseconds());
            $("body").append(form); //将表单放置在web中
            form.append(input1);

            form.submit(); //表单提交 
        }
    </script>
</head>
<body>
    <div>
        <input id="fileUpload" type="file" name="file1" onchange="uploading();"/>
        <span id="reminder"></span>
    </div>
    <div style="width:100%;height:1px;background-color:blue;margin:10px 0 10px 0;"></div>
    <div>
        <table id="fileListTB" style="width:100%">
        </table>
    </div>
</body>
</html>
