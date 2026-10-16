# Study notes and current practice
Updated 16 October 2026. These are my learning records, prepared with AI assistance.
My public [learning map](../Learning-Map.md) and [skills overview](../Skills-Overview.md)
are available in English and Russian. The detailed study notes below are in Russian.

## Completed with guidance

- Compose networking and proxy, 15-16 October: [editable report](Рефераты/Docker/Сеть%20Compose%20-%20DNS%20прокси%20и%20диагностика%20отказов.md) · [PDF](Рефераты/Docker/Сеть%20Compose%20-%20DNS%20прокси%20и%20диагностика%20отказов.pdf). Actual backend-outage result: curl (28), not HTTP 502; recovery and project removal shown.

- Dockerfile and first Compose project, 14-15 October: [editable report](Рефераты/Docker/Dockerfile%20и%20Compose%20-%20сборка%20и%20управление%20приложением.md) · [PDF](Рефераты/Docker/Dockerfile%20и%20Compose%20-%20сборка%20и%20управление%20приложением.pdf). Runtime results reported by me; installation shown; short oral check later completed with terminology clarification.

- Docker storage, 12-14 October: [editable report](Рефераты/Docker/Хранение%20данных%20-%20слои%20volumes%20и%20bind%20mount.md) · [PDF](Рефераты/Docker/Хранение%20данных%20-%20слои%20volumes%20и%20bind%20mount.pdf).

Reports are organized by topic, not date: [Linux, Networks and Docker](Рефераты/README.md). PDF and editable Markdown share the same descriptive filename. Lesson dates stay inside the documents.
- Bash HTTPS API check: [editable report](%D0%A0%D0%B5%D1%84%D0%B5%D1%80%D0%B0%D1%82%D1%8B/Linux/Bash%20-%20%D0%BF%D1%80%D0%BE%D0%B2%D0%B5%D1%80%D0%BA%D0%B0%20HTTPS%20API.md) · [PDF](%D0%A0%D0%B5%D1%84%D0%B5%D1%80%D0%B0%D1%82%D1%8B/Linux/Bash%20-%20%D0%BF%D1%80%D0%BE%D0%B2%D0%B5%D1%80%D0%BA%D0%B0%20HTTPS%20API.pdf).
- Scoped access, terminal and SSH incident: [editable report](%D0%A0%D0%B5%D1%84%D0%B5%D1%80%D0%B0%D1%82%D1%8B/Linux/%D0%9F%D1%80%D0%B0%D0%B2%D0%B0%20%D0%B4%D0%BE%D1%81%D1%82%D1%83%D0%BF%D0%B0%20%D1%82%D0%B5%D1%80%D0%BC%D0%B8%D0%BD%D0%B0%D0%BB%20%D0%B8%20%D0%B4%D0%B8%D0%B0%D0%B3%D0%BD%D0%BE%D1%81%D1%82%D0%B8%D0%BA%D0%B0%20SSH.md) · [PDF](%D0%A0%D0%B5%D1%84%D0%B5%D1%80%D0%B0%D1%82%D1%8B/Linux/%D0%9F%D1%80%D0%B0%D0%B2%D0%B0%20%D0%B4%D0%BE%D1%81%D1%82%D1%83%D0%BF%D0%B0%20%D1%82%D0%B5%D1%80%D0%BC%D0%B8%D0%BD%D0%B0%D0%BB%20%D0%B8%20%D0%B4%D0%B8%D0%B0%D0%B3%D0%BD%D0%BE%D1%81%D1%82%D0%B8%D0%BA%D0%B0%20SSH.pdf).
- Networking Sessions 09–12: [editable notes](%D0%A0%D0%B5%D1%84%D0%B5%D1%80%D0%B0%D1%82%D1%8B/%D0%A1%D0%B5%D1%82%D0%B8/TCP%20HTTP%20proxy%20%D0%B8%20TLS.md) · [PDF](%D0%A0%D0%B5%D1%84%D0%B5%D1%80%D0%B0%D1%82%D1%8B/%D0%A1%D0%B5%D1%82%D0%B8/TCP%20HTTP%20proxy%20%D0%B8%20TLS.pdf).
- Docker Session 13: [editable notes](%D0%A0%D0%B5%D1%84%D0%B5%D1%80%D0%B0%D1%82%D1%8B/Docker/%D0%9E%D1%81%D0%BD%D0%BE%D0%B2%D1%8B%20Docker%20-%20%D0%B7%D0%B0%D0%BF%D1%83%D1%81%D0%BA%20%D0%B8%20%D0%B4%D0%B8%D0%B0%D0%B3%D0%BD%D0%BE%D1%81%D1%82%D0%B8%D0%BA%D0%B0%20%D0%BA%D0%BE%D0%BD%D1%82%D0%B5%D0%B9%D0%BD%D0%B5%D1%80%D0%B0.md) · [PDF](%D0%A0%D0%B5%D1%84%D0%B5%D1%80%D0%B0%D1%82%D1%8B/Docker/%D0%9E%D1%81%D0%BD%D0%BE%D0%B2%D1%8B%20Docker%20-%20%D0%B7%D0%B0%D0%BF%D1%83%D1%81%D0%BA%20%D0%B8%20%D0%B4%D0%B8%D0%B0%D0%B3%D0%BD%D0%BE%D1%81%D1%82%D0%B8%D0%BA%D0%B0%20%D0%BA%D0%BE%D0%BD%D1%82%D0%B5%D0%B9%D0%BD%D0%B5%D1%80%D0%B0.pdf).
- Docker: [theory](Docker-Theory.md) · [ticket](Docker-Ticket.md) · [my report](Docker-Report.md).
- TLS: [my report](TLS-Report.md).

I still owe the Session 09 oral defence. Reported checker PASS is distinguished
from shown output. The 12 October screenshot showed s18-web Exited (0), then it was started for storage practice. Its state after reboot is not checked. Stopping bind-web was reported by me on 14 October.

## Current state and remaining work
- Users/access: [theory](Users-Access-Theory.md) · [ticket and recorded steps](Users-Access-Ticket.md).
- I configured exact start/restart and journal reads for five lab services. Separate SSH logins remain unconfirmed; the agreed access exercise is complete with guidance.
- Guided Bash, Docker storage, Dockerfile v1/v2, first Compose and two-service networking practice are complete. The first Compose oral check is closed; service-name DNS/localhost need reinforcement. Healthcheck is assigned, not yet performed. No new independent skill rating is claimed.
- I also maintain Obsidian theory links, command notes and practice reports; PDF and Git remain available. No background synchronization is configured.
- Reports explain new syntax and new uses only; previously taught commands are not explained again.
- Backups and monitoring are future study requests, not implemented systems.

[Architecture record](../Infrastructure-Plan.md) · [work templates](../../03-Templates/README.md).
I perform lab changes myself; documentation updates are not permission to operate the server.
