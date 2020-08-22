/**
 * @name AccountTrigger.trigger
 * @description trigger for Account
 */
trigger AccountTrigger on Account(
  before insert,
  before update,
  before delete,
  after insert,
  after update,
  after delete,
  after undelete
) {
  FAT_CommonTriggerHandler handler = FAT_CommonTriggerHandler.create(
    Account.class
  );
  handler.invoke();
}
