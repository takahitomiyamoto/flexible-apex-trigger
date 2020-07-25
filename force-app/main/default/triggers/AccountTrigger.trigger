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
  String sObjectName = Account.class.getName();
  new CommonTriggerHandler(sObjectName).invoke();
}
