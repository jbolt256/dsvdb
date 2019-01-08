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
 */
class Parser {
	this() {}
	
	/**
	 * Parses a DSV file.
	 * First line is schema.
	 */
	public string parse(string pathname) {
		/* Set up variables */
		int numLines, horizontalWidth;
		string rawText;
		string[] schema;
		string[] splitLine;
		string[] splitText;
		string[string][uint] parsedText;
		
		/**/
		if ( pathname.isFile ) {
			rawText = std.file.readText(pathname);
			splitText = rawText.split("\r\n");
			numLines = splitText.length; 
			
			/* Determine schema from the first line */
			schema = splitText[0].split("^_");
			horizontalWidth = schema.length;
			
			/* Ensure that first line is formatted correctly */
			if ( schema.length > 0 ) {
			
				/* Parse text according to schema */
				foreach ( i, line; splitText ) {
					splitLine = line.split("^_");
					/* Ensure that the number of COLUMN ID's equals the width of each row */
					if ( splitLine.length == horizontalWidth ) {
						foreach ( k, unit; splitLine ) {
							parsedText[i][schema[k]] = line.split("^_")[k];					
						}
					} else 
						dsvdb.Ext.Debug.log("dev", "Line has different horizontal width than schema.");
				}
			} else 
				dsvdb.Ext.Debug.log("dev", "Zero-length schema provided on line one.");
		} else
			dsvdb.Ext.Debug.log("dev", "Cannot parse non-existant file.");
		
		return parsedText[1]["COL1"];
	}
}