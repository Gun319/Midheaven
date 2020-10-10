using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Midheaven.Models;

namespace Midheaven.Controllers
{
    public class LoginController : Controller
    {
        // GET: Login

        /// <summary>
        /// 数据实体对象
        /// </summary>
        midheavenDBEntities mDBEntities = new midheavenDBEntities();

        /// <summary>
        /// 登录
        /// 判断用类型,根据用户类型跳转至不同的页面,使用异步判断
        /// 用户未通过审核禁止登录
        /// 7天"免登录"
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public ActionResult Login()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Login(string username, string userpwd)
        {
            IQueryable<Member> member = mDBEntities.Member.Where(m => m.UserName == username & m.Password == userpwd);
            if (member.Count() == 1)
            {
                Session["username"] = member.FirstOrDefault().UserName;
                return Json(member, JsonRequestBehavior.AllowGet);
            }
            return Json(member, JsonRequestBehavior.AllowGet);
        }
    }
}