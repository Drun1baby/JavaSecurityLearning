/*! \file JmsException.h
    \brief Describes a JmsException handle
    
    This file describes the functions that can be performed on a JmsException handle
    A JmsDestination handle corresponds to java.util.Enumeration
    \author Copyright (c) 2002, BEA Systems, Inc.
*/

#ifndef _JMS_EXCEPTION_H
#define _JMS_EXCEPTION_H 1

#include <JmsCommon.h>
#include <JmsTypes.h>

/*!
  A throwable handle that represents the class java.lang.Throwable
  */
typedef struct JavaThrowable JavaThrowable;

/*!
  An exception handle that represents the class java.lang.Exception
  */
typedef JavaThrowable JavaException;

/*!
  A JMS exception handle that represents the class javax.jms.JMSException
  */
typedef JavaException JmsException;

#define JMS_LOWEST_EXCEPTION_SUBCLASS 2

/*!
  Will be set if a throwable handle is of type java.lang.Exception
  */
#define ISA_JAVA_EXCEPTION (1 << 0)
/*!
  Will be set if an exception handle is of type javax.jms.JMSException
  */
#define ISA_JMS_EXCEPTION (1 << 1)
/*!
  Will be set if a JMS exception handle is of type javax.jms.IllegalStateException
  */
#define ISA_JMS_ILLEGAL_STATE (1 << (JMS_LOWEST_EXCEPTION_SUBCLASS + 0))
/*!
  Will be set if a JMS exception handle is of type javax.jms.IllegalStateException
  */
#define ISA_JMS_INVALID_CLIENT_ID (1 << (JMS_LOWEST_EXCEPTION_SUBCLASS + 1))
/*!
  Will be set if a JMS exception handle is of type javax.jms.InvalidDestinationException
  */
#define ISA_JMS_INVALID_DESTINATION (1 << (JMS_LOWEST_EXCEPTION_SUBCLASS + 2))
/*!
  Will be set if a JMS exception handle is of type javax.jms.InvalidSelectorException
  */
#define ISA_JMS_INVALID_SELECTOR (1 << (JMS_LOWEST_EXCEPTION_SUBCLASS + 3))
/*!
  Will be set if a JMS exception handle is of type javax.jms.JMSSecurityException
  */
#define ISA_JMS_JMS_SECURITY (1 << (JMS_LOWEST_EXCEPTION_SUBCLASS + 4))
/*!
  Will be set if a JMS exception handle is of type javax.jms.MessageEOFException
  */
#define ISA_JMS_MESSAGE_EOF (1 << (JMS_LOWEST_EXCEPTION_SUBCLASS + 5))
/*!
  Will be set if a JMS exception handle is of type javax.jms.MessageFormatException
  */
#define ISA_JMS_MESSAGE_FORMAT (1 << (JMS_LOWEST_EXCEPTION_SUBCLASS + 6))
/*!
  Will be set if a JMS exception handle is of type javax.jms.MessageNotReadableException
  */
#define ISA_JMS_MESSAGE_NOT_READABLE (1 << (JMS_LOWEST_EXCEPTION_SUBCLASS + 7))
/*!
  Will be set if a JMS exception handle is of type javax.jms.MessageNotWriteableException
  */
#define ISA_JMS_MESSAGE_NOT_WRITEABLE (1 << (JMS_LOWEST_EXCEPTION_SUBCLASS + 8))
/*!
  Will be set if a JMS exception handle is of type javax.jms.ResourceAllocationException
  */
#define ISA_JMS_RESOURCE_ALLOCATION (1 << (JMS_LOWEST_EXCEPTION_SUBCLASS + 9))
/*!
  Will be set if a JMS exception handle is of type javax.jms.TransactionInProgressException
  */
#define ISA_JMS_TRANSACTION_IN_PROGRESS (1 << (JMS_LOWEST_EXCEPTION_SUBCLASS + 10))
/*!
  Will be set if a JMS exception handle is of type javax.jms.TransactionRolledBackException
  */
#define ISA_JMS_TRANSACTION_ROLLED_BACK (1 << (JMS_LOWEST_EXCEPTION_SUBCLASS + 11))

/*!
  Do not clear the exception on the thread, only look at it
  */
#define JMS_PEEK_ONLY (JMS64I) 0x0000000000000001  

#ifdef __cplusplus
extern "C" {
#endif /* __cplusplus */

/*!
  Gets the last exception that occurred on the calling thread
  \param exception May not be NULL.  On success, *exception will contain a valid
  throwable handle.  If JMS_PEEK_ONLY was set in flags then the exception is
  not cleared from the thread and the caller should not destroy the handle.  If
  JMS_PEEK_ONLY is clear then the exception on this thread has been cleared and
  the returned exception handle must be freed by the caller
  \param type May not be NULL.  On success, *type will contain the type of
  throwable handle that was returned.  See the description of the defines
  starting with ISA in this file for more details on the possible types returned
  \param flags Can be set to JMS_PEEK_ONLY if the caller only wants to see
  what exception occurred on this thread without clearing the exception
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
    - JMS_NEED_SPACE
  */
extern int JMSENTRY JmsGetLastException(
  JavaThrowable **exception,
  int *type,
  JMS64I flags
);

/*!
  Gets the message associated with the throwable handle
  \param exception Must be a valid throwable handle.  May not be NULL
  \param message May not be NULL.  On success will contain the message
  associated with this throwable handle
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
    - JMS_NEED_SPACE
  */
extern int JMSENTRY JmsThrowableGetMessage(
  JavaThrowable      * exception,
  JmsString        * message,
  JMS64I              flags
);

/*!
  Gets the error code associated with the JMS exception handle
  \param exception Must be a valid JMS exception handle.  May not be NULL
  \param errorCode May not be NULL.  On success will contain the error Code
  associated with this JMS exception handle
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
    - JMS_NEED_SPACE
  */
extern int JMSENTRY JmsExceptionGetErrorCode(
  JmsException *exception,
  JmsString *errorCode,
  JMS64I              flags
);

/*!
  Gets the throwable handle associated with this JMS exception handle
  \param exception Must be a valid JMS exception handle.  May not be NULL
  \param linkedException May not be NULL.  On success *linkedException will contain
  the throwable handle associated with this JMS exception handle
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
    - JMS_NEED_SPACE
  */
extern int JMSENTRY JmsExceptionGetLinkedException(
  JmsException *exception,
  JavaException **linkedException,
  JMS64I              flags
);

/*!
  Destroys the given throwable handle.  After a call to this function the
  throwable handle is invalid and should not be referenced
  \param exception Must be a valid throwable handle.  May not be NULL
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
    - JMS_NEED_SPACE
  */
extern int JMSENTRY JmsExceptionDestroy(
    JavaThrowable *exception,
    JMS64I              flags
 );

#ifdef __cplusplus
}
#endif /* __cplusplus */
#endif /* _JMS_EXCEPTION_H */

