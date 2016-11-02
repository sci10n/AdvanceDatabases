package tddd43.theme3.jena;

import com.hp.hpl.jena.ontology.OntClass;
import com.hp.hpl.jena.ontology.OntModel;
import com.hp.hpl.jena.ontology.OntResource;
import com.hp.hpl.jena.util.iterator.Filter;

import java.io.PrintStream;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

/**
 * <p>
 * Simple demonstration program to show how to list a hierarchy of classes.
 * </p>
 *
 * @author He Tan, Mikael �sberg
 */
public class ClassHierarchy {

	protected OntModel m_model;

	// Constructors
	//////////////////////////////////

	// External signature methods
	//////////////////////////////////
	/** Show the sub-class hierarchy encoded by the given model */
	public void showHierarchy( PrintStream out, OntModel m ) {
		// create an iterator over the root classes that are not
		// anonymous class expressions
		Iterator<OntClass> i = m.listHierarchyRootClasses()
		.filterDrop(new Filter<OntClass>() {
			public boolean accept(OntClass o) {
				return o.isAnon();
			}});

		while (i.hasNext()) {
			showClass(out, i.next(), new ArrayList<OntClass>(), 0);
		}
	}


	// Internal implementation methods
	//////////////////////////////////

	/** Present a class, then recurse down to the sub-classes.
	 *  Use occurs check to prevent getting stuck in a loop
	 */
	protected void showClass(PrintStream out, OntClass cls, List<OntClass> occurs, int depth) {
		renderClassDescription(out, cls, depth);
		out.println();

		// recurse to the next level down
		if (cls.canAs(OntClass.class) && !occurs.contains(cls)) {
			for (Iterator<OntClass> i = cls.listSubClasses(true); i.hasNext();) {
				OntClass sub = i.next();

				// we push this expression on the occurs list before we recurse
				occurs.add(cls);
				showClass(out, sub, occurs, depth + 1);
				occurs.remove(cls);
			}
		}
	}


	/**
	 * <p>Render a description of the given class to the given output stream.</p>
	 *
	 * @param out A print stream to write to
	 * @param c The class to render
	 */
	public void renderClassDescription(PrintStream out, OntClass c, int depth) {
		indent(out, depth);

		// TODO: !!! Complete this method to print out the class name in the hierarchy
		if (!c.isRestriction() && !c.isAnon()) {
			out.println("Class: " + c.toString());

			// list the instances for this class
			showInstance(out, c, depth + 2);
		}
	}


	/**<p>Present instances of a class
	 *
	 * @param out A print stream to write to
	 * @param c The class to render *
	 *
	 */
	protected void showInstance(PrintStream out, OntClass cls, int depth) {
		// TODO: !!! Implement the method to present instances of a class
		
		for(OntResource clsi: cls.listInstances().toList()){
			indent(out, depth);
			out.println("Instance: " + clsi.toString());
		}

	}


	/** Generate the indentation */
	protected void indent(PrintStream out, int depth) {
		for (int i = 0; i < depth; ++i) {
			out.print("  ");
		}
	}
}