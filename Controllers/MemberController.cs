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
    }
}