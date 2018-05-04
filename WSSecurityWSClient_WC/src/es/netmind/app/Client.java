package es.netmind.app;

import java.net.URL;

import javax.xml.namespace.QName;
import javax.xml.ws.BindingProvider;
import javax.xml.ws.Service;

import org.apache.cxf.ws.security.SecurityConstants;

import es.netmind.service.Echo;

public class Client {

	public static void main(String[] args) {
		try {

			QName serviceName = new QName("http://service.netmind.es/", "EchoService");

			URL wsdlURL = new URL("http://localhost:8080/WSSecurityWS/Echo?wsdl");
			Service service = Service.create(wsdlURL, serviceName);
			Echo proxy = (Echo) service.getPort(Echo.class);

			((BindingProvider) proxy).getRequestContext().put(SecurityConstants.CALLBACK_HANDLER,
					new KeystorePasswordCallback());

			((BindingProvider) proxy).getRequestContext().put(SecurityConstants.SIGNATURE_PROPERTIES,
					Thread.currentThread().getContextClassLoader().getResource("alice.properties"));

			((BindingProvider) proxy).getRequestContext().put(SecurityConstants.ENCRYPT_PROPERTIES,
					Thread.currentThread().getContextClassLoader().getResource("alice.properties"));

			((BindingProvider) proxy).getRequestContext().put(SecurityConstants.SIGNATURE_USERNAME, "alice");
			((BindingProvider) proxy).getRequestContext().put(SecurityConstants.ENCRYPT_USERNAME, "bob");

			
			proxy.echo("Hola!");

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
