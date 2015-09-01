@RestResource(urlMapping='/sobjectendpoint/*')
global with sharing class SObjectWs {
  
  private static final String NAME_TEMPLATE = 'List<{0}>';
  private static final String SLASH_DELIMITER = '/';
  
  @httpPost
  global static void httpPost() {
    RestRequest req = RestContext.request;
    JSONParser parser;
    List<SObject> incomingObjects;
    String objectName = req.requestURI.substringAfterLast(SLASH_DELIMITER);
    String typeString = String.format(NAME_TEMPLATE,
      new List<String> { objectName });

    parser = JSON.createParser(req.requestBody.toString());

    incomingObjects = (List<SObject>) parser.readValueAs(
      Type.forName(typeString));

    insert incomingObjects;
    
    RestContext.response.responseBody =
      Blob.valueOf(JSON.serialize(incomingObjects));
  }
}