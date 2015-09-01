public with sharing class QueryUtils {

  private static final String QUERY_TEMPLATE =
    'select {0} from {1} where Id in :objectIds';
  private static final String FIELD_SEPARATOR = ',';

	public static SObject queryObject(Id objectId) {
    if (String.isBlank(objectId)) {
      return null;
    }

    List<SObject> results = queryObjects(new Set<Id> { objectId });

    return (results.isEmpty()) ? null : results[0];
  }

  public static List<SObject> queryObjects(Set<Id> objectIds) {
    if (objectIds == null || objectIds.isEmpty()) {
      return null;
    }

    Schema.SObjectType objectType = new List<Id>(objectIds)[0].getSObjectType();

    return Database.query(generateQuery(getFieldNames(objectType), objectType));
  }

  private static String getFieldNames(
      Schema.SObjectType objectType) {
    return String.join(
      new List<String> (objectType.getDescribe().fields.getMap().keySet()),
        FIELD_SEPARATOR);
  }

  private static String generateQuery(String fieldNames,
      Schema.SObjectType objectType) {
    return String.format(QUERY_TEMPLATE, new List<String> { fieldNames,
      objectType.getDescribe().getName() });
  }
}