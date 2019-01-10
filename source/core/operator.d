module dsvdb.Core.Operator;

import std.conv;
import dsvdb.Load;
import dsvdb.Ext.Debug;
import dsvdb.Core.Table;

class Operator {
	private Table TAB;
	private RowDataStructure operators;
	private StdTable OpTable;
	
	this() {
		TAB = new Table();
		this.OpTable = TAB.init("local", "operators");
	}

	public StdOperator init(string operatorID, string operatorPW) {
		StdOperator operator;
		operator.operatorID = to!ushort(operatorID);
		operator.operatorPW = operatorPW;
		
		return operator;
	}
}