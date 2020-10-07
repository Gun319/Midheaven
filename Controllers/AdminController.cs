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
            //获取学生名称
            string stuname = Request["RealName"];
            IQueryable<Member> stu = null;
            if (!string.IsNullOrEmpty(stuname))
            {
                stu = mDBEntities.Member.Where(s => s.RealName.Contains(stuname));
            }
            else
            {
                stu = mDBEntities.Member;
            }
            ViewBag.stu = stu;
            return View();
        }
        /// <summary>
        /// 删除
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public ActionResult Del(int id)
        {
            Models.Member mebinfo = new Member() { M_ID = id };
            mDBEntities.Member.Attach(mebinfo);
            mDBEntities.Member.Remove(mebinfo);
            mDBEntities.SaveChanges();
            return RedirectToAction("AdminIndex");
        }
        /// <summary>
        /// 修改审核状态
        /// </summary>
        /// <param name="flag"></param>
        /// <param name="id"></param>
        /// <returns></returns>
        public ActionResult Editflag(int flag, int id)
        {
            Member info = mDBEntities.Member.Where(st => st.M_ID == id).FirstOrDefault();
            info.M_Flog = flag;
            Session["flag"] = flag;
            mDBEntities.SaveChanges();
            return RedirectToAction("AdminIndex");
        }

        /// <summary>
        /// 查询所有课程信息
        /// 不包含评论信息
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public ActionResult AdminSelAllCourse()
        {
            //课程信息
            List<Models.Course> listclass = mDBEntities.Course.ToList();
            ViewBag.cla = listclass;

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