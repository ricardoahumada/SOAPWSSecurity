
echo "-> Creating Alice's keystore..."
"%JAVA_HOME%/bin/keytool" -genkey -keyalg RSA -alias alice -validity 360  -keystore alice.jks -storepass qx4zE7na  -keypass qx4zE7na  -dname "CN=Alice Demo, O=SGR"

# Generate client certificate
echo "-> Creating Bobs's keystore..."
"%JAVA_HOME%/bin/keytool" -genkey -keyalg RSA -alias bob -validity 360  -keystore bob.jks -storepass qx4zE7na  -keypass qx4zE7na  -dname "CN=Bob Demo, O=SGR"

# Generate server certificate
echo "-> Creating the Server's keystore..."
"%JAVA_HOME%/bin/keytool" -genkey -keyalg RSA -alias server -validity 3600  -keystore server.jks -storepass qx4zE7na  -keypass qx4zE7na  -dname "CN=Server Demo, O=SGR"

# -------------------

echo "-> Importing alice into server..."

"%JAVA_HOME%/bin/keytool" -export -keystore alice.jks -alias alice  -storepass qx4zE7na -file alice.cert

"%JAVA_HOME%/bin/keytool" -import -keystore server.jks -alias alice  -storepass qx4zE7na -file alice.cert

# --------------------

echo "-> Importing bob into server..."

"%JAVA_HOME%/bin/keytool" -export -keystore bob.jks -alias bob  -storepass qx4zE7na -file bob.cert

"%JAVA_HOME%/bin/keytool" -import -keystore server.jks -alias bob  -storepass qx4zE7na -file bob.cert

# --------------------

echo "-> Importing server into clients..."

"%JAVA_HOME%/bin/keytool" -export -keystore server.jks -alias server  -storepass qx4zE7na -file server.cert

"%JAVA_HOME%/bin/keytool" -import -keystore alice.jks -alias server  -storepass qx4zE7na -file server.cert

"%JAVA_HOME%/bin/keytool" -import -keystore bob.jks -alias server  -storepass qx4zE7na -file server.cert

# --------------------

echo "-> Importing alice into bob...."

"%JAVA_HOME%/bin/keytool" -import -keystore bob.jks -alias alice  -storepass qx4zE7na -file alice.cert

echo "-> Importing bob into alice..."

"%JAVA_HOME%/bin/keytool" -import -keystore alice.jks -alias bob  -storepass qx4zE7na -file bob.cert


# --------------------

echo "-> Muestra almacen alice y bob...."

"%JAVA_HOME%/bin/keytool" -list -keystore alice.jks
"%JAVA_HOME%/bin/keytool" -list -keystore bob.jks