//**************************************************************************
//
//                        Sybase Inc. 
//
//    THIS IS A TEMPORARY FILE GENERATED BY POWERBUILDER. IF YOU MODIFY 
//    THIS FILE, YOU DO SO AT YOUR OWN RISK. SYBASE DOES NOT PROVIDE 
//    SUPPORT FOR .NET ASSEMBLIES BUILT WITH USER-MODIFIED CS FILES. 
//
//**************************************************************************

#line 1 "c:\\gcoop_all\\core\\gcoop\\pbservice125\\pbsrvbiz\\loansrv.pbl\\loansrv.pblx\\str_lntrnrespons.srs"
#line hidden
[Sybase.PowerBuilder.PBGroupAttribute("str_lntrnrespons",Sybase.PowerBuilder.PBGroupType.Structure,"","c:\\gcoop_all\\core\\gcoop\\pbservice125\\pbsrvbiz\\loansrv.pbl\\loansrv.pblx",null,"pbservice125")]
internal class c__str_lntrnrespons : Sybase.PowerBuilder.PBStructure
{
	public Sybase.PowerBuilder.PBString concoop_id = Sybase.PowerBuilder.PBString.DefaultValue;
	public Sybase.PowerBuilder.PBString loancontract_no = Sybase.PowerBuilder.PBString.DefaultValue;
	public Sybase.PowerBuilder.PBString trnreq_code = Sybase.PowerBuilder.PBString.DefaultValue;
	public Sybase.PowerBuilder.PBDateTime trnreq_date = Sybase.PowerBuilder.PBDateTime.DefaultValue;
	public Sybase.PowerBuilder.PBString xml_trnmast = Sybase.PowerBuilder.PBString.DefaultValue;
	public Sybase.PowerBuilder.PBString xml_trndetail = Sybase.PowerBuilder.PBString.DefaultValue;
	public Sybase.PowerBuilder.PBString entry_id = Sybase.PowerBuilder.PBString.DefaultValue;

	public override object Clone()
	{
		c__str_lntrnrespons vv = (c__str_lntrnrespons)base.Clone();
 		vv.concoop_id = concoop_id;
		vv.loancontract_no = loancontract_no;
		vv.trnreq_code = trnreq_code;
		vv.trnreq_date = trnreq_date;
		vv.xml_trnmast = xml_trnmast;
		vv.xml_trndetail = xml_trndetail;
		vv.entry_id = entry_id;
		return vv;
	}

	public static explicit operator c__str_lntrnrespons(Sybase.PowerBuilder.PBAny v)
	{
		if (v.Value is Sybase.PowerBuilder.PBUnboundedArray)
		{
			Sybase.PowerBuilder.PBUnboundedArray a = (Sybase.PowerBuilder.PBUnboundedArray)v;
			c__str_lntrnrespons vv = new c__str_lntrnrespons();
			vv.concoop_id = (Sybase.PowerBuilder.PBString)((Sybase.PowerBuilder.PBAny)a[1]);
			vv.loancontract_no = (Sybase.PowerBuilder.PBString)((Sybase.PowerBuilder.PBAny)a[2]);
			vv.trnreq_code = (Sybase.PowerBuilder.PBString)((Sybase.PowerBuilder.PBAny)a[3]);
			vv.trnreq_date = (Sybase.PowerBuilder.PBDateTime)((Sybase.PowerBuilder.PBAny)a[4]);
			vv.xml_trnmast = (Sybase.PowerBuilder.PBString)((Sybase.PowerBuilder.PBAny)a[5]);
			vv.xml_trndetail = (Sybase.PowerBuilder.PBString)((Sybase.PowerBuilder.PBAny)a[6]);
			vv.entry_id = (Sybase.PowerBuilder.PBString)((Sybase.PowerBuilder.PBAny)a[7]);

			return vv;
		}
		else
		{
			return (c__str_lntrnrespons) v.Value;
		}
	}

	public override Sybase.PowerBuilder.PBUnboundedAnyArray ToUnboundedAnyArray()
	{
		Sybase.PowerBuilder.PBUnboundedAnyArray a = new Sybase.PowerBuilder.PBUnboundedAnyArray();
		a.Add(new Sybase.PowerBuilder.PBAny(this.concoop_id));
		a.Add(new Sybase.PowerBuilder.PBAny(this.loancontract_no));
		a.Add(new Sybase.PowerBuilder.PBAny(this.trnreq_code));
		a.Add(new Sybase.PowerBuilder.PBAny(this.trnreq_date));
		a.Add(new Sybase.PowerBuilder.PBAny(this.xml_trnmast));
		a.Add(new Sybase.PowerBuilder.PBAny(this.xml_trndetail));
		a.Add(new Sybase.PowerBuilder.PBAny(this.entry_id));

		return a;
	}
}


[Sybase.PowerBuilder.PBStructureLayoutAttribute("str_lntrnrespons")]
[ System.Runtime.InteropServices.StructLayout( System.Runtime.InteropServices.LayoutKind.Sequential, Pack = 1, CharSet = System.Runtime.InteropServices.CharSet.Ansi )]
internal struct c__str_lntrnrespons_ansi
{
	public string concoop_id;
	public string loancontract_no;
	public string trnreq_code;
	public System.DateTime trnreq_date;
	public string xml_trnmast;
	public string xml_trndetail;
	public string entry_id;

	public static implicit operator c__str_lntrnrespons_ansi(c__str_lntrnrespons other)
	{

		c__str_lntrnrespons_ansi ret = new c__str_lntrnrespons_ansi();

		ret.concoop_id = other.concoop_id;

		ret.loancontract_no = other.loancontract_no;

		ret.trnreq_code = other.trnreq_code;

		ret.trnreq_date = other.trnreq_date;

		ret.xml_trnmast = other.xml_trnmast;

		ret.xml_trndetail = other.xml_trndetail;

		ret.entry_id = other.entry_id;

		return ret;
	}

	public static implicit operator c__str_lntrnrespons(c__str_lntrnrespons_ansi other)
	{

		c__str_lntrnrespons ret = new c__str_lntrnrespons();

		ret.concoop_id = other.concoop_id;

		ret.loancontract_no = other.loancontract_no;

		ret.trnreq_code = other.trnreq_code;

		ret.trnreq_date = other.trnreq_date;

		ret.xml_trnmast = other.xml_trnmast;

		ret.xml_trndetail = other.xml_trndetail;

		ret.entry_id = other.entry_id;

		return ret;
	}
}


[Sybase.PowerBuilder.PBStructureLayoutAttribute("str_lntrnrespons")]
[ System.Runtime.InteropServices.StructLayout( System.Runtime.InteropServices.LayoutKind.Sequential, Pack = 1, CharSet = System.Runtime.InteropServices.CharSet.Unicode )]
internal struct c__str_lntrnrespons_unicode
{
	public string concoop_id;
	public string loancontract_no;
	public string trnreq_code;
	public System.DateTime trnreq_date;
	public string xml_trnmast;
	public string xml_trndetail;
	public string entry_id;

	public static implicit operator c__str_lntrnrespons_unicode(c__str_lntrnrespons other)
	{

		c__str_lntrnrespons_unicode ret = new c__str_lntrnrespons_unicode();

		ret.concoop_id = other.concoop_id;

		ret.loancontract_no = other.loancontract_no;

		ret.trnreq_code = other.trnreq_code;

		ret.trnreq_date = other.trnreq_date;

		ret.xml_trnmast = other.xml_trnmast;

		ret.xml_trndetail = other.xml_trndetail;

		ret.entry_id = other.entry_id;

		return ret;
	}

	public static implicit operator c__str_lntrnrespons(c__str_lntrnrespons_unicode other)
	{

		c__str_lntrnrespons ret = new c__str_lntrnrespons();

		ret.concoop_id = other.concoop_id;

		ret.loancontract_no = other.loancontract_no;

		ret.trnreq_code = other.trnreq_code;

		ret.trnreq_date = other.trnreq_date;

		ret.xml_trnmast = other.xml_trnmast;

		ret.xml_trndetail = other.xml_trndetail;

		ret.entry_id = other.entry_id;

		return ret;
	}
}
 