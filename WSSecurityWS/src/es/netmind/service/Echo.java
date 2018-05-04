package es.netmind.service;

import javax.annotation.Resource;
import javax.ejb.SessionContext;
import javax.jws.WebMethod;
import javax.jws.WebService;
import javax.jws.soap.SOAPBinding;

import org.apache.cxf.annotations.Policy;
import org.jboss.ws.api.annotation.EndpointConfig;

@WebService
@Policy(placement = Policy.Placement.BINDING, uri = "/Policy.xml")
@SOAPBinding(style = SOAPBinding.Style.DOCUMENT)
@EndpointConfig(configFile = "WEB-INF/jaxws-endpoint-config.xml", configName = "Custom WS-Security Endpoint")
public class Echo {
    @Resource SessionContext ctx;

    @WebMethod
    public String echo(String input) {
        return ctx.getCallerPrincipal() + " -> " +  input;
    }
}