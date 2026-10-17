# Study notes and current practice
Updated 17 October 2026. These are my learning records, prepared with AI assistance.
My public [learning map](../Learning-Map.md) and [skills overview](../Skills-Overview.md)
are available in English and Russian. The detailed study notes below are in Russian.

## Current focus

I studied and practised one application end to end. The 17 October evening screenshot shows lab-info:v1 built, lab-info running python app.py, loopback publication 8145 to 8000, HTTP 200 with JSON service=lab-info/version=1.0 and a GET 200 log entry. I enter files manually in Vim and asked for explanations of each new Python construct for notes. Next: image/container lifecycle, version changes and data on this same app; further Compose and the three-path exercise are deferred. No module status or independence rating changed; this is a taught example, not an independent assessment.

[Single-app report](Рефераты/Docker/%D0%9E%D0%B4%D0%BD%D0%BE%20%D0%BF%D1%80%D0%B8%D0%BB%D0%BE%D0%B6%D0%B5%D0%BD%D0%B8%D0%B5%20-%20%D0%BE%D0%B1%D1%80%D0%B0%D0%B7%20%D0%BA%D0%BE%D0%BD%D1%82%D0%B5%D0%B9%D0%BD%D0%B5%D1%80%20%D0%B8%20HTTP.md) · [Evidence](Docker-One-App-Result.md).

## Completed with guidance

- Depends_on/service_healthy, 17 October: [report](Рефераты/Docker/Depends_on%20-%20%D0%B3%D0%BE%D1%82%D0%BE%D0%B2%D0%BD%D0%BE%D1%81%D1%82%D1%8C%20%D0%B8%20%D0%B3%D1%80%D0%B0%D0%BD%D0%B8%D1%86%D1%8B%20%D0%B7%D0%B0%D0%B2%D0%B8%D1%81%D0%B8%D0%BC%D0%BE%D1%81%D1%82%D0%B8.md) · [PDF](Рефераты/Docker/Depends_on%20-%20%D0%B3%D0%BE%D1%82%D0%BE%D0%B2%D0%BD%D0%BE%D1%81%D1%82%D1%8C%20%D0%B8%20%D0%B3%D1%80%D0%B0%D0%BD%D0%B8%D1%86%D1%8B%20%D0%B7%D0%B0%D0%B2%D0%B8%D1%81%D0%B8%D0%BC%D0%BE%D1%81%D1%82%D0%B8.pdf). Guided result shown: web healthy, proxy starts afterwards and HTTP 200/v2. Startup/runtime required clarification; no new independent rating.

- Simple HTTP healthcheck, 16 October: [report](Рефераты/Docker/HTTP%20healthcheck%20-%20wget%20%D0%B8%20%D0%B3%D1%80%D0%B0%D0%BD%D0%B8%D1%86%D1%8B%20%D0%BF%D1%80%D0%BE%D0%B2%D0%B5%D1%80%D0%BA%D0%B8.md) · [PDF](Рефераты/Docker/HTTP%20healthcheck%20-%20wget%20%D0%B8%20%D0%B3%D1%80%D0%B0%D0%BD%D0%B8%D1%86%D1%8B%20%D0%BF%D1%80%D0%BE%D0%B2%D0%B5%D1%80%D0%BA%D0%B8.pdf). Manual exit 0 shown; healthy learner-reported. Loopback scope clarified by tutor; independent mastery not claimed.

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
New: [16 self-contained module teaching prompts](Промпты/README.md), with progress snapshots, explain-before-practice rules, Obsidian, PDF reports and documentation publication. These are teaching templates, not completed labs. Simple healthcheck and startup waiting with service_healthy are now completed with guidance; the 17 October screenshot shows healthy and HTTP 200/v2. The current route returns to one Docker application by my request: lab-info now runs and answers HTTP. Next are its lifecycle, versions and data; further Compose, three-path diagnostics and the artificial marker exercise are deferred.

- Users/access: [theory](Users-Access-Theory.md) · [ticket and recorded steps](Users-Access-Ticket.md).
- I configured exact start/restart and journal reads for five lab services. Separate SSH logins remain unconfirmed; the agreed access exercise is complete with guidance.
- Guided Bash, Docker storage, Dockerfile v1/v2, first Compose and two-service networking practice are complete. The first Compose oral check is closed; service-name DNS/localhost need reinforcement. The final 17 October screenshot shows web healthy, proxy starting afterwards and HTTP 200/v2. I initially misunderstood later unhealthy behavior; the tutor clarified it, without a new independent answer from me. DNS/localhost and diagnostics still need reinforcement; multi-container work is deferred while I study one app. No new independent skill rating is claimed.
- I also maintain Obsidian theory links, command notes and practice reports; PDF and Git remain available. The active Obsidian vault now uses iCloud file synchronization; teaching records are updated at block completion.
- Reports explain new syntax and new uses only; previously taught commands are not explained again.
- Backups and monitoring are future study requests, not implemented systems.

[Architecture record](../Infrastructure-Plan.md) · [work templates](../../03-Templates/README.md).
I perform lab changes myself; documentation updates are not permission to operate the server.
