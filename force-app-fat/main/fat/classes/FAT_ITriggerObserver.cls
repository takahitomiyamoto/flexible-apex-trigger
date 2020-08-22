/**
 * @name FAT_ITriggerObserver.cls
 * @description interface for all trigger observers
 */
public interface FAT_ITriggerObserver {
  /**
   * @description custom action in case of before insert
   * @param handler
   */
  void onBeforeInsert(FAT_CommonTriggerHandler handler);

  /**
   * @description custom action in case of before update
   * @param handler
   */
  void onBeforeUpdate(FAT_CommonTriggerHandler handler);

  /**
   * @description custom action in case of before delete
   * @param handler
   */
  void onBeforeDelete(FAT_CommonTriggerHandler handler);

  /**
   * @description custom action in case of after insert
   * @param handler
   */
  void onAfterInsert(FAT_CommonTriggerHandler handler);

  /**
   * @description custom action in case of after update
   * @param handler
   */
  void onAfterUpdate(FAT_CommonTriggerHandler handler);

  /**
   * @description custom action in case of after delete
   * @param handler
   */
  void onAfterDelete(FAT_CommonTriggerHandler handler);

  /**
   * @description custom action in case of after undelete
   * @param handler
   */
  void onAfterUndelete(FAT_CommonTriggerHandler handler);
}
