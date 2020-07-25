/**
 * @name CommonError.cls
 * @description utilities of Exception
 */
public without sharing class CommonError {
  // Custom Exception
  public class RequiredFieldMissingException extends Exception {
  }
  public class CreateObjectException extends Exception {
  }

  // Constants
  private static final String SYMBOL_DIVIDER = CommonConstants.SYMBOL_DIVIDER;
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
    errorObj.stackTrace = e.getStackTraceString()
      .replace(SYMBOL_NEWLINE, SYMBOL_DIVIDER);
    errorObj.type = e.getTypeName();

    return JSON.serialize(errorObj);
  }
}
