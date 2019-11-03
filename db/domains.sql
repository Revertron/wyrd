/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `domains` (
  `domain` varchar(100) NOT NULL,
  `owner` varchar(40) NOT NULL,
  `fallback` varchar(40) DEFAULT NULL,
  `legacy` tinyint(1) NOT NULL DEFAULT 0,
  `seen_first` bigint(12) NOT NULL DEFAULT 0,
  `seen_down_since` bigint(12) NOT NULL DEFAULT 0,
  `tags` varchar(100) DEFAULT NULL,
  `records` text DEFAULT NULL,
  UNIQUE KEY `domain` (`domain`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;
INSERT INTO `domains` VALUES ('blog.medium','21c:3148:d6:1d0e:da4a:dfe0:a129:9cf6',NULL,0,1572364588,0,NULL,'blog	3600	IN	AAAA	21c:3148:d6:1d0e:da4a:dfe0:a129:9cf6');
INSERT INTO `domains` VALUES ('cdnjs.ygg','',NULL,1,0,0,NULL,'cdnjs	IN	AAAA	300:5bf2:a7a5:27c7::77');
INSERT INTO `domains` VALUES ('chelyabinsk.ygg','201:9316:3c04:f29:d5aa:20a0:c5ee:bc0b',NULL,0,1572364588,0,NULL,'chelyabinsk	300	IN	AAAA	201:9316:3c04:f29:d5aa:20a0:c5ee:bc0b');
INSERT INTO `domains` VALUES ('disk.medium','21c:3148:d6:1d0e:da4a:dfe0:a129:9cf6',NULL,0,1572364588,0,NULL,'disk	3600	IN	AAAA	21c:3148:d6:1d0e:da4a:dfe0:a129:9cf6');
INSERT INTO `domains` VALUES ('dns.medium','21c:3148:d6:1d0e:da4a:dfe0:a129:9cf6',NULL,0,1572364588,0,NULL,'dns	300	IN	AAAA	21c:3148:d6:1d0e:da4a:dfe0:a129:9cf6');
INSERT INTO `domains` VALUES ('dns.ygg','201:2923::6d6:1df0:2970:d382',NULL,0,1572364588,0,NULL,'dns	300	IN	AAAA	201:2923::6d6:1df0:2970:d382\nns1.dns	300	IN	AAAA	201:2923::6d6:1df0:2970:d382\nns2.dns	300	IN	AAAA	201:2522::5736:9a6:7dd1:7c95');
INSERT INTO `domains` VALUES ('docs.medium','21c:3148:d6:1d0e:da4a:dfe0:a129:9cf6',NULL,0,1572364588,0,NULL,'docs	3600	IN	AAAA	21c:3148:d6:1d0e:da4a:dfe0:a129:9cf6');
INSERT INTO `domains` VALUES ('domains.ygg','200:149b::b722:fe09:d31:84a4',NULL,1,0,0,NULL,'domains	IN	AAAA	200:149b::b722:fe09:d31:84a4');
INSERT INTO `domains` VALUES ('find.medium','21c:3148:d6:1d0e:da4a:dfe0:a129:9cf6',NULL,0,1572364588,0,NULL,'find	3600	IN	AAAA	21c:3148:d6:1d0e:da4a:dfe0:a129:9cf6');
INSERT INTO `domains` VALUES ('forum-ru.ygg','200:529f:150c:eafe:4405:93fe:8d76:39cb',NULL,0,1572688265,0,NULL,'forum-ru	300	IN	AAAA	200:529f:150c:eafe:4405:93fe:8d76:39cb');
INSERT INTO `domains` VALUES ('fz.ygg','201:918e:f16:bd05:e1f4:7435:7182:42d5',NULL,1,0,0,NULL,'fz	IN	AAAA	201:918e:f16:bd05:e1f4:7435:7182:42d5\r\nirc.fz	IN	AAAA	201:918e:f16:bd05:e1f4:7435:7182:42d5');
INSERT INTO `domains` VALUES ('git.medium','21c:3148:d6:1d0e:da4a:dfe0:a129:9cf6',NULL,0,1572364588,0,NULL,'git	300	IN	AAAA	21c:3148:d6:1d0e:da4a:dfe0:a129:9cf6');
INSERT INTO `domains` VALUES ('gitlab.ygg','',NULL,1,0,0,NULL,'gitlab	IN	AAAA	304:4738:37c6:d295::5');
INSERT INTO `domains` VALUES ('go.medium','21c:3148:d6:1d0e:da4a:dfe0:a129:9cf6',NULL,0,1572364588,0,NULL,'go	3600	IN	AAAA	21c:3148:d6:1d0e:da4a:dfe0:a129:9cf6');
INSERT INTO `domains` VALUES ('host.medium','21c:3148:d6:1d0e:da4a:dfe0:a129:9cf6',NULL,0,1572364588,0,NULL,'host	3600	IN	AAAA	21c:3148:d6:1d0e:da4a:dfe0:a129:9cf6');
INSERT INTO `domains` VALUES ('humhub.ygg','200:1863::1447:c300:24cf:6a5e',NULL,1,0,0,NULL,'humhub	IN	AAAA	200:1863::1447:c300:24cf:6a5e');
INSERT INTO `domains` VALUES ('i2pd.ygg','304:4738:37c6:d295::1',NULL,1,0,0,NULL,'i2pd	IN	AAAA	304:4738:37c6:d295::1\r\ncloud.i2pd	IN	AAAA	304:4738:37c6:d295::2\r\noffice.cloud.i2pd	IN	AAAA	304:4738:37c6:d295::3\r\nrepo.i2pd	IN	AAAA	304:4738:37c6:d295::4');
INSERT INTO `domains` VALUES ('ipinfo.ygg','',NULL,1,0,0,NULL,'ipinfo	IN	AAAA	300:aa35:f9c1:dcce::2');
INSERT INTO `domains` VALUES ('join.medium','21c:3148:d6:1d0e:da4a:dfe0:a129:9cf6',NULL,0,1572364588,0,NULL,'join	3600	IN	AAAA	21c:3148:d6:1d0e:da4a:dfe0:a129:9cf6');
INSERT INTO `domains` VALUES ('lg.ygg','',NULL,1,0,0,NULL,'lg	IN	AAAA	300:5bf2:a7a5:27c7::4');
INSERT INTO `domains` VALUES ('link-directory.ygg','200:529f:150c:eafe:4405:93fe:8d76:39cb',NULL,0,1572688265,0,NULL,'link-directory	300	IN	AAAA	300:529f:150c:eafe::1');
INSERT INTO `domains` VALUES ('link.medium','21c:3148:d6:1d0e:da4a:dfe0:a129:9cf6',NULL,0,1572364588,0,NULL,'link	3600	IN	AAAA	21c:3148:d6:1d0e:da4a:dfe0:a129:9cf6');
INSERT INTO `domains` VALUES ('lxc-hosting.ygg','201:4541:2f84:1188:59ab:e8dd:48a8:d40c',NULL,1,0,0,NULL,'lxc-hosting	IN	AAAA	201:4541:2f84:1188:59ab:e8dd:48a8:d40c');
INSERT INTO `domains` VALUES ('mail.medium','21c:3148:d6:1d0e:da4a:dfe0:a129:9cf6',NULL,0,1572364588,0,NULL,'mail	3600	IN	AAAA	21c:3148:d6:1d0e:da4a:dfe0:a129:9cf6');
INSERT INTO `domains` VALUES ('map.ygg','21f:dd73:7cdb:773b:a924:7ec0:800b:221e',NULL,1,0,0,NULL,'map	IN	AAAA	21f:dd73:7cdb:773b:a924:7ec0:800b:221e');
INSERT INTO `domains` VALUES ('maps.medium','21c:3148:d6:1d0e:da4a:dfe0:a129:9cf6',NULL,0,1572364588,0,NULL,'maps	3600	IN	AAAA	21c:3148:d6:1d0e:da4a:dfe0:a129:9cf6');
INSERT INTO `domains` VALUES ('mesh.ygg','',NULL,1,0,0,NULL,'mesh	IN	AAAA	303:60d4:3d32:a2b9::4');
INSERT INTO `domains` VALUES ('meshirc.ygg','201:870:9573:4095:f4e6:dfde:cc68:c783',NULL,1,0,0,NULL,'meshirc	IN	AAAA	201:870:9573:4095:f4e6:dfde:cc68:c783');
INSERT INTO `domains` VALUES ('minecraft.ygg','202:baed:9808:83c8:738:4041:bd8b:8c1d',NULL,1,0,0,NULL,'minecraft	IN	AAAA	202:baed:9808:83c8:738:4041:bd8b:8c1d');
INSERT INTO `domains` VALUES ('minetest.ygg','200:362b:d038:d21e:4b2e:2f86:1936:e9e2',NULL,1,0,0,NULL,'minetest	IN	AAAA	200:362b:d038:d21e:4b2e:2f86:1936:e9e2');
INSERT INTO `domains` VALUES ('netwhood.ygg','202:12a9:e5:4474:d473:82be:16ac:9381',NULL,1,0,0,NULL,'netwhood	IN	AAAA	202:12a9:e5:4474:d473:82be:16ac:9381\r\ngit	IN	AAAA	202:12a9:e5:4474:d473:82be:16ac:9381');
INSERT INTO `domains` VALUES ('news.medium','21c:3148:d6:1d0e:da4a:dfe0:a129:9cf6',NULL,0,1572364588,0,NULL,'news	3600	IN	AAAA	21c:3148:d6:1d0e:da4a:dfe0:a129:9cf6');
INSERT INTO `domains` VALUES ('nextcloud.ygg','',NULL,1,0,0,NULL,'nextcloud	IN	AAAA	304:4738:37c6:d295::2\r\noffice	IN	AAAA	304:4738:37c6:d295::6');
INSERT INTO `domains` VALUES ('nic.medium','21c:3148:d6:1d0e:da4a:dfe0:a129:9cf6',NULL,0,1572364588,0,NULL,'nic	300	IN	AAAA	21c:3148:d6:1d0e:da4a:dfe0:a129:9cf6');
INSERT INTO `domains` VALUES ('nntp.ygg','201:3ac0:cdc2:126:656b:aca:8b23:9dc7',NULL,1,0,0,NULL,'nntp	IN	AAAA	201:3ac0:cdc2:126:656b:aca:8b23:9dc7');
INSERT INTO `domains` VALUES ('opennic.ygg','200:c493:950a:d576:a413:faef:990b:fb76',NULL,1,0,0,NULL,'opennic	IN	AAAA	200:c493:950a:d576:a413:faef:990b:fb76');
INSERT INTO `domains` VALUES ('peertube.ygg','',NULL,1,0,0,NULL,'peertube	IN	AAAA	301:fd1:86e3:521c::13');
INSERT INTO `domains` VALUES ('pics.medium','21c:3148:d6:1d0e:da4a:dfe0:a129:9cf6',NULL,0,1572364588,0,NULL,'pics	3600	IN	AAAA	21c:3148:d6:1d0e:da4a:dfe0:a129:9cf6');
INSERT INTO `domains` VALUES ('pirateirc.ygg','201:677d:1809:c5eb:202a:d39:e598:305',NULL,1,0,0,NULL,'pirateirc	IN	AAAA	201:677d:1809:c5eb:202a:d39:e598:305\r\nirc.pirateirc	IN	AAAA	201:677d:1809:c5eb:202a:d39:e598:305');
INSERT INTO `domains` VALUES ('play.medium','21c:3148:d6:1d0e:da4a:dfe0:a129:9cf6',NULL,0,1572364588,0,NULL,'play	3600	IN	AAAA	21c:3148:d6:1d0e:da4a:dfe0:a129:9cf6');
INSERT INTO `domains` VALUES ('podivilov.ygg','200:34f8:3a1b:5a5f:c188:f950:bf97:d1a1',NULL,1,0,0,NULL,'podivilov	IN	AAAA	200:34f8:3a1b:5a5f:c188:f950:bf97:d1a1');
INSERT INTO `domains` VALUES ('privatebin.ygg','',NULL,1,0,0,NULL,'privatebin	IN	AAAA	304:4738:37c6:d295::3');
INSERT INTO `domains` VALUES ('provodach.ygg','200:1863::1447:c300:24cf:6a5e',NULL,1,0,0,NULL,'provodach	IN	AAAA	200:1863::1447:c300:24cf:6a5e');
INSERT INTO `domains` VALUES ('read.medium','21c:3148:d6:1d0e:da4a:dfe0:a129:9cf6',NULL,0,1572364588,0,NULL,'read	3600	IN	AAAA	21c:3148:d6:1d0e:da4a:dfe0:a129:9cf6');
INSERT INTO `domains` VALUES ('revertron.hub','200:149b::b722:fe09:d31:84a4',NULL,0,1572723375,0,NULL,'*.revertron	300	IN	AAAA	200:149b::b722:fe09:d31:84a4\nrevertron	300	IN	AAAA	200:149b::b722:fe09:d31:84a4');
INSERT INTO `domains` VALUES ('roskomsvoboda.ygg','',NULL,1,0,0,NULL,'roskomsvoboda	IN	AAAA	300:5bf2:a7a5:27c7::100');
INSERT INTO `domains` VALUES ('speedtest.ygg','201:424c:a9d8:5d69:f3b0:61ef:f201:d37',NULL,1,0,0,NULL,'speedtest	IN	AAAA	201:424c:a9d8:5d69:f3b0:61ef:f201:d37');
INSERT INTO `domains` VALUES ('static-map.ygg','',NULL,1,0,0,NULL,'static-map	IN	AAAA	301:4541:2f84:1188:216:3eff:feb6:65a3');
INSERT INTO `domains` VALUES ('talk.medium','21c:3148:d6:1d0e:da4a:dfe0:a129:9cf6',NULL,0,1572364588,0,NULL,'talk	3600	IN	AAAA	21c:3148:d6:1d0e:da4a:dfe0:a129:9cf6');
INSERT INTO `domains` VALUES ('telegram-proxy.ygg','200:149b::b722:fe09:d31:84a4',NULL,0,1572364588,0,NULL,'telegram-proxy	300	IN	AAAA	200:149b::b722:fe09:d31:84a4\npx.telegram-proxy	60	IN	AAAA	201:2923::6d6:1df0:2970:d382\npx.telegram-proxy	60	IN	AAAA	201:2522::5736:9a6:7dd1:7c95');
INSERT INTO `domains` VALUES ('test.ygg','200:149b::b722:fe09:d31:84a4',NULL,0,1572364588,0,NULL,'test	600	IN	AAAA	200:149b::b722:fe09:d31:84a4\n*.test	300	IN	AAAA	200:149b::b722:fe09:d31:84a4\naaa.test	300	IN	AAAA	301:2923::53');
INSERT INTO `domains` VALUES ('to.ygg','200:1863::1447:c300:24cf:6a5e',NULL,1,0,0,NULL,'to	IN	AAAA	200:1863::1447:c300:24cf:6a5e');
INSERT INTO `domains` VALUES ('tor-bridge.ygg','223:f05:3dee:526c:d4ec:e65c:457b:7fcf',NULL,1,0,0,NULL,'tor-bridge	IN	AAAA	223:f05:3dee:526c:d4ec:e65c:457b:7fcf');
INSERT INTO `domains` VALUES ('torrent-tracker.ygg','',NULL,1,0,0,NULL,'torrent-tracker	IN	AAAA	301:4541:2f84:1188:216:3eff:fe34:ec44');
INSERT INTO `domains` VALUES ('transmission.ygg','200:a0c1:5204:9f99:807d:d4cd:6698:98a3',NULL,1,0,0,NULL,'transmission	IN	AAAA	200:a0c1:5204:9f99:807d:d4cd:6698:98a3');
INSERT INTO `domains` VALUES ('tube.ygg','201:2923::6d6:1df0:2970:d382',NULL,0,1572560526,0,NULL,'tube	300	IN	AAAA	201:2923::6d6:1df0:2970:d382');
INSERT INTO `domains` VALUES ('umbrellix.ygg','202:8fb5:1490:594d:7e29:98fd:8d79:953f',NULL,1,0,0,NULL,'umbrellix	IN	AAAA	202:8fb5:1490:594d:7e29:98fd:8d79:953f');
INSERT INTO `domains` VALUES ('wekan.ygg','201:424a:3537:d340:6665:daaa:4918:2181',NULL,1,0,0,NULL,'wekan	IN	AAAA	201:424a:3537:d340:6665:daaa:4918:2181');
INSERT INTO `domains` VALUES ('wiki.medium','21c:3148:d6:1d0e:da4a:dfe0:a129:9cf6',NULL,0,1572364588,0,NULL,'wiki	300	IN	AAAA	300:1863::53');
INSERT INTO `domains` VALUES ('wiki.ygg','203:e0b0:ec08:4e1f:f004:19a9:577a:90ba',NULL,1,0,0,NULL,'wiki	IN	AAAA	203:e0b0:ec08:4e1f:f004:19a9:577a:90ba');
INSERT INTO `domains` VALUES ('www.medium','21c:3148:d6:1d0e:da4a:dfe0:a129:9cf6',NULL,0,1572364588,0,NULL,'www	300	IN	AAAA	21c:3148:d6:1d0e:da4a:dfe0:a129:9cf6');
INSERT INTO `domains` VALUES ('ygg.dns','200:149b::b722:fe09:d31:84a4',NULL,0,1572634765,0,NULL,'ygg	300	IN	AAAA	301:2522::53\nygg	300	IN	AAAA	301:2923::53');
INSERT INTO `domains` VALUES ('yggedit.ygg','201:b614:c68e:b27f:dc0e:e8ec:15d0:2eb0',NULL,0,1572537126,0,NULL,'yggedit	3600	IN	AAAA	301:b614:c68e:b27f::1');
INSERT INTO `domains` VALUES ('zeronet-public-tracker.ygg','203:5871:3e33:413c:a824:cb7b:2604:92ab',NULL,1,0,0,NULL,'zeronet-public-tracker	IN	AAAA	203:5871:3e33:413c:a824:cb7b:2604:92ab');
