#include "vacuum_thermalApp.h"
#include "Moose.h"
#include "AppFactory.h"
#include "ModulesApp.h"
#include "MooseSyntax.h"

InputParameters
vacuum_thermalApp::validParams()
{
  InputParameters params = MooseApp::validParams();

  return params;
}

vacuum_thermalApp::vacuum_thermalApp(InputParameters parameters) : MooseApp(parameters)
{
  vacuum_thermalApp::registerAll(_factory, _action_factory, _syntax);
}

vacuum_thermalApp::~vacuum_thermalApp() {}

void
vacuum_thermalApp::registerAll(Factory & f, ActionFactory & af, Syntax & syntax)
{
  ModulesApp::registerAll(f, af, syntax);
  Registry::registerObjectsTo(f, {"vacuum_thermalApp"});
  Registry::registerActionsTo(af, {"vacuum_thermalApp"});

  /* register custom execute flags, action syntax, etc. here */
}

void
vacuum_thermalApp::registerApps()
{
  registerApp(vacuum_thermalApp);
}

/***************************************************************************************************
 *********************** Dynamic Library Entry Points - DO NOT MODIFY ******************************
 **************************************************************************************************/
extern "C" void
vacuum_thermalApp__registerAll(Factory & f, ActionFactory & af, Syntax & s)
{
  vacuum_thermalApp::registerAll(f, af, s);
}
extern "C" void
vacuum_thermalApp__registerApps()
{
  vacuum_thermalApp::registerApps();
}
