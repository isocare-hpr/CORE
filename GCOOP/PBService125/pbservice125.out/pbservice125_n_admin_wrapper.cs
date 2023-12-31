using System.ServiceModel; 
using System.Runtime.Serialization; 
using System.Net.Security; 
using System.ServiceModel.Web; 
using System.ServiceModel.Activation; 
using System.Transactions; 
using Sybase.PowerBuilder.WCFNVO; 
namespace pbservice125
{
	[System.Diagnostics.DebuggerStepThrough]
	[ServiceContract(Name="n_admin",Namespace="http://tempurl.org")]
	public class n_admin : System.IDisposable 
	{
		internal pbservice125.c__n_admin __nvo__;
		private bool ____disposed____ = false;
		public void Dispose()
		{
			if (____disposed____)
				return;
			____disposed____ = true;
			c__pbservice125.InitSession(__nvo__.Session);
			Sybase.PowerBuilder.WPF.PBSession.CurrentSession.DestroyObject(__nvo__);
			c__pbservice125.RestoreOldSession();
		}
		public n_admin()
		{
			
			c__pbservice125.InitAssembly();
			__nvo__ = (pbservice125.c__n_admin)Sybase.PowerBuilder.WPF.PBSession.CurrentSession.CreateInstance(typeof(pbservice125.c__n_admin));
			c__pbservice125.RestoreOldSession();
		}
		internal n_admin(pbservice125.c__n_admin nvo)
		{
			__nvo__ = nvo;
		}
		[OperationContract(Name="of_test")]
		public virtual string of_test(string as_test)
		{
			c__pbservice125.InitSession(__nvo__.Session);
			string __retval__;
			Sybase.PowerBuilder.PBString as_test__temp__;
			as_test__temp__ = new Sybase.PowerBuilder.PBString((string)as_test);
			__retval__ = ((pbservice125.c__n_admin)__nvo__).of_test(as_test__temp__);
			c__pbservice125.RestoreOldSession();
			return __retval__;
		}
		[OperationContract(Name="of_getuserpages")]
		public virtual string of_getuserpages(string as_wspass, string as_userid, string as_appid)
		{
			c__pbservice125.InitSession(__nvo__.Session);
			string __retval__;
			Sybase.PowerBuilder.PBString as_wspass__temp__;
			as_wspass__temp__ = new Sybase.PowerBuilder.PBString((string)as_wspass);
			Sybase.PowerBuilder.PBString as_userid__temp__;
			as_userid__temp__ = new Sybase.PowerBuilder.PBString((string)as_userid);
			Sybase.PowerBuilder.PBString as_appid__temp__;
			as_appid__temp__ = new Sybase.PowerBuilder.PBString((string)as_appid);
			__retval__ = ((pbservice125.c__n_admin)__nvo__).of_getuserpages(as_wspass__temp__, as_userid__temp__, as_appid__temp__);
			c__pbservice125.RestoreOldSession();
			return __retval__;
		}
		[OperationContract(Name="of_existinguser")]
		public virtual System.Int16 of_existinguser(string as_wspass, string as_userid, string as_fullname)
		{
			c__pbservice125.InitSession(__nvo__.Session);
			System.Int16 __retval__;
			Sybase.PowerBuilder.PBString as_wspass__temp__;
			as_wspass__temp__ = new Sybase.PowerBuilder.PBString((string)as_wspass);
			Sybase.PowerBuilder.PBString as_userid__temp__;
			as_userid__temp__ = new Sybase.PowerBuilder.PBString((string)as_userid);
			Sybase.PowerBuilder.PBString as_fullname__temp__;
			as_fullname__temp__ = new Sybase.PowerBuilder.PBString((string)as_fullname);
			__retval__ = ((pbservice125.c__n_admin)__nvo__).of_existinguser(as_wspass__temp__, as_userid__temp__, as_fullname__temp__);
			c__pbservice125.RestoreOldSession();
			return __retval__;
		}
		[OperationContract(Name="of_decodestring")]
		public virtual string of_decodestring(string as_wspass, string as_string)
		{
			c__pbservice125.InitSession(__nvo__.Session);
			string __retval__;
			Sybase.PowerBuilder.PBString as_wspass__temp__;
			as_wspass__temp__ = new Sybase.PowerBuilder.PBString((string)as_wspass);
			Sybase.PowerBuilder.PBString as_string__temp__;
			as_string__temp__ = new Sybase.PowerBuilder.PBString((string)as_string);
			__retval__ = ((pbservice125.c__n_admin)__nvo__).of_decodestring(as_wspass__temp__, as_string__temp__);
			c__pbservice125.RestoreOldSession();
			return __retval__;
		}
		[OperationContract(Name="of_resetuserpassword")]
		public virtual System.Int16 of_resetuserpassword(string as_wspass, string as_userid)
		{
			c__pbservice125.InitSession(__nvo__.Session);
			System.Int16 __retval__;
			Sybase.PowerBuilder.PBString as_wspass__temp__;
			as_wspass__temp__ = new Sybase.PowerBuilder.PBString((string)as_wspass);
			Sybase.PowerBuilder.PBString as_userid__temp__;
			as_userid__temp__ = new Sybase.PowerBuilder.PBString((string)as_userid);
			__retval__ = ((pbservice125.c__n_admin)__nvo__).of_resetuserpassword(as_wspass__temp__, as_userid__temp__);
			c__pbservice125.RestoreOldSession();
			return __retval__;
		}
		[OperationContract(Name="of_savenewuser")]
		public virtual System.Int16 of_savenewuser(string as_wspass, string axml_user, ref string as_err)
		{
			c__pbservice125.InitSession(__nvo__.Session);
			System.Int16 __retval__;
			Sybase.PowerBuilder.PBString as_wspass__temp__;
			as_wspass__temp__ = new Sybase.PowerBuilder.PBString((string)as_wspass);
			Sybase.PowerBuilder.PBString axml_user__temp__;
			axml_user__temp__ = new Sybase.PowerBuilder.PBString((string)axml_user);
			Sybase.PowerBuilder.PBString as_err__temp__ = as_err;
			__retval__ = ((pbservice125.c__n_admin)__nvo__).of_savenewuser(as_wspass__temp__, axml_user__temp__, ref as_err__temp__);
			as_err = as_err__temp__;
			c__pbservice125.RestoreOldSession();
			return __retval__;
		}
		[OperationContract(Name="of_saveuserpassword")]
		public virtual System.Int16 of_saveuserpassword(string as_wspass, string as_userid, string as_password)
		{
			c__pbservice125.InitSession(__nvo__.Session);
			System.Int16 __retval__;
			Sybase.PowerBuilder.PBString as_wspass__temp__;
			as_wspass__temp__ = new Sybase.PowerBuilder.PBString((string)as_wspass);
			Sybase.PowerBuilder.PBString as_userid__temp__;
			as_userid__temp__ = new Sybase.PowerBuilder.PBString((string)as_userid);
			Sybase.PowerBuilder.PBString as_password__temp__;
			as_password__temp__ = new Sybase.PowerBuilder.PBString((string)as_password);
			__retval__ = ((pbservice125.c__n_admin)__nvo__).of_saveuserpassword(as_wspass__temp__, as_userid__temp__, as_password__temp__);
			c__pbservice125.RestoreOldSession();
			return __retval__;
		}
		[OperationContract(Name="of_getgroup")]
		public virtual string of_getgroup(string as_wspass, string as_groupid)
		{
			c__pbservice125.InitSession(__nvo__.Session);
			string __retval__;
			Sybase.PowerBuilder.PBString as_wspass__temp__;
			as_wspass__temp__ = new Sybase.PowerBuilder.PBString((string)as_wspass);
			Sybase.PowerBuilder.PBString as_groupid__temp__;
			as_groupid__temp__ = new Sybase.PowerBuilder.PBString((string)as_groupid);
			__retval__ = ((pbservice125.c__n_admin)__nvo__).of_getgroup(as_wspass__temp__, as_groupid__temp__);
			c__pbservice125.RestoreOldSession();
			return __retval__;
		}
		[OperationContract(Name="of_savenewgroup")]
		public virtual System.Int16 of_savenewgroup(string as_wspass, string as_group)
		{
			c__pbservice125.InitSession(__nvo__.Session);
			System.Int16 __retval__;
			Sybase.PowerBuilder.PBString as_wspass__temp__;
			as_wspass__temp__ = new Sybase.PowerBuilder.PBString((string)as_wspass);
			Sybase.PowerBuilder.PBString as_group__temp__;
			as_group__temp__ = new Sybase.PowerBuilder.PBString((string)as_group);
			__retval__ = ((pbservice125.c__n_admin)__nvo__).of_savenewgroup(as_wspass__temp__, as_group__temp__);
			c__pbservice125.RestoreOldSession();
			return __retval__;
		}
		[OperationContract(Name="of_getusers")]
		public virtual string of_getusers(string as_wspass)
		{
			c__pbservice125.InitSession(__nvo__.Session);
			string __retval__;
			Sybase.PowerBuilder.PBString as_wspass__temp__;
			as_wspass__temp__ = new Sybase.PowerBuilder.PBString((string)as_wspass);
			__retval__ = ((pbservice125.c__n_admin)__nvo__).of_getusers(as_wspass__temp__);
			c__pbservice125.RestoreOldSession();
			return __retval__;
		}
		[OperationContract(Name="of_getuser")]
		public virtual string of_getuser(string as_wspass, string as_userid)
		{
			c__pbservice125.InitSession(__nvo__.Session);
			string __retval__;
			Sybase.PowerBuilder.PBString as_wspass__temp__;
			as_wspass__temp__ = new Sybase.PowerBuilder.PBString((string)as_wspass);
			Sybase.PowerBuilder.PBString as_userid__temp__;
			as_userid__temp__ = new Sybase.PowerBuilder.PBString((string)as_userid);
			__retval__ = ((pbservice125.c__n_admin)__nvo__).of_getuser(as_wspass__temp__, as_userid__temp__);
			c__pbservice125.RestoreOldSession();
			return __retval__;
		}
		[OperationContract(Name="of_getgrouppages")]
		public virtual string of_getgrouppages(string as_wspass, string as_groupid, string as_appid)
		{
			c__pbservice125.InitSession(__nvo__.Session);
			string __retval__;
			Sybase.PowerBuilder.PBString as_wspass__temp__;
			as_wspass__temp__ = new Sybase.PowerBuilder.PBString((string)as_wspass);
			Sybase.PowerBuilder.PBString as_groupid__temp__;
			as_groupid__temp__ = new Sybase.PowerBuilder.PBString((string)as_groupid);
			Sybase.PowerBuilder.PBString as_appid__temp__;
			as_appid__temp__ = new Sybase.PowerBuilder.PBString((string)as_appid);
			__retval__ = ((pbservice125.c__n_admin)__nvo__).of_getgrouppages(as_wspass__temp__, as_groupid__temp__, as_appid__temp__);
			c__pbservice125.RestoreOldSession();
			return __retval__;
		}
		[OperationContract(Name="of_getgroupusers")]
		public virtual string of_getgroupusers(string as_wspass, string as_groupid)
		{
			c__pbservice125.InitSession(__nvo__.Session);
			string __retval__;
			Sybase.PowerBuilder.PBString as_wspass__temp__;
			as_wspass__temp__ = new Sybase.PowerBuilder.PBString((string)as_wspass);
			Sybase.PowerBuilder.PBString as_groupid__temp__;
			as_groupid__temp__ = new Sybase.PowerBuilder.PBString((string)as_groupid);
			__retval__ = ((pbservice125.c__n_admin)__nvo__).of_getgroupusers(as_wspass__temp__, as_groupid__temp__);
			c__pbservice125.RestoreOldSession();
			return __retval__;
		}
	}
} 