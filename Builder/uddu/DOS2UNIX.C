// DOS2UNIX - a Win32 utility to convert single text files from MS-DOS to Unix format.

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


#include <io.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
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

int dos2u (path)
char *path;
{
	FILE *in, *out;
	int ch,
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
	while ((ch = getc (in)) != EOF)
		if ((ch != '\015' && ch != '\032') && 
			(putc (ch, out) == EOF))
		{
			rval = TRUE;
			break;
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
		fprintf (stderr, "Dos2Unix: Problems renaming '%s' to '%s'.\n", temppath, path);
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
			printf ("Dos2Unix: Processing file %s ...\n", path);
			if (dos2u (path))
			{
				fprintf (stderr, "Dos2Unix: Problems processing file %s.\n", path);
				exit (1);
			}
		}
		else
		{
			fprintf (stderr, "Dos2Unix: Can't stat '%s'.\n", path);
			exit (1);
		}
	}
}