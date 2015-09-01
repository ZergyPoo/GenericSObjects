trigger AccountTrigger on Account (after insert) {
  if (Trigger.isAfter) {
    if (Trigger.isInsert) {
      TriggerHandler.createTasksForObjects(Trigger.new);
    }
  }
}