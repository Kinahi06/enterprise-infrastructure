# Engineering Work Templates

These templates structure project work, research, troubleshooting and mentor
requests. They are designed to develop independent system-administration
habits rather than produce copy-and-paste command transcripts.

## Suggested Workflow

1. Start with [Project Intake](./Project-Intake.md).
2. Record unfamiliar concepts in [Research Notes](./Research-Notes.md).
3. Prepare risky work with a [Change Plan](./Change-Plan.md).
4. If blocked, complete a [Troubleshooting Request](./Troubleshooting-Request.md)
   or request a limited [Mentor Hint](./Mentor-Hint-Request.md).
5. Prove the result with an [Acceptance Test](./Acceptance-Test.md).
6. Deliver the work with a [Project Submission](./Project-Submission.md).
7. Use an [Incident Postmortem](./Incident-Postmortem.md) after a meaningful
   failure or outage.

## Usage

Copy the relevant template into the project's working directory and rename it:

```text
YYYY-MM-DD-short-topic.md
```

Complete unknown fields with `Unknown` rather than inventing an answer. Update
the document as evidence changes.

## Evidence Standard

Good evidence is reproducible and specific:

- exact error text rather than a paraphrase;
- relevant command output or log excerpt;
- expected versus actual result;
- a stated hypothesis and what would disprove it;
- primary documentation links;
- application-level verification, not only an open port or running process.

## Security

Never paste passwords, private keys, auth tokens, recovery codes, personal data
or unredacted production secrets into these templates. Record where a secret is
managed, not its value.


## My learning and authorship rules — 1 October 2026

I write completed observations, decisions and results in the first person.
I explicitly record tutor/AI assistance and distinguish shown output, my verbal
report, an untested hypothesis and future work. I use Unknown for missing facts.
Theory teaches the mechanism; a ticket states the problem and acceptance criteria,
not a pre-solved repair. I perform server changes myself; asking about a tool does
not authorize my tutor to deploy it. Templates are blank aids, not completed projects.

My study reports include context, theory, observations, reasoning, minimal change,
verification, mistakes, evidence limits, a short takeaway and primary sources.
Commands are grouped by topic and action class: read, probe, modify or delete.
A command discussed but not executed is labelled as such. PDF and editable Markdown
must describe the same result. A guided pass does not increase independence scores.
