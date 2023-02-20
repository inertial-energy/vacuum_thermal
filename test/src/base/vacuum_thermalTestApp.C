//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html
#include "vacuum_thermalTestApp.h"
#include "vacuum_thermalApp.h"
#include "Moose.h"
#include "AppFactory.h"
#include "MooseSyntax.h"
#include "ModulesApp.h"

InputParameters
vacuum_thermalTestApp::validParams()
{
  InputParameters params = vacuum_thermalApp::validParams();
  return params;
}

vacuum_thermalTestApp::vacuum_thermalTestApp(InputParameters parameters) : MooseApp(parameters)
{
  vacuum_thermalTestApp::registerAll(
      _factory, _action_factory, _syntax, getParam<bool>("allow_test_objects"));
}

vacuum_thermalTestApp::~vacuum_thermalTestApp() {}

void
vacuum_thermalTestApp::registerAll(Factory & f, ActionFactory & af, Syntax & s, bool use_test_objs)
{
  vacuum_thermalApp::registerAll(f, af, s);
  if (use_test_objs)
  {
    Registry::registerObjectsTo(f, {"vacuum_thermalTestApp"});
    Registry::registerActionsTo(af, {"vacuum_thermalTestApp"});
  }
}

void
vacuum_thermalTestApp::registerApps()
{
  registerApp(vacuum_thermalApp);
  registerApp(vacuum_thermalTestApp);
}

/***************************************************************************************************
 *********************** Dynamic Library Entry Points - DO NOT MODIFY ******************************
 **************************************************************************************************/
// External entry point for dynamic application loading
extern "C" void
vacuum_thermalTestApp__registerAll(Factory & f, ActionFactory & af, Syntax & s)
{
  vacuum_thermalTestApp::registerAll(f, af, s);
}
extern "C" void
vacuum_thermalTestApp__registerApps()
{
  vacuum_thermalTestApp::registerApps();
}
