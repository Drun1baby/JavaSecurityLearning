/*! \file JmsTextMessage.h
    \brief Describes a JmsTextMessage handle
    
    This file describes the functions that can be performed on a JmsTextMessage handle
    A JmsTextMessage handle corresponds to javax.jms.TextMessage
    \author Copyright (c) 2002, BEA Systems, Inc.
*/

#ifndef _JMS_TEXT_MESSAGE_H
#define _JMS_TEXT_MESSAGE_H 1

#include <JmsCommon.h>
#include <JmsSession.h>
#include <JmsMessage.h>
#include <JmsTypes.h>

/*!
  A text message handle that represents the class javax.jms.TextMessage
  */
typedef JmsMessage JmsTextMessage;

#ifdef __cplusplus
extern "C" {
#endif

/*!
  Gets a text message handle from the given session handle
  \param session Must be a valid session handle.  May not be NULL
  \param text The text to use for this text message handle.  If NULL then
  no text is associated with the handle
  \param message May not be NULL.  On success, *message will contain
  a valid text message handle
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsSessionTextMessageCreate(
  JmsSession          *  session,
  JmsString            *  text,
  JmsTextMessage  ** message,
  JMS64I              flags
);

/*!
  Sets the text of a text message handle
  \param message Must be a valid text message handle.  May not be NULL
  \param text The text to use for this text message handle.  May not be NULL
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsTextMessageSetText(
  JmsTextMessage  * message,
  JmsString       * text,
  JMS64I              flags
);

/*!
  Gets the text of a text message handle
  \param message Must be a valid text message handle.  May not be NULL
  \param text May not be NULL.  On success will contain the
  text of the text message handle
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
    - JMS_NEED_SPACE
  */
extern int JMSENTRY JmsTextMessageGetText(
  JmsTextMessage  * message,
  JmsString       * text,
  JMS64I              flags
);

#ifdef __cplusplus
}
#endif /* __cplusplus */
#endif /* _JMS_TEXT_MESSAGE_H */
