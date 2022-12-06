/*! \file JmsQueue.h
    \brief Describes a JmsQueue handle
    
    This file describes the functions that can be performed on a JmsQueue handle
    A JmsQueue handle corresponds to javax.jms.Queue
    \author Copyright (c) 2002, BEA Systems, Inc.
*/

#ifndef _JMS_QUEUE_H
#define _JMS_QUEUE_H 1

#include <JmsCommon.h>
#include <JmsTypes.h>
#include <JmsDestination.h>

/*!
  A queue handle that represents the class javax.jms.Queue
  */
typedef JmsDestination JmsQueue;

#ifdef __cplusplus
extern "C" {
#endif /* __cplusplus */

/*!
  Gets the name of this queue
  \param queue Must be a valid queue handle.  May not be NULL
  \param name May not be NULL.  On success will contain
  the name of this queue
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
    - JMS_NEED_SPACE
  */
extern int JMSENTRY JmsQueueGetName(
  JmsQueue   * queue,
  JmsString * name,
  JMS64I              flags
);

#ifdef __cplusplus
}
#endif /* __cplusplus */
#endif /* _JMS_QUEUE_H */
