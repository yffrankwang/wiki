mvn eclipse:eclipse -DdownloadSources=true -DdownloadJavadocs=true
mvn antrun:run@build -Dant.target=usage
