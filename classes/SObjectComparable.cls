global with sharing class SObjectComparable implements Comparable {

  private String sortableFieldName;
  private SObject objectToSort;

  global SObjectComparable(SObject objectToSort, String fieldname) {
    this.sortableFieldName = fieldname;
    this.objectToSort = objectToSort;
  }

  global SObject getObjectToSort() {
    return this.objectToSort;
  }

  global Integer compareTo(Object compareTo) {
    SObjectComparable ctComparable = (SObjectComparable) compareTo;
    SObject compareToSObject = ctComparable.getObjectToSort();

    String currentVal = (String) this.objectToSort.get(this.sortableFieldName);
    String compareVal = (String) compareToSObject.get(this.sortableFieldName);

    if (currentVal == compareVal) {
      return 0;
    } else if (currentVal > compareVal) {
      return 1;
    } else {
      return -1;
    }
  }
}