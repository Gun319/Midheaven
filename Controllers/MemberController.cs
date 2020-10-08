using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Text;
using System.Web;
using System.Web.Helpers;
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
                return Json(code);
            }
            else
            {
                code = 201;
                return Json(code);
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
        /// 添加学生
        /// </summary>
        /// <returns></returns>
        public ActionResult Addstu()
        {
            return View();
        }
        /// <summary>
        /// 修改学生信息
        /// </summary>
        /// <returns></returns>
        public ActionResult Updatestu()
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
        public ActionResult MemberByTeacher()
        {
            return View();
        }

        /// <summary>
        /// 教师添加课程
        /// 用户类型为教师,关联当前教师id
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public ActionResult AddCourse()
        {
            return View();
        }

        /// <summary>
        /// 修改课程信息
        /// 教师只能修改自己上传的课程
        /// </summary>
        /// <returns></returns>
        public ActionResult EditCourseById()
        {
            return View();
        }

        /// <summary>
        /// 删除课程
        /// 教师只能删除自己上传的课程
        /// 仅改变课程状态
        /// </summary>
        /// <param name="id">课程编号</param>
        /// <returns></returns>
        public ActionResult DelCourseById(int id)
        {
            return View();
        }

        /// <summary>
        /// 教师查询当前课程所有评论
        /// </summary>
        /// <returns></returns>
        public ActionResult SelCourseCommentById()
        {
            return View();
        }

        /// <summary>
        /// 教师删除当前课程评论
        /// 根据评论id
        /// 单条删除和全选删除
        /// </summary>
        /// <returns></returns>
        public ActionResult DelCourseCommentById()
        {
            return View();
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

                return Json(codet);
            }
            catch (Exception)
            {
                codet = 201;
                return Json(codet);
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
            //暂存

            return result;
        }
    }
}