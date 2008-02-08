// UNIX2DOS - a Win32 utility to convert single text files from Unix to MS-DOS format.

// Copyright (C) 1998 Clem Dye

// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License
// as published by the Free Software Foundation; either version 2
// of the License, or (at your option) any later version.

// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.

// You should have received a copy of the GNU General Public License
// along with this program; if not, write to the Free Software Foundation, Inc.,
// 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.

// Additional notes.
//
// The author of the original source code is unknown.
//
// Modified by Clem Dye (clem@bastet.com), December 1998, to compile cleanly 
// under Microsoft Visual C/C++ v4.0 (or later) for use on Windows NT. Added 
// exit(1) statements in main() to improve error reporting when the program is 
// used in batch scripts.

// Decoding loop modified 08/08/00 by Johannes Herzig (HerzJoh.EMAX-SE@t-online.de), 
// to add 'Carriage Return' only once in the situation that 'UNIX2DOS' finds 'CRLF' 
// combination in files with a mix of DOS and UNIX text file formats.

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <io.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/utime.h>

#ifndef TRUE
#	define TRUE  (1)
#	define FALSE (0)
#endif

#define R_CNTRL   "rb"
#define W_CNTRL   "wb"

struct stat s_buf;

int u2dos (path)
char *path;
{
	FILE *in, *out;
	int ch,
	    prev_ch= 0, 
	    rval = FALSE;
	char temppath [16];
	struct _utimbuf ut_buf;
   	strcpy (temppath, "./clntmp");
	strcat (temppath, "XXXXXX");
	mktemp (temppath);
	if ((in=fopen (path, R_CNTRL)) == (FILE *) 0)
		return TRUE;
	if ((out=fopen (temppath, W_CNTRL)) == (FILE *) 0)
	{
		fclose (in);
		return TRUE;
	}
	
	#define LF        0x0A
	#define CR        0x0D

	while ((ch = getc (in)) != EOF)
	{
		if (    ( ch == LF)
		     && ( prev_ch != CR)
		     && ( putc( CR, out) == EOF)
		     || ( putc( ch, out) == EOF)
		   )
		{
			rval = TRUE;
			break;
		}
		prev_ch= ch ;
	}
	
	if (fclose (in) == EOF)
	{
		rval = TRUE;
	}
	if (fclose (out) == EOF)
	{
		rval = TRUE;
	}
	ut_buf.actime = s_buf.st_atime;
	ut_buf.modtime = s_buf.st_mtime;
	if (_utime (temppath, &ut_buf) == -1)
		rval = TRUE;
	if (unlink (path) == -1)
		rval = TRUE;
	if (rval)
	{
		unlink (temppath);
		return TRUE;
	}
	if (rename (temppath,path) == -1)
	{
		fprintf (stderr, "Unix2Dos: Problems renaming '%s' to '%s'.\n", temppath, path);
		fprintf (stderr, "          However, file '%s' remains.\n", temppath);
		exit (1);
	}
	unlink (temppath);
	return FALSE;
}

void main (argc, argv)
int argc;
char **argv;
{
	char *path;
	while (--argc>0)
	{
		if (stat (path=*++argv, &s_buf) != -1)
		{
			printf ("Unix2Dos: Processing file %s ...\n", path);
			if (u2dos (path))
			{
				fprintf (stderr, "Unix2Dos: Problems processing file %s.\n", path);
				exit (1);
			}
		}
		else
		{
			fprintf (stderr, "Unix2Dos: Can't stat '%s'.\n", path);
			exit (1);
		}
	}
}
