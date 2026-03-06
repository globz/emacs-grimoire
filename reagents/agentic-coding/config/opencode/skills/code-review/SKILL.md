---
name: code-review
description: 
license: MIT
compatibility: opencode
---

# Code Review

Guide proper code review practices emphasizing technical rigor, evidence-based claims, and verification over performative responses.
During code review use the `code-reviewer` subagent

## Overview

Code review requires three distinct practices:

1. **Receiving feedback** - Technical evaluation over performative agreement
2. **Requesting reviews** - Systematic review via code-reviewer subagent
3. **Verification gates** - Evidence before any completion claims

## Core Principle

**Technical correctness over social comfort.** Verify before implementing. Ask before assuming. Evidence before claims.

### Receiving Feedback
Trigger when:
- Receiving code review comments
- Feedback seems unclear or technically questionable
- Multiple review items need prioritization
- Suggestion conflicts with existing decisions

### Requesting Review
Trigger when:
- Completing tasks (after EACH task)
- Finishing major features or refactors
- Before merging to main branch
- Stuck and need fresh perspective
- After fixing complex bugs

### Verification Gates
Trigger when:
- About to claim tests pass, build succeeds, or work is complete
- Moving to next task
- Any statement suggesting success/completion
- Expressing satisfaction with work

## Quick Decision Tree

```
SITUATION?
│
├─ Received feedback
│  ├─ Unclear items? → STOP, ask for clarification first
│  ├─ From human partner? → Understand, then implement
│  
├─ Completed work
│  ├─ Major feature/task? → Request code-reviewer subagent review
│  └─ Before merge? → Request code-reviewer subagent review
│
└─ About to claim status
   ├─ Have fresh verification? → State claim WITH evidence
   └─ No fresh verification? → RUN verification command first
```

## Receiving Feedback Protocol

### Response Pattern
READ → UNDERSTAND → VERIFY → EVALUATE → RESPOND → IMPLEMENT

### Key Rules
- ❌ No performative agreement: "You're absolutely right!", "Great point!", "Thanks for [anything]"
- ❌ No implementation before verification
- ✅ Restate requirement, ask questions, push back with technical reasoning, or just start working
- ✅ If unclear: STOP and ask for clarification on ALL unclear items first
- ✅ YAGNI check: grep for usage before implementing suggested "proper" features

### The Iron Law
**NO COMPLETION CLAIMS WITHOUT FRESH VERIFICATION EVIDENCE**

### Gate Function
IDENTIFY command → RUN full command → READ output → VERIFY confirms claim → THEN claim

Skip any step = lying, not verifying

### Requirements
- Tests pass: Test output shows 0 failures
- Build succeeds: Build command exit 0
- Bug fixed: Test original symptom passes
- Requirements met: Line-by-line checklist verified

### Red Flags - STOP
Using "should"/"probably"/"seems to", expressing satisfaction before
verification, committing without verification, trusting agent reports, ANY
wording implying success without running verification

## Bottom Line

1. Technical rigor over social performance - No performative agreement
2. Systematic review processes - Use code-reviewer subagent
3. Evidence before claims - Verification gates always

Verify. Question. Then implement. Evidence. Then claim.
