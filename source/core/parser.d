module dsvdb.Core.Parser;

import std.file;
import std.array;
import std.conv;
import dsvdb.Load;

class Parser {
	this() {}
	
	/**
	 * Parses a DSV file.
	 * First line is schema.
	 */
	public string file(string pathname) {
		/* Set up variables */
		string rawText;
		string[] schema;
		string[] splitLine;
		string[] splitText;
		string[string][int] parsedText;
		
		/**/
		if ( pathname.isFile ) {
			rawText = std.file.readText(pathname);
			splitText = rawText.split("\r\n");
			
			/* Determine schema from the first line */
			schema = splitText[0].split("^_");
						
			/* Parse text according to schema */
			foreach ( i, line; splitText ) {
				splitLine = line.split("^_");
				foreach ( k, unit; splitLine ) {
					parsedText[i][schema[k]] = line.split("^_")[k];					
				}
			}
		}
		
		return "";
	}
}