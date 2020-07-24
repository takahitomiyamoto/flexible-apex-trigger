/**
 * @name CommonError.cls
 * @description utilities of Error
 */
public without sharing class CommonError {
  private static final String SYMBOL_DIVIDER = CommonConstants.SYMBOL_DIVIDER;
  private static final String SYMBOL_NEWLINE = CommonConstants.SYMBOL_NEWLINE;

  /**
   * @name ErrorObject
   * @description ErrorObject
   */
  private class ErrorObject {
    List<String> fields;
    StatusCode statusCode;
    Exception cause;
    Integer lineNumber;
    String message;
    String stackTrace;
    String type;
  }

  /**
   * @name createErrorMessage
   * @description create Error Message from Database.Error
   */
  public static String createErrorMessage(Database.Error error) {
    ErrorObject errorObj = new ErrorObject();
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
    ErrorObject errorObj = new ErrorObject();
    errorObj.cause = e.getCause();
    errorObj.lineNumber = e.getLineNumber();
    errorObj.message = e.getMessage();
    errorObj.stackTrace = e.getStackTraceString()
      .replace(SYMBOL_NEWLINE, SYMBOL_DIVIDER);
    errorObj.type = e.getTypeName();

    return JSON.serialize(errorObj);
  }
}
