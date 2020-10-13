using System.Linq;
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
            //if (Session["username"] == null)
            //    return RedirectToAction("Login", "Login");
            return View();
        }
        /// <summary>
        /// 管理员首页
        /// 默认显示所有成员信息
        /// </summary>
        /// <returns></returns>
        [HttpPost]
        public ActionResult AdminIndex(string username, int flog, int page)
        {
            mDBEntities.Configuration.ProxyCreationEnabled = false;
            IQueryable<Member> members = mDBEntities.Member.Where(m => m.R_ID != 1);
            if (!string.IsNullOrWhiteSpace(username))
                members = members.Where(m => m.UserName.Contains(username));
            if (flog != -1)
                members = members.Where(m => m.M_Flog == flog);
            return Json(new { total = members, currtrow = members.OrderBy(m => m.M_ID).Skip(10 * (page - 1)).Take(10) }, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// 修改注销状态
        /// </summary>
        /// <param name="mid"></param>
        /// <returns></returns>
        [HttpPost]
        public ActionResult Editflag(int mid)
        {
            int code = 201;
            Member info = mDBEntities.Member.Where(m => m.M_ID == mid).FirstOrDefault();
            if (info.M_Flog == 0)
                info.M_Flog = 1;
            else
                info.M_Flog = 0;
            if (mDBEntities.SaveChanges() == 1)
                code = 200;
            return Json(code, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// 删除成员
        /// 真实删除
        /// </summary>
        /// <returns></returns>
        [HttpPost]
        public ActionResult DelMemberByCID(int mid)
        {
            int code = 201;
            var mebinfo = mDBEntities.Member.Where(m => m.M_ID == mid).FirstOrDefault();
            mDBEntities.Member.Remove(mebinfo);
            if (mDBEntities.SaveChanges() == 1)
                code = 200;
            return Json(code, JsonRequestBehavior.AllowGet);
        }

    }
}