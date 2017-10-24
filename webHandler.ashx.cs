using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.IO;
using System.Web.Script.Serialization;

namespace AjaxWebSite
{
    /// <summary>
    /// Summary description for webHandler
    /// </summary>
    public class webHandler : IHttpHandler
    {
        private class FileBrief
        {
            private string fileName;

            public string FileName
            {
                get { return fileName; }
                set { fileName = value; }
            }
            private string fileDate;

            public string FileDate
            {
                get { return fileDate; }
                set { fileDate = value; }
            }
            private string filePath;

            public string FilePath
            {
                get { return filePath; }
                set { filePath = value; }
            }
        }

        private class ResponseEntity
        {
            private string status;

            public string Status
            {
                get { return status; }
                set { status = value; }
            }
            private string prompt;

            public string Prompt
            {
                get { return prompt; }
                set { prompt = value; }
            }
            private object callBackEntity;

            public object CallBackEntity
            {
                get { return callBackEntity; }
                set { callBackEntity = value; }
            }

        }

        public void ProcessRequest(HttpContext context)
        {
            switch (context.Request.QueryString["action"])
            {
                case "uploadX": UploadAnyFile(context); break;
                case "upload": UploadFile(context); break;
                case "download": DownloadFile(context); break;
                case "filelist": fileList(context); break;
                case "delete": DeleteFile(context); break;
                default: break;
            }
        }

        private void DeleteFile(HttpContext context)
        {
            string path = context.Request.QueryString["filePath"];

            FileBrief fb = new FileBrief();
            fb.FilePath = path;

            File.Delete(path);

            ResponseEntity re = new ResponseEntity();
            re.Status = "ok";
            re.Prompt = "ok";
            re.CallBackEntity = fb;
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            context.Response.Write(serializer.Serialize(re));

        }

        private void fileList(HttpContext context)
        {
            DirectoryInfo folder = new DirectoryInfo(@"C:\temp\classes");
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            List<FileBrief> fileBriefList = new List<FileBrief>();

            foreach (FileInfo file in folder.GetFiles("*"))
            {
                FileBrief fb = new FileBrief();
                fb.FileName = file.Name;
                fb.FilePath = file.FullName;
                fb.FileDate = file.LastWriteTime.ToString("yyyy-MM-dd");

                fileBriefList.Add(fb);
            }

            ResponseEntity re = new ResponseEntity();
            re.Status = "ok";
            re.Prompt = "ok";
            re.CallBackEntity = fileBriefList;

            context.Response.Write(serializer.Serialize(re));
        }

        private void UploadFile(HttpContext context)
        {
            context.Response.ContentType = "text/html";
            HttpServerUtility server = context.Server;
            HttpRequest request = context.Request;
            HttpResponse response = context.Response;

            HttpPostedFile file = context.Request.Files[0];
            if (file.ContentLength > 0)
            {
                string extName = Path.GetExtension(file.FileName);
                string fileName = Guid.NewGuid().ToString();
                string fullName = fileName + extName;

                string imageFilter = ".jpg|.png|.gif|.ico";// 随便模拟几个图片类型
                if (imageFilter.Contains(extName.ToLower()))
                {
                    string phyFilePath = @"C:\uploadImg\" + fullName;
                    file.SaveAs(phyFilePath);
                    response.Write("上传成功！文件名：" + fullName + "<br />");
                    response.Write(string.Format("<img src='Upload/Image/{0}'/>", fullName));
                }
            }
        }

        private void UploadAnyFile(HttpContext context)
        {
            context.Response.ContentType = "text/html";
            HttpServerUtility server = context.Server;
            HttpRequest request = context.Request;
            HttpResponse response = context.Response;

            HttpPostedFile file = context.Request.Files[0];
            if (file.ContentLength > 0)
            {
                string phyFilePath = @"C:\temp\classes\" + file.FileName;
                file.SaveAs(phyFilePath);

                ResponseEntity re = new ResponseEntity();
                re.Status = "ok";
                re.Prompt = "ok";
                FileInfo refile = new FileInfo(phyFilePath);
                FileBrief fb = new FileBrief();
                fb.FileName = refile.Name;
                fb.FileDate = refile.LastWriteTime.ToString("yyyy-MM-dd");
                fb.FilePath = refile.FullName;
                re.CallBackEntity = fb;
                JavaScriptSerializer serializer = new JavaScriptSerializer();
                string str = serializer.Serialize(re);
                response.Write(str);
            }
        }

        private void DownloadFile(HttpContext context)
        {
            context.Response.ContentType = "text/html";
            HttpServerUtility server = context.Server;
            HttpRequest request = context.Request;
            HttpResponse response = context.Response;

            string filePath = context.Request.QueryString["filePath"];
            string fileName = context.Request.QueryString["fileName"];
            
            FileStream fs = new FileStream(filePath, FileMode.Open);
            byte[] bytes = new byte[(int)fs.Length];
            fs.Read(bytes, 0, bytes.Length);
            fs.Close();
            response.ContentType = "application/octet-stream";
            //通知浏览器下载文件而不是打开
            response.AddHeader("Content-Disposition", "attachment; filename=" + HttpUtility.UrlEncode(fileName, System.Text.Encoding.UTF8));
            response.BinaryWrite(bytes);
            response.Flush();
            response.End();
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}