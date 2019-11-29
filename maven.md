### download source javadoc

> mvn eclipse:eclipse -DdownloadSources=true -DdownloadJavadocs=true


### execute ant target

> mvn antrun:run@build -Dant.target=usage


### deploy file manually

> curl -v -u USERNAME:PASSWORD --upload-file xxx.pom      https://oss.sonatype.org/service/local/staging/deploy/maven2/XXX/YYY/ZZZ/artifactId/version/artifactId-version.pom
> curl -v -u USERNAME:PASSWORD --upload-file xxx.pom.asc  https://oss.sonatype.org/service/local/staging/deploy/maven2/XXX/YYY/ZZZ/artifactId/version/artifactId-version.pom.asc
> curl -v -u USERNAME:PASSWORD --upload-file xxx.pom.sha1 https://oss.sonatype.org/service/local/staging/deploy/maven2/XXX/YYY/ZZZ/artifactId/version/artifactId-version.pom.sha1
