module dsvdb.Core.Parser;

import std.array;
import std.conv;
import std.file;
import dsvdb.Load;
import dsvdb.Ext.Debug;

/**
 * The Parser class handles all file-related functions, including:
 * -- reading files
 * -- parsing files
 * -- deleting/creating files
 * (At least eventually)
 */
class Parser {
	this() {}
	
	/**
	 * Parses a DSV file.
	 * First line is schema.
	 */
	public string[string][uint] parse(string pathname) {
		/* Set up variables */
		int numLines, horizontalWidth;
		string rawText;
		string[] schema;
		string[] splitLine;
		string[] splitText;
		string[string][uint] parsedText;
		
		/**/
		if ( pathname.exists ) {
			rawText = std.file.readText(pathname);
			splitText = rawText.split("\r\n");
			numLines = splitText.length; 
			
			/* Determine schema from the first line */
			if ( splitText.length > 0 ) {
				schema = splitText[0].split(DSVDB_DELIMETER);
				horizontalWidth = schema.length;
			} else {
				dsvdb.Ext.Debug.log("dev", "Invalid or nonexistant schema.");
			}
			
			/* Parse text according to schema */
			foreach ( i, line; splitText ) {
				splitLine = line.split(DSVDB_DELIMETER);
				/* Ensure that the number of COLUMN ID's equals the width of each row */
				if ( splitLine.length == horizontalWidth ) {
					foreach ( k, unit; splitLine ) {
						parsedText[i][schema[k]] = line.split(DSVDB_DELIMETER)[k];					
					}
				} else 
					dsvdb.Ext.Debug.log("dev", "Line has different horizontal width than schema.");
			}
		} else
			dsvdb.Ext.Debug.log("dev", "Cannot parse non-existant file.");
		
		return parsedText;
	}
}