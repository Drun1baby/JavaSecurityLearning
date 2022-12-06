/*! \file JmsMetaData.h
    \brief Describes a JmsMetaData handle
    
    This file describes the functions that can be performed on a JmsMetaData handle
    A JmsMetaData handle corresponds to javax.jms.MetaData
    \author Copyright (c) 2002, BEA Systems, Inc.
*/


#ifndef _JMS_METADATA_H
#define _JMS_METADATA_H 1

#include <JmsCommon.h>
#include <JmsTypes.h>

/*!
  A message handle that represents the class javax.jms.MetaData
  */
typedef struct JmsMetaData JmsMetaData;

#ifdef __cplusplus
extern "C" {
#endif /* __cplusplus */

/*!
  Destroys the meta data handle.  After a call to this function the meta data
  handle is no longer valid and should not be referenced
  \param metaData Must be a valid metaData handle.  May not be NULL
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsMetaDataDestroy(
  JmsMetaData  * metaData,
  JMS64I              flags
);

/*!
  Gets the version of JMS this connection supports as a string
  \param metaData Must be a valid metaData handle.  May not be NULL
  \param versionString May not be NULL.  On success will contain the
  JMS version as a string
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
    - JMS_NEED_SPACE
  */
extern int JMSENTRY JmsMetaDataGetJMSVersion(
  JmsMetaData  * metaData,
  JmsString   * versionString,
  JMS64I              flags
);

/*!
  Gets the major version of JMS this connection supports
  \param metaData Must be a valid metaData handle.  May not be NULL
  \param versionMajor May not be NULL.  On success, *versionMajor will
  contain the JMS major version
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsMetaDataGetJMSVersionMajor(
  JmsMetaData  * metaData,
  int         * versionMajor,
  JMS64I              flags
);

/*!
  Gets the minor version of JMS this connection supports
  \param metaData Must be a valid metaData handle.  May not be NULL
  \param versionMinor May not be NULL.  On success, *versionMinor will
  contain the JMS minor version
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsMetaDataGetJMSVersionMinor(
  JmsMetaData  * metaData,
  int         * versionMinor,
  JMS64I              flags
);

/*!
  Gets the name of the JMS Provider from the meta data handle
  \param metaData Must be a valid metaData handle.  May not be NULL
  \param name May not be NULL.  On success will contain the name of the
  JMS provider
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
    - JMS_NEED_SPACE
  */
extern int JMSENTRY JmsMetaDataGetProviderName(
  JmsMetaData  * metaData,
  JmsString   * name,
  JMS64I              flags
);

/*!
  Gets the provider version of JMS this connection supports as a string
  \param metaData Must be a valid metaData handle.  May not be NULL
  \param versionString May not be NULL.  On success will contain the
  provider version as a string
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
    - JMS_NEED_SPACE
  */
extern int JMSENTRY JmsMetaDataGetVersion(
  JmsMetaData  * metaData,
  JmsString   * versionString,
  JMS64I              flags
);

/*!
  Gets the major version of the provider from the meta data handle
  \param metaData Must be a valid metaData handle.  May not be NULL
  \param versionMajor May not be NULL.  On success, *versionMajor will
  contain the provider's major version
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsMetaDataGetVersionMajor(
  JmsMetaData  * metaData,
  int         * versionMajor,
  JMS64I              flags
);

/*!
  Gets the minor version of the provider from the meta data handle
  \param metaData Must be a valid metaData handle.  May not be NULL
  \param versionMinor May not be NULL.  On success, *versionMinor will
  contain the provider's minor version
  \param flags Reserved for future use.  Must be zero
  \return
    - JMS_NO_ERROR
    - JMS_GOT_EXCEPTION
    - JMS_INPUT_PARAM_ERROR
    - JMS_MALLOC_ERROR
    - JMS_JVM_ERROR
  */
extern int JMSENTRY JmsMetaDataGetVersionMinor(
  JmsMetaData  * metaData,
  int         * versionMinor,
  JMS64I              flags
);

#ifdef __cplusplus
}
#endif /* __cplusplus */
#endif /* _METADATA_H */

