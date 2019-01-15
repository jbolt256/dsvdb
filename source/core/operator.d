module dsvdb.Core.Operator;

import std.conv;
import dsvdb.Load;
import dsvdb.Ext.Debug;
import dsvdb.Core.Table;

class Operator {
	private Table TAB;
	private TableRowData operators;
	private StdTable OpTable;
	
	this() {
		TAB = new Table();
		this.OpTable = TAB.init("local", "operators");
	}

	/**
	 * Initialize new operator handle.
	 * Params:
	 *		operatorID = operator ID (four digits)
	 *		operatorPW = operator password (encrypted)
	 */
	public StdOperator init(string operatorID, string operatorPW) {
		StdOperator operator;
		operator.auth = false;
		operator.operatorID = to!ushort(operatorID);
		operator.operatorPW = operatorPW;
		
		if ( this.TAB.rowExistsByColValue(operatorID, "ID") ) {
			operators = this.TAB.getRowsByColValue(operatorID, "ID")[0];
			if ( operators["PASSWORD"] == operatorPW ) {
				operator.auth = true;
			}	
		} else 
			dsvdb.Ext.Debug.elog("dev", "Operator ID invalid.");
		
		return operator;
	}
}