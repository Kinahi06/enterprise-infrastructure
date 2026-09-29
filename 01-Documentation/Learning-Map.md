# Полная карта обучения

Обновлено: 29.09.2026. Здесь разделены **большие модули курса**, **лабораторные
сессии** и **ранние занятия homelab**: у них разная нумерация. Session 11 не
означает завершение модуля 11. Зачтённая лабораторная также не означает полное
освоение всей темы без помощи.

## Ранние занятия — август 2026

| Занятие | Что делали | Запись |
|---|---|---|
| Lesson 1 — Windows infrastructure | Windows 11 ARM в UTM, VirtIO, Resource Monitor, службы, Registry и структура системы | [Журнал](Engeniering%20Journal.md#lesson-1--windows-infrastructure-lab) |
| Lesson 2 — Закрепление | Рефлексия по первому занятию и вопросы для дальнейшего изучения; не отдельный практический зачёт | [Журнал](Engeniering%20Journal.md#lesson-2) |
| Lesson 3 — Ubuntu deployment | Установка Ubuntu Server ARM64, базовая сеть и проверка DNS | [Журнал](Engeniering%20Journal.md#lesson-3--ubuntu-server-deployment) |
| Lesson 4 — Baseline и SSH | Состояние ОС, APT, systemd/socket activation, SSH и ED25519, проверка доступа с Mac | [Журнал](Engeniering%20Journal.md#lesson-4--ubuntu-server-baseline-and-ssh) |
| Lesson 5 — LVM и Samba | Отдельный том, ext4/fstab, групповые права и setgid, SMB, UFW и проверка после reboot | [Журнал](Engeniering%20Journal.md#lesson-5--lvm-backed-samba-file-server) |
| Lesson 6 — Tailscale и автоматизация | Ubuntu/Mac/Windows, MagicDNS, правила UFW по клиентам, SMB, DERP, Bash/PowerShell с помощью преподавателя | [Журнал](Engeniering%20Journal.md#lesson-6--cross-platform-tailscale-administration) |

## Лабораторные сессии — сентябрь 2026

| Сессия | Тема и результат | Статус |
|---|---|---|
| 01 — Broken Web Stack | Подготовленный Docker Compose стенд | Прохождение не подтверждено; не считать завершённой |
| 02 — Service permissions | Доступ сервисной учётной записи к коду; подтверждение process/socket/HTTP | Зачтено |
| 03 — Runtime environment | Поиск неправильного значения PORT через journal и EnvironmentFile | Зачтено с подсказками |
| 04 — Remote API | Различие локальной и удалённой доступности, bind-address и проверка с Mac | Зачтено с подсказками |
| 05 — Dependencies | After и Requires, drop-in, эффективные зависимости и здоровье всей цепочки | Зачтено с объяснением зависимостей |
| 06 — Filesystem resources | Исчерпание inode при свободных байтах, ограниченная выборка старого кэша и восстановление worker | Зачтено; 7 PASS показаны |
| 07 — Linux gate | Две последовательные причины: права и занятый порт; PID → unit, повторная проверка | Зачтено; 11 PASS зафиксированы |
| 08 — Name resolution | Несовпадение hosts-записи и listener; getent, ss и исходный URL | Зачтено с подсказками; все PASS сообщены учеником |
| 09 — TCP errors | Inactive/no listener против packet DROP; восстановление двух endpoint | Практика с помощью завершена; устная защита ещё ожидается |
| 10 — HTTP 502 | Неверный upstream-порт, минимальная правка и restart только proxy | Практика и защита завершены с подсказками; PASS сообщены учеником |
| 11 — HTTP contract | HTTP 200 от старой версии; переключение proxy на нужный backend, проверка версии в ответе | Причина найдена самостоятельно; зачтено с уточнением приёмки, PASS сообщены учеником |
| 12 — TLS | Доверие CA, имя сертификата и проверка HTTPS без отключения защиты | Подготовлено; прохождение учеником не подтверждено |

Подробности: [журнал](Engeniering%20Journal.md), [прогресс](Progress.md),
[навыки по одной строке на тему](Skills-Overview.md). Подготовка стенда и тесты
преподавателя не считаются практикой ученика. Для Session 09 повторная проверка
подтвердила endpoints, но не повторяла весь root-only checker; это не скрывается.

## Большие модули курса — полный маршрут

| № | Модуль | Текущее положение |
|---|---|---|
| 0 | Входной аудит и общая модель DevOps-системы | Частичный теоретический аудит; не завершён |
| 1 | Linux internals: процессы, память, I/O, filesystem, systemd | Практический refresh и Linux gate пройдены; не полное освоение всех internals |
| 2 | Сети: L2–L7, DNS, TCP, routing/NAT, HTTP, proxy, TLS | В работе: сессии 08–11, далее подготовленная 12; весь модуль не закрыт |
| 3 | Контейнеры: namespaces, cgroups, образы, storage/network | После сетей; аудит выявил необходимость углубления, практический зачёт не пройден |
| 4 | CI/CD: pipeline, artifacts, promotion, rollback | В плане; только начальный теоретический аудит |
| 5 | Ansible и Terraform: идемпотентность, drift, state/locking | В плане; практический зачёт не пройден |
| 6 | Облако: IAM, VPC, LB, storage, отказоустойчивость и стоимость | В плане; не проверено |
| 7 | Kubernetes architecture: API, reconciliation, scheduler, kubelet | В плане; не проверено |
| 8 | Kubernetes operations: сеть, storage, probes, rollout, RBAC | В плане; не проверено |
| 9 | Databases и queues: PostgreSQL, restore, Redis, семантика очередей | В плане; не проверено |
| 10 | Observability и reliability: metrics/logs/traces, SLI/SLO, alerts | В плане; не проверено |
| 11 | Security: identity, least privilege, secrets, TLS, supply chain | Отдельные основы применялись в homelab; модуль целиком не пройден |
| 12 | GitOps и финальный сквозной инцидент | В плане; не проверено |

Это маршрут, а не список полученных квалификаций. Старый календарный план
Windows/AD/GPO остаётся дополнительным направлением, не текущим порядком курса.
Для LinkedIn использовать подтверждённые практические темы, а не выдавать весь
маршрут за освоенные технологии или коммерческий опыт.
