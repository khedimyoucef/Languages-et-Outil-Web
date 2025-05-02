
import java.io.File;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import org.w3c.dom.Document;
import org.w3c.dom.Element;

//TODO : add a function to automatically add employees to the list from the terminal
public class EXO1 {
  
    public static DocumentBuilderFactory factory;
    public static DocumentBuilder builder;
    public static Document document;
    public static Element rootElement;
    public static Element employe;

    public void insertAnewEmployee(String args[]) {

        if (args.length != 5) {
            System.out.println("enter a valid emplyee object (5 required elemenets)");
            return;
        }
        employe = document.createElement("Employe");

        Element mat = document.createElement("Mat");
        mat.appendChild(document.createTextNode(emp[0]));
        employe.appendChild(mat);

        Element nom = document.createElement("Nom");
        nom.appendChild(document.createTextNode(emp[1]));
        employe.appendChild(nom);

        Element prenom = document.createElement("Prenom");
        prenom.appendChild(document.createTextNode(emp[2]));
        employe.appendChild(prenom);

        Element dateN = document.createElement("Date_N");
        dateN.appendChild(document.createTextNode(emp[3]));
        employe.appendChild(dateN);

        Element service = document.createElement("Service");
        service.appendChild(document.createTextNode(emp[4]));
        employe.appendChild(service);

        rootElement.appendChild(employe);

    }

    public static void main(String args[]) {

        try {
// création d'une fabrique de parseurs (Factory)
            factory = DocumentBuilderFactory.newInstance();
// création d'un parseur (Builder)
            builder = factory.newDocumentBuilder();
// création d'un document
            document = builder.newDocument();

            //creating the root element 
            rootElement = document.createElement("Employes");
            document.appendChild(rootElement);

            //creating the emplyees array of arrays of strings
            String[][] employes = {
                {"E05", "Kadri", "Amina", "23-11-1995", "S3"},
                {"E04", "Abelmalk", "Hakima", "18-10-1977", "S3"},
                {"E01", "Nouar", "Mohamed", "08-04-1975", "S1"},
                {"E02", "Benali", "Mostapha", "06-07-1965", "S2"},
                {"E06", "Safi", "Mostapha", "23-12-1966", "S4"},
                {"E03", "Drissi", "Oussama", "21-09-1956", "S2"},
                {"E07", "Nadji", "Youssef", "31-12-1985", "S4"}
            };

            //hardcoded function to generate the nodes of employees
            for (String[] emp : employes) {
                Element employe = document.createElement("Employe");

                Element mat = document.createElement("Mat");
                mat.appendChild(document.createTextNode(emp[0]));
                employe.appendChild(mat);

                Element nom = document.createElement("Nom");
                nom.appendChild(document.createTextNode(emp[1]));
                employe.appendChild(nom);

                Element prenom = document.createElement("Prenom");
                prenom.appendChild(document.createTextNode(emp[2]));
                employe.appendChild(prenom);

                Element dateN = document.createElement("Date_N");
                dateN.appendChild(document.createTextNode(emp[3]));
                employe.appendChild(dateN);

                Element service = document.createElement("Service");
                service.appendChild(document.createTextNode(emp[4]));
                employe.appendChild(service);

                rootElement.appendChild(employe);
            }

            //writing the results to an xml file
            TransformerFactory transformerFactory = TransformerFactory.newInstance();
            Transformer transformer = transformerFactory.newTransformer();
            DOMSource source = new DOMSource(document);
            StreamResult result = new StreamResult(new File("Employes.xml"));

            transformer.transform(source, result);

        } catch (Exception e) {
            System.out.println("error creating a new document");
        }

    }

}
