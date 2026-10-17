# Рефераты

- [Сеть Compose: Markdown](Docker/Сеть%20Compose%20-%20DNS%20прокси%20и%20диагностика%20отказов.md) · [PDF](Docker/Сеть%20Compose%20-%20DNS%20прокси%20и%20диагностика%20отказов.pdf). Практика 15-16.10.2026 с помощью; фактический отказ curl (28), восстановление 200/v2 и down показаны. Healthcheck только выдан.

- [Dockerfile и Compose: Markdown](Docker/Dockerfile%20и%20Compose%20-%20сборка%20и%20управление%20приложением.md) · [PDF](Docker/Dockerfile%20и%20Compose%20-%20сборка%20и%20управление%20приложением.pdf). Практика 14-15.10.2026 с подсказками; короткая защита позднее завершена с уточнением терминов. по темам

Структура: Linux, Сети, Docker. Дат в путях нет; даты практики указаны внутри документов.
PDF - версия для чтения, Markdown с тем же именем - редактируемый источник.
Новые рефераты продолжают эту структуру; ранее изученные команды повторно не объясняются.

## Linux

- [Bash - проверка HTTPS API: PDF](Linux/Bash%20-%20проверка%20HTTPS%20API.pdf) · [Markdown](Linux/Bash%20-%20проверка%20HTTPS%20API.md).
- [Права доступа, терминал и SSH: PDF](Linux/Права%20доступа%20терминал%20и%20диагностика%20SSH.pdf) · [Markdown](Linux/Права%20доступа%20терминал%20и%20диагностика%20SSH.md).

## Сети

- [TCP, HTTP, proxy и TLS: PDF](Сети/TCP%20HTTP%20proxy%20и%20TLS.pdf) · [Markdown](Сети/TCP%20HTTP%20proxy%20и%20TLS.md).

## Docker

- [Одно приложение: Markdown](Docker/%D0%9E%D0%B4%D0%BD%D0%BE%20%D0%BF%D1%80%D0%B8%D0%BB%D0%BE%D0%B6%D0%B5%D0%BD%D0%B8%D0%B5%20-%20%D0%BE%D0%B1%D1%80%D0%B0%D0%B7%20%D0%BA%D0%BE%D0%BD%D1%82%D0%B5%D0%B9%D0%BD%D0%B5%D1%80%20%D0%B8%20HTTP.md) · [PDF](Docker/%D0%9E%D0%B4%D0%BD%D0%BE%20%D0%BF%D1%80%D0%B8%D0%BB%D0%BE%D0%B6%D0%B5%D0%BD%D0%B8%D0%B5%20-%20%D0%BE%D0%B1%D1%80%D0%B0%D0%B7%20%D0%BA%D0%BE%D0%BD%D1%82%D0%B5%D0%B9%D0%BD%D0%B5%D1%80%20%D0%B8%20HTTP.pdf). 17.10.2026 вечер: lab-info:v1, контейнер, HTTP 200/JSON 1.0 и GET в логах показаны; код вводится через Vim и разбирается для конспекта.

- [Depends_on: Markdown](Docker/Depends_on%20-%20%D0%B3%D0%BE%D1%82%D0%BE%D0%B2%D0%BD%D0%BE%D1%81%D1%82%D1%8C%20%D0%B8%20%D0%B3%D1%80%D0%B0%D0%BD%D0%B8%D1%86%D1%8B%20%D0%B7%D0%B0%D0%B2%D0%B8%D1%81%D0%B8%D0%BC%D0%BE%D1%81%D1%82%D0%B8.md) · [PDF](Docker/Depends_on%20-%20%D0%B3%D0%BE%D1%82%D0%BE%D0%B2%D0%BD%D0%BE%D1%81%D1%82%D1%8C%20%D0%B8%20%D0%B3%D1%80%D0%B0%D0%BD%D0%B8%D1%86%D1%8B%20%D0%B7%D0%B0%D0%B2%D0%B8%D1%81%D0%B8%D0%BC%D0%BE%D1%81%D1%82%D0%B8.pdf). Практика 17.10.2026 с помощью: healthy, ожидание proxy и HTTP 200/v2 показаны; startup/runtime уточнены. Далее DNS/localhost и диагностика.

- [HTTP healthcheck: Markdown](Docker/HTTP%20healthcheck%20-%20wget%20%D0%B8%20%D0%B3%D1%80%D0%B0%D0%BD%D0%B8%D1%86%D1%8B%20%D0%BF%D1%80%D0%BE%D0%B2%D0%B5%D1%80%D0%BA%D0%B8.md) · [PDF](Docker/HTTP%20healthcheck%20-%20wget%20%D0%B8%20%D0%B3%D1%80%D0%B0%D0%BD%D0%B8%D1%86%D1%8B%20%D0%BF%D1%80%D0%BE%D0%B2%D0%B5%D1%80%D0%BA%D0%B8.pdf). Ручной wget показан, healthy сообщён учеником; практика с помощью. Далее depends_on/service_healthy.

- [Хранение данных - слои, volumes и bind mount: PDF](Docker/Хранение%20данных%20-%20слои%20volumes%20и%20bind%20mount.pdf) · [Markdown](Docker/Хранение%20данных%20-%20слои%20volumes%20и%20bind%20mount.md).

- [Основы Docker - запуск и диагностика контейнера: PDF](Docker/Основы%20Docker%20-%20запуск%20и%20диагностика%20контейнера.pdf) · [Markdown](Docker/Основы%20Docker%20-%20запуск%20и%20диагностика%20контейнера.md).
