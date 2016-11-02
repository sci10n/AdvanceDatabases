package tddd43.theme3.jena;

import com.hp.hpl.jena.ontology.OntModel;
import com.hp.hpl.jena.ontology.OntModelSpec;
import com.hp.hpl.jena.rdf.model.ModelFactory;

/**
 * <p>
 * Simple demonstration program in TDDD43
 * </p>
 *
 * @author He Tan, Mikael �sberg
 *
 */
public class Main {

	public static void main(String[] args) {
		// Parse the OWL file, and create the model for the ontology
		OntModel m = 
			ModelFactory.createOntologyModel(OntModelSpec.OWL_MEM, null);

		try {
			// TODO: change the path to the place where your own ontology 
			// file is, e.g. "file:///z:/uni.owl"
			m.read("file:///z:/TDDD43/uni/university.owl");
		}
		catch (com.hp.hpl.jena.shared.WrappedIOException e) {
			if (e.getCause() instanceof java.io.FileNotFoundException) {
				System.err.println("A java.io.FileNotFoundException caught: " 
						+ e.getCause().getMessage());
				System.err.println("You must alter the path passed to " +
						"OntModel.read() so it finds your university " +
						"ontology");
			}
		}
		catch (Throwable t) {
			System.err.println("Caught exception, message: " + t.getMessage());
		}

		new ClassHierarchy().showHierarchy(System.out, m);
	}
}