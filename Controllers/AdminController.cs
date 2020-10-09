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
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public ActionResult AdminIndex()
        {
            return View();
        }
        /// <summary>
        /// 管理员首页
        /// 默认显示所有成员信息
        /// </summary>
        /// <returns></returns>
        [HttpPost]
        public ActionResult AdminIndex(string username, int flog)
        {
            IQueryable<Member> members = mDBEntities.Member.Where(m => m.R_ID != 1);
            if (!string.IsNullOrWhiteSpace(username))
                members = members.Where(m => m.RealName.Contains(username));
            if (!flog.Equals(-1))
                members = members.Where(m => m.M_Flog == flog);

            return Json(members, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// 修改注销状态
        /// </summary>
        /// <param name="flag"></param>
        /// <param name="id"></param>
        /// <returns></returns>
        [HttpPost]
        public ActionResult Editflag(int mid)
        {
            int code = 0;
            Member info = mDBEntities.Member.Where(m => m.M_ID == mid).FirstOrDefault();
            if (info.M_Flog == 0)
                info.M_Flog = 1;
            else
                info.M_Flog = 0;
            if (mDBEntities.SaveChanges() == 1)
                code = 200;
            else
                code = 201;
            return Json(code, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// 删除成员
        /// 根据成员的id进行删除操作
        /// </summary>
        /// <returns></returns>
        [HttpPost]
        public ActionResult DelMemberByCID(int mid)
        {
            int code = 0;
            var mebinfo = mDBEntities.Member.Where(m => m.M_ID == mid).FirstOrDefault();
            mDBEntities.Member.Remove(mebinfo);
            if (mDBEntities.SaveChanges() == 1)
                code = 200;
            else
                code = 201;
            return Json(code, JsonRequestBehavior.AllowGet);
        }

    }
}