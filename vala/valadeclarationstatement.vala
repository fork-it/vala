/* valadeclarationstatement.vala
 *
 * Copyright (C) 2006-2008  Jürg Billeter
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

using Gee;

/**
 * Represents a local variable or constant declaration statement in the source code.
 */
public class Vala.DeclarationStatement : CodeNode, Statement {
	/**
	 * The local variable or constant declaration.
	 */
	public Symbol declaration { get; set; }

	/**
	 * Creates a new declaration statement.
	 *
	 * @param decl   local variable declaration
	 * @param source reference to source code
	 * @return       newly created declaration statement
	 */
	public DeclarationStatement (Symbol declaration, SourceReference? source_reference) {
		this.declaration = declaration;
		this.source_reference = source_reference;
	}
	
	public override void accept (CodeVisitor visitor) {
		declaration.accept (visitor);
	
		visitor.visit_declaration_statement (this);
	}

	public override bool check (SemanticAnalyzer analyzer) {
		if (checked) {
			return !error;
		}

		checked = true;

		declaration.check (analyzer);

		var local = declaration as LocalVariable;
		if (local != null && local.initializer != null) {
			foreach (DataType error_type in local.initializer.get_error_types ()) {
				// ensure we can trace back which expression may throw errors of this type
				var initializer_error_type = error_type.copy ();
				initializer_error_type.source_reference = local.initializer.source_reference;

				add_error_type (initializer_error_type);
			}
		}

		return !error;
	}

	public override void get_defined_variables (Collection<LocalVariable> collection) {
		var local = declaration as LocalVariable;
		if (local != null && local.initializer != null) {
			local.initializer.get_defined_variables (collection);
			collection.add (local);
		}
	}

	public override void get_used_variables (Collection<LocalVariable> collection) {
		var local = declaration as LocalVariable;
		if (local != null && local.initializer != null) {
			local.initializer.get_used_variables (collection);
		}
	}
}
