public with sharing class TriggerHandler {

  private static final String NAME_FIELD = 'Name';
  private static final String TITLE_FIELD = 'Title';
  private static final String OWNER_ID_FIELD = 'OwnerId';

  public static void createTasksForObjects(List<SObject> objects) {
    if (objects == null || objects.isEmpty()) {
      return;
    }

    Id currentOwnerId;
    List<Task> tasksToCreate = new List<Task>();

    for (SObject so : objects) {
      currentOwnerId = (Id) getValueForField(so, OWNER_ID_FIELD);

      if (currentOwnerId == null) {
        continue;
      }

      tasksToCreate.add(new Task(
        Subject = getNameForTask(so),
        WhatId = so.Id,
        OwnerId = currentOwnerId));
    }

    insert tasksToCreate;
  }

  private static String getNameForTask(SObject so) {
    String taskName = (String) getValueForField(so, NAME_FIELD);

    if (taskName == null) {
      taskName = (String) getValueForField(so, TITLE_FIELD);
    }

    return taskName;
  }

  private static Object getValueForField(SObject so, String fieldName) {
    try {
      return so.get(fieldName);
    } catch (Exception e) {
      return null;
    }
  }
}