using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Midheaven.Models;

namespace Midheaven.Controllers
{
    public class AdminController : Controller
    {
        // GET: Admin

        /// <summary>
        /// 数据实体对象
        /// </summary>
        midheavenDBEntities mDBEntities = new midheavenDBEntities();

        /// <summary>
        /// 管理员首页
        /// 默认显示所有成员信息
        /// </summary>
        /// <returns></returns>
        public ActionResult AdminIndex()
        {
            return View();
        }

        /// <summary>
        /// 查询所有课程信息
        /// 不包含评论信息
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public ActionResult AdminSelAllCourse()
        {
            return View();
        }

        /// <summary>
        /// 查询单个课程
        /// 显示当前课程的前10条评论
        /// </summary>
        /// <returns></returns>
        [HttpPost]
        public ActionResult AdminSelOneCourse()
        {
            return View();
        }

        /// <summary>
        /// 添加成员
        /// 添加所有信息(成员类型),成员默认通过审核
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public ActionResult AdminAddMember()
        {
            return View();
        }

        /// <summary>
        /// 添加课程
        /// 需指定教师,并添加该课程所有信息
        /// </summary>
        /// <returns></returns>
        public ActionResult AdminAddCourse()
        {
            return View();
        }

        /// <summary>
        /// 删除成员
        /// 根据成员的id进行删除操作
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public ActionResult DelMemberByCID()
        {
            return View();
        }
    }
}