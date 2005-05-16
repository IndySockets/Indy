using System;
using System.IO;
using NF = NUnit.Framework;

using IS = Indy.Sockets;

namespace Indy.Tests
{
	[NF.TestFixture]
	public class SysTests
	{
		public SysTests()
		{
		}
		[NF.Test]
		public void Format()
		{
			NF.Assert.AreEqual(IS.Sys.Format("%s", new object[]{"Hello, World!"}), "Hello, World!");
			NF.Assert.AreEqual(IS.Sys.Format("%d", 43), "43");
			NF.Assert.AreEqual(IS.Sys.Format("%x", 255), "ff");
		}

		[NF.Test]
		public void LastChars()
		{
			NF.Assert.AreEqual(IS.Sys.LastChars("Chad is Indy's Chief", 12), "Indy's Chief");
			NF.Assert.AreEqual(IS.Sys.LastChars("Hello", 25), "Hello");
			NF.Assert.AreEqual(IS.Sys.LastChars("Hello", 5), "Hello");
		}

		[NF.Test]
		public void AnsiCompareText()
		{
			NF.Assert.IsTrue(IS.Sys.AnsiCompareText("Hello", "Hello") == 0);
			NF.Assert.IsTrue(IS.Sys.AnsiCompareText("Hello", "hello") == 0);
		}

		[NF.Test]
		public void AddMSecToTime()
		{
			DateTime TempTime = DateTime.Now;
			NF.Assert.IsTrue(DateTime.Equals(IS.Sys.AddMSecToTime(TempTime, 0), TempTime.AddMilliseconds(0)), "1");
			NF.Assert.IsTrue(DateTime.Equals(((DateTime)IS.Sys.AddMSecToTime(TempTime, 1)), ((DateTime)TempTime.AddMilliseconds(1))), "2");
			NF.Assert.IsTrue(DateTime.Equals(IS.Sys.AddMSecToTime(TempTime, 10), TempTime.AddMilliseconds(10)), "3");
		}

		[NF.Test]
		public void StrToInt64()
		{
			NF.Assert.AreEqual(IS.Sys.StrToInt64("1"), Int64.Parse("1"));
			NF.Assert.AreEqual(IS.Sys.StrToInt64("-1"), Int64.Parse("-1"));
		}

		[NF.Test]
		public void StrToInt64Def()
		{
			NF.Assert.AreEqual(IS.Sys.StrToInt64Def("Hello", 1), 1);
			NF.Assert.AreEqual(IS.Sys.StrToInt64Def("1", 2), 1);
			NF.Assert.AreEqual(IS.Sys.StrToInt64Def("Hello", -1), -1);
			NF.Assert.AreEqual(IS.Sys.StrToInt64Def("-1", -2), -1);
		}

		[NF.Test]
		public void FloatToIntStr()
		{
			NF.Assert.AreEqual(IS.Sys.FloatToIntStr(4.1f), "4");
			NF.Assert.AreEqual(IS.Sys.FloatToIntStr(4.0f), "4");
		}

		[NF.Test]
		public void DecodeTime()
		{
			ushort AHour = 0;
			ushort AMin = 0;
			ushort ASec = 0;
			ushort AMSec = 0;
			DateTime Temp = DateTime.Now;
			IS.Sys.DecodeTime(Temp, ref AHour, ref AMin, ref ASec, ref AMSec);
			NF.Assert.AreEqual(AHour, Temp.Hour);
			NF.Assert.AreEqual(AMin, Temp.Minute);
			NF.Assert.AreEqual(ASec, Temp.Second);
			NF.Assert.AreEqual(AMSec, Temp.Millisecond);
		}

		[NF.Test]
		public void DecodeDate()
		{
			ushort ADay = 0;
			ushort AMonth = 0;
			ushort AYear = 0;
			DateTime Temp = DateTime.Now;
			IS.Sys.DecodeDate(Temp, ref AYear, ref AMonth, ref ADay);
			NF.Assert.AreEqual(AYear, Temp.Year);
			NF.Assert.AreEqual(AMonth, Temp.Month);
			NF.Assert.AreEqual(ADay, Temp.Day);
		}

		[NF.Test]
		public void EncodeTime()
		{
			ushort AHour = 10;
			ushort AMin = 15;
			ushort ASec = 30;
			ushort AMSec = 50;
			NF.Assert.IsTrue(DateTime.Equals(IS.Sys.EncodeTime(AHour, AMin, ASec, AMSec), new DateTime(1899, 12, 30, AHour, AMin, ASec, AMSec)));
		}


		[NF.Test]
		public void EncodeDate()
		{
			ushort AYear = 2005;
			ushort AMonth = 3;
			ushort ADay = 20;
			NF.Assert.IsTrue(DateTime.Equals(IS.Sys.EncodeDate(AYear, AMonth, ADay), new DateTime(AYear, AMonth, ADay)));
		}

		[NF.Test]
		public void DateTimeToStr()
		{
			DateTime Temp = DateTime.Now;
			NF.Assert.AreEqual(IS.Sys.DateTimeToStr(Temp), Temp.ToString());
		}

		[NF.Test]
		public void StrToDateTime()
		{
			DateTime Temp = DateTime.Now;
			NF.Assert.IsTrue(DateTime.Equals(IS.Sys.StrToDateTime(Temp.ToString()), Temp));
		}

		[NF.Test]
		public void DayOfWeek()
		{
			NF.Assert.AreEqual(IS.Sys.DayOfWeek(DateTime.Now), ((int)DateTime.Now.DayOfWeek) + 1);
		}

		[NF.Test]
		public void SameText()
		{
			NF.Assert.IsTrue(IS.Sys.SameText("Hello", "Hello"));
			NF.Assert.IsTrue(IS.Sys.SameText("Hello", "hello"));
			NF.Assert.IsFalse(IS.Sys.SameText("Hello", "World"));
		}

		[NF.Test]
		public void CompareStr()
		{
			NF.Assert.AreEqual(IS.Sys.CompareStr("Hello", "Hello"), 0);
			NF.Assert.AreEqual(IS.Sys.CompareStr("Hello", "hello"), String.Compare("Hello", "hello"));
		}

		[NF.Test]
		public void CompareDate()
		{
			DateTime Now = DateTime.Now;
			DateTime NowUtc = DateTime.UtcNow;
			NF.Assert.AreEqual(IS.Sys.CompareDate(Now, Now), 0);
			NF.Assert.AreEqual(IS.Sys.CompareDate(Now, NowUtc), DateTime.Compare(Now, NowUtc));
			NF.Assert.AreEqual(IS.Sys.CompareDate(NowUtc, Now), DateTime.Compare(NowUtc, Now));
		}

		[NF.Test]
		public void IntToStr()
		{
			NF.Assert.AreEqual(IS.Sys.IntToStr(25), "25");
			NF.Assert.AreEqual(IS.Sys.IntToStr(-25), "-25");
		}

		[NF.Test]
		public void Int64ToStr()
		{
			NF.Assert.AreEqual(IS.Sys.IntToStr(((long)25)), "25");
			NF.Assert.AreEqual(IS.Sys.IntToStr(((long)-25)), "-25");
		}

		[NF.Test]
		public void UpperCase()
		{
			NF.Assert.AreEqual(IS.Sys.UpperCase("Hello, World!"), "HELLO, WORLD!");
			NF.Assert.AreEqual(IS.Sys.UpperCase("A"), "A");
		}

		[NF.Test]
		public void LowerCase()
		{
			NF.Assert.AreEqual(IS.Sys.LowerCase("Hello, World!"), "hello, world!");
			NF.Assert.AreEqual(IS.Sys.LowerCase("a"), "a");
		}

		[NF.Test]
		public void StrToInt()
		{
			NF.Assert.AreEqual(IS.Sys.StrToInt("-1"), -1);
			NF.Assert.AreEqual(IS.Sys.StrToInt("0"), 0);
			NF.Assert.AreEqual(IS.Sys.StrToInt("1"), 1);
		}

		[NF.Test]
		public void StrToIntDef()
		{
			NF.Assert.AreEqual(IS.Sys.StrToInt("-1", 2), -1);
			NF.Assert.AreEqual(IS.Sys.StrToInt("0", 2), 0);
			NF.Assert.AreEqual(IS.Sys.StrToInt("1", 2), 1);
			NF.Assert.AreEqual(IS.Sys.StrToInt("Hello", 2), 2);
		}

		[NF.Test]
		public void Trim()
		{
			NF.Assert.AreEqual(IS.Sys.Trim("Hello, World!"), "Hello, World!");
			NF.Assert.AreEqual(IS.Sys.Trim("  Hello, World!  "), "Hello, World!");
		}

		[NF.Test]
		public void TrimLeft()
		{
			NF.Assert.AreEqual(IS.Sys.TrimLeft("Hello, World!"), "Hello, World!");
			NF.Assert.AreEqual(IS.Sys.TrimLeft("  Hello, World!  "), "Hello, World!  ");
		}

		[NF.Test]
		public void TrimRight()
		{
			NF.Assert.AreEqual(IS.Sys.TrimRight("Hello, World!"), "Hello, World!");
			NF.Assert.AreEqual(IS.Sys.TrimRight("  Hello, World!  "), "  Hello, World!");
		}

		[NF.Test]
		[NF.ExpectedException(typeof(IS.EAbort))]
		public void Abort()
		{
			IS.Sys.Abort();
		}

		[NF.Test]
		public void ExtractFileName()
		{
			NF.Assert.AreEqual(IS.Sys.ExtractFileName("C:\\Temp\\MyFile.txt"), Path.GetFileName("C:\\Temp\\MyFile.txt"));
		}

		[NF.Test]
		public void ExtractFileExt()
		{
			NF.Assert.AreEqual(IS.Sys.ExtractFileExt("C:\\Temp\\MyFile.txt"), ".txt");
		}

		[NF.Test]
		public void ChangeFileExt()
		{
			NF.Assert.AreEqual(IS.Sys.ChangeFileExt("C:\\Temp\\MyFile.txt", ".exe"), "C:\\Temp\\MyFile.exe");
		}

		[NF.Test]
		public void LastDelimiter()
		{
			NF.Assert.AreEqual(IS.Sys.LastDelimiter(".", "C:\\Temp\\MyFile.txt"), "C:\\Temp\\MyFile.txt".LastIndexOf("."));
			NF.Assert.AreEqual(IS.Sys.LastDelimiter(".", "Hello, World!"), -1);
		}

		[NF.Test]
		public void StringReplace()
		{
			NF.Assert.AreEqual(IS.Sys.StringReplace("Hello, World!", "Indy", "Indy on .NET"), "Hello, World!");
			NF.Assert.AreEqual(IS.Sys.StringReplace("Hello, World!", "World", "Universe"), "Hello, Universe!");
		}
	}
}