    import java.io.File;
    import java.util.ArrayList;
    import java.util.Collections;
    import java.util.Comparator;
    import java.util.HashMap;
    import java.util.List;
    import java.util.Map;
    import javax.xml.parsers.DocumentBuilder;
    import javax.xml.parsers.DocumentBuilderFactory;
    import javax.xml.parsers.SAXParser;
    import javax.xml.parsers.SAXParserFactory;
    import javax.xml.transform.OutputKeys;
    import javax.xml.transform.Transformer;
    import javax.xml.transform.TransformerFactory;
    import javax.xml.transform.dom.DOMSource;
    import javax.xml.transform.stream.StreamResult;
    import org.w3c.dom.Document;
    import org.w3c.dom.Element;
    import org.xml.sax.Attributes;
    import org.xml.sax.helpers.DefaultHandler;


    //all the needed classes are defined in this single file
    //in java multiple classes can be defined in a single file only one public class is allowed which must match the file name
    public class EXO2 {
        public static void main(String[] args) {
            try {
                //importing the XML file
                File inputFile = new File("Championnat.xml");
                //create the sax parser factory that can create a SAX parser
                SAXParserFactory factory = SAXParserFactory.newInstance();
                //creating the sax parser from the factory
                SAXParser saxParser = factory.newSAXParser();
                //creating the handler that will handle the sax events (displaying some data in our case)
                // the ChampionnatHandler is defined in this file
                ChampionnatHandler handler = new ChampionnatHandler();
                //linking the handler to the parser and parsing the XML file
                saxParser.parse(inputFile, handler);

                //printing the results after the parse is done
                //the hashmap contains the teams and their stats
                //the memory footprint used by the hashmap is not that big since we don't have that many teams
                // Sort using our custom comparator with tie-breaking rules
                List<EquipeStats> sortedEquipes = new ArrayList<>(handler.getEquipes().values());
                //getting the teams from the hashmap and putting them in a list to sort them
                Collections.sort(sortedEquipes, new Comparator<EquipeStats>() {
                    @Override
                    public int compare(EquipeStats e1, EquipeStats e2) {
                        // First compare by points
                        int pointsCompare = Integer.compare(e2.getPoints(), e1.getPoints());
                        if (pointsCompare != 0) return pointsCompare;
                        //if points are different we stop the sort between the 2 teams

                        // Second, compare by goal difference
                        int diffButsCompare = Integer.compare(e2.getDiffButs(), e1.getDiffButs());
                        if (diffButsCompare != 0) return diffButsCompare;

                        // Third, head-to-head points against each other only
                        int headToHeadPointsCompare = Integer.compare(
                            e2.getHeadToHeadPointsAgainst(e1.nom),
                            e1.getHeadToHeadPointsAgainst(e2.nom)
                        );

                        if (headToHeadPointsCompare != 0) return headToHeadPointsCompare;   

                        // Fourth, head-to-head goal difference
                        int headToHeadDiffCompare = Integer.compare(
                            e2.getHeadToHeadDiffAgainst(e1.nom),
                            e1.getHeadToHeadDiffAgainst(e2.nom)
                        );
                        
                        if (headToHeadDiffCompare != 0) return headToHeadDiffCompare;

                        // Fifth, compare total goals scored  (4- Meilleure attaque générale)
                        int goalsScoredCompare = Integer.compare(e2.butsPour, e1.butsPour);
                        if (goalsScoredCompare != 0) return goalsScoredCompare;

                        // Last, compare the highest goal score in a single match
                        int highestScoredCompare = Integer.compare(e2.getHighestMatchScore(), e1.getHighestMatchScore());
                        return highestScoredCompare;
                    }
                });
                // after the parse the hashmap would be filled with the teams and their stats so we just print them out
                int classement = 1;//teams are already sorted so we just use a variable to keep track of the ranking

                // Createing the XML document to write to the xml file
                DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
                DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
                Document doc = dBuilder.newDocument();

                // Root element
                Element rootElement = doc.createElement("CLASSEMENTS");
                doc.appendChild(rootElement);
                for (EquipeStats e : sortedEquipes) {
                    
                    System.out.println("Classmenet: " + classement); 
                    System.out.println("Equipe: " + e.nom); 
                    System.out.println("  Matchs jouees: " + e.joues);
                    System.out.println("  Gangnes: " + e.gagnes + ", Perdus: " + e.perdus + ", Nuls: " + e.nuls);
                    System.out.println("  Buts marque: " + e.butsPour + ", Buts recus: " + e.butsContre);
                    System.out.println("  Difference de buts: " + e.getDiffButs() + ", Points: " + e.getPoints());
                    System.out.println("----------------------------------");
                



                    Element equipeElem = doc.createElement("EQUIPE");
                    //note that setAttribute sets the attributes in a random order
                    equipeElem.setAttribute("CLASSEMENT", String.valueOf(classement));
                    equipeElem.setAttribute("NOM", e.nom);
                    equipeElem.setAttribute("POINTS", String.valueOf(e.getPoints()));
                    equipeElem.setAttribute("BUTS_POUR", String.valueOf(e.butsPour));
                    equipeElem.setAttribute("BUTS_CONTRE", String.valueOf(e.butsContre));
                    equipeElem.setAttribute("DIFF", String.valueOf(e.getDiffButs()));
                    equipeElem.setAttribute("MATCHS_JOUES", String.valueOf(e.joues));
                    equipeElem.setAttribute("GAGNES", String.valueOf(e.gagnes));
                    equipeElem.setAttribute("NULS", String.valueOf(e.nuls));
                    equipeElem.setAttribute("PERDUS", String.valueOf(e.perdus));
                    rootElement.appendChild(equipeElem);

                    classement++;
                    }

                    // writing to an xml file
                    TransformerFactory transformerFactory = TransformerFactory.newInstance();
                    Transformer transformer = transformerFactory.newTransformer();
                    transformer.setOutputProperty(OutputKeys.INDENT, "yes");
                    DOMSource source = new DOMSource(doc);
                    StreamResult result = new StreamResult(new File("Classement.xml"));
                    transformer.transform(source, result);

            } catch (Exception e) {
                e.printStackTrace();
                
            }
        }

        
    }

            class ChampionnatHandler extends DefaultHandler {
                Map<String, EquipeStats> equipes = new HashMap<>();
                //this is a hashmap that will contain the teams and their stats
                //we used startElement instead of endElement mainly because all the useful data is in the attributes of the RENCONTRE Element
                //also the RENCONTRE is self closing so we can't use endElement
                @Override
                public void startElement(String uri, String localName, String qName, Attributes attributes) {
                    //in our case , no namespace was used so the uri is an empty string and the localName is the same as the qName
                    //so it doesnt matter if we use qName or localName
                    if (qName.equals("RENCONTRE")) {
                        //fetching the home and away teams and their scores from the attributes
                        String domicile = attributes.getValue("DOMICILE");
                        String exterieur = attributes.getValue("EXTERIEUR");
                        int scoreDomicile = Integer.parseInt(attributes.getValue("SCORED"));
                        int scoreExterieur = Integer.parseInt(attributes.getValue("SCOREE"));
            
                        // if the teams are new we create a new EquipeStats object for them else we just update the existing ones
                        EquipeStats equipeDomicile = equipes.computeIfAbsent(domicile, EquipeStats::new);
                        EquipeStats equipeExterieir = equipes.computeIfAbsent(exterieur, EquipeStats::new);
            
                        // the update is always called even if the teams are new
                        equipeDomicile.update(scoreDomicile, scoreExterieur);
                        equipeExterieir.update(scoreExterieur, scoreDomicile);

                        equipeDomicile.updateHeadToHead(exterieur, scoreDomicile, scoreExterieur);
                        equipeExterieir.updateHeadToHead(domicile, scoreExterieur, scoreDomicile);
                        //the update must go both ways since the teams are playing against each other

                    }
                }
            //just a getter for the equipes map
            //this is not really needed since we could just use the equipes map directly but it is a good practice to use getters and setters
                public Map<String, EquipeStats> getEquipes() {
                    return equipes;
                }
            }
            


    class EquipeStats {
        String nom;
        int joues = 0, gagnes = 0, perdus = 0, nuls = 0;
        int butsPour = 0, butsContre = 0;
        int highestMatchScore = 0;  //highest score in a single match (used as the 5th crieteria for sorting)

        //to store the data for each played match for this team
        //so each team will have a hashmap that contains the teams they played against and the stats for each match
        Map<String, MatchData> vsOpponents = new HashMap<>();

        EquipeStats(String nom) {
            this.nom = nom;
        }
        //we only pass the newly fetched scored and conceded (goals against home team) and call the updaet method 
        void update(int scored, int conceded) {
            highestMatchScore = Math.max(highestMatchScore, scored);
            // if the current match has a higher number of scored goals update the highsetMatchScore
            //if the current match has a higher number of conceded goals update the highestMatchScore
            joues++;
            butsPour += scored;
            //this still works even if goals are negative
            butsContre += conceded;
            if (scored > conceded) gagnes++;
            else if (scored < conceded) perdus++;
            else nuls++;
        }

        int getPoints() {
            //victory = 3 points, draw = 1 point, loss = 0 points
            return gagnes * 3 + nuls;
        }
        
        int getButsPour() {
            return butsPour;
        }
        
        int getButsContre (){
            return butsContre;
        }


        int getDiffButs() { 
            return butsPour - butsContre;
        }
        
        void updateHeadToHead(String opponent, int scored, int conceded) {
            MatchData data = vsOpponents.computeIfAbsent(opponent, k -> new MatchData());
            data.update(scored, conceded);
            //if the 2 teams played against each other we update the stats for both teams
            //else create a new MatchData object for the opponent and update the stats
        }
        int getHeadToHeadPointsAgainst(String opponent) {
            return vsOpponents.getOrDefault(opponent, new MatchData()).points;
        }
        
        int getHeadToHeadDiffAgainst(String opponent) {
            return vsOpponents.getOrDefault(opponent, new MatchData()).getDiff();
        }
        
        

        int getHighestMatchScore() {
            return highestMatchScore;
        }
    }
    //this is a class that will hold the data for each match
    //so for each team it will have all the matches played against all the teams and the stats for each individual match

    class MatchData {
        int points = 0;
        int butsPour = 0;
        int butsContre = 0;

        void update(int scored, int conceded) {
            butsPour += scored;
            butsContre += conceded;
            if (scored > conceded) points += 3;
            else if (scored == conceded) points += 1;
            // no points added for loss
        }

        int getDiff() {
            return butsPour - butsContre;
        }
    }


