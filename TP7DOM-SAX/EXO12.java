
import java.io.File;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

public class EXO12 {
      public static Node fetchedServiceNode;
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


                 //adding a grad attr to the service element
                //to get the text 
                // on est sur un élément <marque>
/*                 Element marque = (Element) courant;
                String texte = marque.getTextContent(); */

                switch (emp[4]) {
                    case "S1" :
                        service.setAttribute("Grade", "Ingenieur");

                        break;

                    case "S2" :
                    service.setAttribute("Grade", "Admin");


                    break;

                    case "S3":
                    service.setAttribute("Grade", "Technician");

                    break;
                  
                    default:
                    service.setAttribute("Grade", "Agent");
                    break;
                        
                    
                }
                


                // renaming the service node 

                rootElement.appendChild(employe);

               
            }

            //NOTE: NodeList doesnt support the iterable interface therfore can't use the for each loop like the array list
            //fetching the entire Nodelist of service elements (all undependant of directory)
            NodeList ServiceNodes = doc.getElementsByTagName("Service");
           // fetching the appended services nodes to change their text
           for (int i = 0; i < ServiceNodes.getLength(); i++) {
            Node ServiceNode = ServiceNodes.item(i);
            String serviceNodeTextContent = ServiceNode.getTextContent();
            switch (serviceNodeTextContent) {
                case "S1":
                    ServiceNode.setTextContent("Service1");
                    break;
                case "S2":
                    ServiceNode.setTextContent("Service2");
                    break;
                case "S3":
                    ServiceNode.setTextContent("Service3");
                    break;
                default:
                    // you could set default text if you want
                    break;
            }
        }
        

 //node list does
            //adding a new employee 
             

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
