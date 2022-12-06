/*! \file JmsConsumer.h
    \brief Describes a JmsConsumer handle
        
    This file describes the functions that can be performed on a JmsConsumer handle
    A JmsConsumer handle corresponds to javax.jms.MessageConsumer
    \author Copyright (c) 2002, BEA Systems, Inc.
*/

#ifndef _JMS_CONSUMER_H
#define _JMS_CONSUMER_H 1

#include <JmsCommon.h>
#include <JmsCommon.h>
#include <JmsMessage.h>
#include <JmsTypes.h>

/*!
  A consumer handle that represents the class javax.jms.MessageConsumer
  */
typedef struct JmsConsumer JmsConsumer;

#ifdef __cplusplus
extern "C" {
#endif /* __cplusplus */

/*!
  Gets the selector associated with a JmsConsumer
  \param consumer Must be a valid consumer handle.  May not be NULL
  \param selector May not be NULL
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
    - JMS_NEED_SPACE
  */
extern int JMSENTRY JmsConsumerGetSelector(
  JmsConsumer  * consumer,
  JmsString    * selector,
  JMS64I              flags
);

/*!
  Gets a the message listener function associated with this consumer
  \param consumer Must be a valid connection handle.  May not be NULL
  \param listener May not be NULL.  On success *listener will contain the
    message listener function
  \param argument May not be NULL.  On success *argument will contain
    the application supplied argument used for this consumer
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsConsumerGetMessageListener(
  JmsConsumer  * consumer,
  void           (** listener)(JmsMessage *, void *, JMS64I),
  void           **argument,
  JMS64I              flags
);

/*!
  Sets a message listener function associated with this consumer
  The message passed into the listener function is destroyed by the
  system after the listener function returns.  Hence the message should not be
  freed by the listener function and should not be referenced after the
  listener function returns
  \param consumer Must be a valid consumer handle.  May not be NULL
  \param listener The function that should be called in the event a message
  arrives for this consumer.  The message passed into the function will
  normally be freed by the system when the function returns (see flags).  The
  second parameter will be the argument passed to this function.
  \param argument An optional argument that can be passed to this message
  listener function when called by the system.  This argument can be used
  for any purpose by the application.
  \param flags JMS_APPLICATION_MUST_FREE_HANDLE should be set if the
  message handle given to the listener function should not be freed by the system
  when the function returns.  The flags value (plus the
  JMS_CALLED_FROM_JMS flag) will be passed to the listener function as
  its flags input parameter on every invokation.
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsConsumerSetMessageListener(
  JmsConsumer  * consumer,
  void         (* listener)(JmsMessage *, void *, JMS64I),
  void         *argument,
  JMS64I              flags
);

/*!
  Gets a message for this consumer
  \param consumer Must be a valid consumer handle.  May not be NULL
  \param timeout The time in milliseconds to wait for a message
  \param message May not be NULL.  On success *message will contain a valid
    message handle.  It is the responsibility of the caller of this function to
    destroy the message returned
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
    - JMS_NEED_SPACE
  */
extern int JMSENTRY JmsConsumerReceive(
  JmsConsumer  * consumer,
  JMS64I         timeout,
  JmsMessage **message,
  JMS64I              flags
);

/*!
  Closes the message consumer.
  \par
  Since a provider may allocate some resources on behalf of a consumer handle
  outside the Java virtual machine, clients should close them when they are not
  needed. Relying on garbage collection to eventually reclaim these resources
  may not be timely enough. 
  \par
  This call blocks until a receive or message listener in progress has completed. A blocked
  message consumer receive call returns null when this message consumer is closed.
  \param consumer Must be a valid consumer handle.  May not be NULL
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
    - JMS_NEED_SPACE
  */
extern int JMSENTRY JmsConsumerClose(
  JmsConsumer  * consumer,
  JMS64I              flags
);

#ifdef __cplusplus
}
#endif /* __cplusplus */
#endif /* _JMS_CONSUMER_H */
