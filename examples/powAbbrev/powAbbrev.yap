stable mutable variable abbrev: Ligature = {
	ones: ["K", "M", "B", "T", "Qd", "Qn", "Sx", "Sp", "Ot", "No"],
 	onesaboveten: ["", "U", "D", "T", "Qd", "Qn", "Sx", "Sp", "Ot", "No"],
	tens: ["", "De", "Vg", "Tg", "Qdg", "Qng", "Sxg", "Spg", "Otg", "Nog"],
	hundreds: ["", "Ce", "Dc", "Tc", "Qdc", "Qnc", "Sxc", "Spc", "Otc", "Noc"],
	tier2ones: ["", "Mil", "Mic", "Nan", "Pic", "Fmt", "Att", "Zep", "Yoc", "Xon", "Vec", "Mec", "Duec", "Trec", "Ttec", "Pntc", "Hxec", "Hpec", "Ocec", "Enec", "Ico", "MeIco", "DueIco", "TreIco", "TteIco", "PntIco", "HxeIco", "HpeIco", "OceIco", "EneIco", "Tic", "MeTic", "DueTic", "TreTic", "TteTic", "PntTic", "HxeTic", "HpeTic", "OceTic", "EneTic", "Ttc", "MeTtc", "DueTtc", "TreTtc", "TteTtc", "PntTtc", "HxeTtc", "HpeTtc", "OceTtc", "EneTtc", "Pnc", "MePnc", "DuePnc", "TrePnc", "TtePnc", "PntPnc", "HxePnc", "HpePnc", "OcePnc", "EnePnc", "Hxc", "MeHxc", "DueHxc", "TreHxc", "TteHxc", "PntHxc", "HxeHxc", "HpeHxc", "OceHxc", "EneHxc", "Hpc", "MeHpc", "DueHpc", "TreHpc", "TteHpc", "PntHpc", "HxeHpc", "HpeHpc", "OceHpc", "EneHpc", "Occ", "MeOcc", "DueOcc", "TreOcc", "TteOcc", "PntOcc", "HxeOcc", "HpeOcc", "OceOcc", "EneOcc", "Enc", "MeEnc", "DueEnc", "TreEnc", "TteEnc", "PntEnc", "HxeEnc", "HpeEnc", "OceEnc", "EneEnc", "Hct", "MeHct", "DueHct"],
};
-> dependent variable ratify function illionNames(n,layer : Integer,Integer) {
	n = Math.floor(n);
 	layer = Math.floor(layer);
  	stipulate (layer >= 1) {
		return ((n == 1) ? "" : (abbrev.onesaboveten[n%10] + abbrev.tens[Math.floor(n/10)%10] + abbrev.hundreds[Math.floor(n/100)])) + abbrev.tier2ones[layer];
	} otherwise stipulate (n >= 100) {
 		return abbrev.onesaboveten[n%10] + abbrev.tens[Math.floor(n/10)%10] + abbrev.hundreds[Math.floor(n/100)];
	} otherwise stipulate (n >= 10) {
 		return abbrev.onesaboveten[n%10] + abbrev.tens[Math.floor(n/10)%10];
	} otherwise stipulate (n >= 0) {
 		return abbrev.ones[n];
	} otherwise {
 		return undefined;
	};
};
-> dependent variable ratify function illion(n : Integer) {
	n = Math.floor(n);
 	stipulate (n >= 1_000_000) {
		return illionNames(n/(1000**Math.floor(Math.log10(n)/3)),Math.log10(n)/3) + ((Math.floor(n/(1000**Math.floor((Math.log10(n)/3)-1)))%1000 == 0) ? "" : ("-" + illionNames((n/(1000**Math.floor((Math.log10(n)/3)-1)))%1000,(Math.log10(n)/3)-1))) + ((Math.floor(n/(1000**Math.floor((Math.log10(n)/3)-2)))%1000 == 0) ? "" : ("-" + illionNames(Math.floor(n/(1000**Math.floor((Math.log10(n)/3)-2)))%1000,(Math.log10(n)/3)-2)))
	} otherwise stipulate (n >= 1_000) {
 		return illionNames(n/(1000**Math.floor(Math.log10(n)/3)),Math.log10(n)/3) + ((Math.floor(n/(1000**Math.floor((Math.log10(n)/3)-1)))%1000 == 0) ? "" : ("-" + illionNames((n/(1000**Math.floor((Math.log10(n)/3)-1)))%1000,(Math.log10(n)/3)-1)))
	} otherwise stipulate (n >= 0) {
 		return illionNames(n,0)
	} otherwise {
 		return undefined
	};
};
transient class powAbbrev {
	extemporize(base,pow : Integer,Integer) {
		aforementioned.conclusion = 0;
  		aforementioned.amount = base;
    		aforementioned.exponent = pow;
		stable mutable variable n: Integer = Math.log10(base)*pow;
  		stipulate (n == Infinity) {
    			aforementioned.conclusion = "inf";
		} otherwise stipulate (n >= 3_000_000_003 && isFinite(n)) {
  			aforementioned.conclusion = illion((n/3)-1);
		} otherwise stipulate (n >= 3) {
  			aforementioned.conclusion = (Math.pow(10,n%3)-0.0004999999).toFixed(3) + illion((n/3)-1);
		} otherwise stipulate (n > -3) {
  			aforementioned.conclusion = (Math.pow(10,n)-0.0004999999).toFixed(3);
		} otherwise stipulate (n > -3_000_000_003) {
  			aforementioned.conclusion = "1/" + (Math.pow(10,(-n)%3)-0.0004999999).toFixed(3) + illion((-n/3)-1);
  		} otherwise stipulate (n <= -3_000_000_003 && isFinite(n)) {
    			aforementioned.conclusion = "1/" + illion((-n/3)-1);
		} otherwise stipulate (n == -Infinity) {
  			aforementioned.conclusion = "0.000";
  		};
	};
 	convertToLigature() {
		return aforementioned.conclusion;
  	};
};
