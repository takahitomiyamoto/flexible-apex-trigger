/**
 * @name FAT_ITriggerObserver.cls
 * @description interface for all trigger observers
 */
public interface FAT_ITriggerObserver {
  /**
   * @description store FAT_ITriggerObserver
   * @param handler
   * @return FAT_ITriggerObserver
   */
  FAT_ITriggerObserver storeTriggerObserver(FAT_CommonTriggerHandler handler);

  /**
   * @description custom action in case of before insert
   */
  void onBeforeInsert();

  /**
   * @description custom action in case of before update
   */
  void onBeforeUpdate();

  /**
   * @description custom action in case of before delete
   */
  void onBeforeDelete();

  /**
   * @description custom action in case of after insert
   */
  void onAfterInsert();

  /**
   * @description custom action in case of after update
   */
  void onAfterUpdate();

  /**
   * @description custom action in case of after delete
   */
  void onAfterDelete();

  /**
   * @description custom action in case of after undelete
   */
  void onAfterUndelete();
}
