using System.ServiceModel; 
using System.Runtime.Serialization; 
namespace Sybase.PowerBuilder.WCFNVO
{
	[DataContract]
	public struct str_rptexcel
	{
		internal str_rptexcel(c__str_rptexcel __x__)
		{
			CopyFrom(out this, __x__);
		}
		internal void CopyFrom(c__str_rptexcel __x__)
		{
			CopyFrom(out this, __x__);
		}
		[DataMember] 
		public string as_dwobject;
		[DataMember] 
		public string as_path;
		[DataMember] 
		public string as_xmldw;
		[DataMember] 
		public string as_argument01;
		[DataMember] 
		public string as_argument02;
		[DataMember] 
		public string as_argument03;
		[DataMember] 
		public string as_argument04;
		[DataMember] 
		public string as_argument05;
		[DataMember] 
		public string as_argument06;
		[DataMember] 
		public string as_argument07;
		[DataMember] 
		public string as_argument08;
		[DataMember] 
		public string as_argument09;
		[DataMember] 
		public string as_argument10;
		[DataMember] 
		public string as_argument11;
		[DataMember] 
		public string as_argument12;
		[DataMember] 
		public string as_argument13;
		[DataMember] 
		public string as_argument14;
		[DataMember] 
		public string as_argument15;
		[DataMember] 
		public string as_argument16;
		[DataMember] 
		public string as_argument17;
		[DataMember] 
		public string as_argument18;
		[DataMember] 
		public string as_argument19;
		[DataMember] 
		public string as_argument20;
		[DataMember] 
		public string as_savetype;
		internal void CopyTo(c__str_rptexcel __x__)
		{
			__x__.as_dwobject = as_dwobject;
			__x__.as_path = as_path;
			__x__.as_xmldw = as_xmldw;
			__x__.as_argument01 = as_argument01;
			__x__.as_argument02 = as_argument02;
			__x__.as_argument03 = as_argument03;
			__x__.as_argument04 = as_argument04;
			__x__.as_argument05 = as_argument05;
			__x__.as_argument06 = as_argument06;
			__x__.as_argument07 = as_argument07;
			__x__.as_argument08 = as_argument08;
			__x__.as_argument09 = as_argument09;
			__x__.as_argument10 = as_argument10;
			__x__.as_argument11 = as_argument11;
			__x__.as_argument12 = as_argument12;
			__x__.as_argument13 = as_argument13;
			__x__.as_argument14 = as_argument14;
			__x__.as_argument15 = as_argument15;
			__x__.as_argument16 = as_argument16;
			__x__.as_argument17 = as_argument17;
			__x__.as_argument18 = as_argument18;
			__x__.as_argument19 = as_argument19;
			__x__.as_argument20 = as_argument20;
			__x__.as_savetype = as_savetype;
		}
		internal static void CopyFrom(out str_rptexcel __this__, c__str_rptexcel __x__)
		{
			__this__.as_dwobject = __x__.as_dwobject;
			__this__.as_path = __x__.as_path;
			__this__.as_xmldw = __x__.as_xmldw;
			__this__.as_argument01 = __x__.as_argument01;
			__this__.as_argument02 = __x__.as_argument02;
			__this__.as_argument03 = __x__.as_argument03;
			__this__.as_argument04 = __x__.as_argument04;
			__this__.as_argument05 = __x__.as_argument05;
			__this__.as_argument06 = __x__.as_argument06;
			__this__.as_argument07 = __x__.as_argument07;
			__this__.as_argument08 = __x__.as_argument08;
			__this__.as_argument09 = __x__.as_argument09;
			__this__.as_argument10 = __x__.as_argument10;
			__this__.as_argument11 = __x__.as_argument11;
			__this__.as_argument12 = __x__.as_argument12;
			__this__.as_argument13 = __x__.as_argument13;
			__this__.as_argument14 = __x__.as_argument14;
			__this__.as_argument15 = __x__.as_argument15;
			__this__.as_argument16 = __x__.as_argument16;
			__this__.as_argument17 = __x__.as_argument17;
			__this__.as_argument18 = __x__.as_argument18;
			__this__.as_argument19 = __x__.as_argument19;
			__this__.as_argument20 = __x__.as_argument20;
			__this__.as_savetype = __x__.as_savetype;
		}
		public static explicit operator object[](str_rptexcel __this__)
		{
			return new object[] {
				__this__.as_dwobject
				,__this__.as_path
				,__this__.as_xmldw
				,__this__.as_argument01
				,__this__.as_argument02
				,__this__.as_argument03
				,__this__.as_argument04
				,__this__.as_argument05
				,__this__.as_argument06
				,__this__.as_argument07
				,__this__.as_argument08
				,__this__.as_argument09
				,__this__.as_argument10
				,__this__.as_argument11
				,__this__.as_argument12
				,__this__.as_argument13
				,__this__.as_argument14
				,__this__.as_argument15
				,__this__.as_argument16
				,__this__.as_argument17
				,__this__.as_argument18
				,__this__.as_argument19
				,__this__.as_argument20
				,__this__.as_savetype
			};
		}
	}
} 