SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

CREATE TABLE domains (
  domain varchar(100) NOT NULL,
  owner varchar(40) NOT NULL,
  fallback varchar(40) DEFAULT NULL,
  legacy tinyint(1) NOT NULL DEFAULT 0,
  seen_first bigint(12) NOT NULL,
  seen_down_since bigint(12) NOT NULL DEFAULT 0,
  tags varchar(100) DEFAULT NULL,
  records text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


ALTER TABLE domains
  ADD UNIQUE KEY domain (domain);

USE `wyrd`;

SET NAMES utf8mb4;

INSERT INTO `domains` (`domain`, `owner`, `fallback`, `legacy`, `seen_first`, `seen_down_since`, `tags`, `records`) VALUES
('cdnjs.ygg',	'',	NULL,	1,	0,	0,	NULL,	'cdnjs	IN	AAAA	300:5bf2:a7a5:27c7::77'),
('fz.ygg',	'201:918e:f16:bd05:e1f4:7435:7182:42d5',	NULL,	1,	0,	0,	NULL,	'fz	IN	AAAA	201:918e:f16:bd05:e1f4:7435:7182:42d5\r\nirc.fz	IN	AAAA	201:918e:f16:bd05:e1f4:7435:7182:42d5'),
('gitlab.ygg',	'',	NULL,	1,	0,	0,	NULL,	'gitlab	IN	AAAA	304:4738:37c6:d295::5'),
('humhub.ygg',	'200:1863::1447:c300:24cf:6a5e',	NULL,	1,	0,	0,	NULL,	'humhub	IN	AAAA	200:1863::1447:c300:24cf:6a5e'),
('i2pd.ygg',	'304:4738:37c6:d295::1',	NULL,	1,	0,	0,	NULL,	'i2pd	IN	AAAA	304:4738:37c6:d295::1'),
('ipinfo.ygg',	'',	NULL,	1,	0,	0,	NULL,	'ipinfo	IN	AAAA	300:aa35:f9c1:dcce::2'),
('lg.ygg',	'',	NULL,	1,	0,	0,	NULL,	'lg	IN	AAAA	300:5bf2:a7a5:27c7::4'),
('lxc-hosting.ygg',	'201:4541:2f84:1188:59ab:e8dd:48a8:d40c',	NULL,	1,	0,	0,	NULL,	'lxc-hosting	IN	AAAA	201:4541:2f84:1188:59ab:e8dd:48a8:d40c'),
('map.ygg',	'21f:dd73:7cdb:773b:a924:7ec0:800b:221e',	NULL,	1,	0,	0,	NULL,	'map	IN	AAAA	21f:dd73:7cdb:773b:a924:7ec0:800b:221e'),
('mesh.ygg',	'',	NULL,	1,	0,	0,	NULL,	'mesh	IN	AAAA	303:60d4:3d32:a2b9::4'),
('meshirc.ygg',	'201:870:9573:4095:f4e6:dfde:cc68:c783',	NULL,	1,	0,	0,	NULL,	'meshirc	IN	AAAA	201:870:9573:4095:f4e6:dfde:cc68:c783'),
('minecraft.ygg',	'202:baed:9808:83c8:738:4041:bd8b:8c1d',	NULL,	1,	0,	0,	NULL,	'minecraft	IN	AAAA	202:baed:9808:83c8:738:4041:bd8b:8c1d'),
('minetest.ygg',	'200:362b:d038:d21e:4b2e:2f86:1936:e9e2',	NULL,	1,	0,	0,	NULL,	'minetest	IN	AAAA	200:362b:d038:d21e:4b2e:2f86:1936:e9e2'),
('netwhood.ygg',	'202:12a9:e5:4474:d473:82be:16ac:9381',	NULL,	1,	0,	0,	NULL,	'netwhood	IN	AAAA	202:12a9:e5:4474:d473:82be:16ac:9381\r\ngit	IN	AAAA	202:12a9:e5:4474:d473:82be:16ac:9381'),
('nextcloud.ygg',	'',	NULL,	1,	0,	0,	NULL,	'nextcloud	IN	AAAA	304:4738:37c6:d295::2\r\noffice	IN	AAAA	304:4738:37c6:d295::6'),
('nntp.ygg',	'201:3ac0:cdc2:126:656b:aca:8b23:9dc7',	NULL,	1,	0,	0,	NULL,	'nntp	IN	AAAA	201:3ac0:cdc2:126:656b:aca:8b23:9dc7'),
('opennic.ygg',	'200:c493:950a:d576:a413:faef:990b:fb76',	NULL,	1,	0,	0,	NULL,	'opennic	IN	AAAA	200:c493:950a:d576:a413:faef:990b:fb76'),
('peertube.ygg',	'',	NULL,	1,	0,	0,	NULL,	'peertube	IN	AAAA	301:fd1:86e3:521c::13'),
('pirateirc.ygg',	'201:677d:1809:c5eb:202a:d39:e598:305',	NULL,	1,	0,	0,	NULL,	'pirateirc	IN	AAAA	201:677d:1809:c5eb:202a:d39:e598:305\r\nirc.pirateirc	IN	AAAA	201:677d:1809:c5eb:202a:d39:e598:305'),
('podivilov.ygg',	'200:34f8:3a1b:5a5f:c188:f950:bf97:d1a1',	NULL,	1,	0,	0,	NULL,	'podivilov	IN	AAAA	200:34f8:3a1b:5a5f:c188:f950:bf97:d1a1'),
('privatebin.ygg',	'',	NULL,	1,	0,	0,	NULL,	'privatebin	IN	AAAA	304:4738:37c6:d295::3'),
('provodach.ygg',	'200:1863::1447:c300:24cf:6a5e',	NULL,	1,	0,	0,	NULL,	'provodach	IN	AAAA	200:1863::1447:c300:24cf:6a5e'),
('roskomsvoboda.ygg',	'',	NULL,	1,	0,	0,	NULL,	'roskomsvoboda	IN	AAAA	300:5bf2:a7a5:27c7::100'),
('speedtest.ygg',	'201:424c:a9d8:5d69:f3b0:61ef:f201:d37',	NULL,	1,	0,	0,	NULL,	'speedtest	IN	AAAA	201:424c:a9d8:5d69:f3b0:61ef:f201:d37'),
('static-map.ygg',	'',	NULL,	1,	0,	0,	NULL,	'static-map	IN	AAAA	301:4541:2f84:1188:216:3eff:feb6:65a3'),
('to.ygg',	'200:1863::1447:c300:24cf:6a5e',	NULL,	1,	0,	0,	NULL,	'to	IN	AAAA	200:1863::1447:c300:24cf:6a5e'),
('tor-bridge.ygg',	'223:f05:3dee:526c:d4ec:e65c:457b:7fcf',	NULL,	1,	0,	0,	NULL,	'tor-bridge	IN	AAAA	223:f05:3dee:526c:d4ec:e65c:457b:7fcf'),
('torrent-tracker.ygg',	'',	NULL,	1,	0,	0,	NULL,	'torrent-tracker	IN	AAAA	301:4541:2f84:1188:216:3eff:fe34:ec44'),
('transmission.ygg',	'200:a0c1:5204:9f99:807d:d4cd:6698:98a3',	NULL,	1,	0,	0,	NULL,	'transmission	IN	AAAA	200:a0c1:5204:9f99:807d:d4cd:6698:98a3'),
('umbrellix.ygg',	'202:8fb5:1490:594d:7e29:98fd:8d79:953f',	NULL,	1,	0,	0,	NULL,	'umbrellix	IN	AAAA	202:8fb5:1490:594d:7e29:98fd:8d79:953f'),
('wekan.ygg',	'201:424a:3537:d340:6665:daaa:4918:2181',	NULL,	1,	0,	0,	NULL,	'wekan	IN	AAAA	201:424a:3537:d340:6665:daaa:4918:2181'),
('wiki.ygg',	'203:e0b0:ec08:4e1f:f004:19a9:577a:90ba',	NULL,	1,	0,	0,	NULL,	'wiki	IN	AAAA	203:e0b0:ec08:4e1f:f004:19a9:577a:90ba'),
('yggedit.ygg',	'201:b614:c68e:b27f:dc0e:e8ec:15d0:2eb0',	NULL,	0,	1572537126,	0,	NULL,	'yggedit	3600	IN	AAAA	301:b614:c68e:b27f::1'),
('zeronet-public-tracker.ygg',	'203:5871:3e33:413c:a824:cb7b:2604:92ab',	NULL,	1,	0,	0,	NULL,	'zeronet-public-tracker	IN	AAAA	203:5871:3e33:413c:a824:cb7b:2604:92ab');
