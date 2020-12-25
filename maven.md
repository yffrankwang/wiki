### download source javadoc

> mvn eclipse:eclipse -DdownloadSources=true -DdownloadJavadocs=true


### execute ant target

> mvn antrun:run@build -Dant.target=usage


### deploy file manually

> curl -v -u USERNAME:PASSWORD --upload-file xxx.pom      https://oss.sonatype.org/service/local/staging/deploy/maven2/XXX/YYY/ZZZ/artifactId/version/artifactId-version.pom
> curl -v -u USERNAME:PASSWORD --upload-file xxx.pom.asc  https://oss.sonatype.org/service/local/staging/deploy/maven2/XXX/YYY/ZZZ/artifactId/version/artifactId-version.pom.asc
> curl -v -u USERNAME:PASSWORD --upload-file xxx.pom.sha1 https://oss.sonatype.org/service/local/staging/deploy/maven2/XXX/YYY/ZZZ/artifactId/version/artifactId-version.pom.sha1


### Updating to latest Artifacts

An easy way to keep your projects up to date is to use the maven [Versions plugin][versions-plugin].

	mvn versions:display-plugin-updates
	mvn versions:display-dependency-updates
	mvn versions:use-latest-versions

Note - Be careful when changing `javax.servlet` as App Engine Standard uses 3.1 for Java 8, and 2.5 for Java 7.

Our usual process is to test, update the versions, then test again before committing back.

[plugin]: http://www.mojohaus.org/versions-maven-plugin/
