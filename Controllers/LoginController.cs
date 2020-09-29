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
        /// 登陆成功查询用户信息是否补全,未补全跳转页面补录信息
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
            int Code = 401; // 身份验证错误
            IQueryable<Member> member = mDBEntities.Member.Where(m => m.UserName == username & m.Password == userpwd);
            if (member.Count() == 1)
                return Json(member);
            return Json(Code);
        }
    }
}