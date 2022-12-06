/*! \file JmsProducer.h
    \brief Describes a JmsProducer handle
    
    This file describes the functions that can be performed on a JmsProducer handle
    A JmsProducer handle corresponds to javax.jms.MessageProducer
    \author Copyright (c) 2002, BEA Systems, Inc.
*/


#ifndef _JMS_PRODUCER_H
#define _JMS_PRODUCER_H 1

#include <JmsCommon.h>
#include <JmsDestination.h>
#include <JmsMessage.h>
#include <JmsTypes.h>

/*!
  A producer handle that represents the class javax.jms.MessageProducer
  */
typedef struct JmsProducer JmsProducer;

/*!
  This structure is used to indicate production options
  */
typedef struct {
  /*!
    flags tells which options have been set.  Valid flags are defined using the
    JMS_PO_... defines
    */
  JMS32I           flags;
  /*!
    The destination to send this message to if JMS_PO_DESTINATION is set in flags
    */
  JmsDestination * destination;
  /*!
    The delivery mode to use with this message if JMS_PO_DELIVERY_MODE is set in flags
    */
  int              deliveryMode;
  /*!
    The priority that should be used with this message if JMS_PO_PRIORITY is set in flags
    */
  int              priority;
  /*!
    The time to live for this message if JMS_PO_TIMETOLIVE has been set in flags
    */
  JMS64I           timeToLive;
} JmsProducerOptions;

/*!
  Indicates that no message id need be generated for this message
  */
#define JMS_PO_NOMESSAGEID   (1 << 0)
/*!
  Indicates that no timestamp need be generated for this message
  */
#define JMS_PO_NOTIMESTAMP   (1 << 1)
/*!
  Indicates that the destination field of the JmsProducerOptions structure has been set
  */
#define JMS_PO_DESTINATION   (1 << 2)
/*!
  Indicates that the deliveryMode field of the JmsProducerOptions structure has been set
  */
#define JMS_PO_DELIVERY_MODE (1 << 3)
/*!
  Indicates that the priority field of the JmsProducerOptions structure has been set
  */
#define JMS_PO_PRIORITY      (1 << 4)
/*!
  Indicates that the timeToLive field of the JmsProducerOptions structure has been set
  */
#define JMS_PO_TIMETOLIVE    (1 << 5)

#ifdef __cplusplus
extern "C" {
#endif /* __cplusplus */

/*!
  Closes the message producer.
  \par
  Since a provider may allocate some resources on behalf of a producer handle
  outside the Java virtual machine, clients should close them when they are not
  needed. Relying on garbage collection to eventually reclaim these resources
  may not be timely enough.
  \par
  After a call to this function the producer handle is no longer valid and
  should not be referenced
  \param producer Must be a valid producer handle.  May not be NULL
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsProducerClose(
  JmsProducer * producer,
  JMS64I              flags
);

/*!
  Sends a message to a destination
  \param producer Must be a valid producer handle.  May not be NULL
  \param options The options to use with this send.  If NULL, default
  options are used
  \param message The message to send.  Must be a valid message handle,
  may not be NULL
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsProducerSend(
  JmsProducer        * producer,
  JmsProducerOptions * options,
  JmsMessage         * message,
  JMS64I              flags
);

#ifdef __cplusplus
}
#endif /* __cplusplus */
#endif /* _JMS_PRODUCER_H */

