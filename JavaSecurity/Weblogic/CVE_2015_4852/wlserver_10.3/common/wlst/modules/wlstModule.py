"""
This is WLST Module that a user can import into other Jython Modules
@author Satya Ghattu
Copyright (c) 2004 by BEA Systems, Inc. All Rights Reserved.
Copyright (c) 2008,2009 Oracle and/or its affiliates. All rights reserved.  

WARNING: This file is part of the WLST implementation and as such may
change between versions of WLST. You should not try to reuse the logic
in this script or keep copies of this script. Doing so could cause
your WLST scripts to fail when you upgrade to a different version of
WLST.

"""
from weblogic.management.scripting.utils import WLSTUtil
import sys
origPrompt = sys.ps1
theInterpreter = WLSTUtil.ensureInterpreter();
WLSTUtil.ensureWLCtx(theInterpreter)
execfile(WLSTUtil.getWLSTScriptPath())
execfile(WLSTUtil.getOfflineWLSTScriptPath())
exec(WLSTUtil.getOfflineWLSTScriptForModule())
execfile(WLSTUtil.getWLSTCommonModulePath())
theInterpreter = None
sys.ps1 = origPrompt
modules = WLSTUtil.getWLSTModules()
for mods in modules:
  execfile(mods.getAbsolutePath())
wlstPrompt = "false"  

