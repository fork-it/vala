/* valatypecheck.vala
 *
 * Copyright (C) 2006-2007  Jürg Billeter
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.

 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.

 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301  USA
 *
 * Author:
 * 	Jürg Billeter <j@bitron.ch>
 */

using GLib;

/**
 * Represents a type check (`is') expression in the source code.
 */
public class Vala.TypeCheck : Expression {
	/**
	 * The expression to be checked.
	 */
	public Expression expression { get; set; }
	
	/**
	 * The type to be matched against.
	 */
	public DataType type_reference {
		get { return _data_type; }
		set {
			_data_type = value;
			_data_type.parent_node = this;
		}
	}

	private DataType _data_type;

	/**
	 * Creates a new type check expression.
	 *
	 * @param expr   an expression
	 * @param type   a data type
	 * @param source reference to source code
	 * @return       newly created type check expression
	 */	
	public TypeCheck (Expression expr, DataType type, SourceReference source) {
		expression = expr;
		type_reference = type;
		source_reference = source;
	}
	
	public override void accept (CodeVisitor visitor) {
		expression.accept (visitor);
		
		type_reference.accept (visitor);
	
		visitor.visit_type_check (this);

		visitor.visit_expression (this);
	}

	public override bool is_pure () {
		return expression.is_pure ();
	}

	public override void replace_type (DataType old_type, DataType new_type) {
		if (type_reference == old_type) {
			type_reference = new_type;
		}
	}
}
