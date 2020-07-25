/**
 * @name CommonError.cls
 * @description utilities of Exception
 */
public without sharing class CommonError {
  // Constants
  private static final String SYMBOL_DIVIDER = CommonConstants.SYMBOL_DIVIDER;
  private static final String SYMBOL_EMPTY_OBJECT = CommonConstants.SYMBOL_EMPTY_OBJECT;
  private static final String SYMBOL_NEWLINE = CommonConstants.SYMBOL_NEWLINE;

  /**
   * @name ErrorMessage
   * @description error message
   */
  private class ErrorMessage {
    List<String> fields;
    StatusCode statusCode;
    Exception cause;
    Integer lineNumber;
    String message;
    String stackTrace;
    String type;
  }

  /**
   * @name hasStackTrace
   * @description whether stackTrace is empty or not
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
   * @name createErrorMessage
   * @description create Error Message from Database.Error
   */
  public static String createErrorMessage(Database.Error error) {
    ErrorMessage errorObj = new ErrorMessage();
    errorObj.fields = error.getFields();
    errorObj.statusCode = error.getStatusCode();
    errorObj.message = error.getMessage();

    return JSON.serialize(errorObj);
  }

  /**
   * @name createErrorMessage
   * @description create Error Message from Exception
   */
  public static String createErrorMessage(Exception e) {
    ErrorMessage errorObj = new ErrorMessage();
    errorObj.cause = e.getCause();
    errorObj.lineNumber = e.getLineNumber();
    errorObj.message = e.getMessage();
    errorObj.type = e.getTypeName();
    errorObj.stackTrace = hasStackTrace(e.getStackTraceString())
      ? e.getStackTraceString().replace(SYMBOL_NEWLINE, SYMBOL_DIVIDER)
      : '';

    return JSON.serialize(errorObj);
  }

  /**
   * @name getRecordTypeId
   * @description get recordTypeId
   */
  public static void handleError(Database.SaveResult result) {
    if (!result.isSuccess()) {
      for (Database.Error error : result.getErrors()) {
        System.debug(LoggingLevel.ERROR, createErrorMessage(error));
      }
    }
  }
}
