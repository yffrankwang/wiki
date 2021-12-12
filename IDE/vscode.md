### VSCode Maven error `The compiler compliance specified is 1.7 but a JRE 13 is used`

modify pom.xml as follows:
```
<build>
	<pluginManagement>
		<plugins>
			<plugin>
				<groupId>org.apache.maven.plugins</groupId>
				<artifactId>maven-compiler-plugin</artifactId>
				<version>3.8.1</version>
			</plugin>
		</plugins>
	</pluginManagement>
</build>
```
