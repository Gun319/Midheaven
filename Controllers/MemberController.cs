using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Text;
using System.Web;
using System.Web.Mvc;
using Midheaven.Models;

namespace Midheaven.Controllers
{
    public class MemberController : Controller
    {
        // GET: Member

        /// <summary>
        /// 数据实体对象
        /// </summary>
        midheavenDBEntities mDBEntities = new midheavenDBEntities();

        /// <summary>
        /// 暂存验证码
        /// </summary>
        public static string result = "";

        /// <summary>
        /// 首页(游客)
        /// 页面必须包含登录、注册
        /// </summary>
        /// <returns></returns>
        public ActionResult Index()
        {
            return View();
        }

        /// <summary>
        /// 成员注册
        /// 发送邮箱验证码
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public ActionResult Register()
        {
            return View();
        }
        /// <summary>
        /// 成员注册
        /// 验证邮箱完成注册
        /// </summary>
        /// <param name="uname"></param>
        /// <param name="upwd"></param>
        /// <param name="newcode"></param>
        /// <param name="Role"></param>
        /// <returns></returns>
        [HttpPost]
        public JsonResult Register(string uname, string upwd, string newcode, string Role)
        {
            int code = 200;
            if (result == newcode)
            {
                Member member = new Member()
                {
                    UserName = uname,
                    Password = upwd,
                    R_ID = Convert.ToInt32(Role),
                    M_Flog = 0,
                };
                mDBEntities.Member.Add(member);
                mDBEntities.SaveChanges();
                return Json(code, JsonRequestBehavior.AllowGet);
            }
            else
            {
                code = 201;
                return Json(code, JsonRequestBehavior.AllowGet);
            }
        }

        /// <summary>
        /// 学生登陆成功
        /// 所有课程显示简介,课程选择按钮
        /// </summary>
        /// <returns></returns>
        public ActionResult MemberByStudent()
        {
            return View();
        }
        /// <summary>
        /// 学生课程选择
        /// 显示已选的课程,课程删除
        /// </summary>
        /// <returns></returns>
        public ActionResult SelStudentCourse()
        {
            return View();
        }

        /// <summary>
        /// 学生课程选择
        /// 显示已选的课程,根据课程id进行删除,真删除
        /// </summary>
        /// <returns></returns>
        public ActionResult DelStudentCourse(int id)
        {
            return RedirectToAction("SelStudentCourse");
        }

        /// <summary>
        /// 教师登陆成功
        /// 教师所属课程，及其简介
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public ActionResult MemberByTeacher()
        {
            if (Session["username"] == null)
                return RedirectToAction("Login", "Login");
            else
            {
                ViewBag.tName = Session["username"].ToString();
                return View();
            }
        }
        /// <summary>
        /// 查询显示课程
        /// </summary>
        /// <param name="cName">课程名称</param>
        /// <returns></returns>
        [HttpPost]
        public ActionResult MemberByTeacher(string cName)
        {
            int mid = Convert.ToInt32(Session["mid"].ToString());
            //根据课程的id进行分组
            var tCouser = from c in mDBEntities.Course
                          join sc in mDBEntities.StudentCourse on c.C_ID equals sc.C_ID
                          where c.M_ID == mid
                          group new { sc.C_ID } by new { c.C_ID, c.C_Name, c.C_Desc, c.C_img, c.C_flog } into g
                          select new
                          {
                              name = g.Key,
                              count = g.Count()
                          };
            if (!string.IsNullOrWhiteSpace(cName))
                tCouser = tCouser.Where(c => c.name.C_Name.Contains(cName));
            return Json(tCouser.ToList(), JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// 查看全部已上传的课程
        /// </summary>
        /// <returns></returns>
        public ActionResult SelCouser()
        {
            if (Session["username"] == null)
                return RedirectToAction("Login", "Login");
            else
            {
                int mid = Convert.ToInt32(Session["mid"].ToString());
                IQueryable<Course> couser = mDBEntities.Course.Where(c => c.M_ID == mid);
                ViewBag.couser = couser;
                ViewBag.tName = Session["mName"].ToString();
                return View();
            }
        }

        /// <summary>
        /// 教师添加课程
        /// 用户类型为教师,关联当前教师id
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public ActionResult AddCourse()
        {
            if (Session["username"] == null)
                return RedirectToAction("Login", "Login");
            else
                return View();
        }

        /// <summary>
        /// 教师添加课程
        /// 用户类型为教师,关联当前教师id
        /// </summary>
        /// <returns></returns>
        [HttpPost]
        public ActionResult AddCourse(string cName, string CDesc, string imgname)
        {
            int code = 201;
            int mid = Convert.ToInt32(Session["mid"].ToString());
            Course course = new Course()
            {
                C_Name = cName,
                C_Desc = CDesc,
                C_img = imgname,
                M_ID = mid,
                C_flog = 0
            };
            mDBEntities.Course.Add(course);
            if (mDBEntities.SaveChanges() == 1)
                code = 200;
            return Json(code, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// 修改课程信息
        /// 变更课程选择状态
        /// </summary>
        /// <returns></returns>
        [HttpPost]
        public ActionResult EditCourseById(int cid)
        {
            int code = 201;
            Course couser = mDBEntities.Course.Where(c => c.C_ID == cid).FirstOrDefault();
            if (couser.C_flog == 0)
                couser.C_flog = 1;
            else
                couser.C_flog = 0;
            if (mDBEntities.SaveChanges() == 1)
                code = 200;
            return Json(code, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// 删除课程
        /// 教师只能删除自己上传的课程
        /// 仅改变课程状态
        /// </summary>
        /// <param name="id">课程编号</param>
        /// <returns></returns>
        [HttpPost]
        public ActionResult DelCourseById(int cid)
        {
            int code = 201;
            var couinfo = mDBEntities.Course.Where(m => m.C_ID == cid).FirstOrDefault();
            if (couinfo.C_flog == 1)
            {
                mDBEntities.Course.Remove(couinfo);
                if (mDBEntities.SaveChanges() == 1)
                    code = 200;
            }
            else
            {
                code = 202;
            }
            return Json(code, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// 发送邮件
        /// </summary>
        /// <param name="direction">收件人地址</param>
        /// <returns></returns>
        [HttpPost]
        public JsonResult sendEmail(string direction)
        {
            int codet = 200;
            try
            {
                //发送者邮箱账户
                string sendEmail = "junjie-pan-mail@foxmail.com";
                //发送者邮箱账户授权码
                string code = "assbuatxoydlbhjf";
                //发件人地址
                MailAddress from = new MailAddress(sendEmail);
                MailMessage message = new MailMessage();

                //收件人地址 从客户端获取
                message.To.Add(direction);

                //标题
                message.Subject = "中天教育注册";
                message.SubjectEncoding = Encoding.UTF8;
                message.From = from;

                //生成六位随机数 作为验证码
                string authCode = AuthCode();

                //邮件内容
                message.Body = string.Format(@"
                        <div style='margin:auto'>
                            <h2 style='text-align: center; font-size:28px'>
                                <b>中天<span style='color:#AAA'>教育</span></b>
                            </h2>
                            <div style='width:500px;margin:auto'>
                                <h1 style='font-size: 24px'><b>激活您的帐户</b></h1><br />
                                感谢您注册 中天教育！<br /><br />
                                <b><span style='font-size:28px'>您的验证码：<span style='color:blue'>{0}</span></span></b><br /><br />
                                <span>确认后，您可以使用新帐户登录 中天教育 开始您的学习之旅</span>
                            </div>
                        </div>", authCode);

                message.IsBodyHtml = true;
                message.BodyEncoding = Encoding.UTF8;

                SmtpClient client = new SmtpClient();
                client.EnableSsl = true;
                client.Host = "smtp.qq.com";//smtp服务器
                client.Port = 587;//smtp端口
                                  //发送者邮箱账户和授权码
                client.Credentials = new NetworkCredential(sendEmail, code);
                client.Send(message);

                return Json(codet, JsonRequestBehavior.AllowGet);
            }
            catch (Exception)
            {
                codet = 201;
                return Json(codet, JsonRequestBehavior.AllowGet);
            }
        }

        /// <summary>
        /// 验证码生成
        /// </summary>
        /// <returns></returns>
        public string AuthCode()
        {
            string code = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";//要随机的字母
            Random rand = new Random(); //随机类
            result = "";
            for (int i = 0; i < 6; i++) //循环6次，生成6位数字，10位就循环10次
            {
                result += code[rand.Next(63)]; //通过索引下标随机
            }
            return result;
        }

        /// <summary>
        /// 图片上传
        /// </summary>
        /// <returns></returns>
        [HttpPost]
        public ActionResult Indexpic()
        {
            HttpPostedFileBase filename = Request.Files["fileImg"];
            //判断文件名是否为空
            if (filename == null || filename.ContentLength == 0)
            {
                return Content("<script>alert('文件不能为空');</script>");
            }
            //判断后缀名是否为图片
            string[] arrfilename = filename.FileName.Split('.');
            if (arrfilename.Length < 2)
            {
                return Content("<script>alert('文件无后缀名');</script>");
            }
            //判断文件后缀名
            //获取文件后缀名
            string lastfilename = arrfilename[arrfilename.Length - 1].Trim();
            //文件后缀
            string[] lastname = { "jpg", "PNG", "jpeg", "png", "GIF" };
            if (!lastname.Contains(lastfilename))
            {
                return Content("<script>alert('文件不是图片');</script>");
            }
            //文件内容是否为图片
            FileEnum[] fiee = { FileEnum.JPG, FileEnum.jpg, FileEnum.PNG, FileEnum.png, FileEnum.GIF };
            bool flog = file(filename, fiee);
            if (flog == false)
            {
                return Content("<script>alert('文件不是图片');</script>");
            }
            string newfilename = Guid.NewGuid().ToString() + "." + lastfilename;
            //保存
            filename.SaveAs(Server.MapPath("~/image/Course/") + newfilename);
            TempData["name"] = newfilename;
            return Content("<script>window.parent.ShowImg('" + newfilename + "');</script>");
        }

        /// <summary>
        /// 判断文件内容
        /// </summary>
        /// <param name="filename"></param>
        /// <param name="fileEnum"></param>
        /// <returns></returns>
        public bool file(HttpPostedFileBase filename, FileEnum[] fileEnum)
        {
            //获取文件大小
            int fileName = filename.ContentLength;
            //获取文件大小 存入byte[]
            byte[] fileByte = new byte[fileName];
            //读取字节流
            filename.InputStream.Read(fileByte, 0, fileName);
            string img = fileByte[0].ToString() + fileByte[1].ToString();
            foreach (var item in fileEnum)
            {
                if (Convert.ToInt32(img) == Convert.ToInt32(item))
                {
                    return true;
                }
            }
            return false;
        }

        /// <summary>
        /// 文件格式枚举
        /// </summary>
        public enum FileEnum
        {
            JPG = 255216,
            GIF = 7173,
            PNG = 13780,
            png = 13780,
            BMP = 6677,
            RAR = 8297,
            jpg = 255216,
            xml = 6063,
            exe = 7790,
            aspx = 239187,
            cs = 117115,
            js = 119105,
            txt = 210187,
            sql = 255254,
            html = 6033
        }
    }
}