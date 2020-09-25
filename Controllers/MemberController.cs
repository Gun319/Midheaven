using System;
using System.Collections.Generic;
using System.Linq;
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
        /// 首页(游客)
        /// 页面必须包含登录、注册
        /// </summary>
        /// <returns></returns>
        public ActionResult Index()
        {
            return View();
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
        /// 成员注册
        /// 发送邮箱验证码
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public ActionResult Register()
        {
            return View();
        }
    }
}