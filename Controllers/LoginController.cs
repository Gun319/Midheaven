using System;
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
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public ActionResult Login()
        {
            var user = Request.Cookies["User"];
            if (user != null)
            {
                var name = user["name"];
                var pwd = user["pwd"];

                ViewBag.UserName = name.ToString();
                ViewBag.Pwd = pwd;
            }
            return View();
        }
        /// <summary>
        /// 登录
        /// </summary>
        /// <param name="username"></param>
        /// <param name="userpwd"></param>
        /// <returns></returns>
        [HttpPost]
        public ActionResult Login(string username, string userpwd, string chk1)
        {
            IQueryable<Member> member = mDBEntities.Member.Where(m => m.UserName == username & m.Password == userpwd);
            if (member.Count() == 1)
            {
                //如果勾选免登录 加Cookie
                if (chk1 == "true")
                {
                    //实例化Cookie对象
                    HttpCookie user = new HttpCookie("User");
                    //设置该对象的key值
                    user.Values["name"] = username;
                    user.Values["pwd"] = userpwd;
                    user.Values["uid"] = member.FirstOrDefault().M_ID.ToString();
                    //设置过期时间
                    user.Expires = DateTime.Now.AddDays(7);
                    //将该对象添加到Cookie对象集合
                    Response.Cookies.Add(user);
                }
                else
                {
                    var user = Request.Cookies["User"];
                    if (user != null)
                    {
                        //设置过期时间
                        user.Expires = DateTime.Now.AddDays(-1);
                        Response.Cookies.Add(user);
                    }
                }

                Session["username"] = username;
                Session["mid"] = member.FirstOrDefault().M_ID;
                Session["mName"] = member.FirstOrDefault().RealName;

                return Json(member, JsonRequestBehavior.AllowGet);
            }
            return Json(member, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// cookie
        /// </summary>
        /// <returns></returns>
        public JsonResult GetCookie()
        {
            int code = 201;
            var user = Request.Cookies["User"];
            if (user != null)
            {
                code = 200;
            }
            return Json(code, JsonRequestBehavior.AllowGet);
        }
    }
}