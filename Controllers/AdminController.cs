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
            //获取成员名称
            //string stuname = Request["RealName"];
            string realName = Request["RealName"];
            //IQueryable<Member> stu = null;
            //if (!string.IsNullOrEmpty(stuname))
            //{
            //    stu = mDBEntities.Member.Where(s => s.RealName.Contains(stuname));
            //}
            //else
            //{
            //    stu = mDBEntities.Member;
            //}
            IQueryable<Member> members = mDBEntities.Member.Where(m => m.R_ID != 1);
            if (!string.IsNullOrWhiteSpace(realName))
                members = members.Where(m => m.RealName.Contains(realName));
            ViewBag.stu = members;
            return View();
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
            mDBEntities.SaveChanges();
            return RedirectToAction("AdminIndex");
        }

        /// <summary>
        /// 删除成员
        /// 根据成员的id进行删除操作
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public ActionResult DelMemberByCID(int id)
        {
            //根据学号查询删除信息
            var mebinfo = mDBEntities.Member.Where(s => s.M_ID == id).FirstOrDefault();
            //移除
            mDBEntities.Member.Remove(mebinfo);
            mDBEntities.SaveChanges();
            return RedirectToAction("AdminIndex");
        }
       
    }
}