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
        /// 修改课程审核状态
        /// </summary>
        /// <param name="flag"></param>
        /// <param name="id"></param>
        /// <returns></returns>
        public ActionResult c_flag()
        {
            
            return RedirectToAction("AdminSelAllCourse");
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
            List<Roles> listmeb = mDBEntities.Roles.ToList();
            //添加下拉框的默认值
            var selectddl = new List<SelectListItem>()
            {
                new SelectListItem() {Text="--全部--",Value="-1" }
            };
            //查询的数据
            var listmebinfo = new SelectList(listmeb, "R_ID", "R_Name");
            //将从数据库查询的数据和自定义的数据统一
            selectddl.AddRange(listmebinfo);
            ViewBag.ddl = selectddl;
            return View();
        }
        [HttpPost]
        /// <summary>
        /// 添加学生信息
        /// </summary>
        /// <returns></returns>
        public ActionResult AdminAddMember(Member meb)
        {
            Member mebm = new Member();
            mebm.M_ID = meb.M_ID;
            mebm.RealName = meb.RealName;
            mebm.Sex = meb.Sex;
            mebm.Age = meb.Age;
            mebm.PhoneNum = meb.PhoneNum;
            mebm.Address = meb.Address;
            mebm.R_ID = meb.R_ID;
            mebm.M_Flog = meb.M_Flog;
            mDBEntities.Member.Add(meb);
            mDBEntities.SaveChanges();
            return Content("<script>alert('添加成功');location.href='/Admin/AdminIndex';</script>");
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