<head>
<link rel="shortcut icon" type="image/x-icon" href="as.ico">
<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=UA-114798296-1"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());
  gtag('config', 'UA-114798296-1');
</script>
 
</head>

<p align="center">
<a href="https://selesnow.github.io/"><img src="https://alexeyseleznev.files.wordpress.com/2017/03/as.png" height="80"></a>
</p>

<table>
    <tr>
      <td>
        <a href="https://selesnow.github.io/ryandexdirect/">ryandexdirect</a>
      </td>
      <td>
        <a href="https://selesnow.github.io/rfacebookstat/">rfacebookstat</a>
      </td>
      <td>
        <a href="https://selesnow.github.io/rvkstat/">rvkstat</a>
      </td>
      <td>
        <a href="https://selesnow.github.io/rmytarget/">rmytarget</a>
      </td>
      <td>
        <a href="https://selesnow.github.io/rmixpanel/">rmixpanel</a>
      </td>
      <td>
        <a href="https://selesnow.github.io/getProxy/">getProxy</a>
      </td>
      <td>
        <a href="https://selesnow.github.io/rGitHub/">rGitHub</a>
      </td>
      <td>
        <a href="https://selesnow.github.io/news/">NEWS</a>
      </td>
    </tr>
</table>

# rmytarget - пакет для работы с API MyTarget на языке R.

## Содержание README:

* [Установка пакета rmytarget](https://github.com/selesnow/rmytarget#Краткое-описание)
- [Авторизация в API MyTarget](https://github.com/selesnow/rmytarget#Авторизация-в-api-mytarget)
- [Обновление токена доступа после истечение срока действия](https://github.com/selesnow/rmytarget/blob/master/README.md#Обновление-токена-доступа)
- [Получение списка клиентов для агентского аккаунта](https://github.com/selesnow/rmytarget#Получение-списка-клиентов-для-агентского-аккаунта)
- [Получение списка рекламных кампаний](https://github.com/selesnow/rmytarget#Получение-списка-рекламных-кампаний)
- [Получение общей статистики по всем рекламным кампаниям аккаунта](https://github.com/selesnow/rmytarget#Получение-общей-статистики-по-всем-рекламным-кампаниям-аккаунта)

## Краткое описание.

Пакет rmytarget помогает получить дата фрейм со списком клиентов агентств из аккаунта MyTarget, получить список и обшие параметры рекламных кампаний по каждому из проектов, а так же получить детальную статистику по кампаниям за каждый день.


## Установка пакета rmytarget.

Установка пакета осуществляется из репозитория GitHub, для этого сначала требуется установить и подключить пакет devtools.

`install.packages("devtools")`

`library(devtools)`

После чего можно устанавливать пакет rmytarget.

`install_github('selesnow/rmytarget')`

`library(rmytarget)`


## Авторизация в API MyTarget.

Для того что бы работать с API изначально необходимо пройти процедуру аутинтификации и получить токен доступа, в пакете rmytarget для этого существует функция `myTargetAuth`.

В API MyTarget существует две схемы авторазиции, Client Credentials Grant для обычного рекламодателя и для агентства. В зависимости от типа вашего аккаунта вам необходимо получить токен доступа согласно типу вашего аккаунта в MyTarget.

Получение токена для обычного рекламного аккаунта.
```r
myTargetAuth <- myTarAuth(grant_type = "client_credentials",
                          client_id = "XXXXXXXXXX",
                          client_secret = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx")		
```

Аргументы:
grant_type - Тип вашего аккаунта, в данном случае обычный клиентский аккаунт.
client_id - ID выдаётся вам при подтверждение доступа к API MyTarget.
client_secret - Выдаётся вам при подтверждение доступа к API MyTarget вместе с Client ID.

Получение токена для агентского аккаунта.
```r
myTargetAuth <- myTarAuth(grant_type = "agency_client_credentials",
                          client_id = "XXXXXXXXXX",
                          client_secret = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
                          agency_client_name = "xxxxxxxxx@agency_client")
```

Вариант grant_type=agency_client_credentials не является стандартным для OAuth2. Он реализован для того, чтобы агентства могли создавать access-токены для своих клиентов напрямую. Помимо параметров client_id, client_secret нужно передавать agency_client_name.
Для получения информации по агентскому аккаунту, например поучить список клиентов агентсва необходимо следовать первой описанной схеме с grant_type = "client_credentials" и получить токен агентского аккаунта.

##Обновление токена доступа
Каждый полученный access-токен является действительным в течение суток. На это указывает свойство expires_in в ответе на запрос access-токена.
Для обновления токета в пакете rmytarget есть функция `myTarRefreshToken`

```r
myTargetAuth <- myTarRefreshToken(old_auth = myTargetAuth,
                                  client_id = "xxxxxxxxx",
                                  client_secret = "xxxxxxxxxxxxxxxxxxxxxxxxxxx...")
```
Аргументы функции:
old_auth - R объект с учётными данными полученный с помощью функции myTarAuth.
client_id - ID выдаётся вам при подтверждение доступа к API MyTarget.
client_secret - Выдаётся вам при подтверждение доступа к API MyTarget вместе с Client ID.

Подробную информацию о схеме аутинтификации в API вы можете получить по [ссылке](https://target.my.com/adv/api-marketing/doc/authorization).

## Получение списка клиентов для агентского аккаунта.
Эта функция доступна только для агентских аккаунтов, и соответсвенно для токенов выданных агентским аккаунтам.

`myTargetClients <- myTarGetClientList(myTargetAuth)`

Аргументы функции:
auth - Объект R с авторизационными данными, полученный с помощью функции myTarAuth


Более подробную информацию по списку клиентов можно получить по [ссылке](https://target.my.com/doc/api/detailed/#resource_agency_clients)


## Получение списка рекламных кампаний.

Функция доступна для рекламных аккаунтов в которых есть рекламные кампании, для того что бы получить список рекламных кампаний клиента агентства вам необходимо получить для этого клиента токен, указав имя клента в аргументе agency_client_name функции myTarAuth.

`myTargetCampaign <- myTarGetCampaignList(myTargetAuth)`

Аргументы функции:
auth - Объект R с авторизационными данными, полученный с помощью функции myTarAuth

Более полная информация находится в официальной документации к API по [ссылке](https://target.my.com/doc/api/detailed/#resource_campaigns)

## Получение общей статистики по всем рекламным кампаниям аккаунта.
Функция доступна для рекламных аккаунтов в которых есть рекламные кампании.

```r
myTargetSummary <- myTarGetTotalStats(date_to = "2016-08-01",
                                      date_to = "2016-08-10",
                                      auth = myTargetAuth)
```
Функция возвращает data frame со статистикой по рекламным кампаниям в разрезе дат.

Структура полученного data frame.
<table>
    <tr>
        <td><center>Поле</center></td><td><center>Тип данных</center></td><td><center>Описание</center></td>
    </tr>
    <tr>
        <td><center>Date</center></td><td><center>Date</center></td><td><center>Дата</center></td>
    </tr>
    <tr>
        <td><center>CampaignName</center></td><td><center>Character</center></td><td><center>Название рекламной кампании</center></td>
    </tr>
    <tr>
        <td><center>CampaignID</center></td><td><center>Character</center></td><td><center>ID рекламной кампании</center></td>
    </tr>
    <tr>    
        <td><center>Reach</center></td><td><center>integer</center></td><td><center>Охват, количество уникальных пользователей которым были показаны объявления за всё время ведения рекламной кампании</center></td>
    </tr>
     <tr>
        <td><center>CTR</center></td><td><center>Numeric</center></td><td><center>Кликабельность объявлений</center></td>
    </tr>
    <tr>
        <td><center>Cost</center></td><td><center>Numeric</center></td><td><center>Сумма списаний по рекламной кампании в рублях</center></td>
    </tr>
    <tr>
        <td><center>Impressions</center></td><td><center>integer</center></td><td><center>Количество показов</center></td>
    </tr>
    <tr>
        <td><center>Clicks</center></td><td><center>integer</center></td><td><center>Количество кликов</center></td>
    </tr>
    <tr>
        <td><center>UniquesIncrement</center></td><td><center>integer</center></td><td><center>Прирост новых уникальных пользователей увидивших объявления впервые</center></td>
    </tr>
</table> 

---

## *Автор пакета: Алексей Селезнёв, Head of Analytics Dept. at Netpeak*
<table>
    <tr>
      <td>
      <img align="right" src="https://lh3.googleusercontent.com/R-0jgJSxIIhpag2L6YCIhJVIcIWx6-Jt5UCTRJjWzJewo47u2QBnik5CRF2dNB79jmsN_BFRjVOAYfvCqFcn3UNS_thGbbxF-99c9lwBWWlFI7JCWE43K5Yk9HnIW8i8YpTDx3l28IuYswaI-qc9QosHT1lPCsVilTfXTyV2empF4S74daOJ6x5QHYRWumT_2MhUS0hPqUsKVtOoveqDnGf3cF_VsN-RfOAwG9uCeGOgNRgv_fhSr41rw4LBND4gf05nO8zMp4TZMrrcUjKvvx6qNgYDor5LFOHiRmfKISYRVkWYe4wLyGO1FgkgTDjg0300lcur2t3txVwZUgROLZdaxOLx4owa8Rc8B8VKwd3vHxjov_aVfNPT4xf9jSFBBEOI-mfYpa55ejKDw-rqTQ6miFRFWpp_hjrk9KbGyB-Z6iZvYL-2dZ6mzgpUfs2I0tEAGsV07yTzboJ0RNCByC2-U-ZVjWdp2_9Au3FFoUcdQUAmPYOVqOv4r3oLbkkJKLj2A5jp7vf4IAoExLIfJuqEf7XN7fFcv4geib029qJjBt28wnqSO6TKEwB2fesR3uPHvGB6_6NHD70UDH-aCRCK4UBeoajtU0Y8Ks8Vwxo0oZBwmoEu8gudTFBF6mDT7GjLoGLDeNxE-TG7OtWUdxsJk7yzXGW3hE-VxsMD9g=s351-no?w=100" height="150">
      </td>
      <td>
        <b>Контакты</b>
        <br>email: selesnow@gmail.com
        <br>skype: selesnow
        <br>telegram: @AlexeySeleznev
      </td>
    </tr>
    <tr>
     <table>
    <tr>
      <td>
        <a href="https://facebook.com/selesnow/">Facebook</a>
      </td>
      <td>
        <a href="https://vk.com/selesnow">Vkontakte</a>
      </td>
      <td>
        <a href="https://linkedin.com/in/selesnow">Linkedin</a>
      </td>
      <td>
        <a href="https://alexeyseleznev.wordpress.com/">Blog</a>
      </td>
      <td>
        <a href="https://github.com/selesnow/">GitHub</a>
      </td>
      <td>
        <a href="https://stepik.org/users/792428">Stepic</a>
      </td>
    </tr>
</table>
    </tr>
</table>