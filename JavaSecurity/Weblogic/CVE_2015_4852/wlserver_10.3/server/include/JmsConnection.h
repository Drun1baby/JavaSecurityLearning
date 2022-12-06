/*! \file JmsConnection.h
    \brief Describes a JmsConnection handle
    \author Copyright (c) 2002, BEA Systems, Inc.
    This file describes the functions that can be performed on a JmsConnection handle
    A JmsConnection handle corresponds to javax.jms.Connection
*/

#ifndef _JMS_CONNECTION_H
#define _JMS_CONNECTION_H 1

#include <JmsCommon.h>
#include <JmsContext.h>
#include <JmsMetaData.h>
#include <JmsConnectionFactory.h>
#include <JmsSession.h>
#include <JmsTypes.h>

/*!
  A connection handle that represents the class javax.jms.Connection
  */
typedef struct JmsConnection JmsConnection;

#ifdef __cplusplus
extern "C" {
#endif /* __cplusplus */

/*!
  Gets a connection handle from a connection factory handle
  \param connectionFactory Must be a valid connection factory handle.  May not be NULL
  \param connection May not be NULL.  On success *connection will contain a
    valid JmsConnection handle
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsConnectionFactoryCreateConnection(
  JmsConnectionFactory   *connectionFactory,
  JmsConnection **connection,
  JMS64I              flags
);

/*!
  Gets a session handle from a connection handle
  \param connection Must be a valid connection handle.  May not be NULL
  \param transacted If not zero, this session will be transacted.  If zero, this session
    will not be transacted
  \param acknowledgeMode One of the following values <UL>
    <LI>AUTO_ACKNOWLEDGE Messages will be automatically acknoweldged
    <LI>CLIENT_ACKNOWLEDGE The user must explicitly acknowledge messages
    <LI>DUPS_OK_ACKNOWLEDGE Messages will be automatically acknowledged, and duplicate
      messages are allowable
    </UL>
  \param session May not be NULL.  On success *session will contain a
    valid JmsSession handle
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsConnectionCreateSession(
  JmsConnection  * connection,
  int              transacted,
  int              acknowledeMode,
  JmsSession    ** session,
  JMS64I              flags
);

/*!
  Gets the client identifier associated with this connection handle
  \param connection Must be a valid connection handle.  May not be NULL
  \param clientId Must not be NULL. On success will contain the client identifier
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsConnectionGetClientId(
  JmsConnection  * connection,
  JmsString     * clientId,
  JMS64I              flags
);

/*!
  Sets the client identifier associated with this connection handle
  \param connection Must be a valid connection handle.  May not be NULL
  \param clientId Must not be NULL.  The client identifier to set on this handle
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsConnectionSetClientId(
  JmsConnection  * connection,
  JmsString      * clientId,
  JMS64I              flags
);

/*!
  Gets a meta data handle associated with this connection
  \param connection Must be a valid connection handle.  May not be NULL
  \param metaData May not be NULL.  On success *metaData will contain a
    valid meta data handle
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsConnectionGetMetaData(
  JmsConnection  * connection,
  JmsMetaData   ** metaData,
  JMS64I              flags
);

/*!
  Gets a the exception listener function associated with this connection
  \param connection Must be a valid connection handle.  May not be NULL
  \param listener May not be NULL.  On success *listener will contain the
    exception listener function
  \param argument May not be NULL.  On success *argument will contain
    the application supplied argument used for this connection
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsConnectionGetExceptionListener(
  JmsConnection  * connection,
  void              (** listener)(JmsException *, void *, JMS64I),
  void              **argument,
  JMS64I              flags
);

/*!
  Sets an exception listener function associated with this connection
  The exception passed into the listener function is destroyed by the
  system.  Hence the exception should not be freed by the listener
  function and should not be referenced after the listener function
  returns
  \param connection Must be a valid connection handle.  May not be NULL
  \param listener The function that should be called in the event an exception
  happens on this connection.  The exception passed into the function will
  normally be freed by the system when the function returns (see flags).  The
  second argument to the function is an application defined argument.
  \param argument The argument to be passed as the second parameter to the
  exception listener.  The application can use this for any reason.
  \param flags JMS_APPLICATION_MUST_FREE_HANDLE should be set if the
  exception handle given to the listener function should not be freed by the system
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
extern int JMSENTRY JmsConnectionSetExceptionListener(
  JmsConnection  * connection,
  void           (* listener)(JmsException *, void *, JMS64I),
  void           *argument,
  JMS64I              flags
);

/*!
  Starts (or restarts) a connection's delivery of incoming messages. A call to start
  on a connection that has already been started is ignored
  \param connection Must be a valid connection handle.  May not be NULL
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsConnectionStart(
  JmsConnection  * connection,
  JMS64I              flags
);

/*!
  Temporarily stops a connection's delivery of incoming messages. Delivery can be restarted
  using the connection's start method. When the connection is stopped, delivery to all the
  connection's message consumers is inhibited: synchronous receives block, and messages
  are not delivered to message listeners.
  \par
  This call blocks until receives and/or message listeners in progress have completed.
  \par
  Stopping a connection has no effect on its ability to send messages. A call to stop on
  a connection that has already been stopped is ignored.
  \par
  A call to stop must not return until delivery of messages has paused. This means that a
  client can rely on the fact that none of its message listeners will be called and that all
  threads of control waiting for receive calls to return will not return with a message until the
  connection is restarted. The receive timers for a stopped connection continue to advance,
  so receives may time out while the connection is stopped. 
  \par
  If message listeners are running when stop is invoked, the stop call must wait until all of
  them have returned before it may return. While these message listeners are completing,
  they must have the full services of the connection available to them.
  \param connection Must be a valid connection handle.  May not be NULL
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsConnectionStop(
  JmsConnection  * connection,
  JMS64I              flags
);

/*!
  Closes the connection.
  \par
  Since a provider typically allocates significant resources outside the JVM on behalf of a
  connection, clients should close these resources when they are not needed. Relying on
  garbage collection to eventually reclaim these resources may not be timely enough.
  \par
  Unlike the java close,  all sessions, producers, and consumers of a closed connection must
  be closed explicitly in order to free up their handles.
  \par
  Closing a connection causes all temporary destinations to be deleted.  However, all temporary
  destinations must be explicitly closed in order to free up their handles.
  \par
  When this method is invoked, it should not return until message processing has been shut down
  in an orderly fashion. This means that all message listeners that may have been running have
  returned, and that all pending receives have returned. A close terminates all pending message
  receives on the connection's sessions' consumers. The receives may return with a message or
  with NULL, depending on whether there was a message available at the time of the close. If
  one or more of the connection's sessions' message listeners is processing a message at the time
  when connection close is invoked, all the facilities of the connection and its sessions must remain
  available to those listeners until they return control to the JMS provider.
  \par
  Closing a connection causes any of its sessions' transactions in progress to be rolled back. In
  the case where a session's work is coordinated by an external transaction manager, a session's
  commit and rollback methods are not used and the result of a closed session's work is
  determined later by the transaction manager. Closing a connection does NOT force an
  acknowledgment of client-acknowledged sessions. 
  \par
  Invoking the acknowledge method of a received message from a closed connection's session
  must throw an IllegalStateException. Closing a closed connection must NOT throw an
  exception.
  \param connection Must be a valid connection handle.  May not be NULL
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsConnectionClose(
  JmsConnection  * connection,
  JMS64I              flags
);

#ifdef __cplusplus
}
#endif /* __cplusplus */
#endif /* _JMS_CONNECTION_H */
