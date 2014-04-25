using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Drawing;

namespace WebApplication1.Control
{
    public partial class AvatorControl : System.Web.UI.UserControl
    {
        public string FilePath
        {
            get
            {
                if (string.IsNullOrEmpty(hiddenFileName.Value))
                    return null;
                return Path.Combine(DownLoadPath, hiddenFileName.Value);
            }
        }

        private string downLoadPath;
        public string DownLoadPath
        {
            get
            {
                return Path.Combine(AppDomain.CurrentDomain.BaseDirectory, downLoadPath);
            }
            set
            { downLoadPath = value; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                hiddenFileName.Value = Guid.NewGuid().ToString();
            }
        }

        protected void uploadBtn_Click(object sender, EventArgs e)
        {
            if (fileUpload.HasFile)
            {
                try
                {
                    String filename = hiddenFileName.Value;

                    fileUpload.SaveAs(Path.Combine(DownLoadPath, filename));

                    scrImage.ImageUrl = string.Format("~/{0}/{1}", downLoadPath, filename);
                    previewImage.ImageUrl = string.Format("~/{0}/{1}", downLoadPath, filename);
                    imagePanel.Visible = true;
                    uploadRemindTxt.Visible = true;
                    uploadRemindTxt.Text = "文件上传成功";
                }
                catch (Exception ex)
                {
                    uploadRemindTxt.Visible = true;
                    uploadRemindTxt.Text = ex.Message;
                }
            }
            else
            {
                uploadRemindTxt.Visible = true;
                uploadRemindTxt.Text = "文件不存在";
            }
        }

        protected void cutBtn_Click(object sender, EventArgs e)
        {
            String filename = hiddenFileName.Value;
            System.Drawing.Image originalImage =
                System.Drawing.Image.FromFile(Path.Combine(DownLoadPath, filename));

            int x = int.Parse(x1.Value);
            int y = int.Parse(y1.Value);
            int towidth = int.Parse(w.Value);
            int toheight = int.Parse(h.Value);

            System.Drawing.Image bitmap = new System.Drawing.Bitmap(towidth, toheight);
            //新建画板
            Graphics g = System.Drawing.Graphics.FromImage(bitmap);
            g.DrawImage(originalImage, new Rectangle(0, 0, towidth, toheight),
                new Rectangle(x, y, towidth, toheight),
                GraphicsUnit.Pixel);

            try
            {
                //jpg格式保存缩略图
                filename = Guid.NewGuid().ToString();
                bitmap.Save(Path.Combine(DownLoadPath, filename), System.Drawing.Imaging.ImageFormat.Jpeg);
                uploadRemindTxt.Visible = true;
                uploadRemindTxt.Text = "文件裁减成功";

                hiddenFileName.Value = filename;
                scrImage.ImageUrl = string.Format("~/{0}/{1}", downLoadPath, filename);
                previewImage.ImageUrl = string.Format("~/{0}/{1}", downLoadPath, filename);
            }
            catch (System.Exception ex)
            {
                uploadRemindTxt.Visible = true;
                uploadRemindTxt.Text = ex.Message;
            }
            finally
            {
                originalImage.Dispose();
                bitmap.Dispose();
                g.Dispose();
            }
        }
    }
}
