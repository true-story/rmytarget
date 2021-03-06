## ----setup, include = FALSE----------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  eval = FALSE,
  comment = "#>"
)

## ------------------------------------------------------------------------
#  install.packages("devtools")
#  library(devtools)
#  
#  # ����� ���� ����� ������������� ����� rmytarget.
#  install_github('selesnow/rmytarget')
#  library(rmytarget)

## ------------------------------------------------------------------------
#  library(rmytarget)
#  
#  # ================
#  # ������ ������ � ���������� ���������
#  # �����������
#  # ���� �� ��������� ����� �������� ������� �� � �������� �������� �����
#  # ������������ ������ � �������� ������� ��� ���������
#  
#  myTarAuth(login = "seleznev", token_path = "tokens")
#  
#  # �������� ������ ��������� �������� � ����������
#  campaing <- myTarGetCampaignList(login = "seleznev", token_path = "tokens")
#  ads      <- myTarGetAdList(login = "seleznev", token_path = "tokens")
#  
#  # �������� ���������� �� ��������� ���������
#  camp_data    <- myTarGetStats(date_from   = Sys.Date() - 7,
#                                date_to     = Sys.Date(),
#                                object_type = "campaigns",
#                                object_id   = campaing$id,
#                                stat_type   = "day",
#                                login       = "seleznev",
#                                token_path  = "tokens")
#  
#  # �������� ������ ������ �������� � ������ "base", "tps", "viral" �� �����������
#  custom_data <- myTarGetStats(date_from   = Sys.Date() - 7,
#                               date_to     = Sys.Date(),
#                               object_type = "banners",
#                               metrics     = c("base", "tps", "viral"),
#                               stat_type   = "day",
#                               login       = "seleznev",
#                               token_path  = "tokens")
#  
#  # �������� ���� ��������� ������ � ������������ �� ��������� ���������
#  all_data <- myTarGetStats(date_from   = Sys.Date() - 7,
#                            date_to     = Sys.Date(),
#                            object_type = "campaigns",
#                            metrics     = "all",
#                            login       = "seleznev",
#                            token_path  = "tokens")

## ------------------------------------------------------------------------
#  library(rmytarget)
#  
#  # �����������
#  # � �������� ���������� ������� ����� ������������ ������ � �������� "����� ���������� ��������"
#  myTarAuth(login = "agency", token_path = "tokens")
#  
#  # �������� ������ ��������
#  clients <- myTarGetClientList(login = "agency",
#                                token_path = "tokens")
#  
#  # �������� ���������� � ������������ �� �������� ���������� ��������
#  client_stat <-  myTarGetStats(date_from   = Sys.Date() - 7,
#                                date_to     = Sys.Date(),
#                                object_id   = clients$id,
#                                object_type = "users",
#                                metrics     = "all",
#                                login       = "agency",
#  			      token_path = "tokens")

