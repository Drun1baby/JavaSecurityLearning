/*! \file JmsMessage.h
    \brief Describes a JmsMessage handle
    
    This file describes the functions that can be performed on a JmsMessage handle
    A JmsMessage handle corresponds to javax.jms.Message
    \author Copyright (c) 2002, BEA Systems, Inc.
*/

#ifndef _JMS_MESSAGE_H
#define _JMS_MESSAGE_H 1

/*!
  A message handle that represents the class javax.jms.Message
  */
typedef struct JmsMessage JmsMessage;

#include <limits.h>
#include <JmsCommon.h>
#include <JmsEnumeration.h>
#include <JmsDestination.h>
#include <JmsTypes.h>

/*!
  A message has a non-persistent quality of service
  */
#define JMS_NON_PERSISTENT 1
/*!
  A message has a persistent quality of service
  */
#define JMS_PERSISTENT 2

/*!
  The default delivery mode, which is persistent
  */
#define JMS_DEFAULT_DELIVERY_MODE JMS_PERSISTENT
/*!
  The default priority
  */
#define JMS_DEFAULT_PRIORITY 4
/*!
  The default time to live
  */
#define JMS_DEFAULT_TIME_TO_LIVE 0

/*!
  The message subclass is unknown
  */
#define JMS_UNKNOWN_SUBCLASS -1
/*!
  The message subclass is javax.jms.TextMessage, the handle is JmsTextMessage
  */
#define JMS_TEXT_MESSAGE 0
/*!
  The message subclass is javax.jms.BytesMessage, the handle is JmsBytesMessage
  */
#define JMS_BYTES_MESSAGE 1
/*!
  The message subclass is javax.jms.StreamMessage, the handle is JmsStreamMessage
  */
#define JMS_STREAM_MESSAGE 2
/*!
  The message subclass is javax.jms.MapMessage, the handle is JmsMapMessage
  */
#define JMS_MAP_MESSAGE 3
/*!
  The message subclass is javax.jms.ObjectMessage
  */
#define JMS_OBJECT_MESSAGE 4

#ifdef __cplusplus
extern "C" {
#endif /* __cplusplus */

/*!
  Gets the subclass of the given message handle
  \param message Must be a valid message handle.  May not be NULL
  \param subclass May not be NULL.  On success, *subclass will contain
  - JMS_UNKNOWN_SUBCLASS
  - JMS_TEXT_MESSAGE
  - JMS_BYTES_MESSAGE
  - JMS_STREAM_MESSAGE
  - JMS_MAP_MESSAGE
  - JMS_OBJECT_MESSAGE
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsMessageGetSubclass(
  JmsMessage *message,
  int *subclass,
  JMS64I              flags
);

/*!
  Acknowledges all consumed messages of the session of this consumed message.
  \par
  All consumed JMS messages support the acknowledge method for use when a client
  has specified that its JMS session's consumed messages are to be explicitly acknowledged.
  By invoking acknowledge on a consumed message, a client acknowledges all messages
  consumed by the session that the message was delivered to.
  \par
  Calls to acknowledge are ignored for both transacted sessions and sessions specified to use
  implicit acknowledgement modes. 
  \par
  A client may individually acknowledge each message as it is consumed, or it may choose to
  acknowledge messages as an application-defined group (which is done by calling acknowledge
  on the last received message of the group, thereby acknowledging all messages consumed by
  the session.)
  \par
  Messages that have been received but not acknowledged may be redelivered.
  \param message Must be a valid message handle.  May not be NULL
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsMessageAcknowledge(
  JmsMessage *message,
  JMS64I              flags
);

/*!
  Gets the message ID.
  \par
  The JMSMessageID header field contains a value that uniquely identifies each message sent by a
  provider. 
  \par
  When a message is sent, JMSMessageID can be ignored. When the send method returns, it
  contains a provider-assigned value. 
  \par
  A JMSMessageID is a String value that should function as a unique key for identifying messages
  in a historical repository. The exact scope of uniqueness is provider-defined. It should at least
  cover all messages for a specific installation of a provider, where an installation is some
  connected set of message routers.
  \par
  All JMSMessageID values must start with the prefix 'ID:'. Uniqueness of message ID values
  across different providers is not required. 
  \par
  Since message IDs take some effort to create and increase a message's size, some JMS
  providers may be able to optimize message overhead if they are given a hint that the message
  ID is not used by an application. By calling the MessageProducer.setDisableMessageID method,
  a JMS client enables this potential optimization for all messages sent by that message producer.
  If the JMS provider accepts this hint, these messages must have the message ID set to null;
  if the provider ignores the hint, the message ID must be set to its normal unique value.
  \param message Must be a valid message handle.  May not be NULL
  \param messageId May not be NULL.  On success will contain the message identifier
  of the message
  \param flags Reserved for future use.  Must be zero
   \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
    - JMS_NEED_SPACE
  */
extern int JMSENTRY JmsMessageGetMessageId(
  JmsMessage      * message,
  JmsString       * messageId,
  JMS64I              flags
);

/*!
  Gets the message timestamp.
  \par
  The JMSTimestamp header field contains the time a message was handed off to a provider to
  be sent. It is not the time the message was actually transmitted, because the actual send
  may occur later due to transactions or other client-side queueing of messages.
  \par
  When a message is sent, JMSTimestamp is ignored. When the send or publish method returns,
  it contains a time value somewhere in the interval between the call and the return. The value
  is in the format of a normal millis time value in the Java programming language. 
  \par
  Since timestamps take some effort to create and increase a message's size, some JMS
  providers may be able to optimize message overhead if they are given a hint that the
  timestamp is not used by an application. By calling the
  MessageProducer.setDisableMessageTimestamp method, a JMS client enables this potential
  optimization for all messages sent by that message producer. If the JMS provider accepts
  this hint, these messages must have the timestamp set to zero; if the provider ignores the
  hint, the timestamp must be set to its normal value.
  \param message Must be a valid message handle.  May not be NULL
  \param timestamp May not be NULL.  On success will contain the timestamp
  of the message
  \param flags Reserved for future use.  Must be zero
   \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsMessageGetTimestamp(
  JmsMessage      * message,
  JMS64I          * timestamp,
  JMS64I              flags
);

/*!
  Gets the correlation ID for the message.
  \par
  This method is used to return correlation ID values that are either
  provider-specific message IDs or application-specific String values.
  \param message Must be a valid message handle.  May not be NULL
  \param correlationId May not be NULL.  On success will contain the correlation id
  of the message
  \param flags Reserved for future use.  Must be zero
   \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
    - JMS_NEED_SPACE
  */
extern int JMSENTRY JmsMessageGetCorrelationId(
  JmsMessage      * message,
  JmsString       * correlationId,
  JMS64I              flags
);

/*!
  Sets the correlation ID for the message.
  \par
  A client can use the JMSCorrelationID header field to link one message with another. A typical
  use is to link a response message with its request message. 
  \par
  JMSCorrelationID can hold one of the following:
  - A provider-specific message ID
  - An application-specific String
  - A provider-native byte[] value
  \par
  Since each message sent by a JMS provider is assigned a message
  ID value, it is convenient to link messages via message ID. All message
  ID values must start with the 'ID:' prefix.
  \par
  In some cases, an application (made up of several clients) needs
  to use an application-specific value for linking messages. For instance,
  an application may use JMSCorrelationID to hold a value referencing some
  external information.  Application-specified values must not start with the
  'ID:' prefix; this is reserved for provider-generated message ID values. 
  \par
  If a provider supports the native concept of correlation ID, a JMS client
  may need to assign specific JMSCorrelationID values to match those expected
  by clients that do not use the JMS API. A byte[] value is used for this purpose.
  JMS providers without native correlation ID values are not required to support
  byte[] values. The use of a byte[] value for JMSCorrelationID is non-portable.
  \param message Must be a valid message handle.  May not be NULL
  \param correlationId The correlation id to set on the message. May not be NULL
  \param flags Reserved for future use.  Must be zero
   \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsMessageSetCorrelationId(
  JmsMessage      * message,
  JmsString       * correlationId,
  JMS64I              flags
);

/*!
  Gets the JmsDestination handle to which a reply to this message should be sent.
  \param message Must be a valid message handle.  May not be NULL
  \param destination May not be NULL.  On success, *destination will contain
  a valid destination handle to which a reply to this message should be sent
  \param flags Reserved for future use.  Must be zero
   \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsMessageGetReplyTo(
  JmsMessage      * message,
  JmsDestination ** destination,
  JMS64I              flags
);

/*!
  Sets the JmsDestination handle to which a reply to this message should be sent.
  \param message Must be a valid message handle.  May not be NULL
  \param destination Must be a valid destination handle, which represents the
  destination to which a reply to this message should be sent
  \param flags Reserved for future use.  Must be zero
   \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsMessageSetReplyTo(
  JmsMessage      * message,
  JmsDestination  * destination,
  JMS64I              flags
);

/*!
  Gets the Destination object for this message.
  \par
  The JMSDestination header field contains the destination to which the
  message is being sent. 
  \par
  When a message is sent, this field is ignored. After completion of the
  send or publish method, the field holds the destination specified by the
  method. 
  \par
  When a message is received, its JMSDestination value must be equivalent
  to the value assigned when it was sent.
  \param message Must be a valid message handle.  May not be NULL
  \param destination May not be NULL.  On success, *destination will contain
  a valid destination handle
  \param flags Reserved for future use.  Must be zero
   \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsMessageGetDestination(
  JmsMessage      * message,
  JmsDestination ** destination,
  JMS64I              flags
);

/*!
  Sets the Destination object for this message.
  \par
  JMS providers set this field when a message is sent. This method can be
  used to change the value for a message that has been received.
  \param message Must be a valid message handle.  May not be NULL
  \param destination Must contain a valid destination handle.
  \param flags Reserved for future use.  Must be zero
   \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsMessageSetDestination(
  JmsMessage      * message,
  JmsDestination  * destination,
  JMS64I              flags
);

/*!
  Gets the delivery mode of this message handle
  \param message Must be a valid message handle.  May not be NULL
  \param deliveryMode May not be NULL.  On success, *deliveryMode will
  have one of the following values:
  - JMS_NON_PERSISTENT
  - JMS_PERSISTENT
  \param flags Reserved for future use.  Must be zero
   \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsMessageGetDeliveryMode(
  JmsMessage      * message,
  int             * deliveryMode,
  JMS64I              flags
);

/*!
  Gets the redelivered attribute of this message handle
  \param message Must be a valid message handle.  May not be NULL
  \param redelivered May not be NULL.  On success, *redelivered will
  be zero if this message has not been redelivered, and non zero if
  the message has been redelivered
  \param flags Reserved for future use.  Must be zero
   \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsMessageGetRedelivered(
  JmsMessage      * message,
  int          * redelivered,
  JMS64I              flags
);

/*!
  Sets the message type.
  \par
  Some JMS providers use a message repository that contains the
  definitions of messages sent by applications. The JMSType header
  field may reference a message's definition in the provider's repository. 
  \par
  The JMS API does not define a standard message definition repository,
  nor does it define a naming policy for the definitions it contains. 
  \par
  Some messaging systems require that a message type definition for each
  application message be created and that each message specify its type. In
  order to work with such JMS providers, JMS clients should assign a value to
  JMSType, whether the application makes use of it or not. This ensures that
  the field is properly set for those providers that require it.
  \par
  To ensure portability, JMS clients should use symbolic values for JMSType
  that can be configured at installation time to the values defined in the current
  provider's message repository. If string literals are used, they may not be valid
  type names for some JMS providers.
  \param message Must be a valid message handle.  May not be NULL
  \param type Must contain the type to set on the message.  May not be NULL
  \param flags Reserved for future use.  Must be zero
   \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsMessageSetType(
  JmsMessage      * message,
  JmsString       * type,
  JMS64I              flags
);

/*!
  Gets the message type identifier supplied by the client when the message was sent.
  \param message Must be a valid message handle.  May not be NULL
  \param type May not be NULL.  On success, will
  contain the type identifier supplied by the clietn when the message was sent
  \param flags Reserved for future use.  Must be zero
   \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsMessageGetType(
  JmsMessage      * message,
  JmsString      * type,
  JMS64I              flags
);

/*!
  Gets the message's expiration value.
  \par
  When a message is sent, the JMSExpiration header field is left unassigned.
  After completion of the send or publish method, it holds the expiration time
  of the message. This is the sum of the time-to-live value specified by the
  client and the GMT at the time of the send or publish.
  \par
  If the time-to-live is specified as zero, JMSExpiration is set to zero to indicate
  that the message does not expire. 
  \par
  When a message's expiration time is reached, a provider should discard it. The
  JMS API does not define any form of notification of message expiration. 
  \par
  Clients should not receive messages that have expired; however, the JMS API
  does not guarantee that this will not happen.
  \param message Must be a valid message handle.  May not be NULL
  \param expiration May not be NULL.  On success, will
  contain the expiration time of the message
  \param flags Reserved for future use.  Must be zero
   \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsMessageGetExpiration(
  JmsMessage      * message,
  JMS64I          * expiration,
  JMS64I              flags
);

/*!
  Gets the message priority level.
  \par
  The JMS API defines ten levels of priority value, with 0 as the lowest
  priority and 9 as the highest. In addition, clients should consider priorities
  0-4 as gradations of normal priority and priorities 5-9 as gradations
  of expedited priority. 
  \par
  The JMS API does not require that a provider strictly implement priority
  ordering of messages; however, it should do its best to deliver expedited
  messages ahead of normal messages.
  \param message Must be a valid message handle.  May not be NULL
  \param priority May not be NULL.  On success, *priority will
  contain the priority of the message
  \param flags Reserved for future use.  Must be zero
   \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsMessageGetPriority(
  JmsMessage      * message,
  int             * priority,
  JMS64I              flags
);

/*!
  Clears a message's properties.
  \par
  The message's header fields and body are not cleared.
  \param message Must be a valid message handle.  May not be NULL
  \param flags Reserved for future use.  Must be zero
   \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsMessageClearProperties(
  JmsMessage      * message,
  JMS64I              flags
);

/*!
  Determines whether a property of a given name exists on a message
  \param message Must be a valid message handle.  May not be NULL
  \param name The name of the property to check.  May not be NULL
  \param exists May not be NULL.  On success, *exists will contain zero
  if the property does not exists and non-zero if the property does
  exist
  \param flags Reserved for future use.  Must be zero
   \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsMessagePropertyExists(
  JmsMessage      * message,
  JmsString       * name,
  int                  * exists,
  JMS64I              flags
);

/*!
  Gets an enumeration handle containing the names of all the properties
  on this message handle
  \param message Must be a valid map message handle.  May not be NULL
  \param enumeration May not be NULL.  On success, *enumeration will
  contain a valid enumeration handle.  The value parameter of
  JmsEnumerationNextElement should be a JmsString ** with this enumeration.
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsMessageGetPropertyNames(
  JmsMessage      * message,
  JmsEnumeration ** enumeration,
  JMS64I              flags
);

/*!
  Gets the boolean property of the given name on the given message
  \param message Must be a valid map message handle.  May not be NULL
  \param name The name of the property to retrieve.  May not be NULL
  \param value May not be NULL.  On success, *value will contain the
  boolean value of the property
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsMessageGetBooleanProperty(
  JmsMessage      * message,
  JmsString       * name,
  int               * value,
  JMS64I              flags
);

/*!
  Sets a boolean property with the given name on the given message
  \param message Must be a valid map message handle.  May not be NULL
  \param name The name of the property to set.  May not be NULL
  \param value The boolean value to set
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsMessageSetBooleanProperty(
  JmsMessage      * message,
  JmsString       * name,
  int               value,
  JMS64I              flags
);

/*!
  Gets the byte property of the given name on the given message
  \param message Must be a valid map message handle.  May not be NULL
  \param name The name of the property to retrieve.  May not be NULL
  \param value May not be NULL.  On success, *value will contain the
  byte value of the property
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsMessageGetByteProperty(
  JmsMessage      * message,
  JmsString       * name,
  unsigned char            * value,
  JMS64I              flags
);

/*!
  Sets a byte property with the given name on the given message
  \param message Must be a valid map message handle.  May not be NULL
  \param name The name of the property to set.  May not be NULL
  \param value The byte value to set
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsMessageSetByteProperty(
  JmsMessage      * message,
  JmsString       * name,
  unsigned char              value,
  JMS64I              flags
);

/*!
  Gets the short property of the given name on the given message
  \param message Must be a valid map message handle.  May not be NULL
  \param name The name of the property to retrieve.  May not be NULL
  \param value May not be NULL.  On success, *value will contain the
  short value of the property
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsMessageGetShortProperty(
  JmsMessage      * message,
  JmsString       * name,
  short           * value,
  JMS64I              flags
);

/*!
  Sets a short property with the given name on the given message
  \param message Must be a valid map message handle.  May not be NULL
  \param name The name of the property to set.  May not be NULL
  \param value The short value to set
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsMessageSetShortProperty(
  JmsMessage      * message,
  JmsString       * name,
  short             value,
  JMS64I              flags
);

/*!
  Gets the integer property of the given name on the given message
  \param message Must be a valid map message handle.  May not be NULL
  \param name The name of the property to retrieve.  May not be NULL
  \param value May not be NULL.  On success, *value will contain the
  integer value of the property
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsMessageGetIntProperty(
  JmsMessage      * message,
  JmsString       * name,
  JMS32I          * value,
  JMS64I              flags
);

/*!
  Sets an integer property with the given name on the given message
  \param message Must be a valid map message handle.  May not be NULL
  \param name The name of the property to set.  May not be NULL
  \param value The integer value to set
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsMessageSetIntProperty(
  JmsMessage      * message,
  JmsString       * name,
  JMS32I            value,
  JMS64I              flags
);

/*!
  Gets the long property of the given name on the given message
  \param message Must be a valid map message handle.  May not be NULL
  \param name The name of the property to retrieve.  May not be NULL
  \param value May not be NULL.  On success, *value will contain the
  long value of the property
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsMessageGetLongProperty(
  JmsMessage      * message,
  JmsString       * name,
  JMS64I          * value,
  JMS64I              flags
);

/*!
  Sets a long property with the given name on the given message
  \param message Must be a valid map message handle.  May not be NULL
  \param name The name of the property to set.  May not be NULL
  \param value The long value to set
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsMessageSetLongProperty(
  JmsMessage      * message,
  JmsString       * name,
  JMS64I            value,
  JMS64I              flags
);

/*!
  Gets the float property of the given name on the given message
  \param message Must be a valid map message handle.  May not be NULL
  \param name The name of the property to retrieve.  May not be NULL
  \param value May not be NULL.  On success, *value will contain the
  float value of the property
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsMessageGetFloatProperty(
  JmsMessage      * message,
  JmsString       * name,
  float           * value,
  JMS64I              flags
);

/*!
  Sets a float property with the given name on the given message
  \param message Must be a valid map message handle.  May not be NULL
  \param name The name of the property to set.  May not be NULL
  \param value The float value to set
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsMessageSetFloatProperty(
  JmsMessage      * message,
  JmsString       * name,
  float             value,
  JMS64I              flags
);

/*!
  Gets the double property of the given name on the given message
  \param message Must be a valid map message handle.  May not be NULL
  \param name The name of the property to retrieve.  May not be NULL
  \param value May not be NULL.  On success, *value will contain the
  double value of the property
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsMessageGetDoubleProperty(
  JmsMessage      * message,
  JmsString       * name,
  double          * value,
  JMS64I              flags
);

/*!
  Sets a double property with the given name on the given message
  \param message Must be a valid map message handle.  May not be NULL
  \param name The name of the property to set.  May not be NULL
  \param value The double value to set
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsMessageSetDoubleProperty(
  JmsMessage      * message,
  JmsString       * name,
  double            value,
  JMS64I              flags
);

/*!
  Gets the string property of the given name on the given message
  \param message Must be a valid map message handle.  May not be NULL
  \param name The name of the property to retrieve.  May not be NULL
  \param value May not be NULL.  On success will contain the
  string value of the property
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
    - JMS_NEED_SPACE
  */
extern int JMSENTRY JmsMessageGetStringProperty(
  JmsMessage      * message,
  JmsString       * name,
  JmsString       * value,
  JMS64I              flags
);

/*!
  Sets a string property with the given name on the given message
  \param message Must be a valid map message handle.  May not be NULL
  \param name The name of the property to set.  May not be NULL
  \param value The string value to set
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsMessageSetStringProperty(
  JmsMessage      * message,
  JmsString       * name,
  JmsString       * value,
  JMS64I              flags
);

/*!
  Clears out the message body. Clearing a message's body does not
  clear its header values or property entries.
  \par
  If this message body was read-only, calling this method leaves the
  message body in the same state as an empty body in a newly
  created message.
  \param message Must be a valid map message handle.  May not be NULL
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsMessageClearBody(
  JmsMessage      * message,
  JMS64I              flags
);

/*!
  Destroys the message.  After a call to this function the message
  handle is no longer valid and should not be referenced
  \param message Must be a valid message handle.  May not be NULL
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsMessageDestroy(
  JmsMessage       *message,
  JMS64I              flags
);

#ifdef __cplusplus
}
#endif /* __cplusplus */
#endif /* _JMS_MESSAGE_H */
