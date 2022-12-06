/*! \file JmsTopic.h
    \brief Describes a JmsQueue handle
    
    This file describes the functions that can be performed on a JmsTopic handle
    A JmsTopic handle corresponds to javax.jms.Topic
    \author Copyright (c) 2002, BEA Systems, Inc.
*/


#ifndef _JMS_TOPIC_H
#define _JMS_TOPIC_H 1

#include <JmsCommon.h>
#include <JmsTypes.h>
#include <JmsDestination.h>

/*!
  A topic handle that represents the class javax.jms.Topic
  */
typedef JmsDestination JmsTopic;

#ifdef __cplusplus
extern "C" {
#endif /* __cplusplus */

/*!
  Gets the name of this topic
  \param queue Must be a valid topic handle.  May not be NULL
  \param name May not be NULL.  On success will contain
  the name of this topic
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
    - JMS_NEED_SPACE
  */
extern int JMSENTRY JmsTopicGetName(
  JmsTopic    * topic,
  JmsString  * name,
  JMS64I              flags
);

#ifdef __cplusplus
}
#endif /* __cplusplus */
#endif /* _JMS_TOPIC_H */
