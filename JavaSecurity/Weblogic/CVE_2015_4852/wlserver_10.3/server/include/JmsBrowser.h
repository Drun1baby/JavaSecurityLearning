/*! \file JmsBrowser.h
    \brief Describes a JmsBrowser handle
    \author Copyright (c) 2002, BEA Systems, Inc.
    This file describes the functions that can be performed on a JmsBrower handle
    A JmsBrowser handle corresponds to javax.jms.QueueBrowser
*/
#ifndef _JMS_BROWSER_H
#define _JMS_BROWSER_H 1

/*!
  A browser handler that represents the class javax.jms.QueueBrowser
  */
typedef struct JmsBrowser JmsBrowser;

#include <JmsCommon.h>
#include <JmsEnumeration.h>
#include <JmsQueue.h>
#include <JmsTypes.h>

#ifdef __cplusplus
extern "C" {
#endif

/*!
  Gets the queue associated with a JmsBrowser
  \param browser Must be a valid browser handle.  May not be NULL
  \param queue May not be NULL.  On success *queue will contain a
    valid JmsQueue handle
  \param flags Reserved for future use.  Must be zero.
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsBrowserGetQueue(
  JmsBrowser      * browser,
  JmsQueue       ** queue,
  JMS64I              flags
);

/*!
  Gets the selector associated with a JmsBrowser
  \param browser Must be a valid browser handle.  May not be NULL
  \param selector May not be NULL.  On success will contain
  the selector associated with this browser
  \param flags Reserved for future use.  Must be zero.
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
    - JMS_NEED_SPACE
  */
extern int JMSENTRY JmsBrowserGetSelector(
  JmsBrowser      * browser,
  JmsString         * selector,
  JMS64I              flags
);

/*!
  Gets an enumeration handle that can be used to retrieve the messages on the queue
  \param browser Must be a valid browser handle.  May not be NULL
  \param enumeration May not be NULL.  On success will contain a valid
  JmsEnumeration handle.  The value parameter of JmsEnumerationNextElement
  should be a JmsMessage ** with this enumeration.
  \param flags Reserved for future use.  Must be zero.
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */  
extern int JMSENTRY JmsBrowserGetEnumeration(
  JmsBrowser      * browser,
  JmsEnumeration ** enumeration,
  JMS64I              flags
);

/*!
  Closes and destroys a browser handle.
  Closes and destroys a browser handle.  After a call to this function the
  browser is no longer valid and should no longer be referenced
  \param browser Must be a valid browser handle.  May not be NULL
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */  
extern int JMSENTRY JmsBrowserClose(
  JmsBrowser      * browser,
  JMS64I              flags
);

#ifdef __cplusplus
}
#endif /* __cplusplus */
#endif /* _JMS_BROWSER_H */


