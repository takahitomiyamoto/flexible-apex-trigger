/**
 * @name ITriggerObserver.cls
 * @description interface for all trigger observers
 */
public interface ITriggerObserver {
  ITriggerObserver storeTriggerObserver(CommonTriggerHandler handler);
  void onBeforeInsert();
  void onBeforeUpdate();
  void onBeforeDelete();
  void onAfterInsert();
  void onAfterUpdate();
  void onAfterDelete();
  void onAfterUndelete();
}
