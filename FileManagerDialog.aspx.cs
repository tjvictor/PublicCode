using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

public partial class userControl_FileManagerDialog : System.Web.UI.Page
{

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Table table = ListFileList(App_Util.getFilePath(Request.QueryString["orderid"]).Replace("\\报告\\", ""));
            //ViewState.Add("table", table);
            placeHolder.Controls.Add(table);
        }

        
        
    }

    private Table ListFileList(string path)
    {
        DirectoryInfo folder = new DirectoryInfo(path);
        Table table = new Table();
        table.Style.Add("width", "100%");
        foreach (FileInfo file in folder.GetFiles("*"))
        {
            TableRow tr = new TableRow();
            TableCell tc = new TableCell();

            LinkButton lb = new LinkButton();
            lb.Text = file.Name;
            lb.Style.Add("float", "left");
            lb.CommandName = file.Name;
            lb.CommandArgument = file.FullName;
            lb.Click += new EventHandler(Download_Click);

            Label l = new Label();
            l.Text = file.LastWriteTime.ToString("yyyy-MM-dd");
            l.Style.Add("float", "right");

            LinkButton lb_delete = new LinkButton();
            lb_delete.Text = "删除";
            lb_delete.Style.Add("float", "right");
            lb_delete.Style.Add("margin-left", "50px");
            lb_delete.CommandName = file.Name;
            lb_delete.CommandArgument = file.FullName;
            lb_delete.Click += new EventHandler(lb_delete_Click);

            tc.Controls.Add(lb);
            tc.Controls.Add(lb_delete);
            tc.Controls.Add(l);
            tr.Cells.Add(tc);
            table.Rows.Add(tr);
        }

        return table;
    }

    void lb_delete_Click(object sender, EventArgs e)
    {
        try
        {
            string path = ViewState["path"].ToString();
            LinkButton lb = sender as LinkButton;
            File.Delete(lb.CommandArgument);
            fileUploadStatus.Style.Add("color", "green");
            fileUploadStatus.Text = String.Format("删除 {0} 成功", lb.CommandName);


            
        }
        catch (Exception ex)
        {
            fileUploadStatus.Style.Add("color", "red");
            fileUploadStatus.Text = string.Format("删除失败:{0}", ex.Message);
        }
    }

    protected void Download_Click(object sender, EventArgs e)
    {
        LinkButton lb = sender as LinkButton;
        
        //以字符流的形式下载文件
        FileStream fs = new FileStream(lb.CommandArgument, FileMode.Open);
        byte[] bytes = new byte[(int)fs.Length];
        fs.Read(bytes, 0, bytes.Length);
        fs.Close();
        Response.ContentType = "application/octet-stream";
        //通知浏览器下载文件而不是打开
        Response.AddHeader("Content-Disposition", "attachment; filename=" + HttpUtility.UrlEncode(lb.CommandName, System.Text.Encoding.UTF8));
        Response.BinaryWrite(bytes);
        Response.Flush();
        Response.End();
    }

    protected void uploadBtn_Click(object sender, EventArgs e)
    {
        try
        {
            string path = ViewState["path"].ToString();
            if (fileUploadBtn.HasFile)
            {
                fileUploadBtn.SaveAs(path + @"\" + fileUploadBtn.FileName);

                fileUploadStatus.Style.Add("color", "green");
                fileUploadStatus.Text = String.Format("上传 {0} 成功", fileUploadBtn.FileName);

                FileInfo file = new FileInfo(path + @"\" + fileUploadBtn.FileName);

                Table table = ViewState["table"] as Table;
                TableRow tr = new TableRow();
                TableCell tc = new TableCell();

                LinkButton lb = new LinkButton();
                lb.Text = file.Name;
                lb.Style.Add("float", "left");
                lb.CommandName = file.Name;
                lb.CommandArgument = file.FullName;
                lb.Click += new EventHandler(Download_Click);

                Label l = new Label();
                l.Text = file.LastWriteTime.ToString("yyyy-MM-dd");
                l.Style.Add("float", "right");

                LinkButton lb_delete = new LinkButton();
                lb_delete.Text = "删除";
                lb_delete.Style.Add("float", "right");
                lb_delete.Style.Add("margin-left", "50px");
                lb_delete.CommandName = file.Name;
                lb_delete.CommandArgument = file.FullName;
                lb_delete.Click += new EventHandler(lb_delete_Click);

                tc.Controls.Add(lb);
                tc.Controls.Add(lb_delete);
                tc.Controls.Add(l);
                tr.Cells.Add(tc);
                table.Rows.AddAt(0, tr);

                placeHolder.Controls.Clear();
                placeHolder.Controls.Add(table);
                ViewState["table"] = table;
            }
        }
        catch (Exception ex)
        {
            fileUploadStatus.Style.Add("color", "red");
            fileUploadStatus.Text = string.Format("上传失败:{0}", ex.Message);
        }
    }
}