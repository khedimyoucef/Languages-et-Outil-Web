
import java.io.File;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import org.w3c.dom.Document;
import org.w3c.dom.Element;

public class EXO11 {

    public static void main(String[] args) {
        try {
            //GENERATING the document
            DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
            DocumentBuilder builder = factory.newDocumentBuilder();
            Document doc = builder.newDocument();

            //creating the root element
            Element rootElement = doc.createElement("Employes");
            doc.appendChild(rootElement);

            String[][] employes = {
                {"E05", "Kadri", "Amina", "23-11-1995", "S3"},
                {"E04", "Abelmalk", "Hakima", "18-10-1977", "S3"},
                {"E01", "Nouar", "Mohamed", "08-04-1975", "S1"},
                {"E02", "Benali", "Mostapha", "06-07-1965", "S2"},
                {"E06", "Safi", "Mostapha", "23-12-1966", "S4"},
                {"E03", "Drissi", "Oussama", "21-09-1956", "S2"},
                {"E07", "Nadji", "Youssef", "31-12-1985", "S4"}
            };

            for (String[] emp : employes) {
                Element employe = doc.createElement("Employe");

                Element mat = doc.createElement("Mat");
                mat.appendChild(doc.createTextNode(emp[0]));
                employe.appendChild(mat);

                Element nom = doc.createElement("Nom");
                nom.appendChild(doc.createTextNode(emp[1]));
                employe.appendChild(nom);

                Element prenom = doc.createElement("Prenom");
                prenom.appendChild(doc.createTextNode(emp[2]));
                employe.appendChild(prenom);

                Element dateN = doc.createElement("Date_N");
                dateN.appendChild(doc.createTextNode(emp[3]));
                employe.appendChild(dateN);

                Element service = doc.createElement("Service");
                service.appendChild(doc.createTextNode(emp[4]));
                employe.appendChild(service);
               
                
                rootElement.appendChild(employe);


            }

            TransformerFactory transformerFactory = TransformerFactory.newInstance();
            Transformer transformer = transformerFactory.newTransformer();
            DOMSource source = new DOMSource(doc);
            StreamResult result = new StreamResult(new File("Employes.xml"));

            transformer.transform(source, result);

            System.out.println("Fichier Employes.xml généré avec succès !");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
