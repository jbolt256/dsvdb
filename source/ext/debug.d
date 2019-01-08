module dsvdb.Ext.Debug;

import std.datetime.systime;
import std.conv;
import std.format;
import std.file;

/*
 * Since vibe.d can be difficult to debug...
 */
static void log(string log, string message) {
	string errorLogPath = "./dev/logs/" ~ log ~ ".log"; // For now, I guess
	if ( !errorLogPath.isFile ) {
		std.file.write(errorLogPath, " ");
		}
	std.file.append(errorLogPath, format!"[%s] - %s \r\n"(std.datetime.systime.Clock.currTime(), message));
}

static void clear(string log) {
	std.file.write("./dev/logs/" ~ log ~ ".log", "");
}
