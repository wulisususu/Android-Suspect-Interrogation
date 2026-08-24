# Linux Suspect Interrogation API Contract v1

## Overview

This document defines the communication protocol between frontend, backend, and hardware layer.

Goals:

- Linux Kiosk frontend compatibility
- Future Android client compatibility
- Hardware abstraction compatibility
- Offline deployment on RK3588

---

# REST API

Base path:

```
/api/v1
```

## Case

### Create Case

```
POST /cases
```

Request:

```json
{
  "operator_id": "operator001",
  "case_type": "suspect_interrogation"
}
```

Response:

```json
{
  "case_id": "case_xxx",
  "status": "created"
}
```

---

# Identity

## Read Identity Card

```
POST /identity/read
```

Response:

```json
{
  "event": "IDENTITY_SUCCESS",
  "data": {
    "name": "",
    "id_number": ""
  }
}
```

---

# Interrogation

## Start Session

```
POST /interrogation/start
```

Response:

```json
{
  "session_id": "session_xxx",
  "state": "QUESTIONING"
}
```

---

# WebSocket Events

Endpoint:

```
/ws/interrogation/{session_id}
```

## Client message

```json
{
  "event": "USER_TEXT",
  "payload": {
    "text": "answer"
  }
}
```

## Server events

### Identity Required

```json
{
  "event": "IDENTITY_REQUIRED"
}
```

### AI Response

```json
{
  "event": "AI_RESPONSE",
  "payload": {
    "text": "question"
  }
}
```

### Recording State

```json
{
  "event": "RECORDING_START"
}
```

### Signature Complete

```json
{
  "event": "SIGNATURE_COMPLETE",
  "payload": {
    "file": "signature.png"
  }
}
```

---

# Event Flow

```
CREATE_CASE
    |
IDENTITY_REQUIRED
    |
IDENTITY_SUCCESS
    |
QUESTIONING
    |
AI_RESPONSE
    |
SUMMARY
    |
SIGNATURE_COMPLETE
    |
REPORT_GENERATED
```

All communication must work offline.
