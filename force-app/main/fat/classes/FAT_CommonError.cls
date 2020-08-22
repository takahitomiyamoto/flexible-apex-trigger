/**
 * @name FAT_CommonError.cls
 * @description utilities of Exception
 */
public without sharing class FAT_CommonError {
  // Constants
  private static final String SYMBOL_DIVIDER = FAT_CommonConstants.SYMBOL_DIVIDER;
  private static final String SYMBOL_EMPTY_OBJECT = FAT_CommonConstants.SYMBOL_EMPTY_OBJECT;
  private static final String SYMBOL_NEWLINE = FAT_CommonConstants.SYMBOL_NEWLINE;

  /**
   * @description Database.Error
   */
  private class DatabaseError {
    String[] fields;
    String message;
    StatusCode statusCode;
  }

  /**
   * @description error message
   */
  private class ErrorMessage {
    DatabaseError databaseError;
    Exception cause;
    Integer lineNumber;
    String message;
    String stackTrace;
    String type;
  }

  /**
   * @description whether stackTrace is empty or not
   * @param stackTrace
   * @return Boolean
   */
  @TestVisible
  private static Boolean hasStackTrace(String stackTrace) {
    return 0 ==
      stackTrace.replace(SYMBOL_NEWLINE, '')
        .replace(SYMBOL_EMPTY_OBJECT, '')
        .length()
      ? false
      : true;
  }

  /**
   * @description create error message from Database.Error
   * @param error
   * @return JSON.serialize(errorMessage)
   */
  public static String createErrorMessage(Database.Error error) {
    DatabaseError databaseError = new DatabaseError();
    databaseError.fields = error.getFields();
    databaseError.statusCode = error.getStatusCode();
    databaseError.message = error.getMessage();

    ErrorMessage errorMessage = new ErrorMessage();
    errorMessage.databaseError = databaseError;

    return JSON.serialize(errorMessage);
  }

  /**
   * @description create error message from Exception
   * @param e
   * @return JSON.serialize(errorMessage)
   */
  public static String createErrorMessage(Exception e) {
    ErrorMessage errorMessage = new ErrorMessage();
    String stackTraceString = e.getStackTraceString();
    if (hasStackTrace(stackTraceString)) {
      errorMessage.stackTrace = stackTraceString.replace(
        SYMBOL_NEWLINE,
        SYMBOL_DIVIDER
      );
    }
    errorMessage.cause = e.getCause();
    errorMessage.lineNumber = e.getLineNumber();
    errorMessage.message = e.getMessage();
    errorMessage.type = e.getTypeName();

    return JSON.serialize(errorMessage);
  }

  /**
   * @description handle Database.Error
   * @param result
   */
  public static void handleError(Database.SaveResult result) {
    if (null == result) {
      return;
    }

    if (!result.isSuccess()) {
      for (Database.Error error : result.getErrors()) {
        System.debug(LoggingLevel.ERROR, createErrorMessage(error));
      }
    }
  }

  /**
   * @description handle List<Database.Error>
   * @param results
   */
  public static void handleErrors(List<Database.SaveResult> results) {
    if (null == results) {
      return;
    }

    for (Database.SaveResult result : results) {
      handleError(result);
    }
  }
}
