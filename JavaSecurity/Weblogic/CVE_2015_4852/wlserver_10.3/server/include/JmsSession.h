/*! \file JmsSession.h
    \brief Describes a JmsSession handle
    
    This file describes the functions that can be performed on a JmsSession handle
    A JmsSession handle corresponds to javax.jms.Session
    \author Copyright (c) 2002, BEA Systems, Inc.
*/

#ifndef _JMS_SESSION_H
#define _JMS_SESSION_H 1

#include <JmsCommon.h>
#include <JmsBrowser.h>
#include <JmsConsumer.h>
#include <JmsDestination.h>
#include <JmsProducer.h>
#include <JmsQueue.h>
#include <JmsTopic.h>
#include <JmsTypes.h>

/*!
  The session's acknowledge mode is transacted
  */
#define SESSION_TRANSACTED  0
/*!
  The session's acknowledge mode is auto-acknowledge
  */
#define AUTO_ACKNOWLEDGE    1
/*!
  The session's acknowledge mode is client controlled
  */
#define CLIENT_ACKNOWLEDGE  2
/*!
  The session's acknowledge mode is duplicates ok
  */
#define DUPS_OK_ACKNOWLEDGE 3

/*!
  A session handle that represents the class javax.jms.Session
  */
typedef struct JmsSession JmsSession;

#ifdef __cplusplus
extern "C" {
#endif /* __cplusplus */

/*!
  Tells whether or not a session handle is transacted
  \param session Must be a valid session handle.  May not be NULL
  \param transacted May not be NULL.  On success, *transacted will be
  zero if the session is not transacted and non-zero if the session is
  transacted
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsSessionGetTransacted(
  JmsSession      * session,
  int             * transacted,
  JMS64I              flags
);

/*!
  Returns the acknowledge mode of the session
  \param session Must be a valid session handle.  May not be NULL
  \param acknowledgeMode May not be NULL.  On success, *acknowledgeMode
  will be set to the acknowledge mode of the session
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsSessionGetAcknowledgeMode(
  JmsSession      * session,
  int             * acknowledgeMode,
  JMS64I              flags
);

/*!
  Commits all messages done in this transaction and releases any locks
  currently held
  \param session Must be a valid session handle.  May not be NULL
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsSessionCommit(
  JmsSession      * session,
  JMS64I              flags
);

/*!
  Rolls back any messages done in this transaction and releases any
  locks currently held
  \param session Must be a valid session handle.  May not be NULL
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsSessionRollback(
  JmsSession      * session,
  JMS64I              flags
);

/*!
  Closes the session.
  \par
  Since a provider may allocate some resources on behalf of a session outside
  the JVM, clients should close the resources when they are not needed.
  Relying on garbage collection to eventually reclaim these resources may
  not be timely enough.
  \par
  Unlike in java, the producers and consumers of a closed session
  must be explicitly closed.
  \par
  This call will block until a receive call or message listener in progress has
  completed. A blocked message consumer receive call returns null when this
  session is closed.
  \par
  Closing a transacted session must roll back the transaction in progress. 
  \par
  This method is the only Session method that can be called concurrently.
  \par
  Invoking any other Session method on a closed session has undefined
  behaviour.  Closing a closed session also has undefined behaviour.  This
  behaviour is different from the Java behavior.
  \par
  After a call to this function the session handle is no longer valid and
  should not be referenced
  \param session Must be a valid session handle.  May not be NULL
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsSessionClose(
  JmsSession      * session,
  JMS64I              flags
);

/*!
  Stops message delivery in this session, and restarts message delivery with the
  oldest unacknowledged message.
  \par
  All consumers deliver messages in a serial order. Acknowledging a received
  message automatically acknowledges all messages that have been delivered
  to the client.
  \par
  Restarting a session causes it to take the following actions: 
  - Stop message delivery
  - Mark all messages that might have been delivered but not acknowledged as "redelivered" 
  - Restart the delivery sequence including all unacknowledged messages that had
  been previously delivered. Redelivered messages do not have to be delivered in exactly
  their original delivery order. 
  \param session Must be a valid session handle.  May not be NULL
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsSessionRecover(
  JmsSession      * session,
  JMS64I              flags
);

/*!
  Creates a valid producer handle for the given destination from
  the given session handle
  \param session Must be a valid session handle.  May not be NULL
  \param destination Must be a valid destination handle.  May not be NULL
  \param producer May not be NULL.  On success, *producer will contain
  a valid producer handle
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsSessionCreateProducer(
  JmsSession      * session,
  JmsDestination  * destination,
  JmsProducer    ** producer,
  JMS64I              flags
);

/*!
  Creates a valid consumer handle for the given destination from
  the given session handle
  \param session Must be a valid session handle.  May not be NULL
  \param destination Must be a valid destination handle.  May not be NULL
  \param selector The selector to use when receiving messages from this
  destination.  If NULL, all messages from the destination are selected
  \param noLocal if non zero, and the destination is a topic, inhibits the
  delivery of messages published by its own connection. The behavior for
  noLocal is not specified if the destination is a queue.
  \param consumer May not be NULL.  On success, *consumer will contain
  a valid consumer handle
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsSessionCreateConsumer(
  JmsSession      * session,
  JmsDestination  * destination,
  JmsString       * selector,
  int               noLocal,
  JmsConsumer    ** consumer,
  JMS64I              flags
);

/*!
  Creates a valid consumer handle for the given topic from
  the given session handle.  The subscription created is durable
  \param session Must be a valid session handle.  May not be NULL
  \param topic Must be a valid topic handle.  May not be NULL
  \param name The name of the durable subscription
  \param selector The selector to use when receiving messages from this
  topic.  If NULL, all messages from the destination are selected
  \param noLocal if non zero inhibits the delivery of messages published by its
  own connection
  \param consumer May not be NULL.  On success, *consumer will contain
  a valid consumer handle
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsSessionCreateDurableSubscriber(
  JmsSession      * session,
  JmsTopic        * topic,
  JmsString       * name,
  JmsString       * selector,
  int               noLocal,
  JmsConsumer    ** consumer,
  JMS64I              flags
);

/*!
  Creates a valid browser handle for the given queue from
  the given session handle
  \param session Must be a valid session handle.  May not be NULL
  \param queue Must be a valid topic handle.  May not be NULL
  \param selector The selector to use when receiving messages from this
  queue.  If NULL, all messages from the destination are selected
  \param browser May not be NULL.  On success, *browser will contain
  a valid browser handle
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsSessionCreateBrowser(
  JmsSession      * session,
  JmsQueue        * queue,
  JmsString       * selector,
  JmsBrowser     ** browser,
  JMS64I              flags
);

/*!
  Destroys a durable subscription with the given name
  \param session Must be a valid session handle.  May not be NULL
  \param name The name of the subscription to destroy.  May not be NULL
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsSessionUnsubscribe(
  JmsSession      * session,
  JmsString       * name,
  JMS64I              flags
);

/*!
  Creates a temporary queue from the given session
  \param session Must be a valid session handle.  May not be NULL
  \param queue May not be NULL.  On success, *queue will contain
  a valid queue handle
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsSessionCreateTemporaryQueue(
  JmsSession  * connection,
  JmsQueue      ** queue,
  JMS64I              flags
);

/*!
  Creates a temporary topic from the given session
  \param session Must be a valid session handle.  May not be NULL
  \param topic May not be NULL.  On success, *queue will contain
  a valid topic handle
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsSessionCreateTemporaryTopic(
  JmsSession  * connection,
  JmsTopic      ** topic,
  JMS64I              flags
);

#ifdef __cplusplus
}
#endif /* __cplusplus */
#endif /* _JMS_SESSION_H */

