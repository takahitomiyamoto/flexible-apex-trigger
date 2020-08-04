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
  new CommonTriggerHandler(Account.class.getName()).invoke();
}
