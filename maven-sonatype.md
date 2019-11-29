Maven Central Repository に公開手順
====================================

Maven Central Repository に自分が作成したライブラリを公開しました。
公式の手順に参考してやっていましたが、幾つかのところにエラーが発生しましたので、ここで手順を書きます。

### 参考
* https://central.sonatype.org/pages/ossrh-guide.html
* https://central.sonatype.org/pages/apache-maven.html
* https://dzone.com/articles/publish-your-artifacts-to-maven-central

## sonatypeのJIRAアカウントを作成
https://issues.sonatype.org/secure/Signup!default.jspa

## 新しいProjectを作成するissueを新規登録する
https://issues.sonatype.org/secure/CreateIssue.jspa?issuetype=21&pid=10134
* summary: New Project for xxx
* description: Projectの説明（適当）
* Group Id: 例：com.github.pandafw
* Project URL: 例：　https://github.com/pandafw/panda
* SCM URL: 例：例：　https://github.com/pandafw/panda.git

Group Idが独自ドメインの場合、domainの所有権を認証するらしいです。自分の場合、com.github.pandafwを入れたので、すぐ承認されました。

## GNU PGをインストールする
jarファイルなどをMaven Central に公開するには、gpg signが必要なので、GNU PGをインストールします。

https://www.gnupg.org/download/
Windows PCなので、https://www.gnupg.org/ftp/gcrypt/binary/gnupg-w32-2.2.12_20181214.exe
をインストールしました。

```bat
C:\Develop\Tools\gnupg\bin>gpg --version
gpg (GnuPG) 2.2.12
libgcrypt 1.8.4
Copyright (C) 2018 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <https://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.

Home: C:/Users/Ryoma/AppData/Roaming/gnupg
Supported algorithms:
Pubkey: RSA, ELG, DSA, ECDH, ECDSA, EDDSA
Cipher: IDEA, 3DES, CAST5, BLOWFISH, AES, AES192, AES256, TWOFISH,
        CAMELLIA128, CAMELLIA192, CAMELLIA256
Hash: SHA1, RIPEMD160, SHA256, SHA384, SHA512, SHA224
Compression: Uncompressed, ZIP, ZLIB, BZIP2
```

## GPU PGでKeyを作成する

```bat
C:\Develop\Tools\gnupg\bin>gpg --full-gen-key
gpg (GnuPG) 2.2.12; Copyright (C) 2018 Free Software Foundation, Inc.
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.

Please select what kind of key you want:
   (1) RSA and RSA (default)
   (2) DSA and Elgamal
   (3) DSA (sign only)
   (4) RSA (sign only)
Your selection? 1
RSA keys may be between 1024 and 4096 bits long.
What keysize do you want? (2048)
Requested keysize is 2048 bits
Please specify how long the key should be valid.
         0 = key does not expire
      <n>  = key expires in n days
      <n>w = key expires in n weeks
      <n>m = key expires in n months
      <n>y = key expires in n years
Key is valid for? (0)
Key does not expire at all
Is this correct? (y/N) y
GnuPG needs to construct a user ID to identify your key.
Real name: Ryoma Kimura
Email address: ryoma.kimura@gmail.com
Comment:
You selected this USER-ID:
    "Ryoma Kimura <ryoma.kimura@gmail.com>"
Change (N)ame, (C)omment, (E)mail or (O)kay/(Q)uit? o
We need to generate a lot of random bytes. It is a good idea to perform
some other action (type on the keyboard, move the mouse, utilize the
disks) during the prime generation; this gives the random number
generator a better chance to gain enough entropy.
We need to generate a lot of random bytes. It is a good idea to perform
some other action (type on the keyboard, move the mouse, utilize the
disks) during the prime generation; this gives the random number
generator a better chance to gain enough entropy.
gpg: C:/Users/Ryoma/AppData/Roaming/gnupg/trustdb.gpg: trustdb created
gpg: key 27835B3BD2A2061F marked as ultimately trusted
gpg: directory 'C:/Users/Ryoma/AppData/Roaming/gnupg/openpgp-revocs.d' created
gpg: revocation certificate stored as 'C:/Users/Ryoma/AppData/Roaming/gnupg/openpgp-revocs.d\5694AA563793429557F1727835B3BD2A223A.rev'
public and secret key created and signed.
pub   rsa2048 2019-02-11 [SC]
      5694AA563793429557F1727835B3BD2A223A
uid                      Ryoma Kimura <ryoma.kimura@gmail.com>
sub   rsa2048 2019-02-11 [E]
```

passphraseを入力する。
![image.png](https://qiita-image-store.s3.amazonaws.com/0/348218/703a2d32-b5de-ff75-5ea2-422f9a6e4435.png)


## GPU PGでKeyを公開する

```bat
C:\Develop\Tools\gnupg\bin>gpg –-send-keys [KEY_ID]
```
[KEY ID]は前の手順で生成した5694AA563793429557F1727835B3BD2A223Aを入力する。


## pom.xml にdistributionManagement を追加する

```xml
<distributionManagement>
	<snapshotRepository>
		<id>ossrh</id>
		<url>https://oss.sonatype.org/content/repositories/snapshots</url>
	</snapshotRepository>
	<repository>
		<id>ossrh</id>
		<url>https://oss.sonatype.org/service/local/staging/deploy/maven2/</url>
	</repository>
</distributionManagement>
```

## pom.xml にgpg sign と deploy plugin を追加する

```xml
<!-- sonatype release -->
<plugin>
	<groupId>org.sonatype.plugins</groupId>
	<artifactId>nexus-staging-maven-plugin</artifactId>
	<version>1.6.8</version>
	<extensions>true</extensions>
	<configuration>
		<serverId>ossrh</serverId>
		<nexusUrl>https://oss.sonatype.org/</nexusUrl>
		<autoReleaseAfterClose>true</autoReleaseAfterClose>
	</configuration>
</plugin>

<!-- gpg sign -->
<plugin>
	<groupId>org.apache.maven.plugins</groupId>
	<artifactId>maven-gpg-plugin</artifactId>
	<version>1.6</version>
	<executions>
		<execution>
			<id>sign-artifacts</id>
			<phase>verify</phase>
			<goals>
				<goal>sign</goal>
			</goals>
		</execution>
	</executions>
</plugin>
```

## pom.xml にscm情報を追加する。

```xml
<scm>
	<connection>scm:git:https://github.com/pandafw/panda.git</connection>
	<developerConnection>scm:git:https://github.com/pandafw/panda.git</developerConnection>
	<url>https://github.com/pandafw/panda</url>
</scm>
```

## pom.xml にjavadoc, attach-sources pluginを追加する。

```xml
<plugin>
  <groupId>org.apache.maven.plugins</groupId>
  <artifactId>maven-source-plugin</artifactId>
  <version>2.2.1</version>
  <executions>
	<execution>
	  <id>attach-sources</id>
	  <goals>
		<goal>jar-no-fork</goal>
	  </goals>
	</execution>
  </executions>
</plugin>
<plugin>
  <groupId>org.apache.maven.plugins</groupId>
  <artifactId>maven-javadoc-plugin</artifactId>
  <version>2.9.1</version>
  <executions>
	<execution>
	  <id>attach-javadocs</id>
	  <goals>
		<goal>jar</goal>
	  </goals>
	</execution>
  </executions>
</plugin>
```

## Maven settings.xml にossrh server情報を追加する。
settings.xml のディフォルトパスは C:\Users\Ryoma\.m2\settings.xml

```xml
<servers>
	<server>
		<id>ossrh</id>
		<username>your-jira-id</username>
		<password>your-jira-password</password>
	</server>
</servers>
```

## Maven settings.xml にgpg passphraseを追加する。

```xml
<profiles>
	<profile>
		<id>ossrh</id>
		<activation>
			<activeByDefault>true</activeByDefault>
		</activation>
		<properties>
			<gpg.executable>gpg</gpg.executable>
			<gpg.passphrase>[your_gpg_passphrase]</gpg.passphrase>
		</properties>
	</profile>
</profiles>
```

## リリースする
```bat
mvn clean deploy
```

## ossrhにログインして、Staging Repositoriesの情報を確認する。
https://oss.sonatype.org/

![image.png](https://qiita-image-store.s3.amazonaws.com/0/348218/87a560ae-2b2b-d839-89d0-d55bf95684f7.png)

問題がない場合、[Close]ボタンを押して、Closeします。
Close処理で、いろいろチェックされるので、チェックが通らない場合、エラーマークに付くので、[Activity]タブでエラー情報を確認できます。
自分の場合、設定ミスで、gpg signしていないエラーやgpg keyをサーバーから取得できないエラーがあったので、エラーがあるrepositoryを[Drop]して、設定を直して、再度mvn clean deployでリリースします。


## 最後はReleaseする。
アップロードしたrepositoryをちゃんとClose出来たら、[Release]ボタンをクリックして、リリースできます。
大体2, 3時間後に、https://search.maven.org
に反映されます。

