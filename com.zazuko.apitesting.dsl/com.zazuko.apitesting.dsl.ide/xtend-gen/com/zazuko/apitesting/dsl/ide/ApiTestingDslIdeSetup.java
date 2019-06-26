/**
 * generated by Xtext 2.17.0
 */
package com.zazuko.apitesting.dsl.ide;

import com.google.inject.Guice;
import com.google.inject.Injector;
import com.zazuko.apitesting.dsl.ApiTestingDslRuntimeModule;
import com.zazuko.apitesting.dsl.ApiTestingDslStandaloneSetup;
import com.zazuko.apitesting.dsl.ide.ApiTestingDslIdeModule;
import org.eclipse.xtext.util.Modules2;

/**
 * Initialization support for running Xtext languages as language servers.
 */
@SuppressWarnings("all")
public class ApiTestingDslIdeSetup extends ApiTestingDslStandaloneSetup {
  @Override
  public Injector createInjector() {
    ApiTestingDslRuntimeModule _apiTestingDslRuntimeModule = new ApiTestingDslRuntimeModule();
    ApiTestingDslIdeModule _apiTestingDslIdeModule = new ApiTestingDslIdeModule();
    return Guice.createInjector(Modules2.mixin(_apiTestingDslRuntimeModule, _apiTestingDslIdeModule));
  }
}
